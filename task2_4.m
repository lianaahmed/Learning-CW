%
%
function [Corrs] = task2_4(Xtrain, Ytrain)
% Input:
%  Xtrain : M-by-D data matrix (double)
%  Ytrain : M-by-1 label vector (unit8) for X
% Output:
%  Corrs  : (K+1)-by-1 vector (double) of correlation $r_{12}$ 
%           for each class k = 1,...,K, and the last element holds the
%           correlation for the whole data, i.e. Xtrain.
    
    % Initialise size of Corrs
    Corrs = zeros(11,1);
    
    % Carries out PCA
    [EVecs, EVals] = comp_pca(Xtrain);
    
    % Sort eigenvectors
    [tmp, ridx] = sort(EVals, 1, 'descend');
    EVecs = EVecs(:,ridx);
    
    % Set principal components
    E1 = EVecs(:,1);
    E2 = EVecs(:,2);
    
    PC = [E1 E2];
    
    % Reshape Xtrain to be 2D
    X2D = Xtrain * PC;

    % For each class
    for i = 0:9
        
        % Get X2D values for each class
        M = X2D((Ytrain == i),:);
        
        % Calculate mean of M, and use this to calculate the covariance 
        mu = myMean(M);
        cov = myCov(M, mu);
        
        % Set current row in cors as correlation r12
        Corrs((i+1),:) = cov(1,2) / sqrt(cov(1,1) * cov(2,2));
        
    end
        
        % Do the same as above but for X2D overall, and set as the 11th row
        % in Corrs
        mu = myMean(X2D);
        cov = myCov(X2D, mu);

        Corrs(11,:) = cov(1,2) / sqrt(cov(1,1) * cov(2,2));
    
end
