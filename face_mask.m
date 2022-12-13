function [binary_img] = face_mask(input_img)
% input_img=imread("images/DB1/db1_01.jpg");
%% light compensation of the input image
input_img = gray_world(input_img);
% figure()
% imshow(input_img)
%% binary image
binary_img = zeros(size(input_img, 1), size(input_img,2));

%% Convert image from RGB to YCbCr
YCbCr_img = rgb2ycbcr(input_img);

% split the image into Y, Cb and Cr channels.
Y = YCbCr_img(:,:,1);
Cb = YCbCr_img(:,:,2);
Cr = YCbCr_img(:,:,3);

%% Threshold segmentation algorithm
[row, col] = find(Cb>=65 & Cr>=120 & Cr <=150 & Y >= 80);


%% Set the skin to white and the rest to black
for i = 1:size(row)
        binary_img(row(i), col(i)) = 1;
end

%% Morphological operations
se = strel('square',3);
binary_img = imopen(binary_img, se);
binary_img = imclose(binary_img, se);

%fill the eyes and mouth/teeth
binary_img = imfill(binary_img, 'holes'); 
target = 256:-4:4;
binary_img = histeq(binary_img,target);
binary_img = imbinarize(binary_img, 0.8);

binary_img = bwareafilt(binary_img,1);
% figure()
% imshow(binary_img)
end

