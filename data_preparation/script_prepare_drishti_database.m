
% SCRIPT_PREPARE_DRISHTI_DATABASE
% -------------------------------------------------------------------------
% Run this code to organize DRISHTI as needed in our scripts
% -------------------------------------------------------------------------
%
% Author: Jose Ignacio Orlando, Eng., applied mathematics
% Pladema Institute, UNCPBA - CONICET
% email address: jiorlando@conicet.gov.ar  
% Website: github.com/ignaciorlando
% Copyright 2017 - Jose Ignacio Orlando, Matthew B. Blaschko

%% set up variables

% set up main variables
config_prepare_drishti_database;

%% prepare the input data set

% prepare input folder name
input_folder = fullfile(input_folder, 'Drishti-GS1_files');

%% generate DRISHTI-GS1

fprintf('Preparing DRISHTI-GS1...\n');

% prepare output folder
output_folder_dataset = fullfile(output_folder, 'DRISHTI-GS1');
mkdir(output_folder_dataset);

% copy the training set
mkdir(fullfile(output_folder_dataset, 'images'));
copyfile(fullfile(input_folder, 'Drishti-GS1_files', 'Training', 'Images'), ...
    fullfile(output_folder_dataset, 'images'));
% and the test set
copyfile(fullfile(input_folder, 'Drishti-GS1_files', 'Test', 'Images'), ...
    fullfile(output_folder_dataset, 'images'));

% generate FOV masks
root = output_folder_dataset;
threshold = 0.1;
GenerateFOVMasks;

%% done!
fprintf('DRISHTI-GS1 data preparation finished.\n');