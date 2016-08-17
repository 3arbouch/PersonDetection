function [ decision_values ] = evaluateDiffKernels( i, TrX, Try, Tey,TeX )
% this function is used to determine the decision values for each specified
% kernel by the index i
% Is used to plot ROC kurves over K folds
if(i==1)
    %% Train an SVM Model: LINEAR KERNEL

fprintf('Training SVM Model.. Linear Kernel\n');

model = svmtrain(Try, TrX , '-t 0 -c 1 ');
[predicted_label, accuracy, decision_values] = svmpredict(Tey, TeX, model );

elseif(i==2)
%% Train an SVM Model: Polynomial Kernel 2Degree

fprintf('Training SVM Model.. Polynomial Kernel 2 Degrees\n');

model = svmtrain(Try, TrX , '-t 1 -c 1 -d 2');
[predicted_label, accuracy, decision_values] = svmpredict(Tey, TeX, model );

elseif(i==3)

%% Train an SVM Model: Polynomial Kernel 3Degree

fprintf('Training SVM Model.. Polynomial Kernel 3 Degrees\n');

model = svmtrain(Try, TrX , '-t 1 -c 1 -d 3');
[predicted_label, accuracy, decision_values] = svmpredict(Tey, TeX, model );
elseif(i==4)

%% Train an SVM Model: RBF Kernel
fprintf('Training SVM Model.. RBF Kernel\n');
model = svmtrain(Try, TrX , '-t 2 -c 1 -g 0.02 ');
[predicted_label, accuracy, decision_values] = svmpredict(Tey, TeX, model );

elseif(i==5)

%% Train an SVM Model: Sigmoid Kernel Kernel
fprintf('Training SVM Model.. Sigmoid Kernel\n');
model = svmtrain(Try, TrX , '-t 3 -c 1 ');
[predicted_label, accuracy, decision_values] = svmpredict(Tey, TeX, model );


end


    
    

    

end

