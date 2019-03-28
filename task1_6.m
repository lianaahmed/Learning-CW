%
%
function task1_6(MAT_ClusterCentres)
% Input:
%  MAT_ClusterCentres : file name of the MAT file that contains cluster centres C.
%       
%   
    cs = load(MAT_ClusterCentres);
    [k,tmp] = size(cs);
    cs = cs.cs;
    imageArray = [];
    img = zeros(28, 28, k);
    
    for i = 1:k
        img(:,:,i) = reshape(cs(i,:),28, 28)';
        imageArray = cat(3, imageArray, img);
    end

    montage(img, 'DisplayRange', [-50,50]);
   
end
