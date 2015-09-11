% generate Y and R.
% we need to create two matrices Y and R from raw psy1/2Data.
% Y is a img_num * user_num rating matrix, containing attractiveness ratings (1-9) of 2222 faces on 1274 subjects
% R is an indicator matrix, dim = num_face * num_user, where R(i,j) = 1 iif user j gave a rating to face i

clc; clear;
load('../rawData/psy2Data.mat');% 33430*27
rawData = psy2Data;

singleAttriList = [2:4,7:18,23:27];

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
    userID = cleanData(:,19); % the 19th column stores subject information.

    
    userInfoArray = cleanData(:,19:22);   
    userInfoArray = unique(userInfoArray,'rows');
    [~,I]=sort(userInfoArray(:,1));
    userInfoArray=userInfoArray(I,:); 
    
    userID_uniqueList = userInfoArray(:,1);
    user_num = length(userID_uniqueList); % <1274
    
    % singleDataArray
    singleDataArray = cleanData(:,curAttriInd);% the 3rd column stores subject information.    
    Y = zeros(img_num, user_num);
    R = zeros(img_num, user_num);
    
    
    for curItr = 1 : size(cleanData, 1)
        curImId = imgID(curItr);
        curUserId = find(userID_uniqueList == userID(curItr));
        Y(curImId, curUserId) = singleDataArray(curItr);
        R(curImId, curUserId) = 1;
    end
    R = logical(R);
    Y = Y(:,(sum(Y)~=0));
    R = R(:, (sum(R)~=0));
    subData = userInfoArray((sum(Y)~=0),:);% rater's data (ID, age, gen, race)
    save(saveName,'Y','R','subData');
end
fprintf('completed. \n');



