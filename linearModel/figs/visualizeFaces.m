% visualize top attractive faces.

clc; clear; close all;
imPath = 'C:/Users/amand_000/Desktop/2kfaces/';
load('../.././rawData/imageNames.mat');
load('../.././rawData/genderList.mat');
% %% Part 1: visualize average faces
% load('attractPredict_average_average.mat');
% 
% [~,sortedInd] = sort(attractPredict,'descend');
% % top 10
% top_num = 10;
% figure;
% for curItr = 1 : top_num
%     curImName = imageNames{sortedInd(curItr)};
%     subplot(2,5,curItr);
%     imshow(sprintf('%s%s',imPath,curImName));
% end
% ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0,1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
% figureTitle = sprintf('Top %d attractive faces selected by general public',top_num);
% text(0.5, 1,figureTitle,'HorizontalAlignment','center','VerticalAlignment', 'top');
% figName = sprintf('./average/%s.jpg',figureTitle);
% saveas(gcf,figName);
% 
% % last ten 
% figure;
% for curItr = 1 : top_num
%     curImName = imageNames{sortedInd(end+1-curItr)};
%     subplot(2,5,curItr);
%     imshow(sprintf('%s%s',imPath,curImName));
% end
% ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0,1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
% figureTitle = sprintf('%d least attractive faces rated by general public',top_num);
% text(0.5, 1,figureTitle,'HorizontalAlignment','center','VerticalAlignment', 'top');
% figName = sprintf('./average/%s.jpg',figureTitle);
% saveas(gcf,figName);
% 
% %% Part 2: rate by female and male.
% 
% %% female
% load('attractPredict_femaleRater.mat');
% 
% [~,sortedInd] = sort(attractPredict,'descend');
% 
% % top 10
% top_num = 10;
% figure;
% for curItr = 1 : top_num
%     curImName = imageNames{sortedInd(curItr)};
%     subplot(2,5,curItr);
%     imshow(sprintf('%s%s',imPath,curImName));
% end
% ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0,1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
% figureTitle = sprintf('Top %d attractive faces selected by female raters',top_num);
% text(0.5, 1,figureTitle,'HorizontalAlignment','center','VerticalAlignment', 'top');
% figName = sprintf('./raterByGender/%s.jpg',figureTitle);
% saveas(gcf,figName);
% 
% % last ten 
% figure;
% for curItr = 1 : top_num
%     curImName = imageNames{sortedInd(end+1-curItr)};
%     subplot(2,5,curItr);
%     imshow(sprintf('%s%s',imPath,curImName));
% end
% ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0,1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
% figureTitle = sprintf('%d least attractive faces rated by female raters',top_num);
% text(0.5, 1,figureTitle,'HorizontalAlignment','center','VerticalAlignment', 'top');
% figName = sprintf('./raterByGender/%s.jpg',figureTitle);
% saveas(gcf,figName);
% 
% 
% %% male
% load('attractPredict_maleRater.mat');
% 
% [~,sortedInd] = sort(attractPredict,'descend');
% 
% % top 10
% top_num = 10;
% figure;
% for curItr = 1 : top_num
%     curImName = imageNames{sortedInd(curItr)};
%     subplot(2,5,curItr);
%     imshow(sprintf('%s%s',imPath,curImName));
% end
% ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0,1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
% figureTitle = sprintf('Top %d attractive faces selected by male raters',top_num);
% text(0.5, 1,figureTitle,'HorizontalAlignment','center','VerticalAlignment', 'top');
% figName = sprintf('./raterByGender/%s.jpg',figureTitle);
% saveas(gcf,figName);
% 
% % last ten 
% figure;
% for curItr = 1 : top_num
%     curImName = imageNames{sortedInd(end+1-curItr)};
%     subplot(2,5,curItr);
%     imshow(sprintf('%s%s',imPath,curImName));
% end
% ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0,1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
% figureTitle = sprintf('%d least attractive faces rated by male raters',top_num);
% text(0.5, 1,figureTitle,'HorizontalAlignment','center','VerticalAlignment', 'top');
% figName = sprintf('./raterByGender/%s.jpg',figureTitle);
% saveas(gcf,figName);

%% part 3. 2*2
%% female face by female rater
load('attractPredictFemaleFaceBy_femaleRater.mat');
[~,sortedInd] = sort(attractPredict,'descend');
femaleInd = find(genderList==0);
maleInd = find(genderList==1);

% top 10
top_num = 10;
figure;
for curItr = 1 : top_num
    curImName = imageNames{femaleInd(sortedInd(curItr))};
    subplot(2,5,curItr);
    imshow(sprintf('%s%s',imPath,curImName));
