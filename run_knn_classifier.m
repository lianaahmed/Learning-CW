function [Ypreds] = run_knn_classifier(Xtrain, Ytrain, Xtest, Ks)
% Input:
%   Xtrain : M-by-D training data matrix (double)
%   Ytrain : M-by-1 label vector (uint8) for Xtrain
%   Xtest  : N-by-D test data matrix (double)
%   Ks     : 1-by-L vector (integer) of the numbers of nearest neighbours in Xtrain
% Output:
%   Ypreds : N-by-L matrix (uint8) of predicted labels for Xtest

    [N,D] = size(Xtest);
    L = length(Ks);
    Ypreds = zeros(N,L);
    
    % Calculate the euclidean distances between each testing 
    % data and the training data
    distances = sqEuc(Xtest, Xtrain);
    [Ds,idx] = sort(distances, 2,'ascend');
    for j = 1:L
        k = Ks(j);
        ci = idx(:,1:k)'; % Current index
        Ypreds(:,j) = Ytrain(mode(ci,1));
    end
end