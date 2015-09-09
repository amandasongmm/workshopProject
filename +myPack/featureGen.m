function [num_features, X] = featureGen(method)

if method == 'random'
    num_features = 50; 
    num_faces = 2222; 
    X = randn(num_faces, num_features);
end
end