%SORTDATABYRATERANDIMGENDER.m
%   organize the rating information by (1) rater's age, gender, race (2)
%   image's gender.

clc; clear; close all; 
load('../rawData/psy2Data.mat');

%% make a list of rater's ID, age, gender, race.
raterID = psy2Data(:,19);
raterNum = max(raterID);
raterInfoList = zeros(raterNum, 4);
for curRater = 1 : raterNum
    curList = find(raterID == curRater); 
    if ~isempty(curList)
        raterInfoList(curRater, 1) = curRater; 
        curInd = curList(1); 
        raterInfoList(curRater, 2:4) = psy2Data(curInd, 20:22);
    else 
        raterInfoList(curRater, 1) = nan; 
    end 
end
raterInfoList = raterInfoList(all(~isnan(raterInfoList),2), :);

%% sort a list according to age, gender and race.

