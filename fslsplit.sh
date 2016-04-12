#!bin/bash

STUDYDIR=/PATH_TO_YOUR_DIRECTORY/USERNAME/STUDYNAME
PRESTATS=$STUDYDIR/ADULT/ANALYSIS/PRESTATS_SUIT

IDLIST=$STUDYDIR/IDs.txt

  while read -r ID || [[ -n ''$ID'' ]]; do

    FEATDIR=$PRESTATS/${ID}.feat
    SUITDIR=$STUDYDIR/ADULT/SUIT/$ID
    FILTDIR=$SUITDIR/FILTERED_FX

    mkdir -p $FILTDIR
    mkdir -p $SUITDIR

    INPUT=$FEATDIR/filtered_func_data.nii.gz
    MAT=$FEATDIR/reg/example_func2highres.mat
    TEMP=$SUITDIR/filtered_func_highres_temp.nii.gz
    REF=$FEATDIR/reg/highres.nii.gz

    fslsplit $INPUT $FILTDIR/filtered_func_data_ -t

  done < $IDLIST
