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
  
  %% TO-DO
  
  % Iterate ’maxIter’ times
  for i = 1:maxIter
    % Compute Squared Euclidean distance (i.e. the squared distance)
    % between each cluster centre and each observation
    for c = 1:K
    D(c,:) = square_dist(A, initialCentres(c,:));
    end
    
    % Assign data to clusters
    % Ds are the actual distances and idx are the cluster assignments
    [Ds, idx] = min(D); % find min dist. for each observation
  
  
  
  end


  C = nan;
  idx = nan;
  SSE = nan;
  


end
