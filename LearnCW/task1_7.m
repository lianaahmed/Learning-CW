%
%
function Dmap = task1_7(MAT_ClusterCentres, MAT_M, MAT_evecs, MAT_evals, posVec, nbins)
% Input:
%  MAT_ClusterCentres: MAT filename of cluster centre matrix
%  MAT_M     : MAT filename of mean vectors of (K+1)-by-D, where K is
%              the number of classes (which is 10 for the MNIST data)
%  MAT_evecs : MAT filename of eigenvector matrix of D-by-D
%  MAT_evals : MAT filename of eigenvalue vector of D-by-1
%  posVec    : 1-by-D vector (double) to specify the position of the plane
%  nbins     : scalar (integer) to specify the number of bins for each PCA axis
% Output
%  Dmap  : nbins-by-nbins matrix (uint8) - each element represents
%	   the cluster number that the point belongs to.
    
    % Load data 
    MAT_ClusterCentres = load(MAT_ClusterCentres);
    MAT_ClusterCentres = MAT_ClusterCentres.C;
    MAT_M = load(MAT_M);
    MAT_M = MAT_M.M;
    MAT_evecs = load(MAT_evecs);
    MAT_evecs = MAT_evecs.EVecs;
    MAT_evals = load(MAT_evals);
    MAT_evals = MAT_evals.EVals;
    
    % Defining size of Dmap
    Dmap = zeros(nbins, nbins);
    
    % Sort eigen vectors and values
    [tmp, ridx] = sort(MAT_evals, 1, 'descend');
    MAT_evecs = MAT_evecs(:,ridx);
    MAT_evals = MAT_evals(ridx);
    
    % Project mean vector onto first 2 PCA axes to find the means
    mVec = MAT_M(11,:) * MAT_evecs(:,1:2);
    
    % Get the standard deviations
    sd1 = sqrt(MAT_evals(1));
    sd2 = sqrt(MAT_evals(2));
    
    % create plotting range
    Xplot = linspace((mVec(1) - 5*sd1), (mVec(1) + 5*sd1), nbins);
    Yplot = linspace((mVec(2) - 5*sd2), (mVec(2) + 5*sd2), nbins);
    
    % Helper for reshaping in a more efficient way
    invEvecs = inv(MAT_evecs');
    
    for i = 1:nbins
        for j = 1:nbins
            
            % Initialise oldPoint
            oldPoint = zeros(784, 1);
            
            % Set oldPoint as the corresponding points from Xplot and Yplot
            oldPoint(1) = Xplot(i);
            oldPoint(2) = Yplot(j);
           
            % Reshape point and set as newPoint
            newPoint = (invEvecs * oldPoint) + posVec';

            % Compute distances
            distances =  sqEuc(MAT_ClusterCentres, newPoint');
            [Ds,idx] = min(distances);
            
            % Set current point in Dmap as the index of the distances
            Dmap(i,j) = idx;
        end
    end
    
    % This function will draw the decision boundaries
    figure;
    [CC,h] = contourf(Dmap);
    set(h,'LineColor','none');
end



