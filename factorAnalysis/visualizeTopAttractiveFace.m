% visualize top attractive faces.

clc; clear; close all;
fieldList = {'age','gender','race'};
curField = fieldList{3};
load(sprintf('weightBy%s_socialOtherFeature.mat',curField));


groupNum = size(Theta, 1);

%% visualize top faces
attractProduct = X * Theta' + repmat(trainYmean, 1, groupNum);
[topRate, topRateInd] = sort(attractProduct);


imPath = 'C:/Users/amand_000/Desktop/2kfaces/';
load('../rawData/imageNames.mat');

top_num = 10;
for curGroup = 1 : groupNum
    figure;
    for curItr = 1 : top_num
        curImName = imageNames{topRateInd(curItr, curGroup)};
        subplot(2,5,curItr);
        imshow(sprintf('%s%s',imPath,curImName));
    end
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0,...
        1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    figureTitle = sprintf('last %d faces like by %s group %d',top_num, curField, curGroup);
    text(0.5, 1,figureTitle,'HorizontalAlignment',...
        'center','VerticalAlignment', 'top');
    figName = sprintf('%s.jpg',figureTitle);
    saveas(gcf,figName);
end

%% visualize social feature weights.
Theta = Theta(:,2:end);
[topWeight, topWeightInd] = sort(Theta,2,'descend');
[lowWeight, lowWeightInd] = sort(Theta,2);


load('../rawData/psy2FiVal.mat');
leaveOut = {'attractive'};
[~,indexOut] = setdiff(fields_name2,leaveOut);

filteredNames = {fields_name2{indexOut}};


topN = 5;
for curGroup = 1 : groupNum
    figure;
    bar(Theta(curGroup,lowWeightInd(curGroup,1:topN)));
    set(gca,'XTickLabel',{filteredNames{lowWeightInd(curGroup,1:topN)}});
    figureTitle = sprintf('last 5 feature hist by %s group %d',curField, curGroup);
    title(figureTitle);
    figName = sprintf('%s.jpg',figureTitle);
    saveas(gcf,figName);
end




