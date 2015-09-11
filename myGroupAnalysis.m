% myGroupAnalysis.m

% use collaborative filtering to analyze attractiveness preference by age,
% gender and race

clear; close all; clc;

%% Load data matrix
fieldName = 'race';% you can also choose 'gender' and 'race'
fprintf(sprintf('Loading %s YR data..\n\n',fieldName));
load(sprintf('./preprocessedData/%sYRData.mat',fieldName));

%% Split test, cv and training set
trainRatio = 0.8; crossRatio = 0.1; testRatio = 0.1;
[trainYnorm, trainYmean, trainSetR, crossInd, crossGT, testInd, testGT] = ...
    myPack.splitSet(Y, R, trainRatio, crossRatio, testRatio);

%% Initialize params
maxItr = 3000;
featureChoice = 'socialOther';%'socialOther','socialTotal'.
options = optimset('GradObj', 'on', 'MaxIter', maxItr);
[num_faces, num_users] = size(Y);
[init_params, X, gradFlag] = myPack.featureGen(featureChoice, num_users);
num_features = size(X, 2);

%% Cross validate lambda &/ different feature models
lambdaArray = 0:2:10;
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
    fprintf('curLam=%d. MSR = %4.4f\n',curLambda, xValMSR(curItr));
end
[~,minInd] = min(xValMSR);
lambda = lambdaArray(minInd);
fprintf('\n\n\n optimal lambda = %d\n',lambda);

lambda = 5;

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

%% Save the learned feature and learned preference for attractiveness
save(sprintf('./factorAnalysis/weightBy%s_%sfeature.mat',fieldName,featureChoice),'X','Theta','trainYmean','lambda');

