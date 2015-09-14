% myCostFunc.m
function [J, grad] = myCostFunc(params, X, Y, R)

num_users = size(Y,2);
num_features = size(X,2);
Theta = reshape(params,num_users, num_features);

predRate = X * Theta'; 
J_temp = (predRate-Y).^2;
J = sum(sum(J_temp.*R))/2;

grad_temp = (X*Theta' -Y).*R;
t_grad_temp = grad_temp';
Theta_grad = t_grad_temp * X;

grad = [Theta_grad(:)];
end


