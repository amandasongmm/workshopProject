% socialFeaturePCA.m
clear; clc; 

load('./rawData/psy1FiVal.mat');
load('./rawData/psy2FiVal.mat');
socialFeatureMatrix = [psy1FiVal,psy2FiVal];

socialFeatureMatrix = socialFeatureMatrix';% we treat each social feature as one variable, and 2222 as observation number
% 2222*40 #observation * #variables = 
