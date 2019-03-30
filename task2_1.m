%
%
function task2_1(Xtrain, Ytrain, Xtest, Ytest, Ks)
% Input:
%  Xtrain : M-by-D training data matrix (double)
%  Ytrain : M-by-1 label vector (unit8) for Xtrain
%  Xtest  : N-by-D test data matrix (double)
%  Ytest  : N-by-1 label vector (unit8) for Xtest
%  Ks     : 1-by-L vector (integer) of the numbers of nearest neighbours in Xtrain
    
    tic;
        [Ypreds] = run_knn_classifier(Xtrain, Ytrain, Xtest, Ks);
    t = toc;
    disp(t);
    
    for i = 1:length(Ks)
        
        k = Ks(i);
        [CM, acc] = comp_confmat(Ytest, Ypreds, k);
        
        % Saving the results
        num = num2str(k);
        fileCM = strcat('task1_5_cm',num,'.mat');
        save(fileCM, 'CM');
        
        N = length(Xtrains);
        Nerrs = N - diag(CM);
       
        disp(k);
        disp(N);
        disp(Nerrs);
        disp(acc);
        
    end
   
end

