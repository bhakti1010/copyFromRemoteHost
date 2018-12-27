FOLDER1=/usr/local/sifyscripts/
FOLDER2=/tmp/backup_aud/
FOLDER3=/tmp/auto_backup/
FILE1=auditfile_backup.sh
FILE2=autobackup_script.sh
FILE3=log.txt

#make necessary folder along with their parent
mkdir -p $FOLDER1
mkdir -p $FOLDER2
mkdir -p $FOLDER3
cd $FOLDER1

#create a file if it's not their and change permission
test -f $FOLDER1$FILE3 || touch $FOLDER1$FILE3
chmod +w $FILE3
test -f $FOLDER1$FILE1 || touch $FOLDER1$FILE1

#put a script in a  file
echo "SOURCE=/home/dipak/Desktop
DESTINATION=/home/dipak/
sbcName=\$(hostname)

for filename in \$(find \$DESTINATION -maxdepth 1 -name '*.AUD')
do
    rm -rf \$filename
    echo "\$filename deleted"
done;
cd \$SOURCE

for filename in \$(find * -maxdepth 1 -mmin -1440 -name '*.AUD')
do
	cp \$filename \$DESTINATION
	echo "\$DESTINATION"
	echo "\$filename copied"
	mv \$DESTINATION\$filename \$DESTINATION\$sbcName\$filename
	echo "\$filename renamed to \$sbcName\$filename"
	chmod +r \$DESTINATION\$sbcName\$filename
	echo "Read permission for \$DESTINATION\$sbcName\$filename is added"
done;" > $FOLDER1$FILE1

#change permission
chmod +x $FOLDER1$FILE1


#create file and add script in it
test -f $FOLDER1$FILE2 || touch $FOLDER1$FILE2
echo "SOURCE=/home/dipak/Desktop
DESTINATION=/home/dipak/
for filename in \$(find \$DESTINATION -maxdepth 1 -mmin -1440 -name 'auto_backup_config_*')
do
	rm -rf \$filename
	echo "\$filename deleted"
done;

cd \$SOURCE
for filename in \$(find * -mmin -1440 -name 'auto_backup_config_*' )
do
	cp \$filename \$DESTINATION
	echo "\$filename copied"
	chmod +r \$DESTINATION\$filename
	echo "Read permission for \$DESTINATION\$filename is added"
done;" > $FOLDER1$FILE2
chmod +x $FOLDER1$FILE2


#schedule above two script to run every minute and see the output
crontab -l > mycron
echo "* * * * * cd $FOLDER1 ; . ./$FILE1 >> $FOLDER1$FILE3 2>&1" >> mycron
crontab mycron
rm mycron


crontab -l > mycron
cat mycron
echo "* * * * * cd $FOLDER1 ; . ./$FILE2 >> $FOLDER1$FILE3 2>&1" >> mycron
crontab mycron
rm mycron

#see the output of a script after every minute 
cd $FOLDER2
ls -l
cd $FOLDER3
ls -l
cat $FOLDER1$FILE3
sleep 1m
cd $FOLDER2
ls -l
cd $FOLDER3
ls -l
cat $FOLDER1$FILE3
sleep 1m
cd $FOLDER2
ls -l
cd $FOLDER3
ls -l
cat $FOLDER1$FILE3

#remove last two lines from a crontab and schedule the script to at particular time
crontab -l > mycron
head -n -2 mycron > t1
echo "01 01 * * * cd $FOLDER1 ; . ./$FILE1 >> $FOLDER1$FILE3 2>&1" >> t1
echo "01 01 * * * cd $FOLDER1 ; . ./$FILE2 >> $FOLDER1$FILE3 2>&1" >> t1
crontab t1
cat t1

#remove teemporary file created during script
rm mycron
rm t1
