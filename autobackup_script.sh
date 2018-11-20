SOURCE=/home/dipak/Desktop
DESTINATION=/home/dipak/
for filename in $(find $DESTINATION -maxdepth 1 -mmin -1440 -name 'auto_backup_config_*')
do
	rm -rf $filename
	echo $filename deleted
done;

cd $SOURCE
for filename in $(find * -mmin -1440 -name 'auto_backup_config_*' )
do
	cp $filename $DESTINATION
	echo $filename copied
	chmod +r $DESTINATION$filename
	echo Read permission for $DESTINATION$filename is added
done;
