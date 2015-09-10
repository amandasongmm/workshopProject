%% read the raw data from psychology-attributes.xlsx

%% =================== Part I. Import the first half of the data 
[~, txt, raw] = xlsread('psychology-attributes.xlsx','All Data','A1:AB33431');
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(2:end,1);
raw = raw(2:end,[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28]);

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
data = reshape([raw{:}],size(raw));
subDataField = {'subID','subage','submale','subrace'};
fields_name1 = txt(1,2:end);
[~,subInd,~] = intersect(fields_name1,subDataField);
psy1Data = data; 
subData = data(:,subInd);
[Y,I]=sort(subData(:,1));
subData=subData(I,:); 
subData1 = unique(subData,'rows');
subData1 = subData1(all(~isnan(subData1),2),:);

%% Clear temporary variables
clearvars -except psy1Data fields_name1 subData1 subDataField;

%% save the data.
save('psy1Data.mat','psy1Data','fields_name1','subData1', 'subDataField');


%% ================= Part II. Import the second questionaire's data
[~, txt1, raw0_0] = xlsread('psychology-attributes.xlsx','All Data','B1:B33431');
[~, txt2, raw0_1] = xlsread('psychology-attributes.xlsx','All Data','AC1:BB33431');
txt2 = txt2(1,:);
fields_name2 = [txt1, txt2];

raw = [raw0_0,raw0_1];
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
data = reshape([raw{:}],size(raw));
psy2Data = data(2:end, :);

[~,subInd,~] = intersect(fields_name2,subDataField);
subData = data(2:end,subInd);
[Y,I]=sort(subData(:,1));
subData=subData(I,:); 
subData2 = unique(subData,'rows');
subData2 = subData2(all(~isnan(subData2),2),:);

%% Clear temporary variables
clearvars -except psy2Data fields_name2 subData2 subDataField;
save('psy2Data.mat','psy2Data', 'fields_name2','subData2', 'subDataField');