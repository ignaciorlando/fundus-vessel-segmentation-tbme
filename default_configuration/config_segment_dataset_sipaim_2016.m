
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
    'WIDE' ...
};

% Folder where the data sets are located
image_folder = './data';

% Folder where the results are going to be saved
output_segmentations_folder = './data/results';

% Folder where the segmentation model is located
modelLocation = './data/segmentation-model/DRIVE-SIPAIM';

% Decide whether to save intermediate features or not
saveFeatures = true;
