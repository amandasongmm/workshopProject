% 

close all; clear; clc; 

%% load the clusterInd data (clusterd by age, gender, race)
load('sortBySingleAttriSubjectData.mat');%it contains ageIndList, genderIndList, raceIndList
load('../rawData/psy2Data.mat'); % to take psy2Data. 

subList = psy2Data(:, 19);
imList = psy2Data(:,1);
attractList = psy2Data(:, 3);

[ageDenseRateMatrix, ageDenseIndicatorMatrix] = genCondenseMatrix(ageIndList, subList, imList, rateList);
[raceDenseRateMatrix, raceDenseIndicatorMatrix] = genCondenseMatrix(raceIndList, subList, imList, attractList);
[genderDenseRateMatrix, genderDenseIndicatorMatrix] = genCondenseMatrix(genderIndList, subList, imList, attractList);
