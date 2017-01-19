
% CONFIG_EVALUATE_EXISTING_MODEL_SIPAIM_2016
% -------------------------------------------------------------------------
% This code setup script_evaluate_existing_model_sipaim_2016.
% It reproduces the modification we proposed in:
%
% Orlando et al., Convolutional neural network transfer for automated
% glaucoma identification, SIPAIM 2016.
%
% Edit each variable according to your own data sets. We provide some 
% values as an example.
% -------------------------------------------------------------------------
%
% Author: Jos? Ignacio Orlando, Eng., applied mathematics
% Pladema Institute, UNCPBA - CONICET
% email address: jiorlando@conicet.gov.ar  
% Website: github.com/ignaciorlando
% Copyright 2017 - Jos? Ignacio Orlando, Matthew B. Blaschko

% Data sets to segment
datasets_names = {...
    'DRIVE' ...
    'DIARETDB1\train' ...
    'DIARETDB1\test' ...
    'e-ophtha' ...
    'MESSIDOR' ...
};

% Scale to downsample (as in Orlando et al., SIPAIM 2016). This values are
% used
scale_to_downsample = [ ...
    1.00000 ...
    0.74011 ...
    0.74011 ...
    0.96324 ...
    0.81875 ...
];

% Folder where the data sets are located
rootDatasets = '/Users/ignaciorlando/Documents/_vessels';

% Folder where the results are going to be saved
rootResults = '/Users/ignaciorlando/Documents/_vessels/segmentations';

% Folder where the segmentation model is located
modelLocation = '/Users/ignaciorlando/Documents/_vessels/segmentation-model';

