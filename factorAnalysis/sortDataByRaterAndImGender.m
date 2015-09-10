%SORTDATABYRATERANDIMGENDER.m
%   organize the rating information by (1) rater's age, gender, race (2)
%   image's gender.

clc; clear; close all; 
load('../rawData/psy2Data.mat');% subData2 stors the rater ID, rater age, gender, race.

%% sort a list according to age, gender and race.

% by age
ageFields = {'1:<20';'2:20-30';'3:30-45';'4:45-60';'5:60+'};
ageLevel = max(subData2(:,2));
ageIndList = cell(ageLevel,1);
for curAge = 1 : ageLevel
    ageIndList{curAge} = find(subData2(:,2)==curAge);
end

% by gender
genderFields = {'0:female';'1:male'};
genderLevel = 2; 
genderIndList = cell(genderLevel,1);
for curGen = 1 : genderLevel
    genderIndList{curGen} = find(subData2(:,3)==(curGen-1));
end

% by race
raceFields = {'0=other';'1=white';'2=black';'3=east asian'; '4=south asian'; '5:hispanic'; '6:middle eastern'};
raceLevel = max(subData2(:,4))+1;
raceIndList = cell(raceLevel, 1);
for curRace = 1 : raceLevel
    raceIndList{curRace} = find(subData2(:,4)==(curRace-1));
end

save('sortBySingleAttriSubjectData.mat','ageIndList','genderIndList','raceIndList','ageFields','genderFields','raceFields');