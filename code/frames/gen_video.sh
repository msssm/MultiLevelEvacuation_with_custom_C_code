#! /bin/bash
#input arguments:
# <file>%04d.png
# input frame rate (something around 15)
# output video file.mp4

ffmpeg -r $2 -i "$1" -vcodec libx264  -crf 22 -threads 5 $3

