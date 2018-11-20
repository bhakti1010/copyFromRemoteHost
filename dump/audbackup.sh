SOURCE=/var/log/sonus/sbx/evlog/
DESTINATION=/var/log/sonus/sbx/tmp/
#SOURCE=/home/dipak/Desktop
#DESTINATION=/home/dipak/
sbcName=$(hostname)

#rm -rf $DESTINATION*
for filename in $(find $DESTINATION -maxdepth 1 -name '*.AUD')
do
	rm -rf $filename
	echo "$filename deleted"
done;
#find $SOURCE -mmin -1440 -name '*.AUD' | xargs -I '{}' cp '{}' $DESTINATION

cd $SOURCE

for filename in $(find * -maxdepth 1 -mmin -1440 -name '*.AUD')
do
	#echo $filename
	#chmod +r $filename
	cp $filename $DESTINATION
	echo "$DESTINATION"
	echo "$filename copied"
	mv $DESTINATION$filename $DESTINATION$sbcName$filename
	echo "$filename renamed to $sbcName$filename"
	chmod +r $DESTINATION$sbcName$filename
	echo "Read permission for $DESTINATION$sbcName$filename is added"
done;





cmd >>log.txt 2>&1 //both on same
cmd >>log.txt 2>>error.txt //both on differnts
grep CRON /var/log/syslog
tail -f /var/log/syslog | grep CRON
cat /usr/local/sifyscripts/log.txt
cd /usr/local/sifyscripts/
ls -l /var/log/sonus/sbx/tmp/
cd /usr/local/sifyscripts/ ; . ./aud_backup.sh>>/usr/local/sifyscripts/log.txt 2>&1