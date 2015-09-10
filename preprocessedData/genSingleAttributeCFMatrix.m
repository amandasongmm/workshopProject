% generate Y and R.
% we need to create two matrices Y and R from raw psy1/2Data.
% Y is a img_num * user_num rating matrix, containing attractiveness ratings (1-9) of 2222 faces on 1274 subjects
% R is an indicator matrix, dim = num_face * num_user, where R(i,j) = 1 iif user j gave a rating to face i

clc; clear;
load('../rawData/psy2Data.mat');% 33430*27
rawData = psy2Data;

singleAttriList = [2:4,7:18,22:27];

for curItr = 1 : length(singleAttriList)
    curAttriInd = singleAttriList(curItr);
    curAttriName = fields_name2{curAttriInd};
    saveName = sprintf('%sData.mat', curAttriName);
    
    % clean the data.
    cleanData = rawData(all(~isnan(rawData),2),:);
    
    % get img_num
    imgID = cleanData(:,1); % the 1st column stores imageID
    img_num = max(imgID); % 2222
    
    % get user_num
    userID = cleanData(:,19); % the 17th column stores subject information.
    user_num = max(userID); % 1274
    
    % singleDataArray
    singleDataArray = cleanData(:,curAttriInd);% the 3rd column stores subject information.    
    Y = zeros(img_num, user_num);
    R = zeros(img_num, user_num);
    
    for curItr = 1 : size(cleanData, 1)
        curImId = imgID(curItr);
        curUserId = userID(curItr);
        Y(curImId, curUserId) = singleDataArray(curItr);
        R(curImId, curUserId) = 1;
    end
    R = logical(R);
    save(saveName,'Y','R');
end



