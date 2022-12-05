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

eye_diff = imbinarize(mask_im - face_mask_inverse);
eye_diff = bwareaopen(eye_diff,30)
eye_diff = bwareafilt(eye_diff, 7);

% figure()
% imshow(eye_diff)
axis on
mouth_diff = imbinarize(mm - face_mask_inverse);
% figure()
% imshow(mouth_diff);

%% Get information about white objects

eye_props = regionprops(eye_diff,'centroid', 'MajoraxisLength', 'MinoraxisLength', 'Orientation');

mouth_props = regionprops(mouth_diff,'centroid', 'MajoraxisLength', 'MinoraxisLength', 'Orientation');

% imshow(eye_diff);

[eye_centers, mouth_center] = face_boundary(eye_props, mouth_props, I);

% figure()
% imshow(I);
% rectangle('Position', [eye_centers(1,1), eye_centers(1,2), 15, 15], 'EdgeColor', 'b', 'LineWidth', 2);
% rectangle('Position', [eye_centers(2,1), eye_centers(2,2), 15, 15], 'EdgeColor', 'b', 'LineWidth', 2);


end
