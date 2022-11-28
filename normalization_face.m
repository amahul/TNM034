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









end