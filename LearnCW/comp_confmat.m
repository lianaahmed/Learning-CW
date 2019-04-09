function [CM, acc] = comp_confmat(Ytrues, Ypreds, K)
% Input:
%   Ytrues : N-by-1 ground truth label vector
%   Ypreds : N-by-1 predicted label vector
% Output:
%   CM : K-by-K confusion matrix, where CM(i,j) is the number 
%        of samples whose target is the ith class that was 
%        classified as j
%   acc : accuracy (i.e. correct classification rate)
%     K : The number of classes (which is 10 for our data set)

    CM = zeros(K,K);

    for i = 1:K
        A = Ytrues == i;
        for j = 1:K
            B = Ypreds == j;
            CM(i,j) = sum(A & B);
        end
    end
   
    
    acc = sum(diag(CM))/sum(sum(CM));

end
