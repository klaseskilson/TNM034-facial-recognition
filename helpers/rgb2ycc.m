function [YCbCr] = rgb2ycc(rgb)

YCbCr = [ 16; 128; 128;] + [ 0.183  0.614  0.062; 
                             -0.101 -0.339  0.439; 
                              0.439 -0.339 -0.040; ] * rgb;
YCbCr = uint8(YCbCr);
