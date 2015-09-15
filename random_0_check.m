% random_0_check.m

clear all; close all; clc;

%% Generate simulation data.
featureMatrix_GT = round(abs(rands(2222,9)));
userMatrix_GT = round(abs(rands(200,9)));
Y = featureMatrix_GT * userMatrix_GT';
R = round(abs(rand(size(Y))));
Y = Y.*R;

%% Split test, cv and training set
trainRatio = 0.8; crossRatio = 0.1; testRatio = 0.1;
allInd = find(R~=0);
all_sample_num = length(allInd);

trainNum = round(trainRatio*all_sample_num); 
testNum = round(testRatio*all_sample_num);

% assign index to training, cross-validation, and testing set.
randSeed = randperm(all_sample_num);
trainInd = allInd(randSeed(1:trainNum));
testInd = allInd(randSeed(trainNum+1:trainNum+testNum));
crossInd = allInd(randSeed(trainNum+testNum+1:end));

% generate training set: trainSetY and trainSetR
trainSetY = zeros(size(Y));
trainSetY(trainInd) = Y(trainInd);
trainSetR = zeros(size(R));
trainSetR(trainInd) = 1; 

% generate cross validation and testing set
crossGT = Y(crossInd);
testGT = Y(testInd);

% %% Test performance
[i, j] = ind2sub(size(R), testInd);
faceFeature = featureMatrix_GT(i, :);
userWeight = userMatrix_GT(j, :);
prediction = sum(faceFeature.*userWeight, 2);

dif = testGT - prediction; 
MSR = sqrt(sum(dif.^2)/length(dif));
fprintf('Test set. mean squared error = %4.2f.\n',MSR);
