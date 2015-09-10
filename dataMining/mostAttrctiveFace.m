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
minI = 41;
maxI = 60;
base = 40;
for i = minI:maxI
    temp = strcat(imPath,maxYIm{i});
    temp = imread(temp);
    subplot(subNum,subColNum,i-base);
    imshow(temp);
end
figName = sprintf('maxY%d-%d.jpg',minI,maxI);
saveas(gcf,figName);
save('maxY.mat', 'maxY');
