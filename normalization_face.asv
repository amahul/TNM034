function [crop_img] = normalization_face(left_eye, right_eye, inputImg)
%Normalize the images, rotation, scaling, tone-value and same eye height

% % Find the distance between left and right eye
dist_eyes_x = abs(left_eye(1)-right_eye(1));
dist_eyes_y = abs(left_eye(2)-right_eye(2));
% Euclidian distance between two points
hypotenuse = hypot(dist_eyes_x, dist_eyes_y);


% Find the angle between the eyes
angleEye = rad2deg(acos(dist_eyes_x/hypotenuse));

%center image
size(inputImg)
[ty, tx, ~] = size(inputImg); % [pixel in x, pixel in y, rgb]
x_center = tx/2;
y_center = ty/2;

dist_x = round(abs(x_center-left_eye(1)));
dist_y = round(abs(y_center-left_eye(2)));

% pos_eyeX = left_eye(1)
% pos_eyeY = left_eye(2)

paddImg = padarray(inputImg,[dist_x, dist_y],0,'both'); %padding
translate_img =  imtranslate(paddImg, [dist_x, dist_y]);
% imshow(translate_img)


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

[ty_scaled, tx_scaled, ~] = size(scale_img); % [pixel in x, pixel in y, rgb]
x_center_scaled = tx_scaled/2;
y_center_scaled = ty_scaled/2;

% Draw rectangle on eyes
rectangle('Position', [x_center_scaled-8, y_center_scaled-8, 16,16], 'EdgeColor', 'b', 'LineWidth', 2);
rectangle('Position', [x_center_scaled+107, y_center_scaled-8, 16, 16], 'EdgeColor', 'b', 'LineWidth', 2);

%Crop image
margin_x = 40;
crop_img = imcrop(scale_img, [(x_center_scaled-margin_x) (y_center_scaled-60) eye_dist+2*margin_x 230]);

% figure
% imshow(crop_img)
% axis on;

