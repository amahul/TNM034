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
    norm_face = normalization_face(left_eye, right_eye, img);

    %Grayscale
    img = rgb2gray(norm_face);
    img = reshape(img,[],1);

    %Face vector
    X(:,i) = img;
end

X = im2double(X);
%Average face vector, mean face
avg_face = mean(X,2);
img = reshape(avg_face, [231 196]);
imshow(img)

%imshow(img)
%Subtract mean face, each vector rep the difference
A = X - avg_face; 
A_t = A';

%Covariance matrix
[eigen_vector, eigen_value] = eig(A_t*A);
u_i = A * eigen_vector;

%Sort eigen values
[~, order] = sort(diag(eigen_value),'descend');
u_i = u_i(:,order);

%norm
for i = 1:size(u_i,2)
    u_i(:,i) = u_i(:,i) / norm(u_i(:,i));
end

weight = u_i' * A;

save('weight.mat', 'weight' )
save('average_face.mat','img')
save('eigen_face.mat', 'u_i')




