
root = pwd;

% Add folders
addpath(genpath(fullfile(root, 'Configuration')));
addpath(genpath(fullfile(root, 'Features')));
addpath(genpath(fullfile(root, 'Preprocessing')));
addpath(genpath(fullfile(root, 'Segmentations')));
addpath(genpath(fullfile(root, 'SOSVM')));
addpath(genpath(fullfile(root, 'CRF')));
addpath(genpath(fullfile(root, 'Util', 'other')));
addpath(genpath(fullfile(root, 'Util', 'Evaluation')));
addpath(genpath(fullfile(root, 'Util', 'vlfeat', 'toolbox')));

% Setup VLFeat
vl_setup;

% Compile relevant files
mex ./CRF/CRF_1.0/fullyCRFwithGivenPairwises.cpp ./CRF/CRF_1.0/densecrf.cpp ./CRF/CRF_1.0/util.cpp 
mex ./CRF/CRF_1.0/pairwisePart.cpp ./CRF/CRF_1.0/util.cpp