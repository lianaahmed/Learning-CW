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
  
  single(X);
  single(k);
  single(initialCentres);
  single(maxIter);
  
  %Initialise n and m as  the respective size from X
  [n, XD] = size(X);
  [m, YD] = size(initialCentres);
  
  %Initialise C and SSE
  C = zeros(k, n);
  SSE = single(zeros(maxIter,1));
  

  
  % Iterate maxIter times
  for i = 1:maxIter
      
    % Compute Squared Euclidean distance
    % between each cluster centre and each observation
    C = single(pairwiseEuc(X, initialCentres));

    
    
    
    % Assign data to clusters
    % ds = actual distances 
    % idx = cluster assignments
    [ds, idx] = min(C, [], 2); % find min distance for each observation
    idx = idx';
    
    SSE(i) = single(sum(ds));
    % Update cluster centres
    % I have made the assumption that the cluster size will never be 0.
    for j = 1:k
        initialCentres(j, :) = single(mean( X(idx==j,:)));
    end
 
  end
end


% My pairwise Euclidean distance formula
function distance = pairwiseEuc(a,b)

    [n, XD] = size(a);
    [m, YD] = size(b); 
    a = single(a);
    b = single(b);
    
    XX = diag(a*a');
    YY = diag(b*b');

    distance = repmat(XX,1, m) - (2 * a * b') + (repmat(YY,1,n))';

end
