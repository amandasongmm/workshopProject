function [denseRateMatrix, denseIndicatorMatrix] = genCondenseMatrix(subCluster, subList, imList, rateList)

% generate a rate matrix and an indicator matrix according to the data. 
num_faces = max(imList);
num_subCluster = length(subCluster);
denseRateMatrix = zeros(num_faces, num_subCluster);

% put subjects' entries from the same cluster into imWithRepCellArray
indWithRepCell = cell(num_subCluster, 3);
for curItr = 1 : num_subCluster
    curClusterSubInd = subCluster{curItr};
    imWithRepCurArray = [];
    rateWithRepCurArray = [];
    indWithRepCurArray = [];
    for curInnerItr = 1 : length(curClusterSubInd)
        curSub = curClusterSubInd(curInnerItr);
        curSubList = find(subList==curSub);
        imWithRepCurArray = [imWithRepCurArray, imList(curSubList)];
        rateWithRepCurArray = [rateWithRepCurArray, rateList(curSubList)];
        indWithRepCurArray = [indWithRepCurArray, curSubList];
    end
    indWithRepCell{curItr, 1} = imWithRepCurArray;
    indWithRepCell{curItr, 2} = rateWithRepCurArray; 
    indWithRepCell{curItr, 3} = indWithRepCurArray; 
end

% now use indWithRepCell to calculate the denseRateMatrix and
% denseIndicatorMatrix.

for curItr = 1 : num_subCluster
    uniqueImArray = unique(indWithRepCell{curItr, 1});
    for curUniImInd = 1 : length(uniqueImArray)
        curImID = uniqueImArray(curUniImInd);
        curTempInd = indWithRepCell{curItr, 1}==curImID;
        curIndInd = indWithRepCell{curItr, 3}(curTempInd);
        attractTemp = indWithRepCell{curItr, 2}(curIndInd);
        denseRateMatrix(curImID, curItr) = mean(attractTemp);
    end
end





end