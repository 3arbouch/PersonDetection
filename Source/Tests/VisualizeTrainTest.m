close all ; 
load train_feats;
load train_imgs;

featureMAtrix = feats{1} ; 
size(featureMAtrix) ; 

imageMatrix = imgs{1} ; 
size(imageMatrix) ; 

figure ; 
hist(featureMAtrix(13,2),36)

fprintf('Generating feature vectors..\n');
D = numel(feats{1})  % feature dimensionality
X = zeros([length(imgs) D]);
size(X)

 X(1,:) = feats{1}(:);
 size(X(1,:))
