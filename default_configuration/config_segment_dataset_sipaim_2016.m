
% CONFIG_SEGMENT_DATA_SET_SIPAIM_2016
% -------------------------------------------------------------------------
% This code setup script_segment_data_set_sipaim_2016.
% It reproduces the modification we proposed in:
%
% Orlando et al., Convolutional neural network transfer for automated
% glaucoma identification, SIPAIM 2016.
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
    fullfile('DIARETDB1', 'train') ...
    fullfile('DIARETDB1', 'test') ...
    'e-ophtha' ...
    'MESSIDOR' ...
};

% folder where images, masks and stuff are stored
image_folder = '/Users/ignaciorlando/Documents/_vessels';

% folder where vessel segmentations will be saved
output_segmentations_folder = '/Users/ignaciorlando/Documents/_vessels/segmentations';

% The segmentation model has to be located in this folder
modelLocation = '/Users/ignaciorlando/Documents/_vessels/segmentation-model';

