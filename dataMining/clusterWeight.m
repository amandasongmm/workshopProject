%CLUSTERWEIGHT
% cluster people's weight matrix.

clc; clear; close all; 
load('attractivePreference.mat');% contains X and Theta. 

clusterNum = 10; % 
[idx, c] = kmeans(Theta, clusterNum);


