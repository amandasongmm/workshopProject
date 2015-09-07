clear; clc; close all;
addpath(genpath(pwd));

% Initialize variables for calling datasets_feature function
info = load('fileList.mat');
datasets = {'face'};
train_lists = {info.trainList};

test_lists = {info.testList};
feature = 'color';

% Load the configuration and set dictionary size to 20 (for fast demo)
c = conf();
c.feature_config.(feature).dictionary_size=20;

% Compute train and test features
datasets_feature(datasets, train_lists, test_lists, feature, c);

% Load train and test features
train_features = load_feature(datasets{1}, feature, 'train', c);
test_features = load_feature(datasets{1}, feature, 'test', c);