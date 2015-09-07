% myMain.m

clearall; clc; 
load('attractData.mat');%Y and R

%% ========= Part 1: split test, cross-validation and training set ========
allInd = find(R~=0);
all_sample_num = length(allInd);

trainRatio = 0.8; 
crossRatio = 0.1; 
testRatio = 0.1;
trainNum = round(trainRatio*all_sample_num); 
testNum = round(testRatio*all_sample_num);
crossNum = all_sample_num - trainNum - testNum;

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
crossGroundTruth = Y(crossInd);
testGroundTruth = Y(testInd);

%% =========== Part 2: training a collaborative filter model =======
%% Normalized Ratings
[Ynorm, Ymean] = normalizeRatings(Y, R);

%% Initialize features

%% model 1: random initialization
featureNumList = [10, 20, 40, 50, 60, 80, 100, 200, 1000];
lambdaList = [0.1, 1, 10, 100];
[img_num, user_num] = size(Y);

for curInd = 1 : length(featureNumList)
    feature_num = featureNumList(curInd);
    FeatureMatrix = rands(user_num, feature_num);
    maxItr = 100; 
    options = optimset('GradObj', 'on', 'MaxIter', maxItr);
    for curLamInd = 1 : length(lambdaList)
        
    end
end



