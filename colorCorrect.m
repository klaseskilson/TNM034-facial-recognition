function output_image = colorCorrrect(input)
% color correct an image using gray world assumption

% calculate mean value for each layer
red = input(:,:,1);
green = input(:,:,2);
blue = input(:,:,3);
r_mean = mean(red(:));
g_mean = mean(green(:));
b_mean = mean(blue(:));

% normalize
r_g = g_mean / r_mean;
b_g = g_mean / b_mean;

red = r_g * red;
blue = b_g * blue;

output_image = cat(3, red, green, blue);
