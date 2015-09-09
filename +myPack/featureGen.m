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

gradFlag = 0;
if method == 'random'
    num_features = 50; 
    num_faces = 2222; 
    X = randn(num_faces, num_features);
    gradFlag = 1;
end

end