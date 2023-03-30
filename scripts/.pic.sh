#!/usr/bin/env bash

dir="/home/cafo/Pictures/wallpapers/"
cd $dir
ls | grep -i .jpg > pics.txt
for entry in `cat pics.txt`; do
    x=`echo $entry | awk -F '[.:]' '{printf $1}' && echo .png`
    convert $entry $x
    rm -f $entry
done
rm -f $dir/pics.txt
