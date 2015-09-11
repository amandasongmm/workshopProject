function [num_features, X, gradFlag] = featureGen(method)
%
% This function loads features for collaborative filtering
% features can be chosen from the list below:
% {'color', 'hog2x2','hog3x3','sift','random'}
%
% It can only generate random features, all the other ones are
% pre-generated.
%
% gradFlag indicates whether the gradient of X should be set to 0 or not
% if features handcrafted, X should not be updated, gradient(x) = 0
% otherwise, when feature is chosen randomly, we want to learn the feature
% by collaborative filtering, it is set to be the corresponding gradient.
%
if(~exist('method', 'var'))
    method = 'random';
end

switch method
    case 'random'
        fprintf('Randomly initialize features.\n\n');
        num_features = 50;
        num_faces = 2222;
        X = randn(num_faces, num_features);
        gradFlag = 1;
    case  'socialOther'
        fprintf('Loading other social features.\n\n');
        load('./rawData/psy2FiVal.mat');
        leaveOut = {'attractive'};
        [~,indexOut] = setdiff(fields_name2,leaveOut);
        X = psy2FiVal(:,indexOut);
        num_features = size(X,2);
        gradFlag = 0; 
    case  'sift'
        fprintf('Loading sift features.\n\n');
        load('./featureTool/myTest/featureMat/sift20.mat');
        X = total_features;
        num_features = size(X,2);
        gradFlag = 0; 
    case  'socialTotal'
        fprintf('Loading all social features.\n\n');
        load('./rawData/psy2FiVal.mat');
        X = psy2FiVal;
        num_features = size(X,2);
        gradFlag = 0; 
    otherwise
        fprintf('Unknown method.Check codes.\n');
        gradFlag = 1; 
end

end