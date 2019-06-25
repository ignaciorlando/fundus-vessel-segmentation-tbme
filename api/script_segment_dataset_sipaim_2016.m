
% SCRIPT_SEGMENT_DATASET_SIPAIM_2016
% -------------------------------------------------------------------------
% This code segment a uniform data set using the modification we proposed 
% in:
%
% Orlando et al., Convolutional neural network transfer for automated
% glaucoma identification, SIPAIM 2016.
%
% This code will copy all the images to a new folder, in which all of them
% will be standardized to the same resolution. Afterwards, you will have to
% delineate a few of the bigger vessels profiles in order to estimate the
% approximate resolution at which vessels appear. Then, all the images will
% be resized again to such resolution, and
% script_evaluate_existing_model_sipaim_2016 will be called.
% -------------------------------------------------------------------------
%
% Author: Jose Ignacio Orlando, Eng., applied mathematics
% Pladema Institute, UNCPBA - CONICET
% email address: jiorlando@conicet.gov.ar  
% Website: github.com/ignaciorlando
% Copyright 2017 - Jose Ignacio Orlando, Matthew B. Blaschko


config_segment_dataset_sipaim_2016;

vessel_of_interest = 8.7333;

% for each data set
for d = 1 : length(datasets_names)
    
    % get current data set name and scale factor
    current_dataset = datasets_names{d};
    
    % analyzing data set
    fprintf('Processing data set %s\n', current_dataset);
    
    % prepare current folder for image data
    current_data_folder = fullfile(image_folder, current_dataset);
    % prepare current folder for outputs
    current_output_data_folder = fullfile(output_segmentations_folder, current_dataset, 'segmentations');
    mkdir(current_output_data_folder);
    
    % copy all images to a new folder
    if exist(fullfile(current_data_folder, '_aux'), 'dir')==0
        standardized_size_dataset_folder = fullfile(current_data_folder, '_aux');
        mkdir(standardized_size_dataset_folder);
        fprintf('Copying all images\n');
        copyfile(fullfile(current_data_folder, 'images'), fullfile(standardized_size_dataset_folder, 'images'), 'f');
        fprintf('Copying all masks\n');
        copyfile(fullfile(current_data_folder, 'masks'), fullfile(standardized_size_dataset_folder, 'masks'), 'f');
    
        % retrieve minimum image size
        fprintf('Retrieving smallest image size\n');
        standardized_size_images_folder = fullfile(standardized_size_dataset_folder, 'images');
        standardized_size_masks_folder = fullfile(standardized_size_dataset_folder, 'masks');
        [min_x, image_names_per_size] = getMinimumImageSize(standardized_size_images_folder);
        fprintf('-- Smallest size is %i\n', min_x);
    
        % standardize image sizes
        fprintf('Standardizing images\n');
        standardizeDatasetSize(standardized_size_images_folder, standardized_size_masks_folder, min_x);

    else
        
        standardized_size_images_folder = fullfile(current_data_folder, '_aux', 'images');
        standardized_size_masks_folder = fullfile(current_data_folder, '_aux', 'masks');
        mask_names = getMultipleImagesFileNames(standardized_size_masks_folder);
        size_mask = size(imread(fullfile(standardized_size_masks_folder, mask_names{1})));
        min_x = size_mask(2);
        
    end
    
    if exist('calibers', 'var')==0
        % Measure vessel calibre
        [calibers] = measure_vessel_calibre(fullfile(image_folder, current_dataset, '_aux'), 5, 3);
        % Take the average and estimate scale factor
        scale_to_downsample = vessel_of_interest / mean(mean(calibers,2));
        % resize the data set
        standardizeDatasetSize(standardized_size_images_folder, standardized_size_masks_folder, round(min_x * scale_to_downsample));
    end
    
    % Segment!!
    fprintf('Segmenting images\n');
    datasets_names = {fullfile(current_dataset, '_aux')};   
    rootDatasets = image_folder;
    rootResults = output_segmentations_folder;
    mkdir(rootResults);
    already_configured = true;
    script_evaluate_existing_model_sipaim_2016;
    
    % resize the segmentations to their original resolution
    
    original_masks_folder = fullfile(current_data_folder, 'masks');
    original_masks_filenames = getMultipleImagesFileNames(original_masks_folder);
    output_segmentations_folder = fullfile(output_segmentations_folder, datasets_names{d});
    segmentations_filenames = getMultipleImagesFileNames(output_segmentations_folder);
    
    for i = 1 : length(original_masks_filenames)
        
        current_segm = imread(fullfile(output_segmentations_folder, segmentations_filenames{i})) > 0;
        current_original_mask = imread(fullfile(original_masks_folder, original_masks_filenames{i})) > 0;
        
        current_segm = imresize(current_segm, size(current_original_mask), 'nearest');
        imwrite(current_segm, fullfile(current_output_data_folder, segmentations_filenames{i}));
        
    end
    
    
    % Delete all auxiliar folder
    try rmdir(fullfile(image_folder, current_dataset, '_aux'),'s'); catch end
    
end