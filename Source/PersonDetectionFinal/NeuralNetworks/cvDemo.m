% load data
clear all;
close all ; 
load('dataEx3.mat');

% choose degree
degree = [1 2 3 5 7 12];

% split data in K fold (we will only create indices)
setSeed(1);
K = 4;
N = size(y,1);
idx = randperm(N);
Nk = floor(N/K);
for k = 1:K
	idxCV(k,:) = idx(1+(k-1)*Nk:k*Nk) ; 
end

% lambda values (INSERT CODE)

lambda = logspace (-2,2,100) ; 
for j=1:length(degree) ; 
% K-fold cross validation
for i = 1:length(lambda)
	for k = 1:K
		% get k'th subgroup in test, others in train
		idxTe = idxCV(k,:); %% Get the kth line of indices
		idxTr = idxCV([1:k-1 k+1:end],:) ;  %% Get the remaining indices
		idxTr = idxTr(:);
		yTe = y(idxTe);
		XTe = X(idxTe,:);
		yTr = y(idxTr);
		XTr = X(idxTr,:);
		% form tX (INSERT CODE)
        
        txTr = [ones(length(yTr),1)  myPoly(XTr,degree(j))] ; 
        txTe = [ones(length(yTe),1)  myPoly(XTe,degree(j))] ; 

		% least squares (INSERT CODE)
        betaRidge=ridgeRegression(yTr,txTr,lambda(i)) ;    
        
		% training and test MSE(INSERT CODE)
		mseTrSub(k) = computeCost(yTr,txTr,betaRidge) ;
        

		% testing MSE using least squares
		mseTeSub(k) = computeCost(yTe,txTe,betaRidge); 

	end
	mseTr(i) = mean(mseTrSub);
	mseTe(i) = mean(mseTeSub);
end

[value,index] = min(mseTe)  ; 
minmseAll(j) = value ; 
lambdaStar(j) = lambda(index) ; 

mseTrAll(j, :) = mseTr ; 
mseTeAll(j, : ) = mseTe ; 

subplot(3,2,j) ; 
semilogx(lambda,mseTr,'b')
hold on 
semilogx(lambda,mseTe,'r')
end

minmseAll
[value, index] = min(minmseAll)



figure  ; 
boxplot(mseTrAll)

figure  ; 

boxplot(mseTeAll)


