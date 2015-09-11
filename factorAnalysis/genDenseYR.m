function genDenseYR(subAttri, fieldName, origY, origR, subInd)
%GENDENSEYR.m
%   generate Y and R according to rater's attributes.

faceNum = 2222;
attriGroupNum = length(unique(subAttri));
Y = zeros(faceNum, attriGroupNum);
R = zeros(faceNum, attriGroupNum);
tempY = zeros(faceNum, attriGroupNum);
tempR = zeros(faceNum, attriGroupNum);
for curG = 1 : attriGroupNum
    switch fieldName
        case 'age'
            subInCurGroup = subInd(subAttri==curG);
        otherwise
            subInCurGroup = subInd(subAttri==(curG-1));
    end
    tempY(:,curG) = sum(origY(:,subInCurGroup),2);
    tempR(:,curG) = sum(origR(:,subInCurGroup),2);
end

for curG = 1 : attriGroupNum
    for curF = 1 : faceNum
        if tempY(curF,curG) == 0
            Y(curF,curG) = 0;
        else
            Y(curF, curG) = tempY(curF,curG)/tempR(curF,curG);
            R(curF, curG) = 1; 
        end
    end
end
save(sprintf('../preprocessedData/%sYRData.mat',fieldName), 'R','Y');

end