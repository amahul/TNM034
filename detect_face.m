function [eye_centers, mouth_center] = detect_face(I)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[mm] = mouth_map(I);
% figure()
% imshow(mm);

mask_im = hybrid_eye(I);
% figure()
% imshow(mask_im);
%% Remove all white objects outside face mask on eye_map and mouth_map
face_mask_res = face_mask(I);
face_mask_inverse = imcomplement(face_mask_res);
% figure()
% imshow(face_mask_inverse);

eye_diff = mask_im - face_mask_inverse;
class(mm)
class(face_mask_inverse)
mouth_diff = double(mm) - face_mask_inverse;
% figure()
% imshow(mouth_diff);

%% Get information about white objects

figure()
eye_props = regionprops(logical(eye_diff),'centroid', 'MajoraxisLength', 'MinoraxisLength');

mouth_props = regionprops(logical(mouth_diff),'centroid', 'MajoraxisLength', 'MinoraxisLength');

% imshow(eye_diff);

[eye_centers, mouth_center] = face_boundary(eye_props, mouth_props);

end
