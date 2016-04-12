%% Clear workspace

clear all

%% Load SPM
spm fmri

%% Load IDs
fid = fopen('/PATH_TO_YOUR_DIRECTORY/IDs.txt');
ID = cell(0,1);

while ~feof(fid)
ID{size(ID,1)+1,1} = fgetl(fid);
end

%% Create array with paths to subject directories
SUBJDIR = cell(length(ID),1);
for i = 1:length(ID)
    SUBJDIR{i} = fullfile('/PATH_TO_YOUR_DIRECTORY/', ID{i});
end

%% Crop anatomical and mask cerebellum

%Cropped image is: c_anat_brain_suit.nii
%Cerebellar mask is: c_anat_brain_suit_pcereb_corr.nii

%May need to alter bounding box ('bb') values

for i = 1:length(ID)
    cd (SUBJDIR{i})
    suit_isolate('anat_brain_suit.nii', 'bb', [-76, 76; -120, -6; -90, 15])
end

%% Normalize

%Normalize anatomical image into SUIT space
%Output image in SUIT space is: wsuit_mc_anat_brain_suit
%Deformation matrix is: mc_anat_brain_suit_snc.mat

for i = 1:length(ID)
    cd (SUBJDIR{i})
    %suit_normalize('c_anat_brain_suit.nii', 'mask', 'c_anat_brain_suit_pcereb_corr.nii')
    suit_normalize('c_anat_brain_suit.nii', 'mask', 'cerebellar_mask.nii')
end
