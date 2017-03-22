function lines = findLinesWithHoughT(imPath, verbose)
im = imread(imPath);
I = rgb2gray(im);
I = imrotate(I,33,'crop');
if(verbose)
    figure, imshow(I);
end
% We can see that the image is noisy. We will clean it up with a few morphological operations
th = graythresh(I);
BW = edge(I, 'canny'); 
se = strel('line',3,90);
dilatedI = imdilate(BW,se);
% Perform a Hough Transform on the image, the Hough Transform identifies lines in an image 
[H,theta,rho] = hough(dilatedI);
peaks  = houghpeaks(H,10, 'threshold',ceil(0.3*max(H(:))));
lines = houghlines(dilatedI,theta,rho,peaks, 'FillGap',5,'MinLength',7);
% Highlight (by changing color) the lines found by MATLAB
if(verbose)
    figure, imshow(dilatedI);
    hold on
    for k = 1:numel(lines)
        x1 = lines(k).point1(1);
        y1 = lines(k).point1(2);
        x2 = lines(k).point2(1);
        y2 = lines(k).point2(2);
        plot([x1 x2],[y1 y2],'Color','g','LineWidth', 2)
    end
    hold off
end
figure; hist([lines.theta]);
I = imrotate(im,90+56+33,'crop');
figure; imshow(I);