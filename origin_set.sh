#!bin/bash

cat IDs.txt | while read ID || [ -n "$ID" ] ; do 

fslhd ${ID}_anat.nii.gz | grep "sto_xyz" | awk '{print $2,$3,$4,$5}' >> ${ID}_orig_sform.txt

Rscript --vanilla sform_table.R $ID

SFORM=$(cat ${ID}_sform_new.txt)

cp ${ID}_anat.nii.gz ${ID}_anat_brain_suit.nii.gz
fslorient -setsform $SFORM ${ID}_anat_brain_suit.nii.gz 

fslchfiletype NIFTI ${ID}_anat_brain_suit.nii.gz

#fsleyes ${ID}_anat_ACorigin.nii.gz

done
