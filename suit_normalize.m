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

%% Normalize

%Normalize anatomical image into SUIT space
%Output image in SUIT space is: wsuit_mc_anat_brain_suit
%Deformation matrix is: mc_anat_brain_suit_snc.mat

JOBN = str2num(getenv('SLURM_ARRAY_TASK_ID'))
cd (SUBJDIR{JOBN})
suit_normalize('c_anat_brain_suit.nii', 'mask', 'cerebellar_mask.nii')
