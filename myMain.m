
clear; close all; clc;

%% load data matrix
load('./preprocessedData/dataNameList.mat');
curItr = 2; % 2 stands for attractiveness.
curDataName = dataNameList(curItr);
fprintf(sprintf('Loading %s.\n\n',curDataName{:}));
load(curDataName{:});%Y and R

%% split test, cross-validation and training set.
trainRatio = 0.9; crossRatio = 0.01; testRatio = 0.09;
[trainYnorm, trainYmean, trainSetR, crossInd, crossGT, testInd, testGT] = myPack.splitSet(Y, R, trainRatio, crossRatio, testRatio);

%% Initialize params
lambda = 10; maxItr = 100; options = optimset('GradObj', 'on', 'MaxIter', maxItr);
[num_faces, num_users] = size(Y);

% initialzie X and Theta.
[num_features, X] = myPack.featureGen('random');
Theta = randn(num_users, num_features);
init_params = [X(:);Theta(:)];

%% Train the model
params = myPack.fmincg (@(t)(myPack.cofiCostFunc(t, trainYnorm, trainSetR, num_users, num_faces, num_features, lambda)), init_params, options);

% Unfold the returned theta back into X and Theta
X = reshape(params(1:num_faces*num_features), num_faces, num_features);
Theta = reshape(params(num_faces*num_features+1:end), num_users, num_features);
fprintf('Recommender system learning completed.\n');

%% Test performance
MSR = myPack.predictionError(X, Theta, R, trainYmean, testInd, testGT);

fprintf('mean squared error = %4.2f.\n',MSR);
