function[tprAtWP] = ploROcCurvesDiffKernels( data, labels, methods,methodsNames, K  )
% This function is responsible of finding the best parameters for SVM:
% The cost C and the gammma (Bandwith of the RBF KERNEL)
% The best parameters will be the ones that minimizes the validation set
% error or maximizing the average TPR 
% over K folds 



N = size(labels,1);
idx = randperm(N);
Nk = floor(N/K);
parfor k = 1:K
	idxCV(k,:) = idx(1+(k-1)*Nk:k*Nk) ; 
end


styles = {'r','b','g','m','k'};
%
figure  ; 
for i=1:methods
  i
       

    
             for k=1:K
                  k
                % get k'th subgroup in test, others in train

                idxTe = idxCV(k,:); %% Get the kth line of indices
                idxTr = idxCV([1:k-1 k+1:end],:) ;  %% Get the remaining indices
                idxTr = idxTr(:);
                Te.y = labels(idxTe);
                Te.X = data(idxTe,:);
                Tr.y = labels(idxTr);
                Tr.X = data(idxTr,:);
        
		
                [ decision_values ] = evaluateDiffKernels( i, Tr.X, Tr.y, Te.y,Te.X ) ; 
                [tprAtWP(k,i),auc(:,k),fpr(:,:,k),tpr(:,:,k)] = evaluateMultipleMethodsKFolds( Te.y > 0, decision_values, true,'',0,i );
                hold on ; 
                 
                 
             end
           
            fprAvr = mean (fpr,3) ; 
            tprAvr = mean (tpr,3)  ; 
           
           x(i) = semilogx(fprAvr,tprAvr,styles{i},'LineWidth',2);
           legendNames{i} = sprintf('%s  %.3f', methodsNames{i}, mean(tprAtWP(:,i)));
           
           hold on ; 
        
        
    
    
end


 legend(x,  legendNames, 'Location', 'NorthWest' );


end

