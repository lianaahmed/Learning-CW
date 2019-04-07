%
%
function task2_5(Xtrain, Ytrain, Xtest, Ytest, epsilon)
% Input:
%  Xtrain : M-by-D training data matrix (double)
%  Ytrain : M-by-1 label vector (unit8) for Xtrain
%  Xtest  : N-by-D test data matrix (double)
%  Ytest  : N-by-1 label vector (unit8) for Xtest
%  epsilon : a scalar variable (double) for covariance regularisation
    
    % Start Timer
    tic;
        
        % Run classifcation experiment 
        [Ypreds, Ms, Covs] = run_gaussian_classifiers(Xtrain, Ytrain, Xtest, epsilon);
    
    % Stop timer and display time
    disp(toc);
    
    % Get and save confusion matrix
    
    [CM, acc] = comp_confmat(Ytrain, Ytest, 10);
    save('task2_5_cm.mat', CM);
    
    % Get and save M10 and Cov10
    M10 = Ms(10,:);
    Cov10 = Covs(10,:,:);
    
    save('task2_5_m10.mat', M10);
    save('task2_5_cov10.mat', Cov10);
    
    % Calculates N and Nerrs
    N = length(Xtrain);
    Nerrs = N - diag(CM);
     
    % Displays N, Nerrs and acc in standard format
    disp(N);
    disp(Nerrs);
    disp(acc);

end
