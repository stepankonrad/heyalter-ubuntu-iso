use ini::Ini;
use std::env;
use std::fs::File;
use std::io::Write;
use std::process::{exit, Command, Stdio};
use std::string::ToString;

struct Resuids {
    real: libc::uid_t,
    effective: libc::uid_t,
    suid: libc::uid_t,
}

fn getresuid() -> Resuids {
    let mut result = Resuids {
        real: 42,
        effective: 42,
        suid: 42,
    };
    let retcode =
        unsafe { libc::getresuid(&mut result.real, &mut result.effective, &mut result.suid) };
    if retcode != 0 {
        panic!("getresuid failed!");
    }
    result
}

fn setresuid(uids: &Resuids) -> Result<(), ()> {
    let retcode = unsafe { libc::setresuid(uids.real, uids.effective, uids.suid) };
    if retcode != 0 {
        Err(())
    } else {
        Ok(())
    }
}

fn getenvvars() -> Result<Vec<(String, String)>, String> {
    use std::os::unix::fs::{MetadataExt, PermissionsExt};
    let mut file = File::open("/etc/environment").map_err(|e| e.to_string())?;
    let metadata = file.metadata().map_err(|e| e.to_string())?;
    if metadata.uid() != 0 || metadata.gid() != 0 {
        return Err("/etc/environment is not owned by root".to_string());
    }
    let perms = metadata.permissions();
    if perms.mode() != 0o100644 {
        return Err("Expected /etc/environment to have 0o100644 permission mode".to_string());
    }
    let ini = Ini::read_from(&mut file).map_err(|e| e.to_string())?;
    if let Some(section) = ini.section::<String>(None) {
        Ok(section
            .iter()
            .map(|(k, v)| (k.to_string(), v.to_string()))
            .collect())
    } else {
        Ok(Vec::new())
    }
}

fn main() -> ! {
    let bashscript = include_bytes!(env!("BASHSCRIPT"));
    let mut argv = env::args();
    let arg0 = argv.next();
    let arg1 = argv.next();

    if Some("src".to_string()) == arg1 {
        std::io::stdout()
            .write_all(bashscript)
            .expect("Couldn't print bashscript to stdout");
        exit(0);
    }

    let vars = match getenvvars() {
        Ok(vars) => vars,
        Err(e) => {
            if cfg!(debug_assertions) {
                println!("Error retrieving default env vars: {}", e);
            }
            Vec::new()
        }
    };

    let ids = getresuid();
    if cfg!(debug_assertions) {
        println!(
            "Real {}, Eff {}, SUID {}",
            ids.real, ids.effective, ids.suid
        );
    }
    setresuid(&Resuids {
        real: ids.suid,
        effective: ids.suid,
        suid: ids.suid,
    })
    .expect("Error executing setresuid");

    use std::os::unix::process::CommandExt;
    let mut child = Command::new("/usr/bin/bash")
        .env_clear() // Just some security xD
        .envs(vars)
        .arg0(arg0.unwrap_or("".to_string()))
        .stdin(Stdio::piped())
        .spawn()
        .expect("Couldn't spawn bash child process");

    let stdin = child.stdin.as_mut().expect("Couldn't open stdin of bash");
    stdin
        .write_all(bashscript)
        .expect("Couldn't write bash script to stdin");

    let status = child
        .wait()
        .expect("a problem occurred while waiting for the bash process to finish");
    exit(status.code().unwrap_or(102));
}
