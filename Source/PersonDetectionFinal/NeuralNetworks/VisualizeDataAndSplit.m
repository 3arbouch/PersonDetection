load train_feats;
load train_imgs;

% %% --browse through the images, and show the feature visualization beside
% %  -- You should explore the features for the positive and negative
% %  examples and understand how they resemble the original image.
% for i=1:30
%     clf();
%     
%     subplot(131);
%     imshow(imgs{i}); % image itself
%     
%     subplot(132);
%     im( hogDraw(feats{i}) ); colormap gray;
%     subplot(133)
%     hist(feats{i}(:),100) ;
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

[Tr.X, Tr.y, Te.X, Te.y ] = splitNormal(X,labels, partition) ; 


% [X_Train, labels_Train, X_Test, labels_Test ] = splitFair(X,labels) ;


