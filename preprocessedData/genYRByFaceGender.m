%genYRByFaceGender.m
clc; clear;
addpath('.././myPack/');
load('../preprocessedData/genderYRData.mat');
load('../rawData/genderList.mat');

femaleY = Y(genderList==0,:);
femaleR = R(genderList==0,:);
maleY = Y(genderList==1,:);
maleR = R(genderList==1,:);

save('faceGenderYR.mat','femaleY','femaleR','maleY','maleR');

