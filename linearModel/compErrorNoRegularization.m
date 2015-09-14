function [trainError, testError, theta] = compErrorNoRegularization(X,Y,genderInd,trainInd,testInd)

ytrain = Y(trainInd, genderInd);
ytest = Y(testInd, genderInd);

theta = normalEqn(X(trainInd, :),ytrain);

trainError = sqrt(mean((ytrain-X(trainInd,:)*theta).^2));
testError = sqrt(mean((ytest-X(testInd,:)*theta).^2)); 

fprintf('train error = %4.2f, gender =%d,\n',trainError, genderInd);
fprintf('test error = %4.2f,gender =%d\n',testError, genderInd);

end