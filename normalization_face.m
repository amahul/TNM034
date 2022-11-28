function [normImage] = normalization_face(left_eye, right_eye, inputImg)
%Normalize the images, rotation, scaling, tone-value and same eye height

%-----Article: Eiggenfaces_SVD_muller---------
% "one should ensure that the faces are normalized with 
% respect to position, size, orientation, and intensity. All faces must have the same
% size, be at the same angle (upright is most appropriate), and have the same lighting
% intensity, etc."

% Find the distance between left and right eye
deltaX = left_eye(1)-right_eye(1);
deltaY = left_eye(2)-right_eye(2);
% Euclidian distance between two points
hypotenuse = hypot(deltaX, deltaY);

% Find the angle between the eyes
angleEye = rad2deg(acos(deltaE/hypotenuse));


% Correct the eye position 

if (left_eye(2) > right_eye(2))


else

end







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




end