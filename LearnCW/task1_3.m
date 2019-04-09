%
%
function [EVecs, EVals, CumVar, MinDims] = task1_3(X)
% Input:
%  X : M-by-D data matrix (double)
% Output:
%  EVecs, Evals: same as in comp_pca.m
%  CumVar  : D-by-1 vector (double) of cumulative variance
%  MinDims : 4-by-1 vector (integer) of the minimum number of PCA dimensions
%            to cover 70%, 80%, 90%, and 95% of the total variance.
    
    % Carries out PCA
    [EVecs, EVals] = comp_pca(X);
    
    % Since we should explain most of the variance, 
    % we should sort the variances in decreasing order
    
    [tmp, ridx] = sort(EVals, 1, 'descend');
    EVecs = EVecs(:,ridx);
    EVals = EVals(ridx);
    
    % Cumulative variance is calulated by getting the 
    % cumulative sum of the sorted eigenvalues
    CumVar = cumsum(EVals);
    
    % Get total variance
    totalVar = CumVar(784,1);
    
    % Plot the graph
    plot(CumVar);

    % Initialises MinDims as a 4 by 1 vector with zeros
    MinDims = zeros(4,1);
    
    % 70%
    MinDims(1,1) = find(CumVar >= (0.7 * totalVar), 1, 'first');
    
    % 80%
    MinDims(2,1) = find(CumVar >= (0.8 * totalVar), 1, 'first');
    
    % 90%
    MinDims(3,1) = find(CumVar >= (0.9 * totalVar), 1, 'first');
    
    % 95%
    MinDims(4,1) = find(CumVar >= (0.95 * totalVar), 1, 'first');  
    
end
