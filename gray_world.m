function out_image = gray_world(input_img)

%% Split the image to r, g and b channels
r = input_img(:,:,1);
g = input_img(:,:,2);
b = input_img(:,:,3);

%% Compute mean:
r_avg = mean(r);
g_avg = mean(g);
b_avg = mean(b);

%% Compute the gain for the red and green channel:
alpha = g_avg/r_avg;
beta = g_avg/b_avg;

%% Compute color corrected image
r_sensor = alpha*r;
g_sensor = g;
b_sensor = beta*b;

out_image = cat(3, r_sensor,g_sensor,b_sensor);

end