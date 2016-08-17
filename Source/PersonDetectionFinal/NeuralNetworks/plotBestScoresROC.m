function [ tprAtWP ] = plotBestScoresROC( data, labels,scores,  layers,dimHidden,t )
% This function plots ROC curves for different fixed Layers and dimension
% Hidden Variables the K fold ROC curves for each model and its mean 

% This function helps have a prior informations about which of the
% activation function is better 



% Generate the K rows of random indices 
K =5 ; 
N = size(labels,1);
idx = randperm(N);
Nk = floor(N/K);
for k = 1:K
	idxCV(k,:) = idx(1+(k-1)*Nk:k*Nk) ; 
end

% Get the t best scores 
[~,sortIndex] = sort(scores(:),'descend') ; 
% take the t top scores


topScoresindices = sortIndex(1:t) ; 
% k = 1 ; 
% 
%                    idxTe = idxCV(k,:); %% Get the kth line of indices
%                 idxTr = idxCV([1:k-1 k+1:end],:) ;  %% Get the remaining indices
%                 idxTr = idxTr(:);
%                 Te.y = labels(idxTe);
%                 Te.X = data(idxTe,:);
%                 Tr.y = labels(idxTr);
%                 Tr.X = data(idxTr,:);
%      
%      
% 


styles = {'r','b','g','b','c'};
 figure ; 
for i=1:t
    % get the correspending layer and hidden variables values
    [m,n] = ind2sub(size(scores),topScoresindices(i)) ; 
    vectorHiddenVariables = dimHidden(n)*ones(1,layers(m)) ; 
    layers(m)
    dimHidden(n)
    scores(m,n)
     % get k'th subgroup in test, others in train
               
		
              
     
         for k =1:K
             
                idxTe = idxCV(k,:); %% Get the kth line of indices
                idxTr = idxCV([1:k-1 k+1:end],:) ;  %% Get the remaining indices
                idxTr = idxTr(:);
                Te.y = labels(idxTe);
                Te.X = data(idxTe,:);
                Tr.y = labels(idxTr);
                Tr.X = data(idxTr,:);
     
                rng(8339);  % fix seed, this    NN is very sensitive to initialization

                % setup NN. The first layer needs to have number of features neurons,
                %  and the last layer the number of classes (here two).
                nn = nnsetup([size(Tr.X,2) vectorHiddenVariables 2]);
                    
     
                    nn.activation_function = 'sigm';    %  Sigmoid activation function
                    nn.learningRate = 1;                %  Sigm require a lower learning rate
                    
                    
            
                
                

                opts.numepochs =  50;   %  Number of full sweeps through data
                opts.batchsize = 100;  %  Take a mean gradient step over this many samples

                % if == 1 => plots trainin error as the NN is trained
                opts.plot               = 0; 

                

                % this neural network implementation requires number of samples to be a
                % multiple of batchsize, so we remove some for this to be true.
                numSampToUse = opts.batchsize * floor( size(Tr.X) / opts.batchsize);
                Tr.X = Tr.X(1:numSampToUse,:);
                Tr.y = Tr.y(1:numSampToUse);

                % normalize data
                [Tr.normX, mu, sigma] = zscore(Tr.X); % train, get mu and std

                % prepare labels for NN
                LL = [1*(Tr.y>0)  1*(Tr.y<0)];  % first column, p(y=1)
                                                   % second column, p(y=-1)

                [nn, L] = nntrain(nn, Tr.normX, LL, opts);


                Te.normX = normalize(Te.X, mu, sigma);  % normalize test data

                % to get the scores we need to do nnff (feed-forward)
                %  see for example nnpredict().
                % (This is a weird thing of this toolbox)
                nn.testing = 1;
                nn = nnff(nn, Te.normX, zeros(size(Te.normX,1), nn.size(end)));
                nn.testing = 0;

                % predict on the test set
                nnPred = nn.a{end};

                % we want a single score, subtract the output sigmoids
%                 nnPredAll(:,i) = nnPred(:,1) - nnPred(:,2);
               nnPred = nnPred(:,1) - nnPred(:,2) ; 
                if(i~=3)
               [tprAtWP(k,i),auc(:,k),fpr(:,:,k),tpr(:,:,k)] = evaluateMultipleMethodsKFolds( Te.y > 0, nnPred, true,'',0,i );
                hold on ; 
                else
               [tprAtWP(k,i),auc(:,k),fpr(:,:,k),tpr(:,:,k)] = evaluateMultipleMethodsKFolds( Te.y > 0, nnPred, 0,'',0,i );

                end
                % now you can see that the performance of each method
                % is in avgTPRList. You can see that random is doing very bad.
         end
         
         if(i~=3)
           fprAvr = mean (fpr,3) ; 
           tprAvr = mean (tpr,3)  ; 
           
           x(i) = semilogx(fprAvr,tprAvr,styles{i},'LineWidth',2);
           legendNames{i} = sprintf('%s %d: %.3f', 'Best Score number',i, mean(tprAtWP(:,i)));
           
           hold on ; 
         end
end 
                legend(x,  legendNames, 'Location', 'NorthWest' );
                title('ROC curves for the two best parameters') ; 
         
%                  methodNames = {'Best 1', 'Best 2', 'Best 3 '};
%                 avgTPRList = evaluateMultipleMethods( Te.y > 0, nnPredAll, true,methodNames);



end

