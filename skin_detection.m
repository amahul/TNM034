function skin_image = skin_detection(input_img)
% Function to get a facemask with skin color

% Binary Image
binary_img = face_mask(input_img);

%Multiplying the binary image with the original image
skin_image = binary_img.*im2double(input_img);

end




