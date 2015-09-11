function genDenseYR(subAttri, fieldName, origY, origR, subInd)
%GENDENSEYR.m
%   generate Y and R according to rater's attributes.

faceNum = 2222;
attriGroupNum = length(unique(subAttri));
Y = zeros(faceNum, attriGroupNum);
R = zeros(faceNum, attriGroupNum);

for curG = 1 : attriGroupNum
    switch fieldName
        case 'age'
            subInCurGroup = subInd(subAttri==curG);
        otherwise
            subInCurGroup = subInd(subAttri==(curG-1));
    end
    R(:,curG) = sum(origR(:,subInCurGroup),2)>0;
    Y(:,curG) = sum(origY(:,subInCurGroup),2)./sum(origR(:,subInCurGroup),2);
end
Y(isnan(Y))=0;
save(sprintf('../preprocessedData/%sYRData.mat',fieldName), 'R','Y');

end