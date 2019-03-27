%
function [C, idx, SSE] = my_kMeansClustering(X, k, initialCentres, maxIter)
% Input
%   X : N-by-D matrix (double) of input sample data
%   k : scalar (integer) - the number of clusters
%   initialCentres : k-by-D matrix (double) of initial cluster centres
%   maxIter  : scalar (integer) - the maximum number of iterations
% Output
%   C   : k-by-D matrix (double) of cluster centres
%   idx : N-by-1 vector (integer) of cluster index table
%   SSE : (L+1)-by-1 vector (double) of sum-squared-errors

  %% If 'maxIter' argument is not given, we set by default to 500
  if nargin < 4
    maxIter = 500;
  end
  
  %Initialise n and m as  the respective size from X
  [n, m] = size(X);
  
  %Initialise C and SSE
  C = zeros(k, n);
  SSE = zeros(maxIter,1);
  
  % My pairwise Euclidean distance formula
  function distance = pairwiseEuc(a,b)
    
    XX = diag(a*a');
    YY = diag(b*b');
    
    distance = (repmat(XX, m) - (2 * a * b')) + repmat(YY,n)';
    
  end
  
  % Iterate maxIter times
  for i = 1:maxIter
      
    % Compute Squared Euclidean distance
    % between each cluster centre and each observation
    for j = 1:k
        C(j,:) = pairwiseEuc(X, initialCentres(j,:));
    end
    
    % Assign data to clusters
    % ds = actual distances 
    % idx = cluster assignments
    [ds, idx] = min(C); % find min distance for each observation
    
    SSE(i) = sum(ds);
    % Update cluster centres
    % I have made the assumption that the cluster size will never be 0.
    for j = 1:k
        initialCentres(j, :) = mean( X(idx==j,:) );
    end
 
  end
end
