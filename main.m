img=imread("images/DB0/db0_3.jpg");
% imshow(img)

% [mm, mc] = mouth_map(img);
% figure();
% imshow(mm);
% 
% mask_im = hybrid_eye(img);
% 
% face_mask = face_mask(img);
% figure();
% imshow(face_mask);

detect_face(img);


