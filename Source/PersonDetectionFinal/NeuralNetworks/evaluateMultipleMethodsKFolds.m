% Automatically calls fastROC() to show multiple curves, one for each
% prediction vector provided.
%
% labels        Nx1 vector
% predictions   NxM vector, M being the number of predictions to show
%
% if showPlot == true => single plot with multiple curves is shown.
% legendNames is a cell list (optional) with the name to show for each
% prediction in the legend.
%
% Returns tprAtWP where each element is the tprAtWP of each prediction
% vector given as input.
%
function [tprAtWP,auc,fpr,tpr] = evaluateMultipleMethodsKFolds( labels, predictions, ...
                                            showPlot, legendNames,plotMeanValue, stylesNum )

if nargin < 3
    showPlot = false;
end

if ~plotMeanValue
    legendNames = [];
end

if size(labels,2) ~= 1
    error('Labels must be Nx1');
end

if size(labels,1) ~= size(predictions,1)
    error('labels and predictions must have same number of rows');
end

M = size(predictions,2);

% list of plotting styles
styles = {'r','b','g','m','k'};
shades = [1 0.9 0.9 ; 0.9 0.9 1; 0.9 1 0.9 ; 1 0.9 1 ; 0.9 0.9 0.9] ; 

if showPlot && (M > length(styles))
    error('Number of lines to show exceeds possible styles');
end

tprAtWP = zeros(M,1);

% if showPlot
%     figure;
% end

for i=1:M
    if(plotMeanValue)
   [tprAtWP(i),auc,fpr,tpr]  = fastROCKFold( labels, predictions(:,i), showPlot, styles{stylesNum}, 0, plotMeanValue,legendNames(1) );
    else
   [tprAtWP(i),auc,fpr,tpr]=   fastROCKFold( labels, predictions(:,i), showPlot, styles{stylesNum}, shades(stylesNum,:), plotMeanValue,'' ) ; 
    end
    if showPlot
        hold on;
    end
end


% 
% if showPlot && ~isempty(legendNames) && plotMeanValue
%     % add tprAtWP to legend names
%     for i=1:M
%         legendNames{i} = sprintf('%s: %.3f', legendNames{i}, tprAtWP(i));
%     end
%     
%     legend( legendNames, 'Location', 'NorthWest' );
end
