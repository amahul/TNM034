function [normImage] = normalization_face(left_eye, right_eye, inputImg)
%Normalize the images, rotation, scaling, tone-value and same eye height

%-----Article: Eiggenfaces_SVD_muller---------
% "one should ensure that the faces are normalized with 
% respect to position, size, orientation, and intensity. All faces must have the same
% size, be at the same angle (upright is most appropriate), and have the same lighting
% intensity, etc."

% % Find the distance between left and right eye
dist_eyes_x = abs(left_eye(1)-right_eye(1))
dist_eyes_y = abs(left_eye(2)-right_eye(2));
% Euclidian distance between two points
hypotenuse = hypot(dist_eyes_x, dist_eyes_y);


% Find the angle between the eyes
angleEye = rad2deg(acos(dist_eyes_x/hypotenuse));

%Padding the image
%imshow(paddImg);


%rectangle('Position', [left_eye(:,1), left_eye(:,2), 15,15], 'EdgeColor', 'b', 'LineWidth', 2);


% center image
size(inputImg)
[ty, tx, tz] = size(inputImg); % [pixel in x, pixel in y, rgb]
x_center = tx/2
y_center = ty/2

dist_x = round(abs(x_center-left_eye(1)))
dist_y = round(abs(y_center-left_eye(2)))

pos_eyeX = left_eye(1)
pos_eyeY = left_eye(2)



 paddImg = padarray(inputImg,[dist_x dist_y],0,'both'); %padding
 translate =  imtranslate(paddImg, [dist_x, dist_y]);

 %testImg = translate(x_center -10: x_center +10, y_center-10:y_center+10);
 
 %imshow(ty)

% rectangle('Position', [dist_x, dist_y, 10,10], 'EdgeColor','b', 'LineWidth', 2); %%cindy test: retangle
 %rectangle('Position', [left_eye(:,1), left_eye(:,2), 15,15], 'EdgeColor', 'b', 'LineWidth', 2);



% Correct the eye position 
if (left_eye(2) > right_eye(2)) %left eye is higher than right eye

    rotateImg = imrotate(translate,-angleEye, 'bicubic'); %rotate the padded image correct

else %right eye is higher than left eye
     
    rotateImg = imrotate(translate,angleEye, 'bicubic');

end


%Scale image to get same distance between the eyes
wanted_dist = 115;
%skalfaktor = dist_eyes_x/wanted_dist
skalfaktor = wanted_dist/dist_eyes_x
scaledImg  = imresize(rotateImg, skalfaktor);

%Crop image
%croppedImg = imcrop(rotateImg, [250 350 250 300]);
croppedImg = imcrop(scaledImg, [(x_center+20-25) (y_center-50) ( wanted_dist+20-25) 300]);
%croppedImg = imcrop(rotateImg, [213-50 213-50 213+115+50 100])

normImage = croppedImg;
%normImage = croppedImg;
imshow(normImage);
%imshow(inputImg);

% mark the center of image
%rectangle('Position', [x_center, y_center + dist_x, 115,15], 'EdgeColor', 'b', 'LineWidth', 2);


axis on;







%rotate the image so that the eyes are at equal height

%Find what angle we should rotate
%Hitta x-avståndet mellan ögonen
    %(a) distance_in_x = eyeLeft(x-pos) - eyeRight(x-pos)
%Hitta y-avståndet mellan ögonen
    %(b) distance_in_y = eyeLeft(y-pos) - eyeRight(y-pos)

%Hitta hypotenusan för att få en triangel
    %(h) hypo = hypot(a, b);
%Använd trig-funktion för att få fram vinkeln
    %rotation_angle = arcsin(b/h);

%if left eye is higher than right eye: 
    %rotate coutner-clockwise
%else if right eye is higher than left eye
    %rotate clockwise


%Crop the image so that the eyes are at the same position
%crop_im = crop_face(right_eye, left_eye, inputImg);



end