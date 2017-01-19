
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
config_train_sipaim_2016_model

% Check if DRIVE-SIPAIM exists
if exist(fullfile(rootDatasets, 'DRIVE-SIPAIM'), 'file') == 0
    
    % Initialize DRIVE-SIPAIM
    mkdir(fullfile(rootDatasets, 'DRIVE-SIPAIM'));
    
    % Copy files
    copyfile(fullfile(rootDatasets, 'DRIVE', 'training'), ...
        fullfile(rootDatasets, 'DRIVE-SIPAIM', 'training'));
    copyfile(fullfile(rootDatasets, 'DRIVE', 'validation'), ...
        fullfile(rootDatasets, 'DRIVE-SIPAIM', 'training'));
    copyfile(fullfile(rootDatasets, 'DRIVE', 'test'), ...
        fullfile(rootDatasets, 'DRIVE-SIPAIM', 'validation'));
    copyfile(fullfile(rootDatasets, 'DRIVE', 'test'), ...
        fullfile(rootDatasets, 'DRIVE-SIPAIM', 'test'));
    
end


% For each of the data sets
results = cell(length(crfVersions), 1);

% For each version of the CRF
for crfver = 1 : length(crfVersions)

    % Get the configuration
    [config] = getConfiguration_GenericDataset_SIPAIM2016('DRIVE-SIPAIM', ... % data set name
                                               fullfile(rootDatasets, 'DRIVE-SIPAIM'), ... % data set folder
                                               fullfile(rootResults, 'segmentation-model'), ... % results folder
                                               learnC, ... % learn C?
                                               crfVersions{crfver}, ... % crf version
                                               cValue ... % default C value
                                       );
    config.thereAreLabelsInTheTestData = 1;
    % Run vessel segmentation!
    results{crfver} = runVesselSegmentation(config);

end

        