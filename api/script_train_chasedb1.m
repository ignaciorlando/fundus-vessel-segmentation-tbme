
% SCRIPT_TRAIN_CHASEDB1
% -------------------------------------------------------------------------
% Run this code to train a FC-CRF on the CHASEDB1 database. The
% segmentation model is mostly described in:
%
% Orlando et al., A discriminatively trained fully connected condition
% random field model for blood vessel segmentation in fundus images, 
% IEEE TBME 2017.
%
% The feature configuration is the optimal.
% -------------------------------------------------------------------------
%
% Author: Jose Ignacio Orlando, PhD.
% Pladema Institute, UNCPBA - CONICET
% email address: jiorlando@conicet.gov.ar  
% Website: github.com/ignaciorlando
% Copyright 2017 - Jose Ignacio Orlando

warning('off','all');

% Configure the script
config_train_chasedb1

datasetName = 'CHASEDB1';
crfVersion = 'fully-connected';

               
% Get the configuration
[config] = getConfigurationPublicDataset(...
    datasetName, ... % data set name
    fullfile(rootDatasets, datasetName), ... % data set folder
    fullfile(modelPath, datasetName), ... % path to save the resulting model
    learnC, ... % learn C?
    crfVersion, ... % crf version
    cValue, ... % default C value
    saveFeatures ...
);
% Train the model
[config, model] = train_segmentation_model(config);

fprintf('Finished!\n');