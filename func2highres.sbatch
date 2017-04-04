#!/bin/bash

#SBATCH -J func2highres_run1
#SBATCH -n 32
#SBATCH -p short
#SBATCH -t 00:03:00
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=USERNAME@EMAIL.edu
#SBATCH -o func2highres_run1_%A_%a.out
#SBATCH -e func2highres_run1_%A_%a.err

source ~/.bashrc
module load fsl/gcc/5.0.7

STUDYDIR=/PATH_TO_STUDY_DIRECTORY
IDFILE=$STUDYDIR/PATH_TO_IDS/IDs.txt
RUN=1

cat $IDFILE | while read ID || [ -n "$ID" ]; do
  PRESTATS=$STUDYDIR/ANALYSIS/PRESTATS_SUIT/$ID
  FEATDIR=$PRESTATS/${ID}_run${RUN}.feat
  SUITDIR=$STUDYDIR/SUIT/$ID
  FILTDIR=$SUITDIR/FILTERED_FX/RUN${RUN}

  MAT=$FEATDIR/reg/example_func2highres.mat
  REF=$FEATDIR/reg/highres.nii.gz

  SPLIT=$(printf "%04g" ${SLURM_ARRAY_TASK_ID})
  FX=$FILTDIR/filtered_func_data_${SPLIT}.nii.gz
  FXTEMP=$FILTDIR/filtered_func_highres_${SPLIT}_temp.nii.gz
  
  flirt -in $FX -applyxfm -init $MAT -out $FXTEMP -paddingsize 0.0 -interp trilinear -ref $REF
  fslchfiletype NIFTI $FXTEMP $FILTDIR/filtered_func_highres_${SPLIT}.nii
  
  rm $FXTEMP
done

#call with:
# sbatch --array=0-279 func2highres.sbatch
# where array option gives the number of volumes to be processed
# I have yet to figure out a good way to do this without a loop over either the subjects or the volumes
