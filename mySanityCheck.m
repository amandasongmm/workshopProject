% mySanityCheck.m

clear all; close all; clc;

%% Generate simulation data.
featureMatrix_GT = round(abs(rands(2222,9)));
userMatrix_GT = round(abs(rands(200,9)));
Y = featureMatrix_GT * userMatrix_GT';
%R = round(abs(rand(size(Y))));
R = ones(size(Y));
Y = Y.*R;

%% Split test, cv and training set
trainRatio = 0.8; crossRatio = 0.1; testRatio = 0.1;
[trainYnorm, trainYmean, trainSetR, crossInd, crossGT, testInd, testGT] = myPack.splitSet(Y, R, trainRatio, crossRatio, testRatio);

%% Initialize params
% specify X
X = featureMatrix_GT;%num_m*num_f
theta = rands(size(Y,2), size(X,2));
init_params = theta(:);
options = optimset('MaxIter', 200, 'GradObj', 'on');

error = myPack.Gradient_checking(@myPack.myCostFunc,init_params,40, X, trainYnorm, trainSetR);

params = myPack.fmincg(@(t)(myPack.myCostFunc(t,X,Y,R)),init_params,options);
Theta = reshape(params,size(Y,2),size(X,2));

% %% Test performance
[MSR, prediction, dif] = myPack.predictionError(X, Theta, R, trainYmean, testInd, testGT);
fprintf('Test set. mean squared error = %4.2f.\n',MSR);

%% minFunc optimizer
addpath ./common
addpath ./common/minFunc_2012/minFunc
addpath ./common/minFunc_2012/minFunc/compiled

X = featureMatrix_GT;%num_m*num_f
theta = rands(size(Y,2), size(X,2));
init_params = [X(:);theta(:)];
options = struct('MaxIter', 1000, 'optTol', 1e-15,'progTol',1e-40);

tic;
params=minFunc(@myPack.cofiCostFunc, init_params, options, X, trainYnorm, trainSetR,size(X,2),0,1);
fprintf('Optimization took %f seconds.\n', toc);
X = reshape(params(1:size(X,1)*size(X,2)), size(X,1), size(X,2));
Theta = reshape(params(size(X,1)*size(X,2)+1:end), size(Y,2), size(X,2));

%% Test performance
MSR = myPack.predictionError(X, Theta, R, trainYmean, testInd, testGT);
fprintf('mean squared error = %4.2f.\n',MSR);



