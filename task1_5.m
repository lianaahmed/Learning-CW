%
%
function task1_5(X, Ks)
% Input:
%  X  : M-by-D data matrix (double)
%  Ks : 1-by-L vector (integer) of the numbers of nearest neighbours
   
    for k = 1:length(Ks)
       initialCentres = find(X, k, 'first'); 
       my_kMeansClustering(X, k, initialCentres); 
    end
end