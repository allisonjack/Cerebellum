%% Clear workspace
clear all

%% Load SPM
spm fmri

%% Load IDs
fid = fopen('/PATH_TO_TEXT_FILE_CONTAINING_A_LIST_OF_IDS/IDs.txt');
ID = cell(0,1);

while ~feof(fid)
  ID{size(ID,1)+1,1} = fgetl(fid);
end

%% Create array with paths to subject directories
SUBJDIR = cell(length(ID),1);
for i = 1:length(ID)
    SUBJDIR{i} = fullfile('/PATH_TO_MAIN_SUIT_DIRECTORY/', ID{i});
end

%% This only works for clusters using Slurm
JOBN = str2num(getenv('SLURM_ARRAY_TASK_ID'))

cd (SUBJDIR{JOBN})
suit_reslice('mean_func_highres_run1.nii', 'mc_anat_brain_suit_snc.mat', 'mask', 'cerebellar_mask.nii');
