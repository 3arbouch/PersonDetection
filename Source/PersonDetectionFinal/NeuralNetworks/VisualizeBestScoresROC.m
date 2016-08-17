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

layers = [1 2 3] ; 
numberOfActivations = 30:10:170 ; 
activationFunctions = {'sigm', 'tanh_opt'} ; 
K = 5 ; 
s = load('scores.mat') ; 
t = 3 ; 
AvgTpr=plotBestScoresROC( X, labels,s.scores, layers,numberOfActivations,t ) 
figure ; 
boxplot(AvgTpr)
var(AvgTpr)