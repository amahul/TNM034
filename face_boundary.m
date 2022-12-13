function [eyes, mouth] = face_boundary(eye_props, mouth_props)
%% Save variables from regionprops

eye_centers = cat(1, eye_props.Centroid);
mouth_centers = cat(1, mouth_props.Centroid);
mouth_orientations = cat(1, mouth_props.Orientation);

%% Pick a mouth candidate depending on orientation of objects
min_orientation_diff = Inf;
mouth_index = 0;
mouth = zeros(1,2);
if(size(mouth_props,1) >= 1)
    for i = 1:size(mouth_props,1)
        diff = abs(mouth_orientations(i));
        % Save mouth with orientation closest to 0 (horizontal)
        if(diff < min_orientation_diff)
            min_orientation_diff = diff;
            mouth = mouth_centers(i,:);
            mouth_index = i;
        end
    end
end

%% DEBUG: Print rectangle for mouth on original image
% x_length = x_lengths(mouth_index);
% y_length = y_lengths(mouth_index);
m_center = mouth_centers(mouth_index,:);
x_length = mouth_props.MajorAxisLength;
y_length = mouth_props.MinorAxisLength;
% 
% figure()
% imshow(I);
% rectangle('Position', [m_center(1)-x_length/2, m_center(2)-y_length/2, x_length, y_length], 'EdgeColor', 'b', 'LineWidth', 2);

%% Find values for all eye_candidates 
n_eyes = size(eye_centers,1);

% Empty variables
dist_eyes = zeros(n_eyes,1); 
eyes = zeros(2);
eye_candidates = zeros(2,2,n_eyes);
index = 0;

% Save center of mouth to variables
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
            
            % Save pair of eyes 
            eye_pairs = [x1 y1; x2 y2];
            
            % Only saves eyes with smaller y-value than mouth
            % and one eye on both sides of mouth
            if(y_mouth > y1 && y_mouth > y2)                
                if(x1 < x_mouth && x_mouth < x2)

                    % Save all confirmed eye pair to eye candidates
                    index = index + 1;
                    eye_candidates(:,:,index) = eye_pairs;                                                           
                    dist_eyes(index) = sqrt((x1-x2)^2+(y1-y2)^2);   
                end
            end 
        end
    end
else
    if n_eyes < 2
        eyes(1,:) = eye_centers; % Only one eye pair candidate
    else
        eyes = eye_centers; % Only one eye pair candidate
    end
end


%% Save only 2 eye candidates

min_dist = Inf;
if(n_eyes > 2)
    for i = 1:index
        y1 = eye_candidates(1,2,i);
        y2 = eye_candidates(2,2,i);
        x1 = eye_candidates(1,1,i);
        x2 = eye_candidates(2,1,i);

        % Dist between mouth and both eyes
        dist1 = sqrt((x1-x_mouth)^2+(y_mouth-y1)^2);
        dist2 = sqrt((x2-x_mouth)^2+(y_mouth-y2)^2);

        % Find minimun dist difference between mouth and eyes
        % Distance between eyes should be smaller than 1.5 times the 
        % distance between eye and mouth (1.5 is tested and gave the best result)
        if abs(dist1-dist2) < min_dist && dist1 < 1.5*dist_eyes(i) && dist2 < 1.5*dist_eyes(i)         
%         if abs(dist1-dist2) < min_dist && dist_eyes(i) < dist1 && dist_eyes(i) < dist2 && dist1 < 1.5*dist_eyes(i) && dist2 < 1.5*dist_eyes(i)         
            min_dist = abs(dist1-dist2);            
            eyes = eye_candidates(:,:,i);
        end
    end
end