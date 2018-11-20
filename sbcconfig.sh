FOLDER1=/usr/local/sifyscripts/
FOLDER2=/tmp/backup_aud/
FOLDER3=/tmp/auto_backup/
FILE1=auditfile_backup.sh
FILE2=autobackup_script.sh
FILE3=log.txt
mkdir -p $FOLDER1
mkdir -p $FOLDER2
mkdir -p $FOLDER3
cd $FOLDER1
test -f $FOLDER1$FILE3 || touch $FOLDER1$FILE3
chmod +w $FILE3
test -f $FOLDER1$FILE1 || touch $FOLDER1$FILE1
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
chmod +x $FOLDER1$FILE1


crontab -l > mycron
echo "* * * * * cd $FOLDER1 ; . ./$FILE1 >> $FOLDER1$FILE3 2>&1" >> mycron
crontab mycron
rm mycron


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


crontab -l > mycron
cat mycron
echo "* * * * * cd $FOLDER1 ; . ./$FILE2 >> $FOLDER1$FILE3 2>&1" >> mycron
crontab mycron
rm mycron

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

crontab -l > mycron
head -n -2 mycron > t1
echo "01 01 * * * cd $FOLDER1 ; . ./$FILE1 >> $FOLDER1$FILE3 2>&1" >> t1
echo "01 01 * * * cd $FOLDER1 ; . ./$FILE2 >> $FOLDER1$FILE3 2>&1" >> t1
crontab t1
cat t1
rm mycron
rm t1
