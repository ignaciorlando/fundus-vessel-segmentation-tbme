
% SCRIPT_PREPARE_HRF_DATABASE
% -------------------------------------------------------------------------
% Run this code to organize HRF as needed in our scripts
% -------------------------------------------------------------------------
%
% Author: Jose Ignacio Orlando, Eng., applied mathematics
% Pladema Institute, UNCPBA - CONICET
% email address: jiorlando@conicet.gov.ar  
% Website: ignaciorlando.github.io
% Copyright 2017 - Jose Ignacio Orlando, Matthew B. Blaschko

%% set up variables

% set up main variables
config_prepare_hrf_database;

% create folder
mkdir(fullfile(output_folder, 'tmp'));

%% prepare the input data set

% prepare ZIP filename
zip_filename = fullfile(output_folder, 'tmp', 'all.zip');

if exist(zip_filename, 'file') == 0
    % download the images in the tmp folder
    fprintf('Downloading HRF data set...\n');
    websave(fullfile(output_folder, 'tmp', 'all.zip'), ...
        'https://www5.cs.fau.de/fileadmin/research/datasets/fundus-images/all.zip');
end

% check if the file exists
if exist(zip_filename, 'file') ~= 0
    % unzip the file
    fprintf('Unzipping HRF file...\n');
    % unzip on output_folder/tmp
    unzip(zip_filename, fullfile(output_folder, 'tmp'));
else
    throw('File not found');
end

% the input folder will be output_folder + tmp
input_folder = fullfile(output_folder, 'tmp', 'HRF');

%% generate HRF

fprintf('Preparing DRIVE-SIPAIM...\n');

% prepare output folder sipaim
output_folder_sipaim = fullfile(output_folder, 'DRIVE-SIPAIM');
mkdir(output_folder_sipaim);

% copy the training set
mkdir(fullfile(output_folder_sipaim, 'training', 'images'));
copyfile(fullfile(input_folder, 'training', 'images'), ...
    fullfile(output_folder_sipaim, 'training', 'images'));

mkdir(fullfile(output_folder_sipaim, 'training', 'masks'));
copyfile(fullfile(input_folder, 'training', 'mask'), ...
    fullfile(output_folder_sipaim, 'training', 'masks'));

mkdir(fullfile(output_folder_sipaim, 'training', 'labels'));
copyfile(fullfile(input_folder, 'training', '1st_manual'), ...
    fullfile(output_folder_sipaim, 'training', 'labels'));

% copy the validation set (will be the test set)
mkdir(fullfile(output_folder_sipaim, 'validation', 'images'));
copyfile(fullfile(input_folder, 'test', 'images'), ...
    fullfile(output_folder_sipaim, 'validation', 'images'));

mkdir(fullfile(output_folder_sipaim, 'validation', 'masks'));
copyfile(fullfile(input_folder, 'test', 'mask'), ...
    fullfile(output_folder_sipaim, 'validation', 'masks'));

mkdir(fullfile(output_folder_sipaim, 'validation', 'labels'));
copyfile(fullfile(input_folder, 'test', '1st_manual'), ...
    fullfile(output_folder_sipaim, 'validation', 'labels'));

% copy the test set
mkdir(fullfile(output_folder_sipaim, 'test', 'images'));
copyfile(fullfile(input_folder, 'test', 'images'), ...
    fullfile(output_folder_sipaim, 'test', 'images'));

mkdir(fullfile(output_folder_sipaim, 'test', 'masks'));
copyfile(fullfile(input_folder, 'test', 'mask'), ...
    fullfile(output_folder_sipaim, 'test', 'masks'));

mkdir(fullfile(output_folder_sipaim, 'test', 'labels'));
copyfile(fullfile(input_folder, 'test', '1st_manual'), ...
    fullfile(output_folder_sipaim, 'test', 'labels'));

%% generate DRIVE data set with validation set

fprintf('Preparing DRIVE...\n');

% prepare output folder sipaim
output_folder_drive = fullfile(output_folder, 'DRIVE');
mkdir(output_folder_drive);

% copy the training set
mkdir(fullfile(output_folder_drive, 'training', 'images'));
copyfile(fullfile(input_folder, 'training', 'images'), ...
    fullfile(output_folder_drive, 'training', 'images'));

mkdir(fullfile(output_folder_drive, 'training', 'masks'));
copyfile(fullfile(input_folder, 'training', 'mask'), ...
    fullfile(output_folder_drive, 'training', 'masks'));

mkdir(fullfile(output_folder_drive, 'training', 'labels'));
copyfile(fullfile(input_folder, 'training', '1st_manual'), ...
    fullfile(output_folder_drive, 'training', 'labels'));

% copy the validation set (will be the test set)
mkdir(fullfile(output_folder_drive, 'validation', 'images'));
copyfile(fullfile(input_folder, 'training', 'images'), ...
    fullfile(output_folder_drive, 'validation', 'images'));

mkdir(fullfile(output_folder_drive, 'validation', 'masks'));
copyfile(fullfile(input_folder, 'training', 'mask'), ...
    fullfile(output_folder_drive, 'validation', 'masks'));

mkdir(fullfile(output_folder_drive, 'validation', 'labels'));
copyfile(fullfile(input_folder, 'training', '1st_manual'), ...
    fullfile(output_folder_drive, 'validation', 'labels'));

% copy the test set
mkdir(fullfile(output_folder_drive, 'test', 'images'));
copyfile(fullfile(input_folder, 'test', 'images'), ...
    fullfile(output_folder_drive, 'test', 'images'));

mkdir(fullfile(output_folder_drive, 'test', 'masks'));
copyfile(fullfile(input_folder, 'test', 'mask'), ...
    fullfile(output_folder_drive, 'test', 'masks'));

mkdir(fullfile(output_folder_drive, 'test', 'labels'));
copyfile(fullfile(input_folder, 'test', '1st_manual'), ...
    fullfile(output_folder_drive, 'test', 'labels'));

% sample 5 images randomly
validation_idx = sort(datasample(1:20,5, 'Replace', false));

% get filenames
input_folder_for_images = dir(fullfile(output_folder_drive, 'validation', 'images', '*.tif'));
input_folder_for_images = {input_folder_for_images.name};

input_folder_for_labels = dir(fullfile(output_folder_drive, 'validation', 'labels', '*.gif'));
input_folder_for_labels = {input_folder_for_labels.name};

input_folder_for_masks = dir(fullfile(output_folder_drive, 'validation', 'masks', '*.gif'));
input_folder_for_masks = {input_folder_for_masks.name};

% for each folder
for i = 1 : length(input_folder_for_images)
    
    % if the idx is in the training set
    if sum(find(i==validation_idx)) == 0
        delete(fullfile(output_folder_drive, 'validation', 'images', input_folder_for_images{i}));
        delete(fullfile(output_folder_drive, 'validation', 'labels', input_folder_for_labels{i}));
        delete(fullfile(output_folder_drive, 'validation', 'masks', input_folder_for_masks{i}));
    else
        delete(fullfile(output_folder_drive, 'training', 'images', input_folder_for_images{i}));
        delete(fullfile(output_folder_drive, 'training', 'labels', input_folder_for_labels{i}));
        delete(fullfile(output_folder_drive, 'training', 'masks', input_folder_for_masks{i}));
    end
end

%% delete tmp folder
rmdir(fullfile(output_folder, 'tmp'), 's');
fprintf('DRIVE data preparation finished.\n');