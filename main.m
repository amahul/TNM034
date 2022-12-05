img=imread("images/DB1/db1_09.jpg");

size(img)
% imshow(img)

% mm1 = mouth_map(img);
% 
% figure();
% imshow(mm1);
% 
% mask_im = hybrid_eye(img);
% 
% face_mask = face_mask(img);
% figure();
% imshow(face_mask);

detect_face(img);