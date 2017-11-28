
% CONFIG_TRAIN_SIPAIM_2016_MODEL
% -------------------------------------------------------------------------
% This code setup script_train_sipaim_2016_model.
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


% Folder where the data sets are located
rootDatasets = './data';

% Folder where the results are going to be saved
rootResults = './results';

% Flag indicating if the value of C is going to be tuned according to the
% validation set
learnC = 0;

% CRF versions that are going to be evaluated
crfVersions = {'fully-connected'};

% Default C value (it will be used only if learnC is 0)
cValue = 10^2;

% Decide whether to save intermediate features or not
saveFeatures = true;