function [res] = detect_face(I)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[mm, mc] = mouth_map(I);
figure()
imshow(mm);

mask_im = hybrid_eye(I);
figure()
imshow(mask_im);

face_mask_res = face_mask(I);
face_mask_inverse = imcomplement(face_mask_res);
figure()
imshow(face_mask_inverse);

% Removes all white objects outside face mask
eye_diff = mask_im - face_mask_inverse;
mouth_diff = mm - face_mask_inverse;
figure()
imshow(mouth_diff);

figure()
imshow(eye_diff);
res = "temp";

end