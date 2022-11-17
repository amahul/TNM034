function skinImage = skinDetection(inputImg)
% Function to get a facemask with skin color

binaryImg = face_mask(inputImg);

%Multiplying the binary image with the original image
test = binaryImg.*im2double(inputImg);

skinImage = inputImg;

imshow(test);

end