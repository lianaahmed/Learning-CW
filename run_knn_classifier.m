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

    for i = 1:N
        
        % Calculate the euclidean distances between each testing 
        % data and the training data
        Ds = naiveSQD(Xtrain, Xtest(i,:));
        [Ds,idx] = sort(Ds, 'ascend');

        for j = 1:L

            k = Ks(j);
            indices = idx(1:k); % Keep the first k indices

            Ypreds(j,:) = mode(Ytrain(indices));

        end
    end
end

function distance = naiveSQD(a,b)

    distance = sum(bsxfun(@minus, a, b).^2, 2)';

end