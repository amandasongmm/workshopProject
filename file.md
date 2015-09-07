


myMain.m
ReadMe

Overview
In this part of the codes, we implement the collaborative filtering learning algorithm and apply it to the dataset of facial attractiveness ratings. 

This dataset consists of ratings on facial attractiveness on a scale of 1 to 9. The dataset has user_number = 1247, and face_number = 2222. 

In the next parts, we will implement the function cofiCostFunc.m that computes the collaborative filtering objective function and gradient. 

We will then use fmincg.m to learn the parameters for collaborative filtering.

1. attractiveness dataset
The first part of myMain.m will load the dataset attractData.mat, providing the variables Y and R in matlab. 

The matrix Y (img_num * user_num) stores the rating y(i,j) from 1 to 9. The matrix R is a binary-valued indicator matrix, where R(i,j)=1 if user j gave a rating to face i, and R(i,j)=0 otherwise. 

The objective of collaborative filtering is to predict attractiveness rating for the faces that a user have not yet rated. This will allow us to recommend the faces with the highest predicted ratings to the user. And help us understand different types of attractiveness. 

Throughout this file, we will work with two matrices, X and Theta. 

X is the feature matrix and Theta is a preference weight matrix. X is of size img_num * feature_num. Theta is of size user_num * feature_num. 