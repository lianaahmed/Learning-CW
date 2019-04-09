%
%
function task2_3(X, Y)
% Input:
%  X : M-by-D data matrix (double)
%  Y : M-by-1 label vector for X (unit8)
    [EVecs, EVals] = comp_pca(X);
    
    % Since we should explain most of the variance, 
    % we should sort the variances in decreasing order
    
    [tmp, ridx] = sort(EVals, 1, 'descend');
    EVecs = EVecs(:,ridx);
    EVals = EVals(ridx);
    
    PCA = [EVecs(:,1)'; EVecs(:,2)'];
    tData = (PCA*X')';
    
    % For each class
    for i = 0:9
        % Find the X values for each class
        indices = find(Y==i, 10);
        M = tData(indices,:);
        
        % Compute mean and covariance matrix of each class
        mu = myMean(M);
        covM = myCov(M, mu);

        % Compute the eigenvectors and eigenvalues
        [evecs, evals] = eig(covM);

        % Set the linspace
        l = linspace(0, 2*pi);
        
        % Create ellipse
        ellipse = (evecs * sqrt(evals)) * [cos(l(:))'; sin(l(:))'];

        
        % Plot the ellipse
        % Label centres for each circle with class name
        % Label axes

        plot(ellipse(1,:) + mu(1), ellipse(2,:) + mu(2));
        text(mu(1), mu(2), num2str(i));
        xlabel("First principle component");
        ylabel("Second principle component");

        %Plot all ellipses on same figure
        hold on

    end
end
