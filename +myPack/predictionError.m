function MSR = predictionError(X, Theta, R, trainYmean, testInd, testGT)

[i, j] = ind2sub(size(R), testInd);
faceFeature = X(i, :);
userWeight = Theta(j, :);
prediction = sum(faceFeature.*userWeight, 2) + trainYmean(i);

dif = testGT - prediction; 
MSR = sqrt(sum(dif.^2)/length(dif));
end