function [normImage] = normalization_face(left_eye, right_eye, inputImg)
%Normalize the images, rotation, scaling, tone-value and same eye height
[eye_centers, mouth_center] = detect_face(inputImg);
% eye_left = eye_centers(1,:);
% eye_right = eye_centers(2,:);

%-----Article: Eiggenfaces_SVD_muller---------
% "one should ensure that the faces are normalized with 
% respect to position, size, orientation, and intensity. All faces must have the same
% size, be at the same angle (upright is most appropriate), and have the same lighting
% intensity, etc."

% % Find the distance between left and right eye
dist_eyes_x = abs(left_eye(1)-right_eye(1));
dist_eyes_y = abs(left_eye(2)-right_eye(2));
% Euclidian distance between two points
hypotenuse = hypot(dist_eyes_x, dist_eyes_y);


% Find the angle between the eyes
angleEye = rad2deg(acos(dist_eyes_x/hypotenuse));

%Padding the image
%imshow(paddImg);


%rectangle('Position', [left_eye(:,1), left_eye(:,2), 15,15], 'EdgeColor', 'b', 'LineWidth', 2);


%center image
size(inputImg)
[ty, tx, ~] = size(inputImg); % [pixel in x, pixel in y, rgb]
x_center = tx/2;
y_center = ty/2;

dist_x = round(abs(x_center-left_eye(1)));
dist_y = round(abs(y_center-left_eye(2)));
% 
% pos_eyeX = left_eye(1)
% pos_eyeY = left_eye(2)
% 


paddImg = padarray(inputImg,[dist_x, dist_y],0,'both'); %padding
translate_img =  imtranslate(paddImg, [dist_x, dist_y]);
% imshow(translate_img)

 %testImg = translate(x_center -10: x_center +10, y_center-10:y_center+10);
 
 %imshow(ty)

% rectangle('Position', [dist_x, dist_y, 10,10], 'EdgeColor','b', 'LineWidth', 2); %%cindy test: retangle
 %rectangle('Position', [left_eye(:,1), left_eye(:,2), 15,15], 'EdgeColor', 'b', 'LineWidth', 2);



% Correct the eye position 
if (left_eye(2) > right_eye(2)) %left eye is higher than right eye

    rotate_img = imrotate(translate_img,-angleEye, 'bicubic'); %rotate the padded image correct

else %right eye is higher than left eye
     
    rotate_img = imrotate(translate_img,angleEye, 'bicubic');

end

% imshow(rotate_img)

%Scale image to get same distance between the eyes
eye_dist = 115;
%skalfaktor = dist_eyes_x/wanted_dist
scale_fac = eye_dist/dist_eyes_x;
scale_img  = imresize(rotate_img, scale_fac);

figure()
imshow(scale_img)
axis on;

%Crop image

crop_img = imcrop(scale_img, [(x_center+30) (y_center-100) (eye_dist+100) 290]);

figure
imshow(crop_img)
axis on;

% normImage = scaledImg;
%normImage = crop_img;

% imshow(normImage);
% %imshow(inputImg);

% mark the center of image
%rectangle('Position', [x_center, y_center + dist_x, 115,15], 'EdgeColor', 'b', 'LineWidth', 2);

% norm_image = rotated_img;
%Crop the image so that the eyes are at the same position
%crop_im = crop_face(right_eye, left_eye, inputImg);

