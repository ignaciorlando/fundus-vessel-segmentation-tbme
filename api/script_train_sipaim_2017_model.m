
% SCRIPT_TRAIN_SIPAIM_2016_MODEL
% -------------------------------------------------------------------------
% Run this code to learn a segmentation model from DRIVE using the method 
% in:
%
% Orlando et al., A discriminatively trained fully connected condition
% random field model for blood vessel segmentation in fundus images, 
% IEEE TBME 2017.
%
% This will allow you to run scripts ended with the "_SIPAIM 2016" tag
% -------------------------------------------------------------------------
%
% Author: Jose Ignacio Orlando, Eng., applied mathematics
% Pladema Institute, UNCPBA - CONICET
% email address: jiorlando@conicet.gov.ar  
% Website: github.com/ignaciorlando
% Copyright 2017 - Jose Ignacio Orlando, Matthew B. Blaschko

warning('off','all');

% Configure the script
config_train_sipaim_2017_model

% For each of the data sets
results = cell(length(crfVersions), 1);

% For each version of the CRF
for crfver = 1 : length(crfVersions)

    % Get the configuration
    [config] = getConfiguration_GenericDataset_SIPAIM2017('HRF', ... % data set name
                       fullfile(rootDatasets, 'HRF'), ... % data set folder
                       fullfile(rootDatasets, 'results','HRF'), ... % results folder
                       learnC, ... % learn C?
                       crfVersions{crfver}, ... % crf version
                       cValue, ... % default C value
                       saveFeatures ... %
               );
    config.thereAreLabelsInTheTestData = thereAreLabelsInTheTestData;
    % Run vessel segmentation!
    [results, config, model] = runVesselSegmentation(config);
    % Save model and configuration
    mkdir(fullfile(rootDatasets, 'segmentation-model', 'HRF'));
    save(fullfile(rootDatasets, 'segmentation-model', 'HRF', 'config.mat'), 'config');
    save(fullfile(rootDatasets, 'segmentation-model', 'HRF', 'model.mat'), 'model');

end

        