function [res] = face_boundary(eye_props, mouth_props)

% 1. Check for luma variations and average gradient
% 2. Geometry and orientation of the triangle
% 3. The presence of a face boundary around thetriangle

eye_centers = cat(1, eye_props.Centroid);
mouth_centers = cat(1, mouth_props.Centroid);

n_eyes = size(eye_centers,1);
n_mouths = size(mouth_centers, 1);

for i = 1:n_eyes
    for j = 1:n_mouths
        
        
    end
end


