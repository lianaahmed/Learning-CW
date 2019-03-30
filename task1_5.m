%
%
function task1_5(X, Ks)
% Input:
%  X  : M-by-D data matrix (double)
%  Ks : 1-by-L vector (integer) of the numbers of nearest neighbours
   
% single(X);
% single(Ks);
    for k = 1:length(Ks)
       
       i = Ks(k);
       initialCentres = X(1:i,:);
       [C, idx, SSE] = my_kMeansClustering(X, i, initialCentres);
       
       % Saving the results
       num = num2str(i);
       fileC = strcat('task1_5_c_',num,'.mat');
       fileIDX = strcat('task1_5_idx_',num,'.mat');
       fileSSE = strcat('task1_5_sse_',num,'.mat');
       save(fileSSE, 'SSE');
       save(fileC, 'C');
       save(fileIDX, 'idx');
       
    end
    
end