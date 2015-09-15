function [J, grad] = simpleCostFunc(params,X,Y,R,lambda)

num_faces = size(X,1);num_features = size(X,2);num_users = size(Y,2);
X = reshape(params(1:num_faces*num_features), num_faces, num_features);
Theta = reshape(params(num_faces*num_features+1:end), num_users, num_features);

multiTemp = X * Theta'; %
J_temp = (multiTemp - Y).^2;
J_temp = sum(sum(J_temp .* R));
J = J_temp / 2;

xgrad_temp = X * Theta' - Y; % n_m * n_u
xgrad_temp = xgrad_temp .* R;
tgrad_temp = xgrad_temp'; % n_u * n_m
Theta_grad = tgrad_temp * X + lambda * Theta; % n_u * n =(n_u * n_m) * (n_m *n)

J = J + lambda/2 * sum(sum(Theta.^2)) + lambda/2 * sum(sum(X.^2));
X_grad = xgrad_temp * Theta + lambda * X; % n_m * n = (n_m * n_u) * (n_u * n)
grad = [X_grad(:); Theta_grad(:)];


end
