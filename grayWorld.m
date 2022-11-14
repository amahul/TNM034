function outImage = grayWorld(img)
% Detailed explanation goes here
% Lecture 2, slide 11, 12 and 13

%outImage = img;

% Split image to r, g and b channels
r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3);

% Assumes that average of a scene is achromatic. Compute mean:
r_avg = mean(r);
g_avg = mean(g);
b_avg = mean(b);

% Compute the gain for the red and green channel:
alpha = g_avg/r_avg;
beta = g_avg/b_avg;

% Compute color corrected image
r_sensor = alpha*r;
g_sensor = g;
b_sensor = beta*b;

% Behövs detta?
outImage = cat(3, r_sensor,g_sensor,b_sensor);

end