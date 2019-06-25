
% SCRIPT_SEGMENT_DATASET_CHASEDB1
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
%
% Author: Jose Ignacio Orlando, PhD., applied mathematics
% Pladema Institute, UNCPBA - CONICET
% email address: jiorlando@conicet.gov.ar  
% Website: github.com/ignaciorlando
% Copyright 2017 - Jose Ignacio Orlando, Matthew B. Blaschko


config_segment_dataset_chasedb1;

    
% get current data set name and scale factor
dataset_name;

% load the configuration file
load(fullfile(modelLocation, 'config.mat'));
% load the model file
load(fullfile(modelLocation, 'model.mat'));

% prepare image folder and masks
img_folder = fullfile(image_folder, dataset_name, 'images');
masks_folder = fullfile(image_folder, dataset_name, 'masks');

% retrieve image and masks filenames
img_names = getMultipleImagesFileNames(img_folder);
mask_names = getMultipleImagesFileNames(masks_folder);

% retrieve the original x size of the images in the training set
switch config.dataset
    case 'DRIVE'
        size_ = 565;
    case 'STARE'
        size_ = 605;
    case 'CHASEDB1'
        size_ = 999;
    case 'HRF'
        size_ = 3504;
end  
        
% for each image, verify if the feature file exist. if it is not there,
% then we should compute it
for i = 1 : length(img_names)

    fprintf('Extracting features from %i/%i\n',i,length(img_names));

    % open the mask
    mask = imread(fullfile(masks_folder, mask_names{i})) > 0;
    mask = mask(:,:,1);
    
    % resize the mask
    mask = imresize(mask, size(mask, 2) / size_, 'nearest');
    
    
    
    testdata.masks{1} = mask;

    % UNARY FEATURES --------------------------------------------------
    selectedFeatures = config.features.unary.unaryFeatures;
    config2 = config;

    % Remove features we will not include
    config2.features.features(selectedFeatures==0) = [];
    config2.features.featureParameters(selectedFeatures==0) = [];
    config2.features.featureNames(selectedFeatures==0) = [];

    fprintf(strcat('Computing unary features\n'));
    % get the features of this image
    testdata.unaryFeatures = extractFeaturesFromSingleImage(img_folder, img_names{i}, mask, config2, true);
    % get features dimensionality
    config.features.unary.unaryDimensionality = size(testdata.unaryFeatures, 2);
    %
    if (~iscell(testdata.unaryFeatures))
        testdata.unaryFeatures = {testdata.unaryFeatures};
    end
    % get image filename
    filename = img_names{i};
    if (~iscell(filename))
        testdata.filenames = {filename(1:end-4)};
    else
        testdata.filenames = filename(1:end-4);
    end

    % PAIRWISE FEATURES -----------------------------------------------
    selectedFeatures = config.features.pairwise.pairwiseFeatures;
    config2 = config;

    % Remove features we will not include
    config2.features.features(selectedFeatures==0) = [];
    config2.features.featureParameters(selectedFeatures==0) = [];
    config2.features.featureNames(selectedFeatures==0) = [];

    fprintf(strcat('Computing pairwise features\n'));
    % get the features of this image
    pairwisefeatures = {extractFeaturesFromSingleImage(img_folder, img_names{i}, mask, config2, false)};
    % get features dimensionality
    config.features.unary.pairwiseDimensionality = size(pairwisefeatures, 2);
    % compute the pairwise kernels
    testdata.pairwiseKernels = getPairwiseFeatures(pairwisefeatures, config.features.pairwise.pairwiseDeviations);
    % get current label
    if ~isempty(allLabels)
        testdata.labels{1} = allLabels{i};
    end

    % Segment test data to evaluate the model -------------------------
    [current_results.segmentations, current_results.qualityMeasures] = getBunchSegmentations2(config, testdata, model);

    % Save the segmentations ------------------------------------------
    SaveSegmentations(config.resultsPath, config, current_results, model, testdata.filenames);

    % Save current performance
    if config.thereAreLabelsInTheTestData
        results.qualityMeasures.se(i) = current_results.qualityMeasures.se;
        results.qualityMeasures.sp(i) = current_results.qualityMeasures.sp;
        results.qualityMeasures.acc(i) = current_results.qualityMeasures.acc;
        results.qualityMeasures.precision(i) = current_results.qualityMeasures.precision;
        results.qualityMeasures.fMeasure(i) = current_results.qualityMeasures.fMeasure;
        results.qualityMeasures.matthews(i) = current_results.qualityMeasures.matthews;
    end
    results.qualityMeasures.time(i) = current_results.qualityMeasures.time;

end

% Take average performance
if config.thereAreLabelsInTheTestData
    results.averageQualityMeasures.se = mean(results.qualityMeasures.se);
    results.averageQualityMeasures.sp = mean(results.qualityMeasures.sp);
    results.averageQualityMeasures.acc = mean(results.qualityMeasures.acc);
    results.averageQualityMeasures.precision = mean(results.qualityMeasures.precision);
    results.averageQualityMeasures.fMeasure = mean(results.qualityMeasures.fMeasure);
    results.averageQualityMeasures.matthews = mean(results.qualityMeasures.matthews);
end
results.averageQualityMeasures.time = mean(results.qualityMeasures.time);