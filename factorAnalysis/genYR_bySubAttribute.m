% generate Y and R matrix condensed by sorting raters according to their
% race/ age/ gender. 

close all; clear; clc; 

%% load the clusterInd data (clusterd by age, gender, race)
load('../preprocessedData/attractiveData.mat');% contains R and Y of attractiveness
load('../rawData/psy2Data.mat');% we will use subData2
faceNum = max(psy2Data(:,1));
subInd = subData2(:,1);
subAge = subData2(:,2);
subGen = subData2(:,3);
subRace = subData2(:,4);
%ageFields = {'1:<20';'2:20-30';'3:30-45';'4:45-60';'5:60+'};
%genderFields = {'0:female';'1:male'};
%raceFields = {'0=other';'1=white';'2=black';'3=east asian'; ...
%'4=south asian'; '5:hispanic'; '6:middle eastern'};

%% generate Y/R clustered by age/ gender/ race
genDenseYR(subAge, 'age', Y, R, subInd);
genDenseYR(subGen, 'gender', Y, R, subInd);
genDenseYR(subRace, 'race', Y, R, subInd);



