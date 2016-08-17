addpath(genpath('../toolbox/'));

% Load both features and training images
load train_feats;
load train_imgs;



%% -- Generate feature vectors (so each one is a row of X)
fprintf('Generating feature vectors..\n');
D = numel(feats{1});  % feature dimensionality
X = zeros([length(imgs) D]);

for i=1:length(imgs)
    X(i,:) = feats{i}(:);  % convert to a vector of D dimensions
end
% 
% K = 5  ; 
% 
% N = size(labels,1);
% idx = randperm(N);
% Nk = floor(N/K);
% parfor k = 1:K
% 	idxCV(k,:) = idx(1+(k-1)*Nk:k*Nk) ; 
% end
% 
% 
% 
% k = 1 ; 
% 
% % [Tr.X,Tr.y,Te.X,Te.y]=splitFair(X,labels,0.8,1) ; 
% % Split the Data
% %% Train an SVM Model: RBF KERNEL with DATA TRANFORMED with SVD
% 
% fprintf('Training SVM Model.. RBF KERNEL SVD DATA\n');
% % %% Generate SVD Vectors
% % [Utrain,Strain,~]=svd(Tr.X) ;
% % [Utest,Stest,~]=svd(Te.X) ;
% % 
% % XtrainSVD = Utrain*Strain ; 
% % XtestSVD = Utest*Stest ; 
% % 
% % 
% % Tr.XSVD = XtrainSVD(:,1:3500) ; 
% % Te.XSVD = XtestSVD(:,1:3500) ; 
% 
% 
% XSVD = XSVD (:,1:3500) ; 
% 
% % Generate Train and Test 
%                 idxTe = idxCV(k,:); %% Get the kth line of indices
%                 idxTr = idxCV([1:k-1 k+1:end],:) ;  %% Get the remaining indices
%                 idxTr = idxTr(:);
%                 Te.y = labels(idxTe);
%                 Te.X = XSVD(idxTe,:);
%                 Tr.y = labels(idxTr);
%                 Tr.X = XSVD(idxTr,:);
% 
% 
% 
% model1 = svmtrain(Tr.y, Tr.X , '-t 2 -g 0.02 -c 1 ');
% [predicted_label, accuracy, decision_values1] = svmpredict(Te.y, Te.X, model1 );
% 
% 
% 
% 
% 
% %% Train an SVM Model: RBF KERNEL with DATA TRANFORMED with PCA
%% Apply PCA on the DATA
% [U,mu,vars] = pca( X' ) ;
% % With this k, we capture 95 % of the main components of the Data 
% k = 2000 ; 
% [ Y, Xhat, avsq ] = pcaApply( X', U, mu, k ) ; 
% XPCA = Y' ; 
%    idxTe = idxCV(k,:); %% Get the kth line of indices
%                 idxTr = idxCV([1:k-1 k+1:end],:) ;  %% Get the remaining indices
%                 idxTr = idxTr(:);
%                 Te.y = labels(idxTe);
%                 Te.X = XPCA(idxTe,:);
%                 Tr.y = labels(idxTr);
%                 Tr.X = XPCA(idxTr,:);
% 
% fprintf('Training SVM Model.. RBF Kernel PCA Data\n');
% model2 = svmtrain(Tr.y, Tr.X , '-t 2 -g 0.02 -c 1');
% [predicted_label, accuracy, decision_values2] = svmpredict(Te.y, Te.X, model2 );
% 
% 
% %% Train an SVM Model: RBF KERNEL with  SubSampling The Data
% 
% fprintf('Training SVM Model.. RBF Kernel SubSampled  Data\n');
%          idxTe = idxCV(k,:); %% Get the kth line of indices
%                 idxTr = idxCV([1:k-1 k+1:end],:) ;  %% Get the remaining indices
%                 idxTr = idxTr(:);
%                 Te.y = labels(idxTe);
%                 Te.X = X(idxTe,:);
%                 Tr.y = labels(idxTr);
%                 Tr.X = X(idxTr,:);
% 
% 
% Tr.X = Tr.X(:,1:2:D) ; 
% Te.X = Te.X(:,1:2:D) ; 
% 
% model3 = svmtrain(Tr.y, Tr.X , '-t 2 -g 0.02 -c 1');
% [predicted_label, accuracy, decision_values3] = svmpredict(Te.y, Te.X, model3 );
% 
% 
% 
% 
% %% Train an SVM Model: RBF KERNEL with  Fair Split of the  Data
% 
% fprintf('Training SVM Model.. RBF Kernel Fair Data Split Data\n');
% [Tr.X, Tr.y, Te.X, Te.y] = splitFair( X,labels, 0.8,1) ; 
% model4 = svmtrain(Tr.y, Tr.X , '-t 2 -g 0.02 -c 1');
% [predicted_label, accuracy, decision_values4] = svmpredict(Te.y, Te.X, model4 );
% 
% 
% 
% 
% %% Train an SVM Model: RBF KERNEL with   The Hole Data
% 
% fprintf('Training SVM Model.. RBF Kernel ALL Data\n');
%                 idxTe = idxCV(k,:); %% Get the kth line of indices
%                 idxTr = idxCV([1:k-1 k+1:end],:) ;  %% Get the remaining indices
%                 idxTr = idxTr(:);
%                 Te.y = labels(idxTe);
%                 Te.X = X(idxTe,:);
%                 Tr.y = labels(idxTr);
%                 Tr.X = X(idxTr,:);
% 
% 
% 
% 
% model5 = svmtrain(Tr.y, Tr.X , '-t 2 -g 0.02 -c 1');
% [predicted_label, accuracy, decision_values5] = svmpredict(Te.y, Te.X, model5 );
% 
% 
% 
% 
% % See prediction performance
% fprintf('Plotting performance..\n');
% % let's also see how random predicition does
% randPred = rand(size(Te.y));
% 
%  methodNames = {'SVD', 'PCA', 'SubSampling by 2', 'FairSplit','All data'}; % this is to show it in the legend
%  avgTPRList = evaluateMultipleMethods( Te.y > 0, [decision_values1,decision_values2, decision_values3,decision_values4,decision_values5], true, methodNames );
% 
% 
%% Evaluate
methodNames = {'NN with SVD transformation', 'NN with PCA transformation', 'Neural Networks', 'All Data'}; % this is to show it in the legend
K = 5 ; 
numberOfMethodsToEvaluate =  3; 


tprAtWP = plotROCCurvesDiffTransformations(  X, labels, numberOfMethodsToEvaluate,methodNames, K )

% [U,S,V]=svd(X) ; 
% X = U*S ; 
% X=X(:,1:3000) ; 
% [Tr.X,Tr.y,Te.X,Te.y]=splitAndSubSample(X,labels,0.8,8,1) ; 

%%
% % [U,S,V]=svd(X) ; 
% % X = U*S ; 
% % X=X(:,1:3000) ; 
% rangeGamma = 0.0483;
% % rangeGamma = [0.1 10] ; 
% kernel =2 ; 
% 
% 
% rangeC = 10 ;  
% %  rangeC = 1;  
% 
% K = 5 ; 
% 
% 
% 
% [ scores, scoreBest, GammaBest, CBest ] = findBestHyperPArametersSVM( X, labels, rangeGamma, rangeC,kernel,  K  )








