%% Clear workspace
clear all

%% Load SPM
spm fmri

%% Normalize anatomical image into SUIT space
suit_normalize('c_anat_brain_suit.nii', 'mask', 'cerebellar_mask.nii');
