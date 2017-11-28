function [config] = getGeneralConfiguration_SIPAIM2017(config)
% getGeneralConfiguration Prepares the config structure with the
% configuration of features
% [config] = getGeneralConfiguration(config)
% config: prefilled config structure

    % ---------------------------------------------------------------------
    % SOSVM configuration
    config.SOSVM.usePositivityConstraint = 1;
    
    % ---------------------------------------------------------------------
    % Preprocessing
    config.preprocessing.preprocess = 1;
    config.preprocessing.fakepad_extension = ceil( 50 * config.scale_factor );
    config.preprocessing.erosion = 5;
    config.preprocessing.winSize = ceil(40 * config.scale_factor);
    config.preprocessing.enhancement = 'no';

    % ---------------------------------------------------------------------
    % Model selection metric
    config.modelSelectionMetric = 'fMeasure';

    % ---------------------------------------------------------------------
    % Feature configurations     
    % Intensities
        options.Intensities.winsize = ceil(35 * config.scale_factor);
        options.Intensities.fakepad_extension = config.preprocessing.fakepad_extension;
        options.Intensities.filter = 'median';
    % Nguyen
        options.Nguyen2013.w = ceil(parameter_estimator('ddo', 365.42 / 2, 'Nguyen') * config.scale_factor);   
        options.Nguyen2013.step = ceil(2 * config.scale_factor);
    % Soares
        options.Soares2006.scales = ceil(parameter_estimator('av', 25.11/2, 'Soares') * config.scale_factor);
    % Zana
        options.Zana2001.l = ceil(parameter_estimator('ddo', 365.42 / 2,'Zana') * config.scale_factor);
        %options.Zana2001.winsize = ceil(7 * config.scale_factor);
        %options.Zana2001.Intensities = options.Intensities;
        
    % RESULTS ------------------------------------------------------------

    % General feature configuration
    config.features.features = {... 
        @Nguyen2013, ...
        @Soares2006, ...
        @Zana2001, ...
        };
    config.features.numberFeatures = length(config.features.features);
    config.features.featureNames = {...
        'nguyen', ...
        'soares', ...
        'zana', ...
    	};

    % Assign options
    config.features.featureParameters = {...
        options.Nguyen2013, ...
        options.Soares2006, ...
        options.Zana2001 ...
        };
    
    % ---------------------------------------------------------------------
    % CRF configuration
    if strcmp(config.crfVersion, 'local-neighborhood-based') % in case the method is local-neighborhood based
        config.learn.theta_p = 0;
    end

    % Theta_p learning
    config.theta_p.values = [3 1 5];
    %config.theta_p.values = [3 1 5];
    config.theta_p.values = config.theta_p.values * 3.1;

    % ---------------------------------------------------------------------
    % Constants
    config.biasMultiplier = 1;
    
end