% myCostFunc.m
function [J, grad] = myCostFunc(params, X, Y, R)

J = 0;
num_users = size(Y,2);
num_features = size(X,2);
Theta = reshape(params,num_users, num_features);

predRate = X * Theta'; 
J_temp = (predRate-Y).^2;
J = sum(sum(J_temp.*R))/2;

grad_temp = (X*Theta' -Y).*R;%num_m * num_u
t_grad_temp = grad_temp';%num_u * num_m
Theta_grad = t_grad_temp * X;%num_u * num_m * num_m * num_feature

grad = [Theta_grad(:)];
end


