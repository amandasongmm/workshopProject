function [J, grad] = linearRegCostFunction(X, y, theta, lambda)

%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));% (n+1) * 1

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%

% X = m * 2, 
% y = m * 1, 
% theta = [1; 1]; 2 * 1

hyp_theta = X * theta; % m * 1
J = mean((hyp_theta - y).^2)/ 2 + (lambda/2) * sum(theta(2:end, :).^2)/ m;% should exclude theta_0 term

grad(1, :) = mean((hyp_theta - y) .* X(:, 1)); % m*1 , m*1

% disp(size(y));
% disp(size(X(:,2:end)));

grad(2:end) = (X(:, 2:end)' * (hyp_theta - y))/m + lambda * theta(2:end, 1)/m; % m*1, m*(j-1)



% =========================================================================

grad = grad(:);

end
