function [binary_img] = face_mask(input_img, threshold)
%funkar inte helt, den får med bakgrunden i vissa bilder

%to binary image
%binaryImg= zeros(256);
binary_img = zeros(size(input_img, 1), size(input_img,2));

%Convert image from RGB to YCbCr
YCbCr_img = rgb2ycbcr(input_img);

%split the image into Y, Cb and Cr channels.
Y = YCbCr_img(:,:,1);
Cb = YCbCr_img(:,:,2);
Cr = YCbCr_img(:,:,3);


%Från lecture , 77 ≤ Cb ≤ 127 snd 133 ≤ Cr ≤ 173, Y illumination
%[row, col] = find(Cb>=85 & Cr>=135 & Y >= 80);
[row, col] = find(Cb>=85 & Cr>=143 & Cr <=173 & Y >= 80);


%Mark the skin to white
for i = 1:size(row)
        binary_img(row(i), col(i)) = 1;
end

se = strel('square',3);
binary_img = imopen(binary_img, se);
binary_img = imclose(binary_img, se);



%fill the eyes and mouth/teeth
binary_img = imfill(binary_img, 'holes'); 
target = 256:-4:4;
binary_img = histeq(binary_img,target);
binary_img = imbinarize(binary_img, 0.8);

binary_img = bwareafilt(binary_img,1);


%Morphological operations gets rid of the holes in the face and some of the
%background

%binaryImg = inputImg;

% se = strel('disk',11);
% binaryImg = imopen(binaryImg, se);
% binaryImg = imclose(binaryImg, se); 
%  
% binaryImg = imdilate(binaryImg, se);
% binaryImg = imdilate(binaryImg, se);
% binaryImg = imerode(binaryImg, se);
% binaryImg = imerode(binaryImg, se);

% imshow(binaryImg);
end

