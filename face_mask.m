function [binaryImg] = faceMask(inputImg)
%funkar inte helt, den får med bakgrunden i vissa bilder

%to binary image
%binaryImg= zeros(256);
binaryImg = zeros(size(inputImg, 1), size(inputImg,2));

%Convert image from RGB to YCbCr
YCbCr_img = rgb2ycbcr(inputImg);

%split the image into Y, Cb and Cr channels.
Y = YCbCr_img(:,:,1);
Cb = YCbCr_img(:,:,2);
Cr = YCbCr_img(:,:,3);


%Från lecture, 77 ≤ Cb ≤ 127 snd 133 ≤ Cr ≤ 173, Y illumination
[row, col] = find(Cb>=85 & Cr>=135 & Y >= 80);

%Mark the skin to white
for n=1:size(row)
    binaryImg(row(n), col(n))= 1;
end

%Morphological operations gets rid of the holes in the face and some of the
%background

%binaryImg = inputImg;

se = strel('disk',12);
binaryImg = imopen(binaryImg, se);
binaryImg = imclose(binaryImg, se); 
 
binaryImg = imdilate(binaryImg, se);
binaryImg = imdilate(binaryImg, se);
binaryImg = imerode(binaryImg, se);
binaryImg = imerode(binaryImg, se);

imshow(binaryImg);
end

