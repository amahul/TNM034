function [out_image_edge] = eye_map_edge(in_image)

%Test
%in_image = imread("image_0253.jpg");

gray_im = rgb2gray(in_image);
%Sobel can detect edges
sobel_im = edge(gray_im, 'sobel');

SE = strel('disk', 4);  

%Dilation twice to enhance the conected regions
edge_im = imdilate(sobel_im,SE);
edge_im = imdilate(edge_im,SE);

%Erosion three times to get rid of unwanted connected regions
edge_im = imerode(edge_im,SE);
edge_im = imerode(edge_im,SE);
out_image_edge = imerode(edge_im,SE);

imshow(out_image_edge)



