A small project to copy files from remote servers defined in ip.txt file at particular time everyday. There are 5 files in a project.
README.md

	1.sbcconfig.sh  - This file will configure SBC with all necessary folder and file to copy .AUD , .SYS and config into tmp folder.
	2.auditfile_backup.sh - This file is used to pull .AUD and .SYS data from all the SBC listed in a ip.txt file.  
	3.autobackup_script.sh - This file is used to pull config data from all the SBC listed in a ip.txt file.
	4.log.txt - It has log of all the action taken by scripts auditfile_backup.sh and autobackup_script.sh
	5.Ip.txt - list of ip from where server can pull data.
	
