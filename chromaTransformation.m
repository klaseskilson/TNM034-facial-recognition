function [ chroma_img ] = chromaTransformation(img)
%CHROMATRANSFORMATION Transform the chroma of YCrCb input image img
%   Detailed explanation goes here
    
    Y = img(:, :, 1);
    Cb = img(:, :, 2);
    Cr = img(:, :, 3);
    
    % neat constants from appendix A of "Face Detection in Color Images"
    % spread values
    Wcb = 46.97;
    WLcb = 23;
    WHcb = 14;
    Wcr = 38.76;
    WLcr = 20;
    WHcr = 10;
    
    Kl = 125;
    Kh = 188; 
    Ymin = 16;
    Ymax = 235;
    
    % binary threshold images
    Yl = uint8(Y < Kl);
    Yh = uint8(Y > Kh);
    Yi = uint8((Y > Kl) .* (Y < Kh));
    
    % calc center values Cb, Equation 7
    Ba = 108;
    Bb = 118;
    CbCenterl = Ba + (Kl - Y) * (Bb - Ba) / (Kl - Ymin);
    CbCenterl = CbCenterl .* Yl;
    CbCenterh = Ba + (Y - Kh) * (Bb - Ba) / (Ymax - Kh);
    CbCenterh = CbCenterh .* Yh;
    
    % calc center values Cr, Equation 8
    Ra = 154;
    Rb = 144;
    Rc = 132;
    CrCenterl = Ra - (Kl - Y) * (Ra - Rb) / (Kl - Ymin);
    CrCenterl = CrCenterl .* Yl;
    CrCenterh = Ra + (Y - Kh) * (Ra - Rc) / (Ymax - Kh);
    CrCenterh = CrCenterh .* Yh;
    
    % calculate 
    SpreadBl = clusterSpreadL(WLcb, Y, Ymin, Wcb, Kl);
    SpreadBh = clusterSpreadH(WHcb, Y, Ymax, Wcb, Kh);
    SpreadRl = clusterSpreadL(WLcr, Y, Ymin, Wcr, Kl);
    SpreadRh = clusterSpreadH(WHcr, Y, Ymax, Wcr, Kh);
    
    % actually calculate the new Cb and Cr
    CPrimBl = cPrim(Cb, Y, Wcb, SpreadBl, CbCenterl, Kh) .* (Yl);
    CPrimBh = CPrim(Cb, Y, Wcb, SpreadBh, CbCenterh, Kh) .* (Yh);
    CPrimRl = cPrim(Cr, Y, Wcr, SpreadRl, CrCenterl, Kh) .* (Yl);
    CPrimRh = CPrim(Cr, Y, Wcr, SpreadRh, CrCenterh, Kh) .* (Yh);
    % combine the results of the different threshold images
    CPrimBi = Cb .* Y .* Yi;
    CprimB = CPrimBl + CPrimBh + CPrimBi;
    CPrimRi = Cr .* Y .* Yi;
    CprimR = CPrimRl + CPrimRh + CPrimRi;
    
    % merge into one image
    chroma_img = Y;
    chroma_img(:, :, 2) = CprimB;
    chroma_img(:, :, 3) = CprimR;
end

%Equation 5
function [res] =cPrim(C, Y, Wc, clusterSpread, Ccenter, Kh)
    res = (C) - (Ccenter);
    res = res * Wc ./ clusterSpread;
    res = res + (Ccenter) * Kh;
end

%Equation 6
function [res] = clusterSpreadL(WLc, Y, Ymin, Wc, K)
    res = WLc + ((Y - Ymin) * (Wc - WLc)) / (K - Ymin);
end

function [res] = ClusterSpreadH(WHc, Y, Ymax, Wc, K)
    res = WHc + ((Ymax - Y) * (Wc - WHc)) / (Ymax - K);
end
