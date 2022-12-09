% function id = tnm034(im)

im = imread("images/DB1/db1_01.jpg");

% im: Image of unknown face, RGB-image in uint8 format in the
% range [0,255]
%
% id: The identity number (integer) of the identified person,
% i.e. ‘1’, ‘2’,…,‘16’ for the persons belonging to ‘db1’
% and ‘0’ for all other faces

avg_face = load('average_face.mat');
avg_face = cell2mat(struct2cell(avg_face));
u = load('eigen_face.mat');
u = cell2mat(struct2cell(u));

eye_position = detect_face(im);

left_eye = eye_position(1,:);
right_eye = eye_position(2,:);

norm_img = normalization_face(left_eye, right_eye, im);
norm_img = rgb2gray(im2double(norm_img));

% figure()
% imshow(avg_face)
diff = norm_img - avg_face;
figure
imshow(diff)

weight = u'*diff;

% identify correct face
id = 0

end