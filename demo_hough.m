% demo find lines using Hough transform

imPath = 'images/1-045432423423.jpg';
verbose = 1; % show/display whatever the artifacts
lines = findLinesWithHoughT(imPath, verbose);