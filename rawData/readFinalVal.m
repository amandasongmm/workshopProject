%% read the raw data from psychology-attributes.xlsx

%% =================== Part I. Import the first half of the data 
[~, txt, raw] = xlsread('psychology-attributes.xlsx','Final Values','A1:AB2223');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(2:end,1);
raw = raw(2:end,[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28]);

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
data = reshape([raw{:}],size(raw));
leaveOut = {'Image #','catch','catchAns','subID','subage','submale','subrace'};
fields_name1 = txt(1,2:end);
[~,indexOut] = setdiff(fields_name1,leaveOut);
fields_name1 = fields_name1(indexOut);
psy1FiVal = data(1:end, indexOut);

%% Clear temporary variables
clearvars -except psy1FiVal fields_name1;

%% save the data.
save('psy1FiVal.mat','psy1FiVal','fields_name1');


%% ================= Part II. Import the second questionaire's data
[~, txt1, raw0_0] = xlsread('psychology-attributes.xlsx','Final Values','B1:B2223');
[~, txt2, raw0_1] = xlsread('psychology-attributes.xlsx','Final Values','AC1:BB2223');
txt2 = txt2(1,:);
fields_name2 = [txt1, txt2];

raw = [raw0_0,raw0_1];
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
data = reshape([raw{:}],size(raw));
leaveOut = {'Image #','catch','catchAns','subID','subage','submale','subrace'};
[~,indexOut] = setdiff(fields_name2,leaveOut);
fields_name2 = fields_name2(indexOut);
psy2FiVal = data(2:end, indexOut);

%% Clear temporary variables
clearvars -except psy2FiVal fields_name2;
save('psy2FiVal.mat','psy2FiVal', 'fields_name2');