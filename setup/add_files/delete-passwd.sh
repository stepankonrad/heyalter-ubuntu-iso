#! /bin/sh

### BEGIN INIT INFO
# Provides:		delete-password
# Required-Start:	$remote_fs $syslog
# Required-Stop:	$remote_fs $syslog
# Default-Start:	2 
# Default-Stop:		
# Short-Description:	Delete password user schule
### END INIT INFO

set -e

# /etc/init.d/ssh: start and stop the OpenBSD "secure shell(tm)" daemon

. /lib/lsb/init-functions

case "$1" in
  start)
	log_daemon_msg "Starting Delete Passord schule" "delete-passwd" || true

	if passwd -d schule ; then
	    log_end_msg 0 || true
	else
	    log_end_msg 1 || true
	fi
	if rm /etc/init.d/delete-password.sh /etc/rc2.d/S02delete-passwd.sh ; then
	    log_end_msg 0 || true
	else
	    log_end_msg 1 || true
	fi
	;;
  *)
	log_action_msg "Usage: /etc/init.d/ssh {start}" "delete-passwd" || true
	log_daemon_msg "All option except start Delete Passord schule does nothing" "delete-passwd" || true
	exit 1
	;;

esac

exit 0
