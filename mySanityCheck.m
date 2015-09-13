% mySanityCheck.m

clear all; close all; clc;

%% Load average data. 
load('./rawData/psy2FiVal.mat');
Y = psy2FiVal(:, 2);% 2222*1 attractiveness data
R = ones(size(Y));

%% Split test, cv, and training set
trainRatio = 0.8; crossRatio = 0.1; testRatio = 0.1;
[trainYnorm, trainYmean, trainSetR, crossInd, crossGT, testInd, testGT] = ...
    myPack.splitSet(Y, R, trainRatio, crossRatio, testRatio);

%% Initialize params
maxItr = 3000;
featureChoice = 'socialOther';
options = optimset('GradObj', 'on', 'MaxIter', maxItr);
[num_faces, num_users] = size(Y);
[init_params, X, gradFlag] = myPack.featureGen(featureChoice, num_users);
num_features = size(X, 2);

