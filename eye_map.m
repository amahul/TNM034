function [out_image_illum] = eye_map(in_image)

%Test
%in_image = imread("image_0253.jpg");

%Convert RGB color values to YCbCr color space
chroma_img = rgb2ycbcr(in_image);

%color channels scaling
Y = uint16(255 * mat2gray(chroma_img(:,:,1))); 
Cb = uint16(255 * mat2gray(chroma_img(:,:,2)));
Cr = uint16(255 * mat2gray(chroma_img(:,:,3)));

Cr_negative = 255 - Cr;

%First eye map 
EyeMapC = (1/3).*(Cb.^2 + Cr_negative.^2 + (Cb./Cr));
EyeMapC = im2double(histeq(EyeMapC)); %Send back?

SE = strel('disk', 4);
%Second eye map 
Dilate = imdilate(Y,SE);
Erode = imerode(Y,SE);

EyeMapL = Dilate./(Erode+1);
EyeMapL = im2double(histeq(EyeMapL)); %Send back?

%Combination of Cr and Cb
EyeMap = EyeMapC.* EyeMapL;
EyeMap = histeq(EyeMap); 

EyeMap = EyeMap > 0.85;

%Normalize
EyeMap = uint8(255 * mat2gray(EyeMap));

out_image_illum = imdilate(EyeMap,SE);

imshow(out_image_illum)









