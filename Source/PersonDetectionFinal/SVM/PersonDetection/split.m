function [XTr, yTr, XTe, yTe] = split( X,y, prop,s)
% split the data into train and test given a proportion
	setSeed(s);
    N = size(y,1);
		% generate random indices
		idx = randperm(N);
    Ntr = floor(prop * N);
		% select few as training and others as testing
		idxTr = idx(1:Ntr);
		idxTe = idx(Ntr+1:end);
		% create train-test split
    XTr = X(idxTr,:);
    yTr = y(idxTr);
    XTe = X(idxTe,:);
    yTe = y(idxTe);
end

function setSeed(seed)
% set seed
	global RNDN_STATE  RND_STATE
	RNDN_STATE = randn('state');
	randn('state',seed);
	RND_STATE = rand('state');
	%rand('state',seed);
	rand('twister',seed);
end
