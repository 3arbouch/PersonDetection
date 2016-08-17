function [ scores, scoreBest, GammaBest, CBest, avgTPRList ] = findBestHyperPArametersSVM( data, labels, rangeGamma, rangeC,kernel, K  )
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

%  for k =1:K ; 
%                 % get k'th subgroup in test, others in train
%                 idxTe = idxCV(k,:); %% Get the kth line of indices
%                 idxTr = idxCV([1:k-1 k+1:end],:) ;  %% Get the remaining indices
%                 idxTr = idxTr(:);
%                 Te.y(:,k) = labels(idxTe);
%                 Te.X(:,:,k) = data(idxTe,:);
%                 Tr.y(:,k) = labels(idxTr);
%                 Tr.X (:,:,k)= data(idxTr,:);
%  end
%  

for i=1:length(rangeGamma)
    i
    for m=1:length(rangeC)
        m
        % Construct the paramater 

         param = sprintf('%s %d %s %d %s %d  ','-t',kernel,'-c', rangeC(m), '-g',rangeGamma(i)) ; 
        
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

		
              

             
                model = svmtrain(Tr.y, Tr.X , param);
                [~, ~, decision_values] = svmpredict(Te.y, Te.X, model );

                avgTPRList(i,m,k) = evaluateMultipleMethods( Te.y > 0, decision_values, 0)
                
                 
                 
             end

            scores(i,m) = mean(avgTPRList(i,m,:)) ; 
       
        
        
    end
    
end

[scoreBest, index] = max(scores(:)) ; 
[i,j] = ind2sub([length(rangeGamma) length(rangeC) ],index) ; 
GammaBest = rangeGamma(i) ; 
CBest = rangeC(j) ; 


end

