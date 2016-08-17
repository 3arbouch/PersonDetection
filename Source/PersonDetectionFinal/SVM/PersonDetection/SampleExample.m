addpath(genpath('../toolbox/'));

% Load both features and training images
load train_feats;
load train_imgs;

% %% --browse through the images, and show the feature visualization beside
% %  -- You should explore the features for the positive and negative
% %  examples and understand how they resemble the original image.
% for i=1:2
%     clf();
%     
%     subplot(121);
%     imshow(imgs{i}); % image itself
%     
%     subplot(122);
%     im( hogDraw(feats{i}) ); colormap gray;
%     axis off; colorbar off;
%     
%     pause;  % wait for keydo that then,??
% end

%% -- Generate feature vectors (so each one is a row of X)
fprintf('Generating feature vectors..\n');
D = numel(feats{1});  % feature dimensionality
X = zeros([length(imgs) D]);

for i=1:length(imgs)
    X(i,:) = feats{i}(:);  % convert to a vector of D dimensions
end


% % -- Example: split half and half into train/test
% % fprintf('Splitting into train/test..\n');
% % % NOTE: you should do this randomly! and k-fold!
% % Tr.idxs = 1:2:size(X,1);
% % Tr.X = X(Tr.idxs,:);
% % Tr.y = labels(Tr.idxs);
% % 
% % Te.idxs = 2:2:size(X,1);
% % Te.X = X(Te.idxs,:);
% % Te.y = labels(Te.idxs);
% 
% % [Tr.X,Tr.y,Te.X,Te.y]=splitFair(X,labels,0.8,1) ; 
% % Split the Data
% [Tr.X,Tr.y,Te.X,Te.y]=splitAndSubSample(X,labels,0.8,1,1) ; 
% %% Train an SVM Model: LINEAR KERNEL
% 
% fprintf('Training SVM Model.. Linear Kernel\n');
% 
% model1 = svmtrain(Tr.y, Tr.X , '-t 0 -c 1 ');
% [predicted_label, accuracy, decision_values1] = svmpredict(Te.y, Te.X, model1 );
% 
% 
% 
% %% Train an SVM Model: Polynomial Kernel 2Degree
% 
% fprintf('Training SVM Model.. Polynomial Kernel 2 Degrees\n');
% 
% model2 = svmtrain(Tr.y, Tr.X , '-t 1 -c 1 -d 2');
% [predicted_label, accuracy, decision_values2] = svmpredict(Te.y, Te.X, model2 );
% 
% %% Train an SVM Model: Polynomial Kernel 3Degree
% 
% fprintf('Training SVM Model.. Polynomial Kernel 3 Degrees\n');
% 
% model3 = svmtrain(Tr.y, Tr.X , '-t 1 -c 1 -d 3');
% [predicted_label, accuracy, decision_values3] = svmpredict(Te.y, Te.X, model3 );
% 
% %% Train an SVM Model: RBF Kernel
% fprintf('Training SVM Model.. RBF Kernel\n');
% model4 = svmtrain(Tr.y, Tr.X , '-t 2 -c 1 -g 0.02 ');
% [predicted_label, accuracy, decision_values4] = svmpredict(Te.y, Te.X, model4 );
% 
% 
% %% Train an SVM Model: Sigmoid Kernel Kernel
% fprintf('Training SVM Model.. Sigmoid Kernel\n');
% model5 = svmtrain(Tr.y, Tr.X , '-t 3 -c 1 ');
% [predicted_label, accuracy, decision_values5] = svmpredict(Te.y, Te.X, model5 );
% 
% %% See prediction performance
% fprintf('Plotting performance..\n');
% % let's also see how random predicition does
% randPred = rand(size(Te.y));
% 
% % and plot all together, and get the performance of each
% methodNames = {'Linear Kernel', 'Polynomial Kernel Degree 2', 'Polynomial Kernel Degree 3', 'RBF Kernel','Sigmoid Kernel'}; % this is to show it in the legend
% avgTPRList = evaluateMultipleMethods( Te.y > 0, [decision_values1,decision_values2, decision_values3,decision_values4,decision_values5], true, methodNames );
% 
% % now you can see that the performance of each method
% % is in avgTPRList. You can see that random is doing very bad.
% avgTPRList
% 



% [U,S,V]=svd(X) ; 
% X = U*S ; 
% X=X(:,1:3000) ; 
% [Tr.X,Tr.y,Te.X,Te.y]=splitAndSubSample(X,labels,0.8,8,1) ; 

%% SVD
[U,S,V]=svd(X) ; 
XSVD = U*S ; 
XSVD=XSVD(:,1:3500) ; 
% rangeGamma = 0.0483;
% % rangeGamma = [0.1 10] ; 
% kernel =2 ; 
% 
% 


%% Best Parameters
rangeGamma= logspace(-2,-1,20) ; 
rangeC = 5;  

kernel = 2 ; 
K = 5 ; 
% 
% [U,mu,vars] = pca( X' ) ;
% % With this k, we capture 95 % of the main components of the Data 
% k = 1100 ; 
% [ Y, Xhat, avsq ] = pcaApply( X', U, mu, k ) ; 
% X = Y' ; 


[ scores, scoreBest, GammaBest, CBest, avgTPRList] = findBestHyperPArametersSVM( XSVD, labels, rangeGamma, rangeC,kernel,  K  )

%% 

% methodNames = {'Linear Kernel', 'Polynomial Kernel Degree 2', 'Polynomial Kernel Degree 3', 'RBF Kernel','Sigmoid Kernel'}; % this is to show it in the legend
% K = 5 ; 
% numberOfMethodsToEvaluate =  5; 
% [tprAtWP] = ploROcCurvesDiffKernels( X, labels, numberOfMethodsToEvaluate,methodNames, K  )





