function [out_image_colour] = eye_map_colour(in_image)

%Test
%in_image = imread("image_0253.jpg");

gray_im = rgb2gray(in_image);
gray_im = histeq(gray_im);

out_image_colour = gray_im > 20;

