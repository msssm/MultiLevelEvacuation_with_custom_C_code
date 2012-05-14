#!/bin/bash

if [ "$#" -lt 1 -o "$#" -gt 3 ]
then
    echo "Usage: $0 <basemame as specified in simulationconfig file> [ <width> <height> ]"
fi

BASENAME="$1"

if [ "$#" -eq 3 ]
then
    WIDTH=$2
    HEIGHT=$3
else
    WIDTH=1280
    HEIGHT=720
fi

FILES=`find ./frames -name "$BASENAME"*.eps`

for FILENAME in $FILES
do
    #convert -density 300x300 "$FILENAME" -colorspace RGB -resize "$WIDTH"x"$HEIGHT" -extent "$WIDTH"x"$HEIGHT" -quality 98 "${FILENAME%eps}jpg"
    echo "$FILENAME -> ${FILENAME%eps}jpg"
done

avconv -i ./frames/"$BASENAME"_%04d.jpg -r 25 -b 100M ../videos/"$BASENAME".avi
