
% SCRIPT_EVALUATE_EXISTING_MODEL_SIPAIM_2016
% -------------------------------------------------------------------------
% Run this code to evaluate an existing segmentation model, already
% trained. This code WILL NOT learn the FC-CRF using the SOSVM, it will
% just apply an existing model.
%
% The segmentation approach we used is the same than in TBME 2017, but
% using the scaling criterion presented in:
%
% Orlando et al., Convolutional neural network transfer for automated
% glaucoma identification, SIPAIM 2016.
%
% This requires to downsample the images to a resolution similar to the one
% of the images in your training set (e. g., on DRIVE). We did this by just
% measuring the bigger vessels in the training and test sets and taking the
% cocient between them.
% -------------------------------------------------------------------------
%
% Author: Jose Ignacio Orlando, Eng., applied mathematics
% Pladema Institute, UNCPBA - CONICET
% email address: jiorlando@conicet.gov.ar  
% Website: github.com/ignaciorlando
% Copyright 2017 - Jose Ignacio Orlando, Matthew B. Blaschko

warning('off','all');

% Configure this code
if exist('already_configured', 'var')==0
    config_evaluate_existing_model_sipaim_2016;
end

% Locate model and configuration files
load(fullfile(modelLocation, 'model.mat'));
load(fullfile(modelLocation, 'config.mat'));

% For each of the data sets
for i = 1 : length(datasets_names)
              
    % Set the test path
    config.test_data_path = fullfile(rootDatasets, datasets_names{i});
    config.features.saveFeatures = 1;
    
    % Set the results path
    if (~strcmp(rootResults, 'training'))
        if strcmp(config.crfVersion, 'up')
            resultsPath = fullfile(rootResults, datasets_names{i});
        else
            resultsPath = fullfile(rootResults, datasets_names{i});
        end
        if (~exist(resultsPath,'dir'))
            config.output_path = resultsPath;
            mkdir(resultsPath);
        end
    end
    config.resultsPath = resultsPath;

    % Assign downsample factor
    config.downsample_factor = scale_to_downsample(i);
    
    % Determine if you want to save results or not
    config.features.saveFeatures = saveFeatures;
    
    % Determine if there are test data
    config.thereAreLabelsInTheTestData = (exist(fullfile(config.test_data_path, 'labels'), 'file') ~= 0);
    
    % Run vessel segmentation!
    runVesselSegmentationUsingExistingModel(config, model)
    
end
        