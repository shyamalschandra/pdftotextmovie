# Author: Shyamal Suhana Chandra
# Date: August 14, 2021 @11:02 PM
# Function: To convert PDFs into Text Movies (1st Draft)

#!/bin/bash
rm files.txt
rm frame_*.mp4
rm frame_lessig.mp4
touch files.txt
export FILE=`ls -Art *.pdf | tail -n 1`
export TEXT_FILE=`echo $FILE | cut -d "." -f1| awk '{print $0".txt"}'`
echo "Convert PDF to text"
pdftotext $FILE $TEXT_FILE
sed '/^[t|s]*$/d' $TEXT_FILE > no_lines.txt
echo $TEXT_FILE
#IFS=$'\n' read -r -a array <<< `cat no_lines.txt`
IFS=$(echo -en "\n") 
#IFS=\=
#IFS=$'\n'
#read -r -a array <<< `cat no_lines.txt`
#array=($(cut -d "\n" -f no_lines.txt))
#mapfile -t array < no_lines.txt
IFS=$'\r\n' GLOBIGNORE='*' command eval  'array=($(cat no_lines.txt))'
#IFS=$' ' GLOBIGNORE='*' command eval 'array=($(cat no_lines.txt))'
len_array=${#array[@]}
#echo $len_array
COUNTER=1
#i=0
declare -i TOTAL=$((100))
export cnt=`bc -l <<< $len_array/$TOTAL`
#echo $cnt
#echo -n "["
#for element in "${array[@]}"
for element in "${array[@]}":
do
	echo "$element"
	#echo ${#element[@]}
	convert -size 1920x1080 xc:white -font Arial -pointsize 25 -gravity center -draw "text 0,0 \"$element\"" frame.png
	say -v Alex -o frame.aiff "`echo $element`"
	ffmpeg -loglevel quiet -y -i frame.aiff frame.m4a
	seconds=0
	seconds=`ffprobe -i frame.m4a -show_entries format=duration -v quiet -of csv="p=0"`
	#echo "seconds: $seconds"
	#declare -i seconds_int=$((seconds))
	#echo "seconds_int: $seconds_int"
	#export CEIL_SECONDS=`printf %.0f $seconds`
	export CEIL_SECONDS=`echo $seconds | perl -nl -MPOSIX -e 'print ceil($_);'`
	#CEIL_SECONDS=$((CEIL_SECONDS+1))
	#declare -i seconds_int_u=$((CEIL_SECONDS))
	#if [ $seconds_int_u -lt $seconds_int ]
	#then
	#	CEIL_SECONDS=$(($seconds_int+1))
	#fi
	#echo "$CEIL_SECONDS"
	ffmpeg -loglevel quiet -y -loop 1 -i frame.png -c:v libx264 -t `echo $CEIL_SECONDS` -pix_fmt yuv420p -vf scale=1920:1080 frame.mp4
	ffmpeg -loglevel quiet -y -i frame.mp4 -i frame.m4a -t `echo $CEIL_SECONDS` frame_`echo $COUNTER`.mp4
	ls -lstr frame_`echo $COUNTER`.mp4
	COUNTER=$((COUNTER+1))
	#echo $COUNTER
	echo "$COUNTER of $len_array videos"
	#i=$((i+1))
	#echo "HELLO" 	
done
#echo -n "]"

for element in {1..$(($len_array))}
do
        echo "file 'frame_`echo \"$element\"`.mp4'" >> files.txt
done

ffmpeg -loglevel quiet -threads 8 -f concat -i files.txt -c copy frame_lessig.mp4
