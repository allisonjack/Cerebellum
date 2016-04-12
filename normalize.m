%% Clear workspace
clear all

%% Load SPM
addpath(fullfile('/','home2', 'USERNAME', 'spm12'));
spm fmri

%% Normalize anatomical image into SUIT space
suit_normalize('c_anat_brain_suit.nii', 'mask', 'cerebellar_mask.nii');
