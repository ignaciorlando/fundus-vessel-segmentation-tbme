
% SCRIPT_EVALUATE_EXISTING_MODEL_TBME_2017
% -------------------------------------------------------------------------
% Run this code to evaluate an existing segmentation model, already
% trained. This code WILL NOT learn the FC-CRF using the SOSVM, it will
% just apply an existing model.
%
% The segmentation approach we used is the same than in:
%
% Orlando et al., A discriminatively trained fully connected condition
% random field model for blood vessel segmentation in fundus images, 
% IEEE TBME 2017.
%
% This requires to compute a scaling factor that can be obtained as the 
% average FOV vertical diameter of the images on the test set divided by
% the average FOV vertical diameter on the training set (see \rho in the 
% paper).
% -------------------------------------------------------------------------
%
% Author: Jose Ignacio Orlando, Eng., applied mathematics
% Pladema Institute, UNCPBA - CONICET
% email address: jiorlando@conicet.gov.ar  
% Website: github.com/ignaciorlando
% Copyright 2017 - Jose Ignacio Orlando, Matthew B. Blaschko

warning('off','all');

% Configure this code
config_evaluate_existing_model_tbme_2017;

% Locate model and configuration files
load(fullfile(modelLocation, 'model.mat'));
load(fullfile(modelLocation, 'config.mat'));

% For each of the data sets
for i = 1 : length(datasets_names)
              
    % Set the test path
    config.test_data_path = fullfile(rootDatasets, datasets_names{i});
    config.features.saveFeatures = 1;
    
    % Set the results path
    if (~strcmp(rootResults, 'training'));
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
    
    % Determine if there are test data
    config.thereAreLabelsInTheTestData = (exist(fullfile(config.test_data_path, 'labels'), 'file') ~= 0);
    
    % Run vessel segmentation!
    runVesselSegmentationUsingExistingModel(config, model)
    
end
        