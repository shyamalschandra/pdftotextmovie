# Author: Shyamal Suhana Chandra
# Date: August 14, 2021 @11:02 PM
# Function: To convert PDFs into Text Movies (1st Draft)

#!/bin/bash

function convert_PDF_into_text_movie {
	local counterlocal="$1"
	local elementlocal="$2"
	convert -size 1920x1080 -background white -fill black -gravity center caption:"$elementlocal" frame`echo $counterlocal`.png
	tts --text "$elementlocal" --model_name "tts_models/en/ljspeech/glow-tts" --out_path frame$counterlocal.wav
	ffmpeg -loglevel quiet -y -i frame$counterlocal.wav frame$counterlocal.m4a
	local seconds=0
	local seconds=`ffprobe -i frame$counterlocal.m4a -show_entries format=duration -v quiet -of csv="p=0"`
	ffmpeg -loglevel quiet -y -loop 1 -i frame$counterlocal.png -c:v libx264 -t `echo $seconds | perl -nl -MPOSIX -e 'print ceil($_);'` -pix_fmt yuv420p -vf scale=1920:1080 frame$counterlocal.mp4
	ffmpeg -loglevel quiet -y -i frame$counterlocal.mp4 -i frame$counterlocal.m4a -t `echo $seconds | perl -nl -MPOSIX -e 'print ceil($_);'` frame_$counterlocal.mp4
	ls -lstr frame_$counterlocal.mp4	
}


rm files.txt
rm frame_*.mp4
rm frame_lessig.mp4
rm frame*.mp4
rm frame*.m4a
rm frame*.wav
rm frame*.png
rm frame*.aiff

touch files.txt
export FILE=`ls -Art *.pdf | tail -n 1`
export TEXT_FILE=`echo $FILE | cut -d "." -f1| awk '{print $0".txt"}'`
echo "Convert PDF to text"
pdftotext $FILE $TEXT_FILE
sed '/^[t|s]*$/d' $TEXT_FILE > no_lines.txt
echo $TEXT_FILE
IFS=$(echo -en "\n") 
IFS=$'\r\n' GLOBIGNORE='*' command eval  'array=($(cat no_lines.txt))'
len_array=${#array[@]}
COUNTER=1
declare -i TOTAL=$((100))
export cnt=`bc -l <<< $len_array/$TOTAL`
for element in "${array[@]}":
do
	convert_PDF_into_text_movie "$COUNTER" "$element" &
	COUNTER=$((COUNTER+1))
	while [ `ps -f | grep -c pdf2textmovie.sh` -ge 33 ]
	do
		echo "\n$COUNTER of $len_array videos"
		for i in {1..5}
		do
			echo ".\c"
			sleep 1
		done
	done
done
wait
echo "All subvideos done!"
echo "$len_array"
for (( element = 1; element <= ${#array[@]} ; element++ ))
do
        echo "file 'frame_$element.mp4'" >> files.txt
done

ffmpeg -loglevel quiet -threads 8 -f concat -i files.txt -c copy frame_lessig.mp4
echo "Metavideo done!"
