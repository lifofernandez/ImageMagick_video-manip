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

for f in $IN_FOLDER/*.png; do 
    b=${f##*/}
    echo ${b}
    grad=$((${counter} % 360))
    ocho=$((${counter} % 8))
    half=0.005
    half_c=$(expr $counter*$half| bc)
    cent=0.01
    cent_c=$(expr $counter*$cent | bc)
    mili=0.001
    mili_c=$(expr $counter*$mili | bc)

    #echo ${deci_c}

    #convert ${f} -blur 2x6 $OUT_FOLDER/blur_${b} 

    convert ${f} \
        -channel R -blur ${cent_c}x${cent_c} \
        -channel G -blur ${mili_c}x${half_c} \
        -channel B -blur ${mili_c}x${half_c} \
    $OUT_FOLDER/blur_${b} 

    let "counter+=1" 

    if [ ${counter} -gt ${LIMIT} ]
    then
	    break
    fi

done




#-channel G -blur 8x2 -swirl ${counter} \
