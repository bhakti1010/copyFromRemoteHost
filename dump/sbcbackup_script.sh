#!/usr/bin/ksh

#set -x

IPc=`cat /usr/local/sifyscripts/ip.txt | wc -l`;j=1 ;

 

while [ $IPc -gt 0 ]

do

IP=`cat /usr/local/sifyscripts/ip.txt | head -$j | tail -1`

 

DESTINATION=/stats/TEMPSBCCONFIGBACKUP/

cd $DESTINATION

mDATE=`date +%Y%m%d`

SOURCE=/var/log/sonus/sbx/config/auto_backup_config_*

echo "THIS IS FROM: "$IP

scp -i id_rsa -P 2024 linuxadmin@$IP:$SOURCE$mDATE*.gz


IPc=`expr $IPc - 1`

j=`expr $j + 1`

done