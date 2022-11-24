%img=imread("images/DB0/db0_1.jpg");

img=imread("images/DB2/il_09.jpg");
% imshow(img)

mm1 = mouth_map(img);

% figure();
% imshow(mm);
% 
% mask_im = hybrid_eye(img);
% 
% face_mask = face_mask(img);
% figure();
% imshow(face_mask)
% ;

detect_face(img);


