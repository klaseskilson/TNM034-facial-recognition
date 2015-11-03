function [YCgCr] = rgb2ycgcr(rgb)

YCgCr = [ 16; 128; 128;] + [ 65.481  128.553  24.996; 
                             -81.085 112  -30.915; 
                              112 -93.786 -18.214 ] * rgb;
YCgCr = uint8(YCgCr);