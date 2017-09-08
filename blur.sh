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
    grad=$((${counter} % 360))
    #convert ${f} -blur 2x6 $OUT_FOLDER/blur_${b} 
    convert ${f} \
        -channel R -blur 8x8 \
        -channel G -blur 2x2 -swirl ${grad} \
        -channel B -radial-blur ${grad} \
    $OUT_FOLDER/blur_${b} 

    if [ ${counter} -gt 1000 ]
    then
	    break
    fi

done




