function [Ypreds, Ms, Covs] = run_gaussian_classifiers(Xtrain, Ytrain, Xtest, epsilon)
% Input:
%   Xtrain : M-by-D training data matrix (double)
%   Ytrain : M-by-1 label vector for Xtrain (uint8)
%   Xtest  : N-by-D test data matrix (double)
%   epsilon : A scalar variable (double) for covariance regularisation
% Output:
%  Ypreds : N-by-1 matrix (uint8) of predicted labels for Xtest
%  Ms     : K-by-D matrix (double) of mean vectors
%  Covs   : K-by-D-by-D 3D array (double) of covariance matrices

%YourCode - Bayes classification with multivariate Gaussian distributions.

    [N, D] = size(Xtest);
    K = 10; % Number of classes

    Ypreds = zeros(N, 1);
    Ms = zeros(K, D);
    Covs = zeros(K, D, D);

    for i = 1:K
        % Getting the training samples from each class
        M = Xtrain(Ytrain == (i-1),:);             
        mu = myMean(M);
        Ms(i,:) = mu;
        Covs(i,:,:) = myCov(M, mu) + eye(D) * epsilon;
    end
    
    %Computing the posterior probabilities 
    
    postProbs = zeros(K,N);
    for i = 1:K
        mu = Ms(i,:);
        sigma = Covs(i,:,:);
        
        disp("M = " + size(M));
        disp("M' = " + size(M'));
        disp(size(mu));
        disp(size(Ms));
        
        % Difference between each sample and the mean
        d = bsxfun(@minus, M, mu);
        
        postM = squeeze(sigma) - 0.5 * d' * sigma * d;
        postProbs(i,:) = diag(postM);
    end
    
    [~, Ypreds] = max(postProbs, [], 2);
    
    disp(Ypreds);
    disp(Ms);
    disp(Covs);
     
end
