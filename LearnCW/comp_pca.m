function [EVecs, EVals] = comp_pca(X)
% Input: 
%   X:  N x D matrix (double)
% Output: 
%   EVecs: D-by-D matrix (double) contains all eigenvectors as columns
%       NB: follow the Task 1.3 specifications on eigenvectors.
%   EVals:
%       Eigenvalues in descending order, D x 1 vector (double)
%   (Note that the i-th columns of Evecs should corresponds to the i-th element in EVals)
    
    % Number of observations
    N = length(X);
   
    % Covariance matrix of X
    covX =  1/(N-1) * (X' * X);
    
    % Eigenvectors and Eigen values
    [EVecs, EVals] = eig(covX);
    
    EVals = diag(EVals);
    
    for i = 1:784
        if EVecs(1,i) < 0 
           EVecs(1,i) = EVecs(1,i)*(-1);
        end
    end

end

