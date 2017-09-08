#!/bin/bash
# defo.sh -i IN_FOLDER -o OUT_FOLDER 

while getopts i:o: option
do
 case "${option}"
 in
 i) IN_FOLDER=${OPTARG};;
 o) OUT_FOLDER=${OPTARG};;
 esac
done


counter=0 

for f in $IN_FOLDER/*.png; do 
    let "counter+=1" 
    b=${f##*/}
    echo ${b}

    convert ${f} \
       # dmap_o2x2.png -virtual-pixel tile  -fx 'u>=v'
        -dither FloydSteinberg -colors 16
    $OUT_FOLDER/dither_${b} 

    if [ ${counter} -gt 100 ]
    then
	    break
    fi

done




