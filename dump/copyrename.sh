#!/usr/bin/ksh

#set -x

IPc=`cat /usr/local/sifyscripts/ip.txt | wc -l`;j=1 ;

while [ $IPc -gt 0 ]

do
IP=`cat /usr/local/sifyscripts/ip.txt | head -$j | tail -1`
DESTINATION=/stats/TEMPCOPY/
cd $DESTINATION
#mDATE=`date +%Y%m%d`
SOURCE=/var/log/sonus/sbx/evlog/
#echo "THIS IS FROM: "$IP
scp -i id_rsa -P 2024 linuxadmin@$IP:$SOURCE*.AUD
IPc=`expr $IPc - 1`
j=`expr $j + 1`
done




IPc=`cat /usr/local/sifyscripts/ip.txt | wc -l`;j=1 ;
while [ $IPc -gt 0 ]
do
IP=`cat /usr/local/sifyscripts/ip.txt | head -$j | tail -1`
DESTINATION=/stats/temp/

cd $DESTINATION

mDATE=`date +%Y%m%d`

SOURCE=/var/log/sonus/sbx/config/auto_backup_config_*

echo "THIS IS FROM: "$IP

scp -i id_rsa -P 2024 linuxadmin@$IP:$SOURCE$mDATE*.gz


IPc=`expr $IPc - 1`

j=`expr $j + 1`

done

find /home/dipak/Documents/ -cmin -5000 -name *.AUD| xargs -I '{}' cp '{}' /home/dipak/Downloads/copy/


//sbc!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SOURCE=/var/log/sonus/sbx/evlog/
DESTINATION=/var/log/sonus/sbx/tmp/
sbcName=$(hostname)

rm -rf $DESTINATION*
find $SOURCE -mmin -1440 -name '*.AUD' | xargs -I '{}' cp '{}' $DESTINATION

cd $DESTINATION
for file in *
do
    #whatever you need with "$file"
    #echo $file
    #folder="$(cut -d'_' -f4 <<<"$file")"
    #echo $folder
    #mkdir -p "$DESTINATION$folder"
    #cp -u "$file" "$DESTINATION$folder"
    mv $DESTINATION$file $DESTINATION$sbcName$file
done

//sbc one more ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#SOURCE=/var/log/sonus/sbx/config/
#DESTINATION=/tmp
SOURCE=/home/dipak/Desktop
DESTINATION=/home/dipak/
for filename in $(find $DESTINATION -maxdepth 1 -name 'auto_backup_config_*')
do
	rm -rf $filename
	echo "$filename deleted"
done;

for filename in $(find $SOURCE -mmin -1440 -name 'auto_backup_config_*' )
do
	cp $filename $DESTINATION
	echo "$filename copied"
done;


#find $SOURCE -mmin -1440 -name 'auto_backup_config_*' | xargs -I '{}' cp '{}' $DESTINATION 
#find /home/dipak/ -maxdepth 1 -name 't*.txt' -exec rm -rf {} \;
//netscore!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
IPc=`cat /usr/local/sifyscripts/ip.txt | wc -l`;j=1 ;
while [ $IPc -gt 0 ]
do
	IP=`cat /usr/local/sifyscripts/ip.txt | head -$j | tail -1`
	DESTINATION=/stats/TEMPCOPY/
	cd $DESTINATION
	#mDATE=`date +%Y%m%d`
	SOURCE=/var/log/sonus/sbx/tmp/*.AUD
	echo "THIS IS FROM: "$IP
	scp -i id_rsa -P 2024 -v linuxadmin@$IP:$SOURCE
	IPc=`expr $IPc - 1`
	j=`expr $j + 1`
done













!!!!!!!!!!!!!!!!!!!!!!!testing!!!!!!!!!!!!!!!!!!!!!!!!!!
SOURCE=/home/dipak/Documents/
DESTINATION=/home/dipak/copy/
sbcName=$(hostname)

rm -rf $DESTINATION*
find $SOURCE -mmin -1440 -name '*.AUD' | xargs -I '{}' cp '{}' $DESTINATION
find $SOURCE -cmin -1440 -name '*.AUD' | xargs -I '{}' cp '{}' $DESTINATION

cd $DESTINATION
for file in *
do
    #whatever you need with "$file"
    echo $file
    #folder="$(cut -d'_' -f4 <<<"$file")"
    #echo $folder
    #mkdir -p "$DESTINATION$folder"
    #cp -u "$file" "$DESTINATION$folder"
    mv $DESTINATION$file $DESTINATION$sbcName$file
done


pwd
/home/dipak/Documents

ls -l ../copy/
ls | xargs -I '{}' stat '{}'

touch 10000x.AUD
touch -d "24 hours ago" filename

