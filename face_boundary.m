function [eyes, mouth] = face_boundary(eye_props, mouth_props, I)
% 1. Check for luma variations and average gradient
% 2. Geometry and orientation of the triangle
% 3. The presence of a face boundary around thetriangle
%% Save variables from regionprops
eye_centers = cat(1, eye_props.Centroid);
mouth_centers = cat(1, mouth_props.Centroid);
mouth_orientations = cat(1, mouth_props.Orientation);
x_lengths = cat(1,mouth_props.MajorAxisLength);
y_lengths = cat(1,mouth_props.MinorAxisLength);

% avståndet från mun till båda ögon ska vara lika
% Avståndet mellan mun och ögon ska vara större än mellan ögonen
%% Pick a mouth candidate depending on orientation of objects
min_orientation_diff = Inf;
mouth_index = 0;
for i = 1:size(mouth_props,1)
    diff = abs(mouth_orientations(i));
    if(diff < min_orientation_diff)
        min_orientation_diff = diff;
        mouth = mouth_centers(i,:);
        mouth_index = i;
    end
end

%% Print rectangle for mouth on original image
x_length = x_lengths(mouth_index);
y_length = y_lengths(mouth_index);
m_center = mouth_centers(mouth_index,:);

figure()
imshow(I);
rectangle('Position', [m_center(1), m_center(2),2, 2], 'EdgeColor', 'b', 'LineWidth', 2);

%% Find values for all eye_candidates 
n_eyes = size(eye_centers,1);

dist_eyes = zeros(n_eyes,1); % Kanske byta ut n_eyes
dist_em_1 = zeros(n_eyes,1);
dist_em_2 = zeros(n_eyes,1);
eyes = zeros(2);
eye_candidates = zeros(2,2,n_eyes);
index = 0;
x_mouth = m_center(1);
y_mouth = m_center(2);
% If we have more than 2 eye candidates
if(n_eyes > 2)
    % Loop through eye candidates
    for i = 1:n_eyes
        for j = i+1:n_eyes

            y1 = eye_centers(i,2);
            y2 = eye_centers(j,2);
            x1 = eye_centers(i,1);
            x2 = eye_centers(j,1);

            tempeyes = [x1 y1; x2 y2];
            
            % Only saves eyes with smaller y-value than mouth
            % and one eye on both sides of mouth
%             disp("Y_mouth: " + y_mouth + " y1: " + y1 + " y2: " + y2)            
            if(y_mouth > y1 && y_mouth > y2)                
%                 disp("X_mouth: " + x_mouth + " x1: " + x1 + " x2: " + x2)
                if(x1 < x_mouth && x_mouth < x2)
                    % Save variables to keep track
                    index = index + 1;
%                     disp("Added ")
                    tempeyes
                    eye_candidates(:,:,index) = tempeyes;                    
                                       
%                     dist_eyes(index) = abs(x1-x2);
                    dist_eyes(index) = sqrt((x1-x2)^2+(y1-y2)^2);
%                     dist_em_1(index) = sqrt((x1-x_mouth)^2+(y_mouth-y1)^2);
%                     dist_em_2(index) = sqrt((x2-x_mouth)^2+(y_mouth-y2)^2);

                    % Calculate angles of triangle
%                     v1 = mouth-eyes(2,:) % Mouth to left eye
%                     v2 = mouth-eyes(1,:) % Mouth to right eye
%                     v3 = eyes(1,:)-eyes(2,:) % Eye to eye

                    
                end
            end 
        end
    end
else
    eyes = eye_centers;
end
% dist_em_1
% dist_em_2


%% Save only 2 eye candidates
min_dist = Inf;
if(n_eyes > 2)
    for i = 1:index
        y1 = eye_candidates(1,2,i);
        y2 = eye_candidates(2,2,i);
        x1 = eye_candidates(1,1,i);
        x2 = eye_candidates(2,1,i);

        dist1 = sqrt((x1-x_mouth)^2+(y_mouth-y1)^2);
        dist2 = sqrt((x2-x_mouth)^2+(y_mouth-y2)^2);
%         for j = i:index
%             dist1 =  dist_em_1(i);
%             dist2 =  dist_em_2(j);
%             disp("Dist1: " + dist1 + " Dist2: " + dist2)
%             disp("Dist between em1 em2: " + abs(dist1-dist2))
%             disp("Dist_eyes " + dist_eyes(i))

            % Find minimun dist difference between em_1 and em_2
            % Distance between eyes should be smaller than distance between
            % eye and mouth
        if abs(dist1-dist2) < min_dist && dist_eyes(i) < dist1 && dist_eyes(i) < dist2 && dist1 < 1.5*dist_eyes(i) && dist2 < 1.5*dist_eyes(i)         
            disp("Dist diff: " + abs(dist1-dist2));
            min_dist = abs(dist1-dist2);
            
            eyes = eye_candidates(:,:,i);
        end
%         end
    end

end

% Sort eyes so left eye is first
% eyes = sortrows(sort(eyes,)
rectangle('Position', [eyes(1,1)-8, eyes(1,2)-8, 16, 16], 'EdgeColor', 'b', 'LineWidth', 2);
rectangle('Position', [eyes(2,1)-8, eyes(2,2)-8, 16, 16], 'EdgeColor', 'b', 'LineWidth', 2);
%% Find eye candidates
% % Save eye variables
% y1_eye = eye_centers(1,2);
% y2_eye = eye_centers(2,2);
% x1_eye = eye_centers(1,1); % left eye
% x2_eye = eye_centers(2,1); % right eye