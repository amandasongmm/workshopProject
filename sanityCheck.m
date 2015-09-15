% sanityCheck.m
clc; clear; 
feature_GT = round(abs(rands(2222,9)));
user_GT = round(abs(rands(200,9)));
Y = feature_GT * user_GT';
R = round(abs(rand(size(Y))));
%R = ones(size(Y));
Y = Y.*R;

%% split test and training set. 
allInd = find(R~=0);
randSeed = randperm(length(allInd));
testRatio = 0.1;
testNum = round(testRatio*length(allInd)); % = 0.01 of whole sample

testInd = allInd(randSeed(1:testNum));
trainingInd = allInd(randSeed(testNum+1:end));
testingGT = Y(testInd);

% generate rate matrix, where R(i,j)=1 iif user j gave a rating to face i
trainR = zeros(size(Y));
trainR(trainingInd)	= 1;
trainY = zeros(size(Y));
trainY(trainingInd) = Y(trainingInd);

% Normalized Ratings.
[Ynorm, Ymean] = myPack.normalizeRatings(trainY, trainR);
num_faces = size(trainY,1);
num_users = size(trainY,2);
num_features = size(feature_GT,2);

X = feature_GT;
Theta = rand(size(user_GT));

init_params = [Theta(:)];
maxItr = 1000;
options = optimset('GradObj', 'on', 'MaxIter', maxItr);
lambda = 0;

theta = fmincg(@(t)(myPack.cofiCostFunc(t, X, Ynorm, trainR, num_features, lambda, 0)), init_params, options);
Theta = reshape(theta, num_users, num_features);

%% Test performance. 
[i, j] = ind2sub(size(R), testInd); % i is the face id, j is the user id. 
movieF = X(i, :);% num_test * num_feat
userFL = Theta(j, :);% num_test * num_feat
prediction = sum(movieF .* userFL, 2) + Ymean(i);% num_test.

dif = testingGT - prediction;
msr = sqrt(sum(dif.^2)/length(dif));
disp(msr);
