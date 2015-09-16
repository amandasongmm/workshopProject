clear; clc; close all;
addpath ../;
load('/Users/Olivialinlin/Documents/Github/workshopProject/preprocessedData/attractiveData.mat')

trainRatio = 0.9; crossRatio = 0.01; testRatio = 0.09;
[trainYnorm, trainYmean, trainSetR, crossInd, crossGT, testInd, testGT] = myPack.splitSet(Y, R, trainRatio, crossRatio, testRatio);


[U,S,V] = svd(trainYnorm);
%%
diagS = diag(S);
lambdaARR = 1:1:length(diagS);
xValMSR = zeros(1,length(lambdaARR));
for i = 1: length(lambdaARR)
    Ind100 = find(diagS>diagS(lambdaARR(i)));
    Ssvd = diag(diagS(Ind100));
    Usvd = U(:,Ind100);
    Vsvd = V(Ind100,:);
    Ysvd = Usvd*Ssvd*Vsvd;
    [indi, indj] = ind2sub(size(R), testInd);
    testYPred = Ysvd(indi,indj);
    prediction = sum(testYPred, 2) + trainYmean(indi);
    dif = testGT - prediction; 
    xValMSR(i) = sqrt(sum(dif.^2)/length(dif));
    fprintf('mean squared error = %4.2f.\n',xValMSR(i));
end
[~,minInd] = min(xValMSR);
lambda = lambdaARR(minInd);
