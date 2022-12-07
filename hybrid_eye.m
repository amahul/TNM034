function [hybrid_image] = hybrid_eye(in_image)

% Test
%in_image = imread("images/DB1/db1_10.jpg");
% in_image = white_patch(in_image);

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
hybrid_image = bwareafilt(hybrid_image, 8);

figure();
imshow(hybrid_image);

%info = regionprops(hybrid_image,'Boundingbox') ;

% hold on
% for k = 1 : length(info)
%      BB = info(k).BoundingBox;
%      rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','r','LineWidth',2) ;
% end


