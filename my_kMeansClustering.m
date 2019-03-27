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
  
  [n dim] = size(X);
  C = zeros(k, n);
  
  %%
  function distance = pairwiseEuc(a,b)
    distance = zeros(size(a,2),size(b,2));
  end
  
  % Iterate ’maxIter’ times
  for i = 1:maxIter
    % Compute Squared Euclidean distance (i.e. the squared distance)
    % between each cluster centre and each observation
    for j = 1:k
        C(j,:) = pairwiseEuc(A, initialCentres(j,:));
    end
    
    % Assign data to clusters
    % Ds are the actual distances and idx are the cluster assignments
    [Ds, idx] = min(C); % find min dist. for each observation
  
    % Update cluster centres
    % I have made the assumption that the cluster size will never be 0.
    for j = 1:k
        initialCentres(j, :) = mean( X(idx==j,:) );
    end
  
  end
  SSE = nan;
end
