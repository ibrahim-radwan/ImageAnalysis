%# read the file
filename = 'images/1r.jpg';
x = imread(filename);
%# convert to grayscale
x = rgb2gray(x);
x = im2bw(x);
%# get only the bars area
xend = find(diff(sum(x,2)),1);
x(xend:end,:) = [];

%# sum intensities along the bars
xsum = sum(x);

%# threshold the image by half of all pixels intensities
th = ( max(xsum)-min(xsum) ) / 2;
xth = xsum > th;

%# find widths
xstart = find(diff(xth)>0);
xstop = find(diff(xth)<0);
if xstart(1) > xstop(1)
    xstart = [1 xstart];
end
if xstart(end) > xstop(end)
    xstop = [xstop numel(xth)];
end

xwidth = xstop-xstart;

%# look at the histogram
hist(xwidth,1:max(xwidth))

%# it's clear that single bar has 2 pixels (can be automated), so
barwidth = xwidth ./ min(xwidth);