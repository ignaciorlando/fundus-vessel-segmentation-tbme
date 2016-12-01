
warning('off','all');

rootDatasets = '/Users/ignaciorlando/Documents/_vessels';
rootResults = '/Users/ignaciorlando/Documents/_vessels/results';


% Datasets names
datasetsNames = {...
    'DRIVE' ...
};
thereAreLabelsInTheTestData = 1;

% Flag indicating if the value of C is going to be tuned according to the
% validation set
learnC = 1;
% CRF versions that are going to be evaluated
crfVersions = {'fully-connected'};

% C values
cValue = 10^2;


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
                                           );
        config.thereAreLabelsInTheTestData = thereAreLabelsInTheTestData(experiment);
        % Run vessel segmentation!
        results{experiment,crfver} = runVesselSegmentation(config);
        
    end
    
end
        