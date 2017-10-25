
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

vessel_of_interest = 7;

% for each data set
for d = 1 : length(datasets_names)
    
    % get current data set name and scale factor
    current_dataset = datasets_names{d};
    
    % analyzing data set
    fprintf('Processing data set %s\n', current_dataset);
    
    % prepare current folder for image data
    current_image_data_folder = fullfile(image_folder, current_dataset);
    % prepare current folder for outputs
    current_output_data_folder = fullfile(output_segmentations_folder, current_dataset, 'segmentations');
    
    standardized_size_dataset_folder = fullfile(current_image_data_folder, '_aux');
    standardized_size_images_folder = fullfile(standardized_size_dataset_folder, 'images');
    standardized_size_masks_folder = fullfile(standardized_size_dataset_folder, 'masks');
    
    % copy all images to a new folder
    if exist(fullfile(current_image_data_folder, '_aux'), 'dir')==0 
        
        mkdir(standardized_size_dataset_folder);
        fprintf('Copying all images\n');
        copyfile(fullfile(current_image_data_folder, 'images'), fullfile(standardized_size_dataset_folder, 'images'), 'f');
        fprintf('Copying all masks\n');
        copyfile(fullfile(current_image_data_folder, 'masks'), fullfile(standardized_size_dataset_folder, 'masks'), 'f');
    
        % retrieve minimum image size
        fprintf('Retrieving smallest image size\n');
        [min_x, image_names_per_size] = getMinimumImageSize(standardized_size_images_folder);
        fprintf('-- Smallest size is %i\n', min_x);
    
        % standardize image sizes
        fprintf('Standardizing images\n');
        standardizeDatasetSize(standardized_size_images_folder, standardized_size_masks_folder, min_x);
        
        % if the rescaling factor exists, use it
        if exist('scales_to_downsample', 'var')==0
            % Measure vessel calibre
            [calibers] = measure_vessel_calibre(fullfile(image_folder, current_dataset, '_aux'), 5, 3);
            % Take the average and estimate scale factor
            scale_to_downsample = vessel_of_interest / mean(mean(calibers,2));
        else
            scale_to_downsample = scales_to_downsample(d);
        end
        
        % Resize all the images/masks based on scale_to_downsample
        resizeImagesInFolder(standardized_size_images_folder, ...
            standardized_size_masks_folder, scale_to_downsample);          
        
    end
    
    % Segment!!
    fprintf('Segmenting images\n');
    datasets_names = {fullfile(current_dataset, '_aux')};   
    rootDatasets = image_folder;
    rootResults = output_segmentations_folder;
    resultsPath = fullfile(rootResults, current_dataset);
    mkdir(resultsPath);
    already_configured = true;
    script_evaluate_existing_model_sipaim_2016;
    
    % Delete all auxiliar folder
    try rmdir(fullfile(image_folder, current_dataset, '_aux'),'s'); catch end
    
end