function [trainInd, testInd, crossInd] = simpleSplit(dataNum, trainRatio, testRatio, crossRatio)

trainNum = round(dataNum*trainRatio);
testNum = round(dataNum*testRatio);
allInd = randperm(dataNum);
trainInd = allInd(1:trainNum);
testInd = allInd(trainNum+1:trainNum+testNum);
crossInd = allInd(1+trainNum+testNum:end);

end
