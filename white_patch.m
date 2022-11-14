function outImage = whitePatch(img)
%   Detailed explanation goes here

% Split image to r, g and b channels
r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3);

% Assumes that the brightest point in the image is due to specular
%   reflection, which reflect the color of the light source. 
%   Compute max:

% r_max = max(r);
% g_max = max(g);
% b_max = max(b);


r_max= max(r, [], 'all'); %? sensor assumed as channel
g_max = max(g, [], 'all');
b_max = max(b, [], 'all');

% Compute the gain for the red and green channel:
alpha = g_max./r_max;
beta = g_max./b_max;

% Compute color corrected image
r_sensor = alpha.*r;
g_sensor = g;
b_sensor = beta.*b;

%outImage = cat(3, r_sensor,g_sensor,b_sensor);
outImage = img;

end

