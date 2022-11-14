function [binaryImg] = faceMask(inputImg)
%to binary image
binaryImg = zeros(size(inputImg, 1), size(inputImg,2));

%Convert image from RGB to YCbCr
YCbCr_img = rgb2ycbcr(inputImg);

%split the image into Y, Cb and Cr channels.
Y = YCbCr_img(:,:,1);
Cb = YCbCr_img(:,:,2);
Cr = YCbCr_img(:,:,3);

% 
% Y = inputImg(:,:,1);
% Cb = inputImg(:,:,2);
% Cr = inputImg(:,:,3);

%Från lecture
[row, col] = find(Cb>=85 & Cr>=135 & Y >= 80);


%Mark the skin to white
for n=1:size(row)
    binaryImg(row(n), col(n))= 1;
end

%Morphological operations to get rid of holes in the face and some of the
%background

%binaryImg = inputImg;
binaryImg = imopen(binaryImg, strel('disk',12));
binaryImg = imclose(binaryImg, strel('disk',12)); 

binaryImg = imdilate(binaryImg, strel('disk',12));
binaryImg = imdilate(binaryImg, strel('disk',12));
binaryImg = imerode(binaryImg, strel('disk',12));
binaryImg = imerode(binaryImg, strel('disk',12));


end

