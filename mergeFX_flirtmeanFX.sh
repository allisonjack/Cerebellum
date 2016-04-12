#!/bin/bash

usage()
{
cat << EOF
usage: $0 options

This script merges functional images in SUIT space and performs linear 
registration from functional to high-res anatomical space on the mean_func image.

OPTIONS:
   -h  Show this message
   -I  ID
   
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
FEATDIR=$STUDYDIR/CHILD/ANALYSIS/PRESTATS_SUIT/${ID}.feat
SUITDIR=$STUDYDIR/CHILD/SUIT/$ID
FILTDIR=$SUITDIR/FILTERED_FX

MAT=$FEATDIR/reg/example_func2highres.mat
TEMP=$SUITDIR/filtered_func_highres_temp.nii.gz
REF=$FEATDIR/reg/highres.nii.gz

fslmerge -t $SUITDIR/filtered_func_suit $FILTDIR/wcmfiltered_func_highres_*.nii

flirt -in $FEATDIR/mean_func -applyxfm -init $MAT -out $SUITDIR/mean_func_highres_temp -paddingsize 0.0 -interp trilinear -ref $REF

fslchfiletype NIFTI $SUITDIR/mean_func_highres_temp.nii.gz $SUITDIR/mean_func_highres.nii

rm $SUITDIR/mean_func_highres_temp.nii.gz
