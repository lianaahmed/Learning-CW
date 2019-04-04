%
%
function M = task1_2(X, Y)
% Input:
%  X : M-by-D data matrix (double)
%  Y : M-by-1 label vector (unit8)
% Output:
%  M : (K+1)-by-D mean vector matrix (double)
%      Note that M(K+1,:) is the mean vector of X.

    M = zeros(11,784);
    img = zeros(28, 28, 11);

    for i = 0:9
        % indices stores all the indices we need for X
        % by grabbing them from Y
        indices = find(Y==i);
        M(i+1,:) = sum(X(indices,:))/length(indices);
    end 

    M(11,:) = sum(M(1:10,:))/10;

    for j = 1:11
        img(:,:,j) = reshape(M(j,:),28, 28)';
    end
    montage(img, 'DisplayRange', [0,1]);

end
