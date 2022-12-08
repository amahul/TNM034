function [m_map_BW] = mouth_map(I)
%% Prepare variables

% Convert RGB image to YCbCr Components
YCbCr = rgb2ycbcr(I);

% Convert to double since max value for uint8 is 255.

% Isolate Cb. 
Cb = double(YCbCr(:,:,2));
% Isolate Cr. 
Cr = double(YCbCr(:,:,3));

%% Computations according to literature

Cr2 = Cr.^2;
Cr2n = 255.*(Cr2-min(Cr2))./(max(Cr2)-min(Cr2));

CrCb = Cr./Cb;
CrCbn = 255.*(CrCb-min(CrCb))./(max(CrCb)-min(CrCb));

% n is the number of pixels within the face mask
% mean2 calculates avarage of matrix elements
n = 0.95*(mean2(Cr2n)/mean2(CrCbn));

m_map = (Cr2) .* ((Cr2)-n.*(CrCb)).^2;

%% Stretching, dilation and binarization

% Normalize
m_map = 255.*m_map./max(max(m_map));

% Convert to uint8
m_map = uint8(m_map); 

% Dilate image
r = 10;
SE = strel('square', r); % spherical structuring element
m_map = imdilate(m_map,SE); 

% Stretch image, tested values
target = 256:-4:4;
m_map_stretched = histeq(m_map,target);

% Binarize image with thresholdvalue 0.8
m_map_BW = imbinarize(m_map_stretched, 0.8);

%% keep 5 largest objects

m_map_BW = bwareafilt(m_map_BW,5); 
%% DEBUG: Draw mouth on input image
% 
% % Find center and width of white area
% props = regionprops(m_map1,'centroid', 'MajoraxisLength', 'MinoraxisLength')
% x_length = props.MajorAxisLength;
% y_length = props.MinorAxisLength;
% m_center = props.Centroid;
% 
% % Draw image with rectangle
% % m_center = round(props.Centroid);
% figure()
% imshow(I);
% rectangle('Position', [m_center(1)-x_length/2, m_center(2)-y_length/2, x_length, y_length], 'EdgeColor', 'b', 'LineWidth', 2);
