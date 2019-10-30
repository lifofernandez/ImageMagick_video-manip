#!/bin/bash
# morph.sh -i IN_FOLDER -o OUT_FOLDER 

while getopts i:o:l: option
do
 case "${option}"
 in
 i) IN_FOLDER=${OPTARG};;
 o) OUT_FOLDER=${OPTARG};;
 esac
done

declare -a files=($IN_FOLDER/*)
for (( i = 0; i < ${#files[*]}; ++ i ))
do
  prev=${files[$i-1]}
  curr=${files[$i]} 
  prox=${files[$i+1]}
  echo transicion: ${curr##*/} :::::: ${prox##*/}
  convert ${curr} ${prox} \
	-morph 5 \
	-layers TrimBounds \
	-set dispose previous \
	$OUT_FOLDER/morph_resize-${curr##*/}_${prox##*/}.gif
#       -background black \
#	-alpha remove \
#	-coalesce \
#	-loop 1 \
#	-set delay '%[fx:(t>0&&t<n-1)?10:60]' \
#	-duplicate 1,-2-1 \
done

gifsicle --delay 0 --merge $OUT_FOLDER/* -o morph_resizes.gif
gifsicle morph_resizes.gif "#-1-0" -o morph_reverse.gif
gifsicle --delay 0 --merge morph_resizes.gif morph_reverse.gif -o morph_pingpong.gif

ffmpeg -i morph_pingpong.gif -movflags faststart -pix_fmt yuv420p -vf 'scale=trunc(iw/2)*2:trunc(ih/2)*2' morph.mp4



