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
    Ms = zeros(K, D);
    Covs = zeros(K, D, D);
    Ypreds = zeros(N,1);

    for i = 0:9
        % Getting the training samples from each class
        samples = Xtrain((Ytrain == i),:);
        mu = myMean(samples);
        Ms((i+1),:) = mu;
        Covs((i+1),:,:) = myCov(samples, mu) + eye(D) * epsilon;
    end
%     disp(samples);
    %Computing the posterior probabilities 
    
    postProbs = zeros(4191, K);
    for i = 1:K
        mu = Ms(i,:);
        sigma = Covs(i,:,:);
        
        % Difference between each sample and the mean
        d = bsxfun(@minus, samples, mu);
        
        postM = (-0.5) * d * inv(squeeze(sigma)) * d' -0.5 * logdet(squeeze(sigma));
        postProbs(:,i) = diag(postM);
    end
    disp(size(postProbs));
    for i = 1:N
        [~, idx] = max(postProbs(i,:));
        Ypreds(i,:) = idx;
    end

     disp(Ypreds);
     disp(Ms);
     disp(Covs);
  
end
