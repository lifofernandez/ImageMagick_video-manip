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
#	-coalesce \
#       -background black \
#	-alpha remove \
#       -set delay '%[fx:(t>0&&t<n-1)?10:60]' \
#	-duplicate 1,-2-1 \
#	-loop 1 \
done
gifsicle --merge $OUT_FOLDER/* -o morph_resizes.gif


