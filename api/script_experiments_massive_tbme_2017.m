
% SCRIPT_EXPERIMENTS_MASSIVE_TBME_2017
% -------------------------------------------------------------------------
% Run this code to perform multiple experiments on different data sets. 
% The segmentation approach we used is the same than in:
%
% Orlando et al., A discriminatively trained fully connected condition
% random field model for blood vessel segmentation in fundus images, 
% IEEE TBME 2017.
%
% It will take each of the data sets listed in datasetsNames, and will
% learn the CRF using each training set on each of the folders, and
% evaluate on the images on the test set folder.
% -------------------------------------------------------------------------
%
% Author: Jose Ignacio Orlando, Eng., applied mathematics
% Pladema Institute, UNCPBA - CONICET
% email address: jiorlando@conicet.gov.ar  
% Website: github.com/ignaciorlando
% Copyright 2017 - Jose Ignacio Orlando, Matthew B. Blaschko

warning('off','all');

% Configure the script
config_experiments_massive_tbme_2017

% For each of the data sets
results = cell(length(datasetsNames), length(crfVersions));
for experiment = 1 : length(datasetsNames)

    % For each version of the CRF
    for crfver = 1 : length(crfVersions)
               
        % Get the configuration
        [config] = getConfiguration_GenericDataset(datasetsNames{experiment}, ... % data set name
                                                   fullfile(rootDatasets, datasetsNames{experiment}), ... % data set folder
                                                   fullfile(rootResults, datasetsNames{experiment}), ... % results folder
                                                   learnC, ... % learn C?
                                                   crfVersions{crfver}, ... % crf version
                                                   cValue ... % default C value
                                                   saveFeatures ...
                                                   scaling_factors(experiment) ...
                                           );
        config.thereAreLabelsInTheTestData = (exist(fullfile(config.test_data_path, 'labels'), 'file') ~= 0);
        % Run vessel segmentation!
        results{experiment,crfver} = runVesselSegmentation(config);
        
    end
    
end
        