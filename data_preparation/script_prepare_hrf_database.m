
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
else
    fprintf('HRF zip file found. Skipping download...\n');
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
input_folder = fullfile(output_folder, 'tmp');

%% generate HRF

fprintf('Resizing images on HRF to half of their resolution...\n');

% prepare data folders
input_image_folder = fullfile(input_folder, 'images');
input_labels_folder = fullfile(input_folder, 'manual1');
input_fov_mask_folder = fullfile(input_folder, 'mask');

% resize all the images to half of their original size
image_filenames = getMultipleImagesFileNames(input_image_folder);
labels_filenames = getMultipleImagesFileNames(input_labels_folder);
fov_masks_filenames = getMultipleImagesFileNames(input_fov_mask_folder);

for i = 1 : length(image_filenames)
    
    % get current image filename
    current_image_filename = image_filenames{i};
    
    % open the images
    I = imread(fullfile(input_image_folder, current_image_filename));
    gt = imread(fullfile(input_labels_folder, labels_filenames{i}));
    fov_mask = imread(fullfile(input_fov_mask_folder, fov_masks_filenames{i}));
    
    % resize them
    I = imresize(I, 0.5);
    gt = imresize(gt, 0.5, 'nearest');
    fov_mask = imresize(fov_mask, 0.5, 'nearest');
    
    % remove the jpeg extension
    current_image_filename = strcat(current_image_filename(1:end-4), '.png');
    delete(fullfile(input_image_folder, image_filenames{i}));
    image_filenames{i} = current_image_filename;
    
    % save the rescaled images
    imwrite(I, fullfile(input_image_folder, current_image_filename));
    imwrite(gt, fullfile(input_labels_folder, labels_filenames{i}));
    imwrite(fov_mask, fullfile(input_fov_mask_folder, fov_masks_filenames{i}));
    
end

% prepare output folders
output_folder_hrf = fullfile(output_folder, 'HRF');
mkdir(output_folder_hrf);

fprintf('Copying images...\n');

for i = 1 : length(image_filenames)
    
    if i <= 12
        dataset_tag = 'training';
    elseif (i > 12) && (i <= 15)
        dataset_tag = 'validation';
    else
        dataset_tag = 'test';
    end
    
    output_images_folder = fullfile(output_folder_hrf, dataset_tag, 'images');
    output_labels_folder = fullfile(output_folder_hrf, dataset_tag, 'labels');
    output_masks_folder = fullfile(output_folder_hrf, dataset_tag, 'masks');
        
    if (i==1) || (i==13) || (i==16)
        mkdir(output_images_folder)
        mkdir(output_labels_folder)
        mkdir(output_masks_folder)
    end
    
    copyfile(fullfile(input_image_folder, image_filenames{i}), ...
        output_images_folder);
    copyfile(fullfile(input_labels_folder, labels_filenames{i}), ...
        output_labels_folder);
    copyfile(fullfile(input_fov_mask_folder, fov_masks_filenames{i}), ...
        output_masks_folder);
    
end


%% delete tmp folder
rmdir(fullfile(output_folder, 'tmp'), 's');
fprintf('HRF data preparation finished.\n');