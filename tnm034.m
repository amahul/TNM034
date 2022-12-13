function id = tnm034(im)

% im: Image of unknown face, RGB-image in uint8 format in the
% range [0,255]
%
% id: The identity number (integer) of the identified person,
% i.e. ‘1’, ‘2’,…,‘16’ for the persons belonging to ‘db1’
% and ‘0’ for all other faces

%% Load data from files
avg_face = load('average_face.mat');
avg_face = cell2mat(struct2cell(avg_face));
u = load('eigen_face.mat');
u = cell2mat(struct2cell(u));
% u = reshape(u, [231 196 16]);

weights = load('weight.mat');
weights = cell2mat(struct2cell(weights));

%% commment here
eye_position = detect_face(im);

left_eye = eye_position(1,:);
right_eye = eye_position(2,:);

cropped = normalization_face(left_eye, right_eye, im);
cropped = im2double(cropped);

% figure()
% imshow(avg_face)
diff = rgb2gray(cropped) - avg_face;
figure
imshow(diff)
diff = reshape(diff, [], 1);

input_weight = u'*diff;

min_diff = Inf;
id = 0;
for i = 1:16
    weight_diff = abs(norm(input_weight - weights(:,i)));
    
    if weight_diff < min_diff
        min_diff = weight_diff;
        id = i;
    end
    
end

disp("Identification: " + id)
disp("minimun weight: " + min_diff)

threshold = 0.03
if min_diff > threshold
    id = 0


% identify correct face


end