#!/bin/bash
# blur.sh -i IN_FOLDER -o OUT_FOLDER 

while getopts i:o:l: option
do
 case "${option}"
 in
 i) IN_FOLDER=${OPTARG};;
 o) OUT_FOLDER=${OPTARG};;
 l) LIMIT=${OPTARG};;
 esac
done


counter=0 

#declare -a files=(*)
declare -a files=($IN_FOLDER/*)
for (( i = 0; i < ${#files[*]}; ++ i ))
do
  #b=${f##*/}
  prev=${files[$i-1]}
  curr=${files[$i]} 
  prox=${files[$i+1]}
  #echo ${prev##*/} ${curr##*/} ${prox##*/}
  echo transicion: ${curr##*/} :::::: ${prox##*/}
  convert ${curr} ${prox} -morph 10 \
            -layers TrimBounds -set dispose previous -coalesce \
            -background black -alpha remove \
            -set delay '%[fx:(t>0&&t<n-1)?10:60]' \
	    $OUT_FOLDER/morph_resize-${curr##*/}_${prox##*/}.gif
            #-duplicate 1,-2-1 \
	    #-loop 1 \
done

#for f in $IN_FOLDER/*.png; do 
#    b=${f##*/}
#    echo ${b}
#    #grad=$((${counter} % 360))
#    #ocho=$((${counter} % 8))
#    #half=0.005
#    #half_c=$(expr $counter*$half| bc)
#    #cent=0.01
#    #cent_c=$(expr $counter*$cent | bc)
#    #mili=0.001
#    #mili_c=$(expr $counter*$mili | bc)
#
#
#    convert ${f}  ${f-SIGIENTE} -morph 10 \
#              -layers TrimBounds -set dispose previous -coalesce \
#              -background black -alpha remove \
#              -set delay '%[fx:(t>0&&t<n-1)?10:60]' \
#              -duplicate 1,-2-1  -loop 0  $OUT_FOLDER/morph_resize-${b}.gif
#
#    let "counter+=1" 
#
#    if [ ${counter} -gt ${LIMIT} ]
#    then
#	    break
#    fi
#
#done


