
clear; close all; clc; 

%% Load data matrix
fprintf('Loading attractiveness dataset.\n\n');
load('./preprocessedData/attractiveData.mat');%Y and R

%% Split test, cross-validation and training set. 
trainRatio = 0.9; crossRatio = 0.01; testRatio = 0.09;
[trainYnorm, trainYmean, trainSetR, crossInd, crossGT, testInd, testGT] = myPack.splitSet(Y, R, trainRatio, crossRatio, testRatio);

%% Initialize params
maxItr = 3000;
featureChoice = 'socialOther';%'socialOther','socialTotal'.
options = optimset('GradObj', 'on', 'MaxIter', maxItr);
[num_faces, num_users] = size(Y);
[init_params, X, gradFlag] = myPack.featureGen(featureChoice, num_users);
num_features = size(X, 2);

%% cross-validating parameters!
% lambdaARR = 1:1:20;
% xValMSR = zeros(1,length(lambdaARR));
% for i = 1: length(lambdaARR)
%     %% Train the model
%     params = myPack.fmincg (@(t)(myPack.cofiCostFunc(t, trainYnorm, trainSetR, num_users, num_faces, num_features, lambdaARR(i), gradFlag)), init_params, options);            
% 
%     % Unfold the returned theta back into X and Theta
%     X = reshape(params(1:num_faces*num_features), num_faces, num_features);
%     Theta = reshape(params(num_faces*num_features+1:end), num_users, num_features);
%     fprintf('Recommender system learning completed.\n');
% 
%     %% Test performance
%     xValMSR(i) = myPack.predictionError(X, Theta, R, trainYmean, crossInd, crossGT);
%     fprintf('mean squared error = %4.2f.\n',xValMSR(i));
% 
% end
% [~,minInd] = min(xValMSR);
% lambda = lambdaARR(minInd);
lambda = 50;

%% Train the model

params = myPack.fmincg (@(t)(myPack.cofiCostFunc(t, trainYnorm, trainSetR, num_features, lambda, gradFlag)), init_params, options);            

% Unfold the returned theta back into X and Theta
X = reshape(params(1:num_faces*num_features), num_faces, num_features);
Theta = reshape(params(num_faces*num_features+1:end), num_users, num_features);
fprintf('Recommender system learning completed.\n');

%% Test performance
MSR = myPack.predictionError(X, Theta, R, trainYmean, testInd, testGT);
fprintf('mean squared error = %4.2f.\n',MSR);

%% Save the learned feature and learned preference for attractiveness
save('./dataMining/attractivePreferenceSocialOther.mat','X','Theta');

