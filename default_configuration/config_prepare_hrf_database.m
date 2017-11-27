
% CONFIG_PREPARE_HRF_DATABASE
% -------------------------------------------------------------------------
% This script configures config_prepare_hrf_database. Modify each
% variable accordingly.
% -------------------------------------------------------------------------
%
% Author: Jose Ignacio Orlando, PhD.
% Pladema Institute, UNCPBA - CONICET
% email address: jiorlando@conicet.gov.ar  
% Website: github.com/ignaciorlando
% Copyright 2017 - Jose Ignacio Orlando, Matthew B. Blaschko

% output folder
output_folder = fullfile(pwd, 'data');

% Decide whether to save intermediate features or not
saveFeatures = true;