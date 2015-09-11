% myGroupAnalysis.m

% use collaborative filtering to analyze attractiveness preference by age,
% gender and race

clear; close all; clc; 

%% Load data matrix
fieldName = 'age';% you can also choose 'gender' and 'race'
fprintf(sprintf('Loading %s YR data..\n\n',fieldName));
load(sprintf('./preprocessedData/%sYRData.mat',fieldName));

%% Split test, cv and training set
trainRatio = 0.9; crossRatio = 0.01; testRatio = 0.09;
[trainYnorm, trainYmean, trainSetR, crossInd, crossGT, testInd, testGT] = ...
    myPack.splitSet(Y, R, trainRatio, crossRatio, testRatio);

%% Initialize params
maxItr = 300; options = optimset('GradObj', 'on', 'MaxIter', maxItr);
[num_faces, num_users] = size(Y);
[num_features, X, gradFlag] = myPack.featureGen('socialOther');
Theta = randn(num_users, num_features);
init_params = [X(:);Theta(:)];

%% Cross validate lambda &/ different feature models
lambda = 10; 

%% Train and test with optimal model. 
params = myPack.fmincg (@(t)(myPack.cofiCostFunc...
    (t, trainYnorm, trainSetR, num_users, num_faces, num_features, lambda, gradFlag)), init_params, options);  
X = reshape(params(1:num_faces*num_features), num_faces, num_features);
Theta = reshape(params(num_faces*num_features+1:end), num_users, num_features);
fprintf('Recommender system learning completed.\n');

%% Test performance
MSR = myPack.predictionError(X, Theta, R, trainYmean, testInd, testGT);
fprintf('mean squared error = %4.2f.\n',MSR);

%% Save the learned feature and learned preference for attractiveness
save(sprintf('./factorAnalysis/weightBy_%s.mat',fieldName),'X','Theta');