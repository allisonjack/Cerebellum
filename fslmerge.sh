#!/bin/bash

STUDYDIR=/PATH_TO_YOUR_DIRECTORY/USERNAME/STUDYNAME
LVL1=$SCRATCH/ADULT/ANALYSIS/PPI_LVL1_SUIT
IDLIST=$SCRATCH/LVL3_SUIT_motion_matched/AC_matched.txt

  for ROI in iRpSTS LpSTS; do

    LVL3=$SCRATCH/${ROI}_PPI_LVL3_SUIT_motion_matched
    mkdir -p $LVL3

      while read -r ID || [[ -n "$ID" ]]; do

        SUBJDIR=$LVL1/$ROI/${ID}.feat/stats

        printf "$SUBJDIR/cope3.nii.gz " >> copein_${ROI}_tmp.txt
        printf "$SUBJDIR/varcope3.nii.gz " >> varcopein_${ROI}_tmp.txt

      done < $IDLIST

    COPEIN=$(cat copein_${ROI}_tmp.txt)
    VARCOPEIN=$(cat varcopein_${ROI}_tmp.txt)

    fslmerge -t $LVL3/AC_cope3_4D.nii.gz $COPEIN
    fslmerge -t $LVL3/AC_varcope3_4D.nii.gz $VARCOPEIN

  done

rm *tmp*
