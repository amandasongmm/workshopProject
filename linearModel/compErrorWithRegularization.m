function [subsetError] = compErrorWithRegularization(X,Y,theta,subsetInd, errorField,genderInd)


Xsubset = X(subsetInd,:);
if exist('genderInd','var')
    Ysubset = Y(subsetInd, genderInd);
    subsetError = sqrt(mean((Ysubset-Xsubset*theta).^2));
    fprintf('%s error = %4.2f, gender =%d,\n',errorField, subsetError, genderInd);
else
    Ysubset = Y(subsetInd,:);
    subsetError = sqrt(mean((Ysubset-Xsubset*theta).^2));
    fprintf('%s error = %4.2f\n',errorField, subsetError);
end

end