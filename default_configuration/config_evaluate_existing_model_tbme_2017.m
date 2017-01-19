
% CONFIG_EVALUATE_EXISTING_MODEL_TBME_2017
% -------------------------------------------------------------------------
% This code setup script_evaluate_existing_model_tbme_2017.
% It reproduces the modification we proposed in:
%
% Edit each variable according to your own data sets. We provide some 
% values as an example.
% -------------------------------------------------------------------------
%
% Author: Jose Ignacio Orlando, Eng., applied mathematics
% Pladema Institute, UNCPBA - CONICET
% email address: jiorlando@conicet.gov.ar  
% Website: github.com/ignaciorlando
% Copyright 2017 - Jose Ignacio Orlando, Matthew B. Blaschko

% Data sets to segment
datasets_names = {...
    'DRIVE' ...
    'STARE' ...
    'CHASEDB1' ...
    'HRF' ...
    'ARIA' ...
};

% TO DO: MODIFY THIS AS IN TBME
scale_to_downsample = [ ...
    1.00000 ...
    0.74011 ...
    0.74011 ...
    0.96324 ...
    0.81875 ...
];

% Folder where the data sets are located
rootDatasets = './data';

% Folder where the results are going to be saved
rootResults = './results';

% Folder where the segmentation model is located
modelLocation = './segmentation-model';

