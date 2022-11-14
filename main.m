img=imread("images/DB1/db1_01.jpg");
% imshow(img)

[mm, mc] = mouth_map(img);
figure();
imshow(mm);

mask_im = hybrid_eye(img);

face_mask = faceMask(img);
figure();
imshow(face_mask);

