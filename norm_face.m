function [normImage] = norm_face(left_eye, right_eye, input_img)

%size(rotate_img);
[ty, tx, ~] = size(input_img); % [pixel in x, pixel in y, rgb]
x_center = tx/2;
y_center = ty/2;

%both coord
left = left_eye
right = right_eye
middle_eye = (left(:) + right(:)).'/2;

%spec coord
middle_eye_x = middle_eye(:,1)
middle_eye_y = middle_eye(:,2)

%translation distance
dist_x = round(abs(x_center-middle_eye_x))
dist_y = round(abs(y_center-middle_eye_y))

%Find the distance between right and middle
dist_eyes_x = abs(middle_eye_x-right_eye(1));
dist_eyes_y = abs(middle_eye_y-right_eye(2));

center_img = imtranslate(input_img,[dist_x, dist_y]);
figure()
imshow(center_img)
axis on;

%Euclidian distance between two points
hypotenuse = hypot(dist_eyes_x, dist_eyes_y);

%Find the angle between the eyes
angleEye = rad2deg(acos(dist_eyes_x/hypotenuse));

%Correct the eye position 
if (middle_eye_y > right_eye(2)) %left eye is higher than right eye
    rotate_img = imrotate(center_img,-angleEye, 'bicubic'); %rotate the padded image correct
else %right eye is higher than left eye 
    rotate_img = imrotate(center_img,angleEye, 'bicubic');
end
figure()
imshow(rotate_img)
axis on;

%Scale image to get same distance between the eyes //needs work
eye_dist = 80;
%skalfaktor = dist_eyes_x/wanted_dist
scale_fac = eye_dist/dist_eyes_x;
scale_img  = imresize(rotate_img, scale_fac);

figure()
imshow(scale_img)
axis on;

%Crop image
target_size = [400 300];
window = centerCropWindow2d(size(scale_img),target_size);
crop_img = imcrop(scale_img,window);

figure()
imshow(crop_img)
axis on;

normImage = crop_img;


