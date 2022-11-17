%function [hybrid_image] = hybrid_eye(in_image)

% Test
%in_image = imread("images/DB1/db1_05.jpg");

out_image_illum = eye_map(in_image);
out_image_colour = eye_map_colour(in_image);
out_image_edge = eye_map_edge(in_image);

%Eye blob rules 
out_image_illum = eye_rules(out_image_illum);
out_image_colour = eye_rules(out_image_colour);
out_image_edge = eye_rules(out_image_edge);

%Combine images after rules have been applied
ill_and_colour = out_image_illum & out_image_colour;
ill_and_edge = out_image_illum & out_image_edge;
colour_and_edge = out_image_colour & out_image_edge;

hybrid_image = ill_and_colour | ill_and_edge | colour_and_edge;

%imshow(hybrid_image)