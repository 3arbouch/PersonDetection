% Automatically calls fastROC() to show multiple curves, one for each
% prediction vector provided.
% shows also the mean predictions over all the K folds 
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


function TPRAverage = evaluateMultipleMethodsForKFolds( labels, predictions,meanPredictions,showPlot, legendNames )


if nargin < 3
    showPlot = false;
end

if nargin < 4
    legendNames = [];
end

if size(labels,2) ~= 1
    error('Labels must be Nx1');
end

if size(labels,1) ~= size(meanPredictions,1)
    error('labels and predictions must have same number of rows');
end

M = size(predictions,2);
N = size(meanPredictions,2) ; 
% list of plotting styles
styles = {'r','b','g'};
shades = [1 0.7 0.7 ; 0.7 0.7 1; 0.7 1 0.7 ] ; 



if showPlot && (M > length(styles))
    error('Number of lines to show exceeds possible styles');
end

tprAtWP = zeros(M,N);
TPRAverage = zeroes(N,1) ; 
if showPlot
    figure;
end
for j=1:N
    for i=1:M
        tprAtWP(i,j) = fastROC( labels, predictions(:,i), showPlot, styles{j},shades(j,:), flase);
        if showPlot
            hold on;
        end
    end
    TPRAverage(j) = fastROC( labels, meanPredictions(:,j), showPlot, styles{j},0, true) ; 
        if showPlot
            hold on;
        end
    
end
if showPlot && ~isempty(legendNames)
    % add tprAtWP to legend names
    for i=1:N
        legendNames{i} = sprintf('%s: %.3f', legendNames{i}, TPRAverage(i));
    end
    
    legend( legendNames, 'Location', 'NorthWest' );


end

