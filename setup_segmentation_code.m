
% SETUP_SEGMENTATION_CODE
% -------------------------------------------------------------------------
% Run this code to setup the segmentation code, adding folders to the path
% and compiling .mex files.
% -------------------------------------------------------------------------
%
% Author: Jos? Ignacio Orlando, Eng., applied mathematics
% Pladema Institute, UNCPBA - CONICET
% email address: jiorlando@conicet.gov.ar  
% Website: github.com/ignaciorlando
% Copyright 2017 - Jos? Ignacio Orkando, Matthew B. Blaschko

% Retrieve current directory
root = pwd;

% An ignored folder, namely configuration, will be created for you so you
% just have to edit configuration scripts there without having to commit
% every single change you made
if exist('configuration', 'file')==0
    % Create folder
    mkdir('configuration');
    % Copy default configuration files
    copyfile('default_configuration', 'configuration');
end

% Add folders to path
addpath(genpath(fullfile(root, 'api')));
addpath(genpath(fullfile(root, 'configuration')));
addpath(genpath(fullfile(root, 'core')));
addpath(genpath(fullfile(root, 'evaluation')));
addpath(genpath(fullfile(root, 'fundus-util')));
addpath(genpath(fullfile(root, 'external', 'vlfeat', 'toolbox')));

% Setup VLFeat
vl_setup;

% Compile relevant files
mex -outdir ./core/CRF/CRF_1.0/ ./core/CRF/CRF_1.0/fullyCRFwithGivenPairwises.cpp ./core/CRF/CRF_1.0/densecrf.cpp ./core/CRF/CRF_1.0/util.cpp 
mex -outdir ./core/CRF/CRF_1.0/ ./core/CRF/CRF_1.0/pairwisePart.cpp ./core/CRF/CRF_1.0/util.cpp

% Clean everything
clear
clc

% Print a nice message
fprintf('Vessel segmentation setup finished. Everything was fine :-)\n');