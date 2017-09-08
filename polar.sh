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

    convert ${f} -virtual-pixel Transparent \
        -distort DePolar -1 $OUT_FOLDER/depolar_${b} 
    convert  $OUT_FOLDER/depolar_${b} -virtual-pixel HorizontalTile -background None \
        -distort Polar -1 $OUT_FOLDER/cycled_${b} 

    if [ ${counter} -gt 100 ]
    then
	    break
    fi

done




