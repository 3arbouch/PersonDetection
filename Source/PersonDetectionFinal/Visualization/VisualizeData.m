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

 for i=1:2
    clf();
    
    subplot(121);
    imshow(imgs{i}); % image itself
    
    subplot(122);
    im( hogDraw(feats{i}) ); colormap gray;
    axis off; colorbar off;
    hist(X(i,:),50) ; 
    pause;  % wait for keydo that then,??
end


%%
indexPersons = find(labels>0) ; 
indexNonPersons = find(labels<0) ; 

    figure  ; 
    
    subplot(221) ;  
    hist (X(indexPersons,2),50,'b') ;
    
    subplot(222); 
    hist(XPCA(indexPersons,2),50) ;
    
    
    
    subplot(223) ;  
    hist(X(indexNonPersons,2),50) ;
    
    subplot(224); 
    hist(XPCA(indexNonPersons,2),50) ;
    
    
    
   


% figure ; 
% hist(XPCA(indexPersons,7),50) ; 
% figure ; 
% hist(XPCA(indexNonPersons,7),50) ; 


% 
% %%PCA
% [U,mu,vars] = pca( X' ) ; 
% 
% % %% SVD
% % [U,S,V]= svd(X) ; 
% % Y= U*S ; 
% % principleComponetPeaople=Y(find(labels>0),:) ; 
% % principleComponetNotPeaople=Y(find(labels<0),:) ;
% % 
% % 
% % 
% % figure ; 
% % plot3(principleComponetPeaople(:,1),principleComponetPeaople(:,2),principleComponetPeaople(:,3), 'r*' )
% % hold on ; 
% % plot3(principleComponetNotPeaople(:,1),principleComponetNotPeaople(:,2) ,principleComponetNotPeaople(:,3),'bo' )
% % hold on
% % 
% 
% %% Visulaize Principle Components for PCA 
% k=3 ; 
% [ Y, Xhat, avsq ] = pcaApply( X', U, mu, k ) ; 
% Y = Y' ; 
% principleComponetPeaople=Y(find(labels>0),:) ; 
% principleComponetNotPeaople=Y(find(labels<0),:) ; 
% %% Plot
% figure ; 
% plot(principleComponetPeaople(:,1),principleComponetPeaople(:,2), 'r*' )
% hold on ; 
% plot(principleComponetNotPeaople(:,1),principleComponetNotPeaople(:,2) ,'bo' )
% hold on
% % 
