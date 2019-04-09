%
%
function task1_6(MAT_ClusterCentres)
% Input:
%  MAT_ClusterCentres : file name of the MAT file that contains cluster centres C.
%       
%   

    % Load the cluster centres into C
    C = load(MAT_ClusterCentres);
    C = C.C;
    
    % Initialise k and imageArray
    [k,tmp] = size(C);
    imageArray = [];
    
    % Form k images from C
    for i = 1:k
        imageArray = cat(3, imageArray, (reshape(C(i,:),28, 28)'));
    end

    montage(imageArray, 'DisplayRange', [0,1]);
    
    % In order to actually run this, I created a script 'run1_6.mat'
   
end
