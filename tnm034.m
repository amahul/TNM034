function id = tnm034(im)
%% Load data from files
avg_face = load('average_face.mat');
avg_face = cell2mat(struct2cell(avg_face));
u = load('eigen_face.mat');
u = cell2mat(struct2cell(u));
weights = load('weight.mat');
weights = cell2mat(struct2cell(weights));

%% Call face detection functions
eye_position = detect_face(im);

left_eye = eye_position(1,:);
right_eye = eye_position(2,:);

cropped = normalization_face(left_eye, right_eye, im);
cropped = im2double(cropped);

%% Calculate weight for input image and identify correct
diff = rgb2gray(cropped) - avg_face;
% figure
% imshow(diff)
diff = reshape(diff, [], 1);

input_weight = u'*diff;

% Loop through training data and find id with smallest weight difference
min_diff = Inf;
id = 0;
for i = 1:16
    weight_diff = abs(norm(input_weight - weights(:,i)));
    
    if weight_diff < min_diff
        min_diff = weight_diff;
        id = i;
    end 
end

% disp("Identification: " + id)
% disp("minimun weight: " + min_diff)

% Return 0 if weight difference is larger than threshold
threshold = 0.03
if min_diff > threshold
    id = 0;

end