#!/bin/bash

printf "ID\tLI\tROI\n" >> LI.txt

for ROI in VI CrusI CrusII VIIb; do

  cat full_sample_n97_3-9-16.txt | while read ID || [[ -n "$ID" ]]; do
      COPE=${ID}_cope3.nii.gz
      
      #Mask cope with ROI
      mkdir -p ROIs/INDIV
      fslmaths $COPE -mas ROIs/${ROI}_SUIT_2mm ROIs/INDIV/${ID}_${ROI}_cope3
      INPUT=ROIs/INDIV/${ID}_${ROI}_cope3
  
      #Find the 95th percentile value; calculate the mean of voxels above this threshold
      UTHR=$(fslstats $INPUT -p 95)
      MEANMAX=$(fslstats $INPUT -l $UTHR -m)
      
      #Set threshold for inclusion in LI calculation at 50% of mean max activation      
      THR=$(echo ${MEANMAX}*.5 | bc -l)
      
      #Threshold image
      fslmaths $INPUT -thr $THR ROIs/INDIV/${ID}_${ROI}_thr
      THRMASK=ROIs/INDIV/${ID}_${ROI}_thr
            
      #Voxel count for LH and RH
      LK=$(fslstats $THRMASK -k ROIs/L${ROI}_SUIT_2mm.nii.gz -V | awk '{print $1}')
      RK=$(fslstats $THRMASK -k ROIs/R${ROI}_SUIT_2mm.nii.gz -V | awk '{print $1}')
      
      #Calculate LI
      LI=$(echo "($LK-$RK)/($LK+$RK)" | bc -l)
      
      printf "${ID}\t${LI}\t${ROI}\n" >> LI.txt
  done
done
