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
  
  %Initialise n the respective size from X
  [n, XD] = size(X);
  
  %Initialise C and SSE
  C = zeros(k, n);
  SSE = zeros(maxIter,1);
  

  idx = zeros(size(X,1),1);
  % Iterate maxIter times
  for i = 1:maxIter
    old = idx;  
    
    % Compute Squared Euclidean distance
    % between each cluster centre and each observation
    
    for j = 1:k
        C(j,:) = naiveSQD(X, initialCentres(j,:));
    end
    
    % Assign data to clusters
    % ds = actual distances 
    % idx = cluster assignments
    [ds, idx] = min(C, [], 1); % find min distance for each observation
    
    SSE(i) = sum(ds);
    % Update cluster centres
    % I have made the assumption that the cluster size will never be 0.
    for j = 1:k
        initialCentres(j, :) = myMean(X(idx==j,:));
    end
    
    if isequal(old, idx)
        break
    end
    
  end
  C = initialCentres;
end


function distance = naiveSQD(a,b)

    distance = sum(bsxfun(@minus, a, b).^2, 2)';

end

function mean = myMean(a)
    mean = sum(a) ./ size(a, 1);
end
