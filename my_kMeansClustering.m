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
  
  %Initialise C
  C = initialCentres;

  idx = zeros(size(X,1),1);
  % Iterate maxIter times
  for i = 1:maxIter
    
    
    % Compute Squared Euclidean distance
    % between each cluster centre and each observation
    D = sqEuc(X, C);
    
    % Assign data to clusters
    % ds = actual distances 
    % idx = cluster assignments
    [ds, idx] = min(D, [], 2); % find min distance for each observation
    
    % calculate SSE
    SSE(i) = sum(ds);
    
    % Update cluster centres
    % I have made the assumption that the cluster size will never be 0.
    old = C;  
    for j = 1:k
        C(j, :) = myMean(X(idx==j,:));
    end
    
    if isequal(old, C)
        break
    end
    
  end
  
  % Final SSE
  SSE(i+1) = sum(ds);
  
end
