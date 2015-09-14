% mySanityCheck.m

clear all; close all; clc;

%% Generate simulation data.
featureMatrix_GT = round(abs(rands(2222,9)));
userMatrix_GT = round(abs(rands(200,9)));
Y = featureMatrix_GT * userMatrix_GT';
R = round(abs(rand(size(Y))));
Y = Y.*R;

%% Split test, cv and training set
trainRatio = 0.8; crossRatio = 0.1; testRatio = 0.1;
[trainYnorm, trainYmean, trainSetR, crossInd, crossGT, testInd, testGT] = myPack.splitSet(Y, R, trainRatio, crossRatio, testRatio);

%% Initialize params
maxItr = 3000;
options = optimset('GradObj', 'on', 'MaxIter', maxItr);
[num_faces, num_users] = size(Y);
gradFlag = 0; 
X = featureMatrix_GT; 
num_features = size(X, 2);
Theta = randn(num_users, num_features);
init_params = [Theta(:)];

% %% Train and test with optimal model.
params = myPack.fmincg(@(t)(myPack.myCostFunc(t,X,Y,R)),init_params, options);
Theta = reshape(params,num_users, num_features);

% %% Test performance
[MSR, prediction, dif] = myPack.predictionError(X, Theta, R, trainYmean, testInd, testGT);
fprintf('Test set. mean squared error = %4.2f.\n',MSR);



