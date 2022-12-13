function [crop_img] = normalization_face(left_eye, right_eye, input_img)
%Normalize the images, rotation, scaling and same eye height

%% Find the distance between left and right eye
dist_eyes_x = abs(left_eye(1)-right_eye(1));
dist_eyes_y = abs(left_eye(2)-right_eye(2));
% Euclidian distance between two points
hypotenuse = hypot(dist_eyes_x, dist_eyes_y);

%% Find the angle between the eyes
angle_eye = 0;
if hypotenuse ~= 0
    angle_eye = rad2deg(acos(dist_eyes_x/hypotenuse));
end

%% Find the center of the image
[ty, tx, ~] = size(input_img); % [pixel in x, pixel in y, rgb]
x_center = tx/2;
y_center = ty/2;

% find the distance between the left eye and the center
dist_x = round(abs(x_center-left_eye(1)));
dist_y = round(abs(y_center-left_eye(2)));

%% Padding and translate
padd_img = padarray(input_img,[dist_x, dist_y],0,'both');
%translate the left eye to the center
translate_img =  imtranslate(padd_img, [dist_x, dist_y]);
%% Correct the eye position by rotation
if (left_eye(2) > right_eye(2)) %left eye is higher than right eye

    rotate_img = imrotate(translate_img,-angle_eye, 'bicubic');

else %right eye is higher than left eye
     
    rotate_img = imrotate(translate_img,angle_eye, 'bicubic');

end

%% Scale image to get same distance between the eyes
eye_dist = 115;
scale_fac = 0;
scale_img = rotate_img;

% Scale rotated image if dist is not equal 0
if dist_eyes_x ~= 0
    scale_fac = eye_dist/dist_eyes_x;
    scale_img  = imresize(rotate_img, scale_fac);
end

%calculate the new center point 
[ty_scaled, tx_scaled, ~] = size(scale_img); % [pixel in x, pixel in y, rgb]
x_center_scaled = tx_scaled/2;
y_center_scaled = ty_scaled/2;

% figure()
% imshow(scale_img)
% axis on;

% Draw rectangle on eyes
% rectangle('Position', [x_center_scaled-8, y_center_scaled-8, 16,16], 'EdgeColor', 'b', 'LineWidth', 2);
% rectangle('Position', [x_center_scaled+107, y_center_scaled-8, 16, 16], 'EdgeColor', 'b', 'LineWidth', 2);

%% Crop the image
margin_x = 40;
crop_img = imcrop(scale_img, [(x_center_scaled-margin_x) (y_center_scaled-60) eye_dist+2*margin_x 230]);

% figure
% imshow(crop_img)
% axis on;

