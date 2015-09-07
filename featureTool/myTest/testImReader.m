clear; clc; close all;
imgPath = '../images/testIm/';
imgType = '*.jpg'; % change based on image type
images  = dir([imgPath imgType]);
imagefiles = dir([imgPath imgType]);      
nfiles = length(imagefiles);    % Number of files found
images = cell(nfiles,1);
for ii=1:nfiles
   currentfilename = [imgPath imagefiles(ii).name];
   currentimage = imread(currentfilename);

   images{ii} = currentimage;
end
imagefiles = struct2cell(imagefiles);
trainList  = strcat(imgPath,imagefiles(1,1:6));
testList = strcat(imgPath,imagefiles(1,7));
save fileList.mat trainList testList images;
clearvars

