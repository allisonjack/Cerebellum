%% Clear workspace
clear all

%% Load SPM
spm fmri

%% Load IDs
fid = fopen('/lustre/groups/andi/GA_collab/SUIT/ASD_IDs.txt');
ID = cell(0,1);

while ~feof(fid)
  ID{size(ID,1)+1,1} = fgetl(fid);
end

%% Create array with paths to subject directories
SUBJDIR = cell(length(ID),1);
for i = 1:length(ID)
    SUBJDIR{i} = fullfile('/lustre/groups/andi/GA_collab/SUIT/', ID{i});
end

%% This only works for clusters using Slurm
JOBN = str2num(getenv('SLURM_ARRAY_TASK_ID'))

cd (SUBJDIR{JOBN})
suit_reslice('mean_func_highres_run1.nii', 'mc_anat_brain_suit_snc.mat', 'mask', 'cerebellar_mask.nii');
