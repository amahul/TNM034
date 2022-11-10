% I is the input image 
% returns mouth_map and center of mouth 
function [m_map, m_center] = mouth_map(I)
%% Prepare variables
% Convert RGB image to YCbCr Components
YCbCr = rgb2ycbcr(I);
% We convert to double since max value for uint8 is 255.

% Isolate Y. 
Y = double(YCbCr(:,:,1));
% Isolate Cb. 
Cb = double(YCbCr(:,:,2));
% Isolate Cr. 
Cr = double(YCbCr(:,:,3));

Cr2 = Cr.^2;

%% Normalize and convert back to uint8

% Cr2n = 255.*Cr2./max(max(Cr2)) 

Cr2n = 255.*(Cr2-min(Cr2))./(max(Cr2)-min(Cr2));
figure()
imshow(uint8(Cr2n));
% 
CrCb = Cr./Cb;
CrCbn = 255.*(CrCb-min(CrCb))./(max(CrCb)-min(CrCb));
figure();
imshow(uint8(CrCbn));

%% Calculate results
% n is the number of pixels within the face mask
% mean2 calculates avarage of matrix elements
n = 0.95*(mean2(Cr2n)/mean2(CrCbn));

% m_map = Cr2n .* (Cr2n-n.*(CrCbn)).^2
m_map = (Cr2) .* ((Cr2)-n.*(CrCb)).^2;

% Normalize
% m_map = 255.*(m_map-min(m_map))./(max(m_map)-min(m_map))
m_map = 255.*m_map./max(max(m_map))
% Convert to uint8
m_map = uint8(m_map); 

figure();
imshow(m_map);


r = 5;
SE = strel('sphere', r); % spherical structuring element
m_map = imdilate(m_map,SE); % DILATION:
figure()
imshow(m_map)

% Binarize image with thresholdvalue 0.8
BW = imbinarize(m_map, 0.7);

figure()
imshow(BW)

BW = bwareafilt(BW,1); % only keep one white object
figure()
imshow(BW)

% Find center and with of white area
props = regionprops(BW,'centroid', 'area', 'MajoraxisLength', 'MinoraxisLength')
x_length = props.MajorAxisLength;
y_length = props.MinorAxisLength;

% Draw image with rectangle
m_center = round(props.Centroid)
imshow(I)
rectangle('Position', [m_center(1)-x_length/2, m_center(2)-y_length/2, x_length, y_length], 'EdgeColor', 'b', 'LineWidth', 2);



