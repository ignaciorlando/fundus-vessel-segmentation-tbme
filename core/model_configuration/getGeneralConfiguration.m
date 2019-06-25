function [config] = getGeneralConfiguration(config)
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
    config.preprocessing.fakepad_extension = 50;
    config.preprocessing.erosion = 5;
    config.preprocessing.winSize = 40;
    config.preprocessing.enhancement = 'no';

    % ---------------------------------------------------------------------
    % Model selection metric
    config.modelSelectionMetric = 'fMeasure';

    % ---------------------------------------------------------------------
    % Feature configurations 
    
    switch config.dataset
        
        case 'DRIVE'
            % Intensities
            options.Intensities.winsize = 35;
            options.Intensities.fakepad_extension = config.preprocessing.fakepad_extension;
            options.Intensities.filter = 'median';
            % Nguyen
            options.Nguyen2013.w = 16;   
            options.Nguyen2013.step = 4;
            % Soares
            options.Soares2006.scales = [1 2 3];
            % Zana
            options.Zana2001.l = 15;
            options.Zana2001.winsize = 7;
            options.Zana2001.Intensities = options.Intensities;
        case 'STARE'
            % Intensities
            options.Intensities.winsize = 35;
            options.Intensities.fakepad_extension = config.preprocessing.fakepad_extension;
            options.Intensities.filter = 'median';
            % Nguyen
            options.Nguyen2013.w = 16;   
            options.Nguyen2013.step = 4;
            % Soares
            options.Soares2006.scales = [3];
            % Zana
            options.Zana2001.l = 18;
            options.Zana2001.winsize = 7;
            options.Zana2001.Intensities = options.Intensities;
        case 'CHASEDB1'
            % Intensities
            options.Intensities.winsize = 35;
            options.Intensities.fakepad_extension = config.preprocessing.fakepad_extension;
            options.Intensities.filter = 'median';
            % Nguyen
            options.Nguyen2013.w = ceil(15 * config.scale_factor);   
            options.Nguyen2013.step = ceil(2 * config.scale_factor);
            % Soares
            options.Soares2006.scales = ceil([2 3 4 5] * config.scale_factor);
            % Zana
            options.Zana2001.l = ceil(9 * config.scale_factor);
            options.Zana2001.winsize = ceil(7 * config.scale_factor);
            options.Zana2001.Intensities = options.Intensities;
        case 'HRF'
            % Intensities
            options.Intensities.winsize = 35;
            options.Intensities.fakepad_extension = config.preprocessing.fakepad_extension;
            options.Intensities.filter = 'median';
            % Nguyen
            options.Nguyen2013.w = ceil(15 * config.scale_factor);   
            options.Nguyen2013.step = ceil(2 * config.scale_factor);
            % Soares
            options.Soares2006.scales = ceil([2 3 4 5] * config.scale_factor);
            % Zana
            options.Zana2001.l = ceil(9 * config.scale_factor);
            options.Zana2001.winsize = ceil(7 * config.scale_factor);
            options.Zana2001.Intensities = options.Intensities;
    end
    

        
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
    config.theta_p.values = [3 7 5];
    config.theta_p.values = config.theta_p.values * config.scale_factor;

    % ---------------------------------------------------------------------
    % Constants
    config.biasMultiplier = 1;
    
end