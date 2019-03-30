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

    CM = zeros(size(K,1));
    numRows = size(Ytrues,1);

    for i = 1:K
        
        entry = CM(Ytrues(i,1),Ypreds(i,1));
        entry = entry + 1;
        CM(Ytrues(i,1), Ypreds(i,1)) = entry;
   
    end
    
    count = 0;
    
    for j = 1:max(K)
        count = count + 1;
    end
    
    acc = count/numRows;

end
