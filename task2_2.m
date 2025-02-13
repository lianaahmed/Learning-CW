%
%
function Dmap = task2_2(Xtrain, Ytrain, k, MAT_evecs, MAT_evals, posVec, nbins)
% Input:
%  X   : M-by-D data matrix (double)
%  k   : scalar (integer) - the number of nearest neighbours
%  MAT_evecs : MAT filename of eigenvector matrix of D-by-D
%  MAT_evals : MAT filename of eigenvalue vector of D-by-1
%  posVec    : 1-by-D vector (double) to specity the position of the plane
%  nbins     : scalar (integer) - the number of bins for each PCA axis
% Output:
%  Dmap  : nbins-by-nbins matrix (uint8) - each element represents
%	   the cluster number that the point belongs to.

    %Extract data 
    MAT_evecs = load(MAT_evecs);
    MAT_evecs = MAT_evecs.EVecs;
    MAT_evals = load(MAT_evals);
    MAT_evals = MAT_evals.EVals;
    
    % Defining size of Dmap
    Dmap = zeros(nbins, nbins);
    
    % Define size of Xtest
    Xtest = zeros(nbins^2, 784);
    
     % Sort eigen vectors and values
    [tmp, ridx] = sort(MAT_evals, 1, 'descend');
    MAT_evecs = MAT_evecs(:,ridx);
    MAT_evals = MAT_evals(ridx);
    
    % Get mean of Xtrain
    meanXtrain = myMean(Xtrain);
    
    % Project mean vector onto first 2 PCA axes to find the means
    mVec = meanXtrain * MAT_evecs(:,1:2);
    
    % Get the standard deviations
    sd2 = sqrt(MAT_evals(2));
    sd1 = sqrt(MAT_evals(1));
    
    % create plotting range
    Xplot = linspace((mVec(1) - 5*sd1), (mVec(1) + 5*sd1), nbins);
    Yplot = linspace((mVec(2) - 5*sd2), (mVec(2) + 5*sd2), nbins);
    
    % Helper for reshaping in a more efficient way
    invEvecs = inv(MAT_evecs');
    
    % Counter for setting Xtest
    z = 1;
    
    for i = 1:nbins
        for j = 1:nbins
            
            % Initialise oldPoint
            oldPoint = zeros(784, 1);
            
            % Set oldPoint as the corresponding points from Xplot and Yplot
            oldPoint(1) = Xplot(i);
            oldPoint(2) = Yplot(j);
           
            % Reshape point and set as newPoint
            newPoint = (invEvecs * oldPoint) + posVec';
            
            % Set current row in Xtest as the newPoint
            Xtest(z,:) = newPoint;
            
            % Increment z
            z = z + 1;
        end
    end
    
    % Run knn classifier to get Ypreds
    Ypreds = run_knn_classifier(Xtrain, Ytrain, Xtest, k);
    
    % Reshape Ypreds
    Ypreds = reshape(Ypreds, nbins, nbins);
    
    % This function will draw the decision boundaries
    figure;
    [CC,h] = contourf(Ypreds);
    set(h,'LineColor','none');
end
