%
%
function task1_4(EVecs)
% Input:
%  Evecs : the same format as in comp_pca.m
%
    rowEVecs = EVecs';
    imageArray = [];
    img = zeros(28, 28, 10);

    for i = 1:10
        img(:,:,i) = reshape(rowEVecs(i,:)*255.0,28, 28)';
        imageArray = cat(3, imageArray, img);
    end
    montage(img, 'DisplayRange', [-40,40]);
end
