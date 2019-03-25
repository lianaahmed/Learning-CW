%
%
function task1_1(X, Y)
% Input:
%  X : M-by-D data matrix (double)
%  Y : M-by-1 label vector (unit8)
 
for i = 1:10
    % indices stores all the indices we need for X
    % by grabbing them from Y
    indices = find(Y==i,10);
    % imageArray will hold each image that we get from X
    imageArray = [];
    
    M = X(indices,:);
    
    for k = 1:length(indices)
        img = reshape(M(k,:) * 255.0,28, 28)';
        imageArray = cat(3, imageArray, img);
    end
    montage(imageArray, 'ThumbnailSize', [400,400]);
    pause(5);
end 
end
