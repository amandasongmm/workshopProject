% myLinearMixModel.m

clear; close all; clc; 
addpath(genpath('.././drtoolbox'));

%% load social feature data. 
load('../preprocessedData/socialFeaFullData.mat');%contains 'socialFeaData','fieldsFullList'
X = socialFeaData;

%% Check the intrinsic dimensionality of 2222*40 (num_face * num_feature matrix)

[mappedX, mapping] = compute_mapping(X,'PCA');