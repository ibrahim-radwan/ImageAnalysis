close all;
clear;
clc;
im_path = 'images/robocup_image1.jpeg';
im = imread(im_path);
im_gray = rgb2gray(im);

x_start = 418;
y_start = 155;

x_end = 466;
y_end = 225;

template = im(y_start:y_end, x_start:x_end, :);
template_gray = rgb2gray(template);
figure; imshow(template_gray);

im_gray = rgb2gray(imread('images/robocup_image2.jpeg'));

% template matching based on Sum of Absolute Differences (SAD)
[height_t, width_t, ~] = size(template);
[height, width, ~] = size(im);

% Detect the salient points using Harris technique
pointsImg = detectHarrisFeatures(im_gray);
pointsTemplate = detectHarrisFeatures(template_gray);

% Feature description
[featuresImg, validPointsImg] = extractFeatures(im_gray, pointsImg); % original image
[featuresTemplate, validPointsTemplate] = extractFeatures(template_gray, pointsTemplate); % template image

% Match the features
indexPairs = matchFeatures(featuresImg, featuresTemplate);

% Location of the matched points
matchedPointsImg = validPointsImg(indexPairs(:, 1), :);
matchedPointsTemplate = validPointsTemplate(indexPairs(:, 2), :);

% time to show
figure; 
showMatchedFeatures(im_gray, template_gray, matchedPointsImg, matchedPointsTemplate);
