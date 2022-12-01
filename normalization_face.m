function [norm_image] = normalization_face(input_img)
%Normalize the images, rotation, scaling, tone-value and same eye height
[eye_centers, mouth_center] = detect_face(input_img);
eye_left = eye_centers(1,:);
eye_right = eye_centers(2,:);

rotated_img = rotation(input_img, eye_left, eye_right);

norm_image = rotated_img;
%Crop the image so that the eyes are at the same position



end