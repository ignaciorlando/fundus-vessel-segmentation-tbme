
% CONFIG_PREPARE_DRIVE_DATABASE
% -------------------------------------------------------------------------
% This script configures config_prepare_drive_database. Modify each
% variable accordingly.
% -------------------------------------------------------------------------
%
% Author: Jose Ignacio Orlando, Eng., applied mathematics
% Pladema Institute, UNCPBA - CONICET
% email address: jiorlando@conicet.gov.ar  
% Website: github.com/ignaciorlando
% Copyright 2017 - Jose Ignacio Orlando, Matthew B. Blaschko

% input folder
input_folder = '/Users/ignaciorlando/Downloads';

% output folder
output_folder = fullfile(pwd, 'data');

% Decide whether to save intermediate features or not
saveFeatures = true;