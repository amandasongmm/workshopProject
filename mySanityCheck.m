% mySanityCheck.m

clear all; close all; clc;
%
% %% Test 1: Load average data.
% load('./rawData/psy2FiVal.mat');
% Y = psy2FiVal(:, 2);% 2222*1 attractiveness data
% R = ones(size(Y));

%% Test 2: Generate simulation data.
featureMatrix_GT = round(abs(rands(2222,9)));
userMatrix_GT = round(abs(rands(200,9)));
Y = featureMatrix_GT * userMatrix_GT';
R = round(abs(rand(size(Y))));
Y = Y.*R;

%% Split test, cv and training set
trainRatio = 0.8; crossRatio = 0.1; testRatio = 0.1;
[trainYnorm, trainYmean, trainSetR, crossInd, crossGT, testInd, testGT] = ...
    myPack.splitSet(Y, R, trainRatio, crossRatio, testRatio);

%% Initialize params
maxItr = 3000;
featureChoice = 'random';%'socialOther','socialTotal'.
options = optimset('GradObj', 'on', 'MaxIter', maxItr);
[num_faces, num_users] = size(Y);
gradFlag = 0; 
X = featureMatrix_GT; 
num_features = size(X, 2);
Theta = randn(num_users, num_features);
init_params = [Theta(:)];


%% Cross validate lambda &/ different feature models
lambdaArray = 0:0.1:1;
xValMSR = zeros(1,length(lambdaArray));
for curItr = 1: length(lambdaArray)
    %% Train the model
    curLambda = lambdaArray(curItr);
    params = myPack.fmincg (@(t)(myPack.cofiCostFunc(t, X, trainYnorm, trainSetR, num_features, curLambda, gradFlag)), init_params, options);
    if gradFlag == 1
        X = reshape(params(1:num_faces*num_features), num_faces, num_features);
        Theta = reshape(params(num_faces*num_features+1:end), num_users, num_features);
    else
        Theta = reshape(params, num_users, num_features);
    end
    
    %% Test performance
    xValMSR(curItr) = myPack.predictionError(X, Theta, R, trainYmean, crossInd, crossGT);
    fprintf('curLam=%d, MSR = %4.4f\n',curLambda, xValMSR(curItr));
end

[~,minInd] = min(xValMSR);
lambda = lambdaArray(minInd);
fprintf('\n\n\nOptimal lambda = %d\n',lambda);

%% Train and test with optimal model.
params = myPack.fmincg (@(t)(myPack.cofiCostFunc(t, X, trainYnorm, trainSetR, num_features, lambda, gradFlag)),...
    init_params, options);
if gradFlag == 1
    X = reshape(params(1:num_faces*num_features), num_faces, num_features);
    Theta = reshape(params(num_faces*num_features+1:end), num_users, num_features);
else
    Theta = reshape(params, num_users, num_features);
end

%% Test performance
[MSR, prediction, dif] = myPack.predictionError(X, Theta, R, trainYmean, testInd, testGT);
fprintf('Test set. mean squared error = %4.2f.\n',MSR);



