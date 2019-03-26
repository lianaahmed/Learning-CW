%
%
function task1_1(X, Y)
% Input:
%  X : M-by-D data matrix (double)
%  Y : M-by-1 label vector (unit8)
 
for i = 0:9
    % indices stores all the indices we need for each class in X
    % by gfinding the appropriate ones we need from Y
    indices= find(Y==i,10);
    % imageArray will hold each image that we get from X
    imageArray = [];
    
    M = X(indices,:);
    
    for k = 1:length(indices)
        img = reshape(M(k,:),28, 28)';
        imageArray = cat(3, imageArray, img);
    end
    montage(imageArray, 'DisplayRange', [0,1]);
    
    % I used pause to pause between each photo to allow me
    % enough time to save each file.
    pause(5);
end 
end
