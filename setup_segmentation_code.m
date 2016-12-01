
root = pwd;

addpath(genpath(fullfile(root, 'Features')));
addpath(genpath(fullfile(root, 'Preprocessing')));
addpath(genpath(fullfile(root, 'Segmentations')));
addpath(genpath(fullfile(root, 'SOSVM')));
addpath(genpath(fullfile(root, 'Util', 'Evaluation')));
addpath(genpath(fullfile(root, 'Util', 'vlfeat', 'toolbox')));

vl_setup;