
%
%
function Dmap = task2_6(X, Y, epsilon, MAT_evecs, MAT_evals, posVec, nbins)
% Input:
%  X        : M-by-D data matrix (double)
%  Y        : M-by-1 label vector (uint8)
%  epsilon  : scalar (double) for covariance matrix regularisation
%  MAT_evecs : MAT filename of eigenvector matrix of D-by-D
%  MAT_evals : MAT filename of eigenvalue vector of D-by-1
%  posVec   : 1-by-D vector (double) to specity the position of the plane
%  nbins     : scalar (integer) denoting the number of bins for each PCA axis
% Output
%  Dmap  : nbins-by-nbins matrix (uint8) - each element represents
%      the cluster number that the point belongs to.
 
    %Extract data
    MAT_evecs = load(MAT_evecs);
    MAT_evecs = MAT_evecs.EVecs;
    MAT_evals = load(MAT_evals);
    MAT_evals = MAT_evals.EVals;
   
    % Defining size of Dmap
    Dmap = zeros(nbins, nbins);
   
    % Define size of Xtest
    Xtest = zeros(nbins^2, 784);
   
     % Sort eigen vectors and values
    [tmp, ridx] = sort(MAT_evals, 1, 'descend');
    MAT_evecs = MAT_evecs(:,ridx);
    MAT_evals = MAT_evals(ridx);
   
    % Get mean of X
    meanX = myMean(X);
   
    % Project mean vector onto first 2 PCA axes to find the means
    mVec = meanX * MAT_evecs(:,1:2);
   
    % Get the standard deviations
    sd2 = sqrt(MAT_evals(2));
    sd1 = sqrt(MAT_evals(1));
   
    % create plotting range
    Xplot = linspace((mVec(1) - 5*sd1), (mVec(1) + 5*sd1), nbins);
    Yplot = linspace((mVec(2) - 5*sd2), (mVec(2) + 5*sd2), nbins);
   
    % Helper for reshaping in a more efficient way
    invEvecs = inv(MAT_evecs');
   
    % Counter for setting Xtest
    z = 1;
   
    for i = 1:nbins
        for j = 1:nbins
           
            % Initialise oldPoint
            oldPoint = zeros(784, 1);
           
            % Set oldPoint as the corresponding points from Xplot and Yplot
            oldPoint(1) = Xplot(i);
            oldPoint(2) = Yplot(j);
           
            % Reshape point and set as newPoint
            newPoint = (invEvecs * oldPoint) + posVec';
           
            % Set current row in Xtest as the newPoint
            Xtest(z,:) = newPoint';
           
            % Increment z
            z = z + 1;
        end
    end
   
    div = size(Xtest,1);
    Ypreds = [];
    for i = 1:10
        step1 = 1+(div/10)*(i-1);
        step2 = (div/10)*(i);
        Ypreds = cat(1,Ypreds, run_gaussian_classifiers_2_6(X, Y, Xtest(step1:step2,:), epsilon));
    end
    size(Ypreds)
   
    % Reshape Ypreds
    Ypreds = reshape(Ypreds, nbins, nbins);
   
    % This function will draw the decision boundaries
    figure;
    [CC,h] = contourf(Ypreds);
    set(h,'LineColor','none');
end

% I had issues with my sizing, and found unfortunately this was the easiest
% way to fix it

function [Ypreds, Ms, Covs] = run_gaussian_classifiers_2_6(Xtrain, Ytrain, Xtest, epsilon)
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
    postProbs = zeros(4000, K);
    
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
