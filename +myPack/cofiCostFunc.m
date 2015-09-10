function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda,gradFlag)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

            
% You need to return the following values correctly
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost function and gradient for collaborative
%               filtering. Concretely, you should first implement the cost
%               function (without regularization) and make sure it is
%               matches our costs. After that, you should implement the 
%               gradient and use the checkCostFunction routine to check
%               that the gradient is correct. Finally, you should implement
%               regularization.
%
% Notes: X - num_movies  x num_features matrix of movie features
%        Theta - num_users  x num_features matrix of user features
%        Y - num_movies x num_users matrix of user ratings of movies
%        R - num_movies x num_users matrix, where R(i, j) = 1 if the 
%            i-th movie was rated by the j-th user
%
% You should set the following variables correctly:
%
%        X_grad - num_movies x num_features matrix, containing the 
%                 partial derivatives w.r.t. to each element of X
%        Theta_grad - num_users x num_features matrix, containing the 
%                     partial derivatives w.r.t. to each element of Theta
%

% X = n_m * n, Theta = n_u * n, Y = n_m * n_u
if(~exist('gradFlag', 'var'))
	gradFlag = 0;
end

multiTemp = X * Theta'; %  
J_temp = (multiTemp - Y).^2; 
J_temp = sum(sum(J_temp .* R)); 
J = J_temp / 2; 
J = J + lambda/2 * sum(sum(Theta.^2)); 
xgrad_temp = X * Theta' - Y; % n_m * n_u
xgrad_temp = xgrad_temp .* R;  

if (gradFlag == 1)
    J = J + lambda/2 * sum(sum(X.^2)); 
    X_grad = xgrad_temp * Theta + lambda * X; % n_m * n = (n_m * n_u) * (n_u * n) 
end

tgrad_temp = xgrad_temp'; % n_u * n_m
Theta_grad = tgrad_temp * X + lambda * Theta; % n_u * n =(n_u * n_m) * (n_m * n)

% =============================================================

grad = [X_grad(:); Theta_grad(:)];

end