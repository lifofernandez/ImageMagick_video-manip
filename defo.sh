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

for f in $IN_FOLDER/*; do 
    let "counter+=1" 
    b=${f##*/}
    echo ${b}

    convert ${f} -virtual-pixel tile -mattecolor DodgerBlue \
    -interpolate Spline -distort BilinearForward \
        '0,0 20,60 90,0 70,63 0,90 5,83 90,90 85,88' \
    $OUT_FOLDER/defo_${b} 

    if [ ${counter} -gt 100 ]
    then
	    break
    fi

done



