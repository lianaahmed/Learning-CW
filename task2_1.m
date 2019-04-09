%
%
function task2_1(Xtrain, Ytrain, Xtest, Ytest, Ks)
% Input:
%  Xtrain : M-by-D training data matrix (double)
%  Ytrain : M-by-1 label vector (unit8) for Xtrain
%  Xtest  : N-by-D test data matrix (double)
%  Ytest  : N-by-1 label vector (unit8) for Xtest
%  Ks     : 1-by-L vector (integer) of the numbers of nearest neighbours in Xtrain
    

        [Ypreds] = run_knn_classifier(Xtrain, Ytrain, Xtest, Ks);
    
    for i = 1:length(Ks)
        
        k = Ks(i);
        [CM, acc] = comp_confmat(Ytest, Ypreds(:,i), 10);
        
        % Saving the results
        num = num2str(k);
        fileCM = strcat('task2_1_cm',num,'.mat');
        save(fileCM, 'CM');
        
        N = length(Ypreds);
        Nerrs = N - diag(CM);
        
        disp(k);
        disp(N);
        disp(Nerrs);
        disp(acc);
        
    end
   
end

