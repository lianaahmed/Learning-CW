function distance = sqEuc(x,y)

    %Get the size of each matrix
    M = size(y, 1);
    N = size(x, 1);

    %Calculate the dot product
    XX = dot(x, x, 2);
    YY = dot(y, y, 2);

    %Get the Euclidean distance between each training point and test point
    distance = repmat(XX,1,M)- (2*x*y.') + (repmat(YY,1,N)).';

end
