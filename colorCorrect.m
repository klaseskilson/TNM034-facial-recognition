function output_image = colorCorrrect(input)
% color correct an image using gray world assumption

% calculate mean value for each layer
red = input(:,:,1);
green = input(:,:,2);
blue = input(:,:,3);
r_mean = 1/mean(red(:));
g_mean = 1/mean(green(:));
b_mean = 1/mean(blue(:));

max_RGB = max(max(r_mean,g_mean),b_mean);

% normalize
r_mean = r_mean/max_RGB;
g_mean = g_mean/max_RGB;
b_mean = b_mean/max_RGB;

red = red * r_mean;
green = green * g_mean;
blue = blue * b_mean;

output_image = cat(3, red, green, blue);


