%% Clear workspace
clear all

%% Load SPM
addpath(fullfile('/','home2', 'USERNAME', 'spm12'));
spm fmri

%%Reslice filtered_func IN HIGHRES ANATOMICAL SPACE into SUIT space
suit_reslice('mean_func_highres.nii', 'mc_anat_brain_suit_snc.mat', 'mask', 'cerebellar_mask.nii');
