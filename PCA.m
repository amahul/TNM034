function[i] = PCA()

%1 Collect faces for training

images = dir("images/DB1/*.jpg");

%1 Normalization function
for i = 1:length(images)
    img = imread("images/DB1/" + images(i).name);
 
    [eye_centers, ~] = detect_face(img);
    left_eye = eye_centers(1,:);
    right_eye = eye_centers(2,:);

    %Normalize face
    %find eye coordinates for left and right
    norm_face = normalization_face(left_eye, right_eye, img);

    %Grayscale
    img = rgb2gray(norm_face);
    % x vector
    %img = reshape(img)
    
    img = reshape(img,[],1);
    %Face vector
    X(:,i) = img;
end

X = im2double(X);
%Average face vector, mean face
avg_face = mean(X,2);
img = reshape(avg_face, [231 196]);
imshow(img)
%Subtract mean face, each vector rep the difference
A = X - avg_face; 
A_t = transpose(A);

%Covariance matrix
[eigen_vector, eigen_value] = eig(A_t*A);
u_i = A * eigen_vector;

%sorterar
[eigen_value, order] = sort(diag(eigen_value),'descend');
u_i = u_i(:,order);

for i = 1:size(u_i,2)
    u_i(:,i) = u_i(:,i) / norm(u_i(:,i));
end

weight = u_i' * A;

save('weight.mat', 'weight' )
save('average_face.mat','avg_face')
save('eigen_face.mat', 'u_i')


%1 Same size n = rows x cols

%2 Each image as a n-vector x

%3 Find average face vector

%4 Subtract mean for each face vector

%5 Find covariance matrix, C
% C = A A'
% A = n x M
% C = c x c

%6a Eigenvectors for C, need to reduce C

%6b Consider C = A' A instead

%6c 



