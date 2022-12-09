function [eye_centers, mouth_center] = detect_face(I)
%% Call functions to find mouth and eyes in input image
mm = mouth_map(I);
mask_im = hybrid_eye(I);

%% Remove all white objects outside face mask on eye_map and mouth_map

% Get face mask from face_mask function
face_mask_res = face_mask(I);
face_mask_inverse = imcomplement(face_mask_res);
figure()
imshow(face_mask_res)

% Remove all objects from eye map that is outside face mask
eye_diff = imbinarize(mask_im - face_mask_inverse);
[nrows, ~] = size(eye_diff);

% Remove all objects in the 2/3 part below in image (false candidates)
eye_diff(2/3*nrows:nrows,:) = 0; 

% Remove small objects
eye_diff = bwareaopen(eye_diff,30); 

% Keep only 3 largest objects
eye_diff = bwareafilt(eye_diff, 3); 

% Remove all objects from mouth map that is outside face mask
mouth_diff = imbinarize(mm - face_mask_inverse);

%% Get information about white objects

eye_props = regionprops(eye_diff,'centroid', 'MajoraxisLength', 'MinoraxisLength', 'Orientation');

mouth_props = regionprops(mouth_diff,'centroid', 'MajoraxisLength', 'MinoraxisLength', 'Orientation');

%% Call face boundare to eliminate all false candidates

[eye_centers, mouth_center] = face_boundary(eye_props, mouth_props);

%% DEBUG: Print eyes on input image

% figure()
% imshow(I);
% rectangle('Position', [eye_centers(1,1), eye_centers(1,2), 15, 15], 'EdgeColor', 'b', 'LineWidth', 2);
% rectangle('Position', [eye_centers(2,1), eye_centers(2,2), 15, 15], 'EdgeColor', 'b', 'LineWidth', 2);


end
