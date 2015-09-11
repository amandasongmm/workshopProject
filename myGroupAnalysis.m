% myGroupAnalysis.m

% use collaborative filtering to analyze attractiveness preference by age,
% gender and race

clear; close all; clc; 

%% Load data matrix
fieldName = 'race';% you can also choose 'gender' and 'race'
fprintf(sprintf('Loading %s YR data..\n\n',fieldName));
load(sprintf('./preprocessedData/%sYRData.mat',fieldName));

%% Split test, cv and training set
trainRatio = 0.9; crossRatio = 0.07; testRatio = 0.03;
[trainYnorm, trainYmean, trainSetR, crossInd, crossGT, testInd, testGT] = ...
    myPack.splitSet(Y, R, trainRatio, crossRatio, testRatio);

%% Initialize params
maxItr = 3000; 
featureChoice = 'socialOther';%'socialOther','socialTotal'.
options = optimset('GradObj', 'on', 'MaxIter', maxItr);
[num_faces, num_users] = size(Y);
[num_features, X, gradFlag] = myPack.featureGen(featureChoice);
Theta = randn(num_users, num_features);
init_params = [X(:);Theta(:)];

%% Cross validate lambda &/ different feature models
lambdaArray = 0:0.1:1;
xValMSR = zeros(1,length(lambdaArray));
for curItr = 1: length(lambdaArray)
    %% Train the model
    curLambda = lambdaArray(curItr);
    fprintf('curLambda = %d\n',curLambda);
    params = myPack.fmincg (@(t)(myPack.cofiCostFunc(t, trainYnorm, trainSetR, num_users, num_faces, num_features, curLambda, gradFlag)), init_params, options);            

    % Unfold the returned theta back into X and Theta
    X = reshape(params(1:num_faces*num_features), num_faces, num_features);
    Theta = reshape(params(num_faces*num_features+1:end), num_users, num_features);

    %% Test performance
    xValMSR(curItr) = myPack.predictionError(X, Theta, R, trainYmean, crossInd, crossGT);
    fprintf('.curLam=%d. MSR = %4.4f\n',curLambda, xValMSR(curItr));
end
[~,minInd] = min(xValMSR);
lambda = lambdaArray(minInd);
fprintf('\n\n\n optimal lambda = %d\n',lambda);

%% Train and test with optimal model. 
params = myPack.fmincg (@(t)(myPack.cofiCostFunc...
    (t, trainYnorm, trainSetR, num_users, num_faces, num_features, lambda, gradFlag)), init_params, options);  
X = reshape(params(1:num_faces*num_features), num_faces, num_features);
Theta = reshape(params(num_faces*num_features+1:end), num_users, num_features);

%% Test performance
MSR = myPack.predictionError(X, Theta, R, trainYmean, testInd, testGT);
fprintf('Test set. mean squared error = %4.2f.\n',MSR);

%% Save the learned feature and learned preference for attractiveness
save(sprintf('./factorAnalysis/weightBy%s_%sfeature.mat',fieldName,featureChoice),'X','Theta','trainYmean','lambda');