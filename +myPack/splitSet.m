function [trainYnorm, trainYmean, trainSetR, crossInd, crossGT, testInd, testGT] = splitSet(Y, R, trainRatio, crossRatio, testRatio)

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
[trainYnorm, trainYmean] = myPack.normalizeRatings(trainSetY, trainSetR);

end