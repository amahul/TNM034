function [normImage] = normalization_face(left_eye, right_eye, inputImg)
%Normalize the images, rotation, scaling, tone-value and same eye height

%-----Article: Eiggenfaces_SVD_muller---------
% "one should ensure that the faces are normalized with 
% respect to position, size, orientation, and intensity. All faces must have the same
% size, be at the same angle (upright is most appropriate), and have the same lighting
% intensity, etc."

% % Find the distance between left and right eye
deltaX = abs(left_eye(1)-right_eye(1));
deltaY = abs(left_eye(2)-right_eye(2));
% Euclidian distance between two points
hypotenuse = hypot(deltaX, deltaY);


% Find the angle between the eyes
angleEye = rad2deg(acos(deltaX/hypotenuse));

%Padding the image
%imshow(paddImg);

% Center the image

%rectangle('Position', [left_eye(:,1), left_eye(:,2), 15,15], 'EdgeColor', 'b', 'LineWidth', 2);
rectangle('Position', [left_eye(:,1), left_eye(:,2), 100,10], 'EdgeColor', 'b', 'LineWidth', 2);


% Correct the eye position 
if (left_eye(2) > right_eye(2)) %left eye is higher than right eye

    paddImg = padarray(inputImg,[10 10],0,'both'); %padding
    rotateImg = imrotate(paddImg,-angleEye, 'bicubic'); %rotate
    %centerPosition = left_eye + [hypotenuse/2,0];
    centerPosition = deltaX/2;


else %right eye is higher than left eye
   
    paddImg = padarray(inputImg,[10 10],0,'both');
    rotateImg = imrotate(paddImg,angleEye, 'bicubic');
    %centerPosition = left_eye + [hypotenuse/2,0];
    centerPosition = deltaX/2;

end

normImage = rotateImg;
imshow(normImage);








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
crop_im = crop_face(right_eye, left_eye, inputImg);



end