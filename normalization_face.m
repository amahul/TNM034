function [normImage] = normalization_face(inputImg)
%Normalize the images, rotation, scaling, tone-value and same eye height


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