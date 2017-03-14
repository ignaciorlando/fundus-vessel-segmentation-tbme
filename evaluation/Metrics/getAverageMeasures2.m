
function [averageQualityMeasures] = getAverageMeasures2(qualityMeasures)
% getAverageMeasures2 Compute the average measures
% [averageQualityMeasures] = getAverageMeasures2(qualityMeasures)
% OUTPUT: averageQualityMeasures: average quality measures
% INPUT: qualityMeasures: struct with arrays for each specific quality
%        measure
    
    averageQualityMeasures.time = mean(qualityMeasures.time);

    if (isfield(qualityMeasures,'se'))
        averageQualityMeasures.se = mean(qualityMeasures.se);
    end
    
    if (isfield(qualityMeasures,'sp'))
        averageQualityMeasures.sp = mean(qualityMeasures.sp);
    end
    
    if (isfield(qualityMeasures,'acc'))
        averageQualityMeasures.acc = mean(qualityMeasures.acc);
    end
    
    if (isfield(qualityMeasures,'precision'))
        averageQualityMeasures.precision = mean(qualityMeasures.precision);
    end
    
    if (isfield(qualityMeasures,'recall'))
        averageQualityMeasures.recall = mean(qualityMeasures.recall);
    end
    
    if (isfield(qualityMeasures,'fMeasure'))
        averageQualityMeasures.fMeasure = mean(qualityMeasures.fMeasure);
    end
    
    if (isfield(qualityMeasures,'matthews'))
        averageQualityMeasures.matthews = mean(qualityMeasures.matthews);
    end
    
    if (isfield(qualityMeasures,'dice'))
        averageQualityMeasures.dice = mean(qualityMeasures.dice);
    end
    
    if (isfield(qualityMeasures,'arias'))
        averageQualityMeasures.arias = mean(qualityMeasures.arias);
    end

    if (isfield(qualityMeasures,'scores'))
        averageQualityMeasures.scores = qualityMeasures.scores;
    end
    
    if (isfield(qualityMeasures,'auc'))
        averageQualityMeasures.auc = mean(qualityMeasures.auc);
    end
    
    if (isfield(qualityMeasures,'auc_pr'))
        averageQualityMeasures.auc_pr = mean(qualityMeasures.auc_pr);
    end
    
    if (isfield(qualityMeasures,'unaryPotentials'))
        averageQualityMeasures.unaryPotentials = qualityMeasures.unaryPotentials;
    end
    
    if (isfield(qualityMeasures,'aucUP'))
        averageQualityMeasures.aucUP = mean(qualityMeasures.aucUP);
    end
    
    if (isfield(qualityMeasures,'aucUP_pr'))
        averageQualityMeasures.aucUP_pr = mean(qualityMeasures.aucUP_pr);
    end
    
    if (isfield(averageQualityMeasures,'auc'))
        averageQualityMeasures.qualities = [averageQualityMeasures.se; ...
                                            averageQualityMeasures.sp; ...
                                            averageQualityMeasures.acc; ...
                                            averageQualityMeasures.auc; ...
                                            averageQualityMeasures.matthews; ...
                                            averageQualityMeasures.precision; ...
                                            averageQualityMeasures.recall; ...
                                            averageQualityMeasures.fMeasure; ...
                                            ];
    else
        averageQualityMeasures.qualities = [averageQualityMeasures.se; ...
                                        averageQualityMeasures.sp; ...
                                        averageQualityMeasures.acc; ...
                                        averageQualityMeasures.matthews; ...
                                        averageQualityMeasures.precision; ...
                                        averageQualityMeasures.recall; ...
                                        averageQualityMeasures.fMeasure; ...
                                        ];
    end

end