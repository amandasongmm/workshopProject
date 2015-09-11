% myDraft.m
% to test the genCondenseMatrix.m

clc; clear;
load('sortBySingleAttriSubjectData.mat');%it contains ageIndList, genderIndList, raceIndList
load('../rawData/psy2Data.mat'); % to take psy2Data. 

psy2Data = psy2Data(:,3)

subCluster = ageIndList; 
subList = psy2Data(:, 19);
imList = psy2Data(:,1);
rateList = psy2Data(:, 3);

% generate a rate matrix and an indicator matrix according to the data. 
num_faces = max(imList);
num_subCluster = length(subCluster);
denseRateMatrix = zeros(num_faces, num_subCluster);

% put subjects' entries from the same cluster into imWithRepCellArray
indWithRepCell = cell(num_subCluster, 2);
for curItr = 1 : num_subCluster
    curClusterSubInd = subCluster{curItr};
    imWithRepCurArray = [];
    rateWithRepCurArray = [];
    for curInnerItr = 1 : length(curClusterSubInd)
        curSub = curClusterSubInd(curInnerItr);
        curSubList = find(subList==curSub);
        imWithRepCurArray = [imWithRepCurArray, imList(curSubList)'];
        rateWithRepCurArray = [rateWithRepCurArray, rateList(curSubList)'];
    end
    indWithRepCell{curItr, 1} = imWithRepCurArray;
    indWithRepCell{curItr, 2} = rateWithRepCurArray; 
end

% now use indWithRepCell to calculate the denseRateMatrix and
% denseIndicatorMatrix.

for curItr = 1 : num_subCluster
    uniqueImArray = unique(indWithRepCell{curItr, 1});
    for curUniImInd = 1 : length(uniqueImArray)
        curImID = uniqueImArray(curUniImInd);
        curTempInd = indWithRepCell{curItr, 1}==curImID;
        attractTemp = indWithRepCell{curItr, 2}(curTempInd);
        denseRateMatrix(curImID, curItr) = mean(attractTemp);
    end
end
