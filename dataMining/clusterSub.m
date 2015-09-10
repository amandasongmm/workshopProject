%CLUSTERSUBJECTDATA
% cluster subject information matrix.

clc; clear; close all; 
load('../rawData/psy2Data.mat');% contains X and Theta. 
load('../preprocessedData/attractiveData.mat');

clusterNum = 70; % 
faceNum = 2222;
[idx, c] = kmeans(subData2, clusterNum);
fprintf('clusterNum = %d.\n',clusterNum);
Y_cluster = zeros(faceNum,clusterNum);
R_cluster = zeros(faceNum,clusterNum);
for i = 1:clusterNum
    curInd = (idx==i);
    Y_cluster(:,i) = mean(Y(:,curInd),2);
    R_cluster(:,i) = (sum(R(:,curInd),2)>0);
end
Y = Y_cluster;
R = R_cluster;
%% save variables
save('../preprocessedData/attractiveDataClusterSub.mat','Y', 'R');