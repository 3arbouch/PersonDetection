function [ decision_values, Te ] = evaluateDiffTransformations( i, k,X, labels, XSVD,XPCA,idxCV)
% this function is used to determine the decision values for each specified
% kernel by the index i
% Is used to plot ROC kurves over K folds

if(i==1)
  %% Train an SVM Model: RBF KERNEL with DATA TRANFORMED with SVD

fprintf('Training SVM Model.. RBF KERNEL SVD DATA\n');



XSVD = XSVD(:,1:3500) ; 

% Generate Train and Test 
                idxTe = idxCV(k,:); %% Get the kth line of indices
                idxTr = idxCV([1:k-1 k+1:end],:) ;  %% Get the remaining indices
                idxTr = idxTr(:);
                Te.y = labels(idxTe);
                Te.X = XSVD(idxTe,:);
                Tr.y = labels(idxTr);
                Tr.X = XSVD(idxTr,:);


                
          rng(8339);  % fix seed, this    NN is very sensitive to initialization

% setup NN. The first layer needs to have number of features neurons,
%  and the last layer the number of classes (here two).
nn = nnsetup([size(Tr.X,2) 100 100 2]);
opts.numepochs =  50;   %  Number of full sweeps through data
opts.batchsize = 100;  %  Take a mean gradient step over this many samples

% if == 1 => plots trainin error as the NN is trained
opts.plot               = 0; 

   nn.activation_function = 'sigm';    %  Sigmoid activation function
   nn.learningRate = 1;                %  Sigm require a lower learning rate
                    

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
nnPred = nnPred(:,1) - nnPred(:,2);

  decision_values = nnPred ;   
           
                
                
                
                

% model = svmtrain(Tr.y, Tr.X , '-t 2 -g 0.0207 -c 1 ');
% [predicted_label, accuracy, decision_values] = svmpredict(Te.y, Te.X, model );


elseif(i==2)
%% Train an SVM Model: RBF KERNEL with DATA TRANFORMED with PCA

   idxTe = idxCV(k,:); %% Get the kth line of indices
                idxTr = idxCV([1:k-1 k+1:end],:) ;  %% Get the remaining indices
                idxTr = idxTr(:);
                Te.y = labels(idxTe);
                Te.X = XPCA(idxTe,:);
                Tr.y = labels(idxTr);
                Tr.X = XPCA(idxTr,:);

                
                
        rng(8339);  % fix seed, this    NN is very sensitive to initialization

% setup NN. The first layer needs to have number of features neurons,
%  and the last layer the number of classes (here two).
nn = nnsetup([size(Tr.X,2) 100 100 2]);
opts.numepochs =  50;   %  Number of full sweeps through data
opts.batchsize = 100;  %  Take a mean gradient step over this many samples

% if == 1 => plots trainin error as the NN is trained
opts.plot               = 0; 

   nn.activation_function = 'sigm';    %  Sigmoid activation function
   nn.learningRate = 1;                %  Sigm require a lower learning rate
                    

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
nnPred = nnPred(:,1) - nnPred(:,2);

  decision_values = nnPred ;   
             
                
                
                
                
                
                
% fprintf('Training SVM Model.. RBF Kernel PCA Data\n');
% model = svmtrain(Tr.y, Tr.X , '-t 2 -g 0.0162 -c 5');
% [predicted_label, accuracy, decision_values] = svmpredict(Te.y, Te.X, model );
elseif(i==3)
    %% Neural Networks
             idxTe = idxCV(k,:); %% Get the kth line of indices
                idxTr = idxCV([1:k-1 k+1:end],:) ;  %% Get the remaining indices
                idxTr = idxTr(:);
                Te.y = labels(idxTe);
                Te.X = X(idxTe,:);
                Tr.y = labels(idxTr);
                Tr.X = X(idxTr,:);
    
    rng(8339);  % fix seed, this    NN is very sensitive to initialization

% setup NN. The first layer needs to have number of features neurons,
%  and the last layer the number of classes (here two).
nn = nnsetup([size(Tr.X,2) 100 100 2]);
opts.numepochs =  50;   %  Number of full sweeps through data
opts.batchsize = 100;  %  Take a mean gradient step over this many samples

% if == 1 => plots trainin error as the NN is trained
opts.plot               = 0; 

   nn.activation_function = 'sigm';    %  Sigmoid activation function
   nn.learningRate = 1;                %  Sigm require a lower learning rate
                    

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
nnPred = nnPred(:,1) - nnPred(:,2);

  decision_values = nnPred ;   
    
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
% Tr.X = Tr.X(:,1:2:size(X,2)) ; 
% Te.X = Te.X(:,1:2:size(X,2)) ; 
% 
% model = svmtrain(Tr.y, Tr.X , '-t 2 -g 0.02 -c 1');
% [predicted_label, accuracy, decision_values] = svmpredict(Te.y, Te.X, model );



elseif(i==4)
%% Train an SVM Model: RBF KERNEL with   The Hole Data

fprintf('Training SVM Model.. RBF Kernel ALL Data\n');
                idxTe = idxCV(k,:); %% Get the kth line of indices
                idxTr = idxCV([1:k-1 k+1:end],:) ;  %% Get the remaining indices
                idxTr = idxTr(:);
                Te.y = labels(idxTe);
                Te.X = X(idxTe,:);
                Tr.y = labels(idxTr);
                Tr.X = X(idxTr,:);




model = svmtrain(Tr.y, Tr.X , '-t 2 -g 0.02 -c 1');
[predicted_label, accuracy, decision_values] = svmpredict(Te.y, Te.X, model );


end

end

