function [eyes, mouth] = face_boundary(eye_props, mouth_props)

% 1. Check for luma variations and average gradient
% 2. Geometry and orientation of the triangle
% 3. The presence of a face boundary around thetriangle

eye_centers = cat(1, eye_props.Centroid);
mouth_centers = cat(1, mouth_props.Centroid);

n_eyes = size(eye_centers,1);
n_mouths = size(mouth_centers, 1);

min_y = Inf; % to keep track of smallest y
eyes = zeros(2);
% If we have more than 2 eye candidates
if(n_eyes > 2)
    % Loop through eye candidates
    for i = 1:n_eyes
        for j = i+1:n_eyes
            y1 = eye_centers(i,2);
            y2 = eye_centers(j,2);

            % Find eyes with minimal difference in y
            if(abs(y1-y2) < min_y)
                min_y = abs(y1-y2);
                eyes(1,:) = eye_centers(i,:);
                eyes(2,:) = eye_centers(j,:);
                
            end
          
        end
    end
else
    eyes = eye_centers;
end

% Sort eyes so left eye is first
eyes = sortrows(sort(eyes,1));


% Variables for finding the mouth that is closest to 
% x-coordinate between eyes
min_diff = Inf;

% Save eye variables
y1_eye = eye_centers(1,2);
y2_eye = eye_centers(2,2);
x1_eye = eye_centers(1,1); % left eye
x2_eye = eye_centers(2,1); % right eye
between_eyes = (x1_eye+x2_eye)/2;
if(n_mouths > 1)
    for j = 1:n_mouths
        x_mouth = mouth_centers(i:1);
        y_mouth = mouth_centers(i,2);
       
        
        % Only keep mouth with y-value smaller than eyes
        % and x-value between eyes x-value
        if(y_mouth > y1_eye && y_mouth > y2_eye)
            if(x_mouth > x1_eye && x_mouth < x2_eye)
                
                diff = abs(between_eyes-x_mouth);
                if(diff < min_diff)
                    min_diff = diff;
                    mouth = mouth_centers(i,:);
                end
            end        
        end
    
        % one eye to the right of the mouth and one to the left            
        
        % y coordinate for mouth should be under eyes
            
    end
else
    mouth = mouth_centers(1,:);
end





