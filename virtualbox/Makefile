DISK_SIZE=20000
VM_NAME=heyalter-96683212-1637-4ec1-8271-234bc528bb83

.PHONY: clean boot 

${VM_NAME}/${VM_NAME}.vbox:
	VBoxManage createvm --name ${VM_NAME} --basefolder $$(pwd) --ostype Ubuntu_64 --default --register
	VBoxManage modifyvm ${VM_NAME} --memory 3072 --vram 128 --cpus 2
	VBoxManage storagectl ${VM_NAME} --name "SATA" --portcount 6

# TODO: add support for multiple drives
hdd1.vdi: ${VM_NAME}.vbox
	VBoxManage createmedium disk --filename $@ --size ${DISK_SIZE}
	VBoxManage storageattach ${VM_NAME} --storagectl "SATA" --port 1 --device 0 --type hdd --medium $@

boot: ${VM_NAME}/${VM_NAME}.vbox ${VM_NAME}/hdd.vdi ${IMAGE}
	VBoxManage storageattach ${VM_NAME} --storagectl "SATA" --port 0 --device 0 --type dvddrive --medium ${IMAGE}
	VBoxManage startvm ${VM_NAME} --type gui

clean:
	VBoxManage unregistervm ${VM_NAME} --delete

