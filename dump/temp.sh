#!/bin/sh

SOURCE=/stats/temp/
DESTINATION=/stats/SBCBACKUP/
cd $SOURCE
for file in *
do
    #whatever you need with "$file"
    echo $file
    folder="$(cut -d'_' -f4 <<<"$file")"
    echo $folder
    mkdir -p "$DESTINATION$folder"
    cp -u "$file" "$DESTINATION$folder"
done

