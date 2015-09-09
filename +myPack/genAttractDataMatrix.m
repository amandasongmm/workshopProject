% generate Y and R. 
% we need to create two matrices Y and R from raw psy1/2Data.
% Y is a img_num * user_num rating matrix, containing attractiveness ratings (1-9) of 2222 faces on 1274 subjects 
% R is an indicator matrix, dim = num_face * num_user, where R(i,j) = 1 iif user j gave a rating to face i

clc; clear; 
load('../rawData/psy2Data.mat');% 33430*27 
rawData = psy2Data;

%% clean the data. 
cleanData = rawData(all(~isnan(rawData),2),:);

imgID = cleanData(:,1); % the 1st column stores imageID
img_num = max(imgID); % 2222

userID = cleanData(:,19); % the 17th column stores subject information.
user_num = max(userID); % 1274

attractArray = cleanData(:,3);% the 3rd column stores subject information.

Y = zeros(img_num, user_num);
R = zeros(img_num, user_num);

for curItr = 1 : size(cleanData, 1)
	curImId = imgID(curItr);
    curUserId = userID(curItr);
	Y(curImId, curUserId) = attractArray(curItr);
	R(curImId, curUserId) = 1; 
end
R = logical(R);
save('../attractData.mat','Y','R');




