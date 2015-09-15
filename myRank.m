% myRank.m
clear; close all; clc; 
load('./preprocessedData/faceGenderYR.mat');

figure;
subplot(2,2,1);
hist(femaleY(:,1));
axis([0 9 0 300]);
title('FeFaceFeRater');

subplot(2,2,2);
hist(femaleY(:,2));
axis([0 9 0 300]);
title('FeFaceMaleRater');

subplot(2,2,3);
hist(maleY(:,1));
axis([0 9 0 300]);
title('MaleFaceFeRater');

subplot(2,2,4);
hist(maleY(:,2));
axis([0 9 0 300]);
title('MaleFaceMeRater');

figure;
subplot(1,2,1);
hist(femaleY(:));
axis([0 9 0 600]);
title('FeFae');

subplot(1,2,2);
hist(maleY(:));
axis([0 9 0 600]);
title('MaleFace');

figure;
subplot(1,2,1);
hist([femaleY(:,1);maleY(:,1)]);
axis([0 9 0 600]);
title('FemaleRater');
subplot(1,2,2);
hist([femaleY(:,2);maleY(:,2)]);
axis([0 9 0 600]);
title('MaleRater');