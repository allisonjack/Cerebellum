%% Clear workspace

clear all

%% Load SPM
spm fmri

%% Load IDs
fid = fopen('/lustre/groups/andi/CDD_R01/SUIT/IDs_new_batch.txt');
ID = cell(0,1);

while ~feof(fid)
ID{size(ID,1)+1,1} = fgetl(fid);
end

%% Create array with paths to subject directories
SUBJDIR = cell(length(ID),1);
for i = 1:length(ID)
    SUBJDIR{i} = fullfile('/lustre/groups/andi/CDD_R01/SUIT/', ID{i});
end

%%For Slurm

JOBN = str2num(getenv('SLURM_ARRAY_TASK_ID'))
cd (SUBJDIR{JOBN})

%% Crop anatomical and mask cerebellum

%Cropped image is: c_anat_brain_suit.nii
%Cerebellar mask is: c_anat_brain_suit_pcereb_corr.nii

%May need to alter bounding box ('bb') values

suit_isolate_seg({'anat_brain_suit.nii'})
