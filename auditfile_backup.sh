SOURCE=/home/dipak/Desktop
DESTINATION=/home/dipak/
sbcName=$(hostname)

for filename in $(find $DESTINATION -maxdepth 1 -name '*.AUD')
do
    rm -rf $filename
    echo $filename deleted
done;
cd $SOURCE

for filename in $(find * -maxdepth 1 -mmin -1440 -name '*.AUD')
do
	cp $filename $DESTINATION
	echo $DESTINATION
	echo $filename copied
	mv $DESTINATION$filename $DESTINATION$sbcName$filename
	echo $filename renamed to $sbcName$filename
	chmod +r $DESTINATION$sbcName$filename
	echo Read permission for $DESTINATION$sbcName$filename is added
done;
