#!/bin/bash

usage()
{
cat << EOF
usage: $0 options

OPTIONS:
   -h           Show this message
   -I           ID
   
EOF
}

while getopts "hI:" OPTION
do
  case $OPTION in
      h)
        usage
        exit 1
        ;;
      I)
        ID=$OPTARG
        ;;
      ?)
        usage
        exit
        ;;
  esac
done

STUDYDIR=/PATH_TO_YOUR_DIRECTORY/USERNAME/STUDYNAME
PRESTATS=$STUDYDIR/ANALYSIS/PRESTATS_SUIT

FEATDIR=$PRESTATS/${ID}.feat
SUITDIR=$STUDYDIR/ADULT/SUIT/$ID
FILTDIR=$SUITDIR/FILTERED_FX

MAT=$FEATDIR/reg/example_func2highres.mat
REF=$FEATDIR/reg/highres.nii.gz

  for i in $(seq -f "%04g" 0 143); do

    FX=$FILTDIR/filtered_func_data_${i}.nii.gz
    FXTEMP=$FILTDIR/filtered_func_highres_${i}_temp.nii.gz

    flirt -in $FX -applyxfm -init $MAT -out $FXTEMP -paddingsize 0.0 -interp trilinear -ref $REF
#     echo flirting $ID functional $i

    fslchfiletype NIFTI $FXTEMP $FILTDIR/filtered_func_highres_${i}.nii

    rm $FXTEMP

  done
