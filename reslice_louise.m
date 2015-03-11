%% Clear workspace
clear all

%% Load SPM
addpath(fullfile('/','home2', 'aj349', 'spm8'));
spm fmri

%%Reslice filtered_func IN HIGHRES ANATOMICAL SPACE into SUIT space
matlabpool(8)
parfor ii = 0:143
    FILTFX = sprintf('filtered_func_highres_%04d.nii', ii);
    suit_reslice(FILTFX, 'mc_anat_brain_suit_snc.mat', 'mask', 'cerebellar_mask.nii');
end
