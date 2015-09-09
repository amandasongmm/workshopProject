clear; clc; close all;
fprintf('Loading facial attractiveness dataset.\n\n');
load('../preprocessedData/attractiveData.mat');%Y and R

[maxY, maxInd] = max(Y);
load('../rawData/imageNames.mat');
maxInd = maxInd(maxY~=0);
maxYIm = imageNames(maxInd);
imPath = '/Users/Olivialinlin/Desktop/myTest/2kfaces_new/';
subColNum = 5;
subNum = ceil(20/subColNum);
figure;
for i = 1:20
    temp = strcat(imPath,maxYIm{i});
    temp = imread(temp);
    subplot(subNum,subColNum,i);
    imshow(temp);
end
figName = 'maxY.jpg';
saveas(gcf,figName);
