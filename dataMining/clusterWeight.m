%CLUSTERWEIGHT
% cluster people's weight matrix.

clc; clear; close all; 
load('attractivePreference.mat');% contains X and Theta. 

clusterNum = 4; % 
[idx, c] = kmeans(Theta, clusterNum);
fprintf('clusterNum = %d.\n',clusterNum);

% find the maximum response of the center of each weight cluster
resp = X*c';
[maxResp, maxInd] = max(resp);

% load imageName to map indices to the actual face images
load('../rawData/imageNames.mat');
maxRespIm = imageNames(maxInd);
imPath = '/Users/Olivialinlin/Desktop/myTest/2kfaces_new/';
subColNum = 3;
subNum = ceil(clusterNum/subColNum);


figure;
for i = 1:length(maxInd)
    temp = strcat(imPath,maxRespIm{i});
    temp = imread(temp);
    subplot(subNum,subColNum,i);
    imshow(temp);
end
figName = strcat('maxResponseFace',int2str(clusterNum),'.jpg');
saveas(gcf,figName);
