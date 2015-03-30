#!/bin/bash

usage()
{
cat << EOF
usage: $0 options

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

STUDYDIR=/scratch/aj349/BIOPOINT_CRBLM
FEATDIR=$STUDYDIR/CHILD/ANALYSIS/PRESTATS_SUIT/${ID}.feat
SUITDIR=$STUDYDIR/CHILD/SUIT/$ID

MAT=$FEATDIR/reg/example_func2highres.mat
TEMP=$SUITDIR/filtered_func_highres_temp.nii.gz
REF=$FEATDIR/reg/highres.nii.gz

FXMED=$(fslstats $SUITDIR/filtered_func_suit -P 50)
BT=$(echo ${FXMED}*.75 | bc -l)
SIGMA=2.12314225053

susan $SUITDIR/filtered_func_suit $BT $SIGMA 3 1 1 $SUITDIR/mean_func_suit $BT $SUITDIR/filtered_func_suit_smooth
