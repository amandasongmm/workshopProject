clc; clear;
load('../rawData/psy2Data.mat');% 33430*27
rawData = psy2Data;

singleAttriList = [2:4,7:18,23:27];
dataNameList = cell(length(singleAttriList),1);
for curItr = 1 : length(singleAttriList)
    curAttriInd = singleAttriList(curItr);
    curAttriName = fields_name2{curAttriInd};
    saveName = sprintf('./preprocessedData/%sData.mat', curAttriName);
    dataNameList{curItr} = saveName; 
end
save('dataNameList.mat','dataNameList');