close all;
clear;
clc;
im_path = 'images/robocup_image1.jpeg';
im = imread(im_path);
figure; imshow(im);

x_start = 89;
y_start = 406;

x_end = 141;
y_end = 451;

template = im(y_start:y_end, x_start:x_end, :);

figure; imshow(template);

% template matching based on Sum of Absolute Differences (SAD)
[height_t, width_t, ~] = size(template);
[height, width, ~] = size(im);
SAD = ones(height, width) * inf;

if(mod(height_t, 2) == 0)
    center_template_r = floor(height_t / 2);
else
    center_template_r = floor(height_t / 2) + 1;
end

if(mod(width_t, 2) == 0)
    center_template_c = floor(width_t / 2);
else
    center_template_c = floor(width_t / 2) + 1;
end

for i = center_template_r : height - center_template_r
    for j = center_template_c : width - center_template_c
        im_sub = im(i - center_template_r + 1: i + center_template_r, ...
                   j - center_template_c + 1: j + center_template_c - 1, :);
               error = (abs(im_sub - template));
               SAD(i,j) = sum(error(:));
    end
end
figure; imagesc(SAD);

% find the location of the object
[v, I] = min(SAD(:));

[I_row, I_col] = ind2sub(size(SAD),I);

figure; imshow(im);
hold on;
rectangle('position', [I_col - center_template_c, I_row - center_template_r, width_t, height_t], ...
           'EdgeColor', 'r', ...
           'LineWidth', 3);
plot(I_col, I_row, '*y');