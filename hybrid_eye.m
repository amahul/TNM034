function [hybrid_image] = hybrid_eye(in_image)

% Test
%in_image = imread("images/DB2/bl_14.jpg");

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

% x_low = 1;
% y_low = 2;
% x_high = 6;
% y_high = 8;
% axis([0 10 0 10]);  
% rectangle('Position',[x_low y_low (x_high-x_low) (y_high-y_low)]);

% out_image_illum = logical(out_image_illum);
% 
% out_image_illum = bwareafilt(out_image_illum,2);

% % Find center and width of white area
% props = regionprops(out_image_illum,'centroid', 'MajoraxisLength', 'MinoraxisLength');
% x_length = props.MajorAxisLength;
% y_length = props.MinorAxisLength;
% m_center = props.Centroid;
% 
% % Draw image with rectangle
% %m_center = round(props.Centroid);
% figure()
% imshow(hybrid_image);
% rectangle('Position', [m_center(1)-x_length/2, m_center(2)-y_length/2, x_length, y_length], 'EdgeColor', 'b', 'LineWidth', 2);

info = regionprops(hybrid_image,'Boundingbox') ;
imshow(hybrid_image);
bwareafilt(hybrid_image, 5);
hold on
for k = 1 : length(info)
     BB = info(k).BoundingBox;
     rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','r','LineWidth',2) ;
end

