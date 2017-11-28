function mejorParametro = parameter_estimator(predictor, measurement, feature_extraction_method)
%predictorName -> av(ancho vaso), fvaf(fov dividido angulo del fov),ddo(diametro disco optico)
%y dfov(diametro del fov)
%-----------------------%
%predictorValue posee el valor del desciptor que se usa como variable
%independiente, por ejemplo, el valor de ancho de vaso de un nuevo dataset.
%-----------------------%
%method define el filtro que se desea aplicar
%Zana, Soares, Nguyen, Frangi, MatchedFilter o Azzopardi.
%-----------------------%
%   notUseDataset corresponde al dataset que se desea calcular el parametro, por lo tanto no se usa
%   sus valores. Si se pasa cero usa todos los valores:
%   1-Drive
%   2-Aria
%   3-HRF
%   4-Stare
%   5-Chasedb1
%-----------------------%
    switch feature_extraction_method
        case 'Zana'
            switch predictor
                case 'av'
                    training_data = [6.22 15 ; 9.28 18 ; 25.11 40 ; 7.46 18 ; 16.21 23 ];
                    mp = line_estimator(measurement,training_data);
                case 'fvaf'
                    training_data = [11.988 15 ; 14.56 18 ; 54.358 40 ; 18.528 18 ; 30.766 23 ];
                    mp = line_estimator(measurement,training_data);
                case 'ddo'
                    training_data = [75.98 15 ; 107.6 18 ; 365.42 40 ; 104.12 18 ; 192.58 23 ];
                    mp = line_estimator(measurement,training_data);
                case 'dfov'
                    training_data = [539.5 15 ; 728 18 ; 3261.5 40 ; 648.5 18 ; 923 23 ];
                    mp = line_estimator(measurement, training_data);
            end;
        case 'Soares'
            switch predictor
                case 'av'
                    matFirst = [6.22 1 ; 9.28 3 ; 25.11 8 ; 7.46 3 ; 16.21 5 ];
                    first=line_estimator(measurement,matFirst);
                    matSecond = [6.22 2 ; 9.28 4 ; 25.11 9 ; 7.46 3 ; 16.21 6 ];
                    second=line_estimator(measurement,matSecond);
                    matThird = [6.22 3 ; 9.28 4 ; 25.11 12 ; 7.46 3 ; 16.21 9 ];
                    third =line_estimator(measurement,matThird);
                    first = int64(first);
                    second = int64(second);
                    third = int64(third);
                    mp = unique([first second third]);
                case 'fvaf'
                    matFirst = [11.988 1 ; 14.56 3 ; 54.358 8 ; 18.528 3 ; 30.766 5 ];
                    first=line_estimator(measurement,matFirst);
                    matSecond = [11.988 2 ; 14.56 4 ; 54.358 9 ; 18.528 3 ; 30.766 6 ];
                    second=line_estimator(measurement,matSecond);
                    matThird = [11.988 3 ; 14.56 4 ; 54.358 12 ; 18.528 3 ; 30.766 9 ];
                    third=line_estimator(measurement,matThird);
                    first = int64(first);
                    second = int64(second);
                    third = int64(third);
                    mp = unique([first second third]);
                case 'ddo'
                    matFirst = [75.98 1 ; 107.6 3 ; 365.42 8 ; 104.12 3 ; 192.58 5 ];
                    first=line_estimator(measurement,matFirst);
                    matSecond = [75.98 2 ; 107.6 4 ; 365.42 9 ; 104.12 3 ; 192.58 6 ];
                    second=line_estimator(measurement,matSecond);
                    matThird = [75.98 3 ; 107.6 4 ; 365.42 12 ; 104.12 3 ; 192.58 9 ];
                    third=line_estimator(measurement,matThird);
                    first = int64(first);
                    second = int64(second);
                    third = int64(third);
                    mp = unique([first second third]);
                case 'dfov'
                    matFirst = [539.5 1 ; 728 3 ; 3261.5 8 ; 648.5 3 ; 923 5 ];
                    first=line_estimator(measurement,matFirst);
                    matSecond = [539.5 2 ; 728 4 ; 3261.5 9 ; 648.5 3 ; 923 6 ];
                    second=line_estimator(measurement,matSecond);
                    matThird = [539.5 3 ; 728 4 ; 3261.5 12 ; 648.5 3 ; 923 9 ];
                    third=line_estimator(measurement,matThird);
                    first = int64(first);
                    second = int64(second);
                    third = int64(third);
                    mp = unique([first second third]);
            end;    
        case 'Frangi'
            switch predictor
                case 'av'
                    training_data = [6.22 4 ; 9.28 4 ; 25.11 10 ; 7.46 4 ; 16.21 6 ];
                    mp=line_estimator(measurement,training_data);
                case 'fvaf'
                    training_data = [11.988 4 ; 14.56 4 ; 54.358 10 ; 18.528 4 ; 30.766 6 ];
                    mp=line_estimator(measurement,training_data);
                case 'ddo'
                    training_data = [75.98 4 ; 107.6 4 ; 365.42 10 ; 104.12 4 ; 192.58 6 ];
                    mp=line_estimator(measurement,training_data);
                case 'dfov'
                    training_data = [539.5 4 ; 728 4 ; 3261.5 10 ; 648.5 4 ; 923 6 ];
                    mp=line_estimator(measurement,training_data);
            end;
        case 'Nguyen'
            switch predictor
                case 'av'
                    training_data = [6.22 16 ; 9.28 16 ; 25.11 54 ; 7.46 16 ; 16.21 32 ];
                    mp=line_estimator(measurement,training_data);
                case 'fvaf'
                    training_data = [11.988 16 ; 14.56 16 ; 54.358 54 ; 18.528 16 ; 30.766 32 ];
                    mp=line_estimator(measurement,training_data);
                case 'ddo'
                    training_data = [75.98 16 ; 107.6 16 ; 365.42 54 ; 104.12 16 ; 192.58 32 ];
                    mp=line_estimator(measurement,training_data);
                case 'dfov'
                    training_data = [539.5 16 ; 728 16 ; 3261.5 54 ; 648.5 16 ; 923 32 ];
                    mp=line_estimator(measurement,training_data);
            end;
        case 'MatchedFilter'
            switch predictor
                case 'av'
                    training_data = [6.22 7 ; 9.28 8 ; 25.11 34 ; 7.46 8 ; 16.21 24 ];
                    mp=line_estimator(measurement,training_data);
                case 'fvaf'
                    training_data = [11.988 7 ; 14.56 8 ; 54.358 34 ; 18.528 8 ; 30.766 24 ];
                    mp=line_estimator(measurement,training_data);
                case 'ddo'
                    training_data = [75.98 7 ; 107.6 8 ; 365.42 34 ; 104.12 8 ; 192.58 24 ];
                    mp=line_estimator(measurement,training_data);
                case 'dfov'
                    training_data = [539.5 7 ; 728 8 ; 3261.5 34 ; 648.5 8 ; 923 24 ];
                    mp=line_estimator(measurement,training_data);
            end;
        case 'Azzopardi'
            switch predictor
                case 'av'
                    %simetric params
                    rho = [6.22 8 ; 9.28 14 ; 25.11 30 ; 7.46 12 ; 16.21 22 ]; 
                    mp.s_rho=line_estimator(measurement,rho);
                    sigma = [6.22 2.4 ; 9.28 3.9 ; 25.11 11.9 ; 7.46 2.9 ; 16.21 7.4 ];
                    mp.s_sigma=line_estimator(measurement,sigma);
                    sigma0 = [6.22 3 ; 9.28 2.5 ; 25.11 2 ; 7.46 1.5 ; 16.21 3 ];
                    mp.s_sigma0=line_estimator(measurement,sigma0);
                    alpha = [6.22 0.7 ; 9.28 0.4 ; 25.11 0.4 ; 7.46 0.6 ; 16.21 0.2 ];
                    mp.s_alpha=line_estimator(measurement,alpha);
                    %asiemtric params
                    as_sigma = [6.22 1.9 ; 9.28 3.4 ; 25.11 11.4 ; 7.46 2.4 ; 16.21 6.9 ];
                    mp.as_sigma=line_estimator(measurement,as_sigma);
                    as_rho = [6.22 22 ; 9.28 28 ; 25.11 54 ; 7.46 24 ; 16.21 38 ]; 
                    mp.as_rho=line_estimator(measurement,as_rho);
                    as_sigma0 = [6.22 2 ; 9.28 1.5 ; 25.11 1 ; 7.46 1.5 ; 16.21 1 ];
                    mp.as_sigma0=line_estimator(measurement,as_sigma0);
                    mp.as_alpha = 0.1;
                case 'fvaf'
                    %simetric params
                    rho = [11.988 8 ; 14.56 14 ; 54.358 30 ; 18.528 12 ; 30.766 22 ];
                    mp.s_rho=line_estimator(measurement,rho);
                    sigma = [11.988 2.4 ; 14.56 3.9 ; 54.358 11.9 ; 18.528 2.9 ; 30.766 7.4 ];
                    mp.s_sigma=line_estimator(measurement,sigma);
                    sigma0 = [11.988 3 ; 14.56 2.5 ; 54.358 2 ; 18.528 1.5 ; 30.766 3 ];
                    mp.s_sigma0=line_estimator(measurement,sigma0);
                    alpha = [11.988 0.7 ; 14.56 0.4 ; 54.358 0.4 ; 18.528 0.6 ; 30.766 0.2 ];
                    mp.s_alpha=line_estimator(measurement,alpha);
                    %asiemtric params
                    as_sigma = [11.988 1.9 ; 14.56 3.4 ; 54.358 11.4 ; 18.528 2.4 ; 30.766 6.9 ];
                    mp.as_sigma=line_estimator(measurement,as_sigma);
                    as_rho = [11.988 22 ; 14.56 28 ; 54.358 54 ; 18.528 24 ; 30.766 38 ]; 
                    mp.as_rho=line_estimator(measurement,as_rho);
                    as_sigma0 = [11.988 2 ; 14.56 1.5 ; 54.358 1 ; 18.528 1.5 ; 30.766 1 ];
                    mp.as_sigma0=line_estimator(measurement,as_sigma0);
                    mp.as_alpha = 0.1;
                case 'ddo'
                    %simetric params
                    rho = [75.98 8 ; 107.6 14 ; 365.42 30 ; 104.12 12 ; 192.58 22 ];
                    mp.s_rho=line_estimator(measurement,rho);
                    sigma = [75.98 2.4 ; 107.6 3.9 ; 365.42 11.9 ; 104.12 2.9 ; 192.58 7.4 ];
                    mp.s_sigma=line_estimator(measurement,sigma);
                    sigma0 = [75.98 3 ; 107.6 2.5 ; 365.42 2 ; 104.12 1.5 ; 192.58 3 ];
                    mp.s_sigma0=line_estimator(measurement,sigma0);
                    alpha = [75.98 0.7 ; 107.6 0.4 ; 365.42 0.4 ; 104.12 0.6 ; 192.58 0.2 ];
                    mp.s_alpha=line_estimator(measurement,alpha);
                    %asiemtric params
                    as_sigma = [75.98 1.9 ; 107.6 3.4 ; 365.42 11.4 ; 104.12 2.4 ; 192.58 6.9 ];
                    mp.as_sigma=line_estimator(measurement,as_sigma);
                    as_rho = [75.98 22 ; 107.6 28 ; 365.42 54 ; 104.12 24 ; 192.58 38 ]; 
                    mp.as_rho=line_estimator(measurement,as_rho);
                    as_sigma0 = [75.98 2 ; 107.6 1.5 ; 365.42 1 ; 104.12 1.5 ; 192.58 1 ];
                    mp.as_sigma0=line_estimator(measurement,as_sigma0);
                    mp.as_alpha = 0.1;
                case 'dfov'
                    %simetric params
                    rho = [539.5 8 ; 728 14 ; 3261.5 30 ; 648.5 12 ; 923 22 ];
                    mp.s_rho=line_estimator(measurement,rho);
                    sigma = [539.5 2.4 ; 728 3.9 ; 3261.5 11.9 ; 648.5 2.9 ; 923 7.4 ];
                    mp.s_sigma=line_estimator(measurement,sigma);
                    sigma0 = [539.5 3 ; 728 2.5 ; 3261.5 2 ; 648.5 1.5 ; 923 3 ];
                    mp.s_sigma0=line_estimator(measurement,sigma0);
                    alpha = [539.5 0.7 ; 728 0.4 ; 3261.5 0.4 ; 648.5 0.6 ; 923 0.2 ];
                    mp.s_alpha=line_estimator(measurement,alpha);
                    %asiemtric params
                    as_sigma = [539.5 1.9 ; 728 3.4 ; 3261.5 11.4 ; 648.5 2.4 ; 923 6.9 ];
                    mp.as_sigma=line_estimator(measurement,as_sigma);
                    as_rho = [539.5 22 ; 728 28 ; 3261.5 54 ; 648.5 24 ; 923 38 ]; 
                    mp.as_rho=line_estimator(measurement,as_rho);
                    as_sigma0 = [539.5 2 ; 728 1.5 ; 3261.5 1 ; 648.5 1.5 ; 923 1 ];
                    mp.as_sigma0=line_estimator(measurement,as_sigma0);
                    mp.as_alpha = 0.1;
            end;
        case 'Theta_p-Zana'
            switch predictor
                case 'av'
                    training_data = [6.22 3 ; 9.28 15 ; 25.11 11 ; 7.46 15 ; 16.21 3 ];
                    mp=line_estimator(measurement,training_data);
                case 'fvaf'
                    training_data = [11.988 3 ; 14.56 15 ; 54.358 11 ; 18.528 15 ; 30.766 3 ];
                    mp=line_estimator(measurement,training_data);
                case 'ddo'
                    training_data = [75.98 3 ; 107.6 15 ; 365.42 11 ; 104.12 15 ; 192.58 3 ];
                    mp=line_estimator(measurement,training_data);
                case 'dfov'
                    training_data = [539.5 3 ; 728 15 ; 3261.5 11 ; 648.5 15 ; 923 3 ];
                    mp=line_estimator(measurement,training_data);
            end;
        case 'Theta_p-Azzopardi'
            switch predictor
                case 'av'  
                    training_data = [6.22 3 ; 9.28 7 ; 7.46 15];
                    mp=line_estimator(measurement,training_data);
                case 'fvaf'
                    training_data = [11.988 3 ; 14.56 7 ; 18.528 15 ];
                    mp=line_estimator(measurement,training_data);
                case 'ddo'
                    training_data = [75.51 3 ; 107.6 7 ; 104.12 15 ];
                    mp=line_estimator(measurement,training_data);
                case 'dfov'
                    training_data = [539.5 3 ; 728 7 ; 648.5 15 ];
                    mp=line_estimator(measurement,training_data);
            end;
    end;
    mejorParametro = mp;
end


function estimated_parameter = line_estimator(measurement, best_parameters)
    p=polyfit(best_parameters(:,1), best_parameters(:,2),1);
    estimated_parameter = (p(1) * measurement) + p(2);
end
