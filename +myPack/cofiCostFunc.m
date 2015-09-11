function [J, grad] = cofiCostFunc(params, X, Y, R, num_features, lambda,gradFlag)
%COFICOSTFUNC Collaborative filtering cost function

%   [J, grad] = cofiCostFunc(params, X, Y, R, num_features, lambda,gradFlag)returns the cost and gradient for the
%   collaborative filtering problem.
%   if gradFlag = 0, won't update feature matrix X, only update weigth matrix Theta
%   if gradFlag = 1, update feature matrix X and weight matrix Theta.
%   X - num_face  x num_features Matrix of face features
%   Theta - num_users  x num_features Matrix of user preference
%   Y - num_face x num_users Matrix of user ratings of movies
%   R - num_face x num_users Indicator Matrix
%   X_grad - num_faces x num_features matrix, containing the partial derivatives w.r.t. to each element of X
%   Theta_grad - num_users x num_features matrix, containing the partial derivatives w.r.t. to each element of Theta

if(~exist('gradFlag', 'var'))
    fprintf('Add gradFlag!!!!!\n');
end

[num_faces, num_users] = size(Y);

if gradFlag == 1
    X = reshape(params(1:num_faces*num_features), num_faces, num_features);
    Theta = reshape(params(num_faces*num_features+1:end), num_users, num_features);
else
    Theta = reshape(params, num_users, num_features);
end

multiTemp = X * Theta'; %
J_temp = (multiTemp - Y).^2;
J_temp = sum(sum(J_temp .* R));
J = J_temp / 2;

xgrad_temp = X * Theta' - Y; % n_m * n_u
xgrad_temp = xgrad_temp .* R;
tgrad_temp = xgrad_temp'; % n_u * n_m
Theta_grad = tgrad_temp * X + lambda * Theta; % n_u * n =(n_u * n_m) * (n_m * n)

if (gradFlag == 1)
    J = J + lambda/2 * sum(sum(Theta.^2)) + lambda/2 * sum(sum(X.^2));
    X_grad = xgrad_temp * Theta + lambda * X; % n_m * n = (n_m * n_u) * (n_u * n)
    grad = [X_grad(:); Theta_grad(:)];
else
    J = J + lambda/2 * sum(sum(Theta(:,2:end).^2));
    Theta_grad(:,1) = tgrad_temp * X(:,1); % n_u * n =(n_u * n_m) * (n_m * n)%Theta - num_users  x num_features
    grad = [Theta_grad(:)];
end
end
