% myLinear.m

addpath './linearModel';
clc;clear;close all;
genderFields = {'female';'male'};

%% Part I: predict average attractiveness score from an average person
% % load data.
% load('./rawData/psy2FiVal');% psy2FiVal
% Y = psy2FiVal(:,2);
% socialFeature = psy2FiVal(:,[1,3:end]);
% X = myPack.featureNormalizeAddIntercept(socialFeature);
%
% % split sets
% dataNum = size(Y,1);
% trainRatio = 0.8; testRatio = 0.1;crossRatio = 0.1;
% [trainInd, testInd, crossInd] = simpleSplit(dataNum, trainRatio, testRatio, crossRatio);
%
% % regularized regression
% lambdaList = 1;%logspace(-111,10,5);
% theta = zeros(size(X,2),1);
% errorArray = zeros(length(lambdaList),3);% train, cross, test.
% thetaArray = zeros(length(theta),length(lambdaList));
% for curItr = 1 : length(lambdaList)
%     thetaArray(:,curItr) = trainLinearReg(X(trainInd,:),Y(trainInd,1),lambdaList(curItr), theta);
%     [sortedTheta, sortInd] = sort(thetaArray(:,curItr),'descend');
%     disp([sortedTheta, sortInd]);
%     errorArray(curItr,1) = compErrorWithRegularization(X, Y, thetaArray(:,curItr), trainInd, 'train');
%     errorArray(curItr,2) = compErrorWithRegularization(X, Y, thetaArray(:,curItr), testInd, 'test');
%     errorArray(curItr,3) = compErrorWithRegularization(X, Y, thetaArray(:,curItr), crossInd, 'cross validation');
% end
% attractPredict = X*thetaArray(:,curItr);
% save('./linearModel/figs/attractPredict_average_average.mat','attractPredict');

%% Part II: predict attractiveness score rated by male and female raters separetely.
% load('./preprocessedData/genderYRData.mat');% Use Y as data.
% load('./rawData/psy2FiVal');% psy2FiVal
% socialFeature = psy2FiVal(:,[1,3:end]);
% X = myPack.featureNormalizeAddIntercept(socialFeature);
% 
% %% split into train and test.
% dataNum = size(Y,1);
% trainRatio = 0.8; testRatio = 0.1;crossRatio = 0.1;
% [trainInd, testInd, crossInd] = simpleSplit(dataNum, trainRatio, testRatio, crossRatio);

% %% linear regression with no regularization
% for curG = 1 : 2
%     [trainError, testError, theta] = compErrorNoRegularization(X,Y,curG,trainInd,testInd);
%     [sortedTheta, sortInd] = sort(theta,'descend');
%     disp([sortedTheta, sortInd]);
% end


% %% regularized regression
% lambdaList = 1;%logspace(-100,3,5);
% theta = zeros(size(X,2),1);

% for curG = 1 : 2
%     errorArray = zeros(length(lambdaList),3);
%     thetaArray = zeros(length(theta),length(lambdaList));
%     for curItr = 1 : length(lambdaList)
%         [theta] = trainLinearReg(X(trainInd,:),Y(trainInd,1),lambdaList(curItr), theta);
%         thetaArray(:,curItr) = theta;
%         [sortedTheta, sortInd] = sort(thetaArray(:,curItr),'descend');
%         disp([sortedTheta, sortInd]);
%         errorArray(curItr,1) = compErrorWithRegularization(X, Y, thetaArray(:,curItr), trainInd, 'train',curG);
%         errorArray(curItr,2) = compErrorWithRegularization(X, Y, thetaArray(:,curItr), testInd, 'test',curG);
%         errorArray(curItr,3) = compErrorWithRegularization(X, Y, thetaArray(:,curItr), crossInd, 'cross validation',curG);
%         attractPredict = X*thetaArray(:,curItr);
%         save(sprintf('./linearModel/figs/attractPredict_%sRater.mat',genderFields{curG}),'attractPredict');
%     end
% end

%% Part III. separate male and female faces
load('./preprocessedData/faceGenderYR.mat');
load('./rawData/psy2FiVal');% psy2FiVal
load('./rawData/genderList.mat');
socialFeature = psy2FiVal(:,[1,3:end]);
X = myPack.featureNormalizeAddIntercept(socialFeature);
femaleX = X(genderList==0,:);
maleX = X(genderList==1,:);

% regularized linear regression
lambdaList = 1;%logspace(-100,3,5);

%% check female face first.
X = femaleX;
Y = femaleY;
theta = zeros(size(X,2),1);

% split into train and test.
dataNum = size(Y,1);
trainRatio = 0.8; testRatio = 0.1;crossRatio = 0.1;
[trainInd, testInd, crossInd] = simpleSplit(dataNum, trainRatio, testRatio, crossRatio);
for curG = 1 : 2
    errorArray = zeros(length(lambdaList),3);
    thetaArray = zeros(length(theta),length(lambdaList));
    for curItr = 1 : length(lambdaList)
        [theta] = trainLinearReg(X(trainInd,:),Y(trainInd,curG),lambdaList(curItr), theta);
        thetaArray(:,curItr) = theta;
        [sortedTheta, sortInd] = sort(thetaArray(:,curItr),'descend');
        disp([sortedTheta, sortInd]);
        errorArray(curItr,1) = compErrorWithRegularization(X, Y, thetaArray(:,curItr), trainInd, 'train',curG);
        errorArray(curItr,2) = compErrorWithRegularization(X, Y, thetaArray(:,curItr), testInd, 'test',curG);
        errorArray(curItr,3) = compErrorWithRegularization(X, Y, thetaArray(:,curItr), crossInd, 'cross validation',curG);
        attractPredict = X*thetaArray(:,curItr);
        save(sprintf('./linearModel/figs/attractPredictFemaleFaceBy_%sRater.mat',genderFields{curG}),'attractPredict');
        
    end
end

% check male face next.
X = maleX;
Y = maleY;
theta = zeros(size(X,2),1);

% split into train and test.
dataNum = size(Y,1);
trainRatio = 0.8; testRatio = 0.1;crossRatio = 0.1;
[trainInd, testInd, crossInd] = simpleSplit(dataNum, trainRatio, testRatio, crossRatio);
for curG = 1 : 2
    errorArray = zeros(length(lambdaList),3);
    thetaArray = zeros(length(theta),length(lambdaList));
    for curItr = 1 : length(lambdaList)
        [theta] = trainLinearReg(X(trainInd,:),Y(trainInd,curG),lambdaList(curItr), theta);
        thetaArray(:,curItr) = theta;
        [sortedTheta, sortInd] = sort(thetaArray(:,curItr),'descend');
        disp(lambdaList(curItr));
        disp([sortedTheta, sortInd]);
        errorArray(curItr,1) = compErrorWithRegularization(X, Y, thetaArray(:,curItr), trainInd, 'train',curG);
        errorArray(curItr,2) = compErrorWithRegularization(X, Y, thetaArray(:,curItr), testInd, 'test',curG);
        errorArray(curItr,3) = compErrorWithRegularization(X, Y, thetaArray(:,curItr), crossInd, 'cross validation',curG);
        attractPredict = X*thetaArray(:,curItr);
        save(sprintf('./linearModel/figs/attractPredictMaleFaceBy_%sRater.mat',genderFields{curG}),'attractPredict');
        
    end
end


































