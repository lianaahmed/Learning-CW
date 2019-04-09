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

    [N, D] = size(Xtest); % Get N and D
    K = 10; % Number of classes
    Ms = zeros(K, D); % Initialise size of Ms
    Covs = zeros(K, D, D); % Initialise size of Ms
    Ypreds = zeros(N,1); % Initialise size of Ypreds
    
    % For each class
    for i = 0:9
        % Getting the training samples from each class
        samples = Xtrain((Ytrain == i),:);
        
        % Get mean of samples and set as Ms(i+1)
        mu = myMean(samples); 
        Ms((i+1),:) = mu; 
        
        % Get covariance and set as Covs(i+1)
        Covs((i+1),:,:) = myCov(samples, mu) + eye(D) * epsilon; 
    end

    % Set size of the log posterior probability matrix
    postProbs = zeros(4005, K);
    
    for i = 1:K
        
        % Get current mu from our means matrix
        mu = Ms(i,:);
        
        % Set sigma and reshape to be a 2D, D by D matrix
        sigma = Covs(i,:,:);
        sigma = reshape(sigma, D, D);
        
        % Difference between each sample and the mean
        d = bsxfun(@minus, Xtest, mu);
        
        % Computing the log posterior probability
        postM = (-0.5) * d * inv(sigma) * d' -0.5 * logdet(sigma);
        postProbs(:,i) = diag(postM);
    end

    for i = 1:N
        
        % Set Ypreds(i) as the max index
        [~, idx] = max(postProbs(i,:));
        Ypreds(i,:) = idx(1)-1;
        
    end
  
end
