% socialFeaturePCA.m


clear; clc; close all; 
addpath(genpath('./drtoolbox'));

%% load data
load('./preprocessedData/socialFeaFullData.mat');%contains 'socialFeaData','fieldsFullList'
X = socialFeaData;



%% clustering of social features
clc;
clusterNum = 6; 
idx = kmeans(X',clusterNum);

% for curId = 1 : max(idx)
%     tempList = find(idx==curId);
%     if ~isempty(tempList)
%         for curInner = 1 : length(tempList)
%             fprintf('%s,',fieldsFullList{tempList(curInner)});
%         end
%     end
%     fprintf('\n===============\n');
% end

%% MDS on social features
distMatrix = pdist(X', 'euclidean');
[Y, eigvals] = cmdscale(distMatrix);
plot(Y(:,1),Y(:,2),'.');
text(Y(:,1)+1,Y(:,2),fieldsFullList);


%% check intrinsic dimensions. done stored in factorAnalysis
% dim_MLE = intrinsic_dim(socialFeaData, 'MLE');
% dim_CorrDim = intrinsic_dim(socialFeaData, 'CorrDim');% Compute correlation dimension estimation
% dim_NearNbDim = intrinsic_dim(socialFeaData, 'NearNbDim');% Compute nearest neighbor dimension estimation
% dim_GMST = intrinsic_dim(socialFeaData, 'GMST');% Geodesic minimum spanning tree
% dim_EigValue = intrinsic_dim(socialFeaData, 'EigValue'); % Perform PCA
% dim_PackingNumbers = intrinsic_dim(socialFeaData, 'PackingNumbers'); % Perform PCA
% 
% %% PCA embedding 
% [mappedX, mapping] = compute_mapping(X, 'PCA');
% figure, scatter(mappedX(:,1), mappedX(:,2), 5); title('Result of PCA');
% 
% [mappedX, mapping] = compute_mapping(X, 'Laplacian');
% figure, scatter(mappedX(:,1), mappedX(:,2), 5); title('Result of Laplacian Eigenmaps'); drawnow