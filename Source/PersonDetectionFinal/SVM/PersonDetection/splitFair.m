function  [XTr, yTr, XTe, yTe] = splitFair( X,y, prop,s)
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
    indicesOfNonFaces = find(yTr<0) ; 
    numberOfFaces = sum(yTr>0) ; 
    indices=generateIndices(indicesOfNonFaces, numberOfFaces) ; 
    
    ind= [find(yTr>0)' indices ] ; 
    XTr =  XTr(ind,:) ; 
    yTr = yTr(ind,:) 
    sum(yTr>0)
    sum(yTr<0)
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

function indicesNonFacesToTake= generateIndices(indicesNonFaces, numberToTake)
indicesNonFacesToTake= zeros(1,numberToTake)  ; 
for i=1:numberToTake
    index = randi([1 length(indicesNonFaces)],1,1) ;
    indicesNonFacesToTake(i) = indicesNonFaces(index) ;   
    indicesNonFaces(index) = [] ; 
    
end


end