end
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0,1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
figureTitle = sprintf('Top %d attractive female faces selected by female raters',top_num);
text(0.5, 1,figureTitle,'HorizontalAlignment','center','VerticalAlignment', 'top');
figName = sprintf('./faceByGender_raterByGender/%s.jpg',figureTitle);
saveas(gcf,figName);

% last ten 
figure;
for curItr = 1 : top_num
    curImName = imageNames{femaleInd(sortedInd(end+1-curItr))};
    subplot(2,5,curItr);
    imshow(sprintf('%s%s',imPath,curImName));
end
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0,1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
figureTitle = sprintf('%d least female attractive faces rated by female raters',top_num);
text(0.5, 1,figureTitle,'HorizontalAlignment','center','VerticalAlignment', 'top');
figName = sprintf('./faceByGender_raterByGender/%s.jpg',figureTitle);
saveas(gcf,figName);

%% female face by male rater
load('attractPredictFemaleFaceBy_maleRater.mat');
[~,sortedInd] = sort(attractPredict,'descend');

% top 10
top_num = 10;
figure;
for curItr = 1 : top_num
    curImName = imageNames{femaleInd(sortedInd(curItr))};
    subplot(2,5,curItr);
    imshow(sprintf('%s%s',imPath,curImName));
end
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0,1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
figureTitle = sprintf('Top %d attractive female faces selected by male raters',top_num);
text(0.5, 1,figureTitle,'HorizontalAlignment','center','VerticalAlignment', 'top');
figName = sprintf('./faceByGender_raterByGender/%s.jpg',figureTitle);
saveas(gcf,figName);

% last ten 
figure;
for curItr = 1 : top_num
    curImName = imageNames{femaleInd(sortedInd(end+1-curItr))};
    subplot(2,5,curItr);
    imshow(sprintf('%s%s',imPath,curImName));
end
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0,1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
figureTitle = sprintf('%d least attractive female faces rated by male raters',top_num);
text(0.5, 1,figureTitle,'HorizontalAlignment','center','VerticalAlignment', 'top');
figName = sprintf('./faceByGender_raterByGender/%s.jpg',figureTitle);
saveas(gcf,figName);








%% male face by female rater
load('attractPredictmaleFaceBy_femaleRater.mat');
[~,sortedInd] = sort(attractPredict,'descend');

% top 10
top_num = 10;
figure;
for curItr = 1 : top_num
    curImName = imageNames{maleInd(sortedInd(curItr))};
    subplot(2,5,curItr);
    imshow(sprintf('%s%s',imPath,curImName));
end
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0,1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
figureTitle = sprintf('Top %d attractive male faces selected by female raters',top_num);
text(0.5, 1,figureTitle,'HorizontalAlignment','center','VerticalAlignment', 'top');
figName = sprintf('./faceByGender_raterByGender/%s.jpg',figureTitle);
saveas(gcf,figName);

% last ten 
figure;
for curItr = 1 : top_num
    curImName = imageNames{maleInd(sortedInd(end+1-curItr))};
    subplot(2,5,curItr);
    imshow(sprintf('%s%s',imPath,curImName));
end
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0,1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
figureTitle = sprintf('%d least attractive male faces rated by female raters',top_num);
text(0.5, 1,figureTitle,'HorizontalAlignment','center','VerticalAlignment', 'top');
figName = sprintf('./faceByGender_raterByGender/%s.jpg',figureTitle);
saveas(gcf,figName);





%% male face by male rater
load('attractPredictMaleFaceBy_maleRater.mat');
[~,sortedInd] = sort(attractPredict,'descend');

% top 10
top_num = 10;
figure;
for curItr = 1 : top_num
    curImName = imageNames{maleInd(sortedInd(curItr))};
    subplot(2,5,curItr);
    imshow(sprintf('%s%s',imPath,curImName));
end
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0,1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
figureTitle = sprintf('Top %d attractive male faces selected by male raters',top_num);
text(0.5, 1,figureTitle,'HorizontalAlignment','center','VerticalAlignment', 'top');
figName = sprintf('./faceByGender_raterByGender/%s.jpg',figureTitle);
saveas(gcf,figName);

% last ten 
figure;
for curItr = 1 : top_num
    curImName = imageNames{maleInd(sortedInd(end+1-curItr))};
    subplot(2,5,curItr);
    imshow(sprintf('%s%s',imPath,curImName));
end
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0,1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
figureTitle = sprintf('%d least attractive male faces rated by male raters',top_num);
text(0.5, 1,figureTitle,'HorizontalAlignment','center','VerticalAlignment', 'top');
figName = sprintf('./faceByGender_raterByGender/%s.jpg',figureTitle);
saveas(gcf,figName);

