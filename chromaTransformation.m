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
    Yi = uint8(Y > Kl) .* uint8(Y < Kh);
    % calc center values Cb, Equation 7
    Ba = 108;
    Bb = 118;
    CbCenterl = Ba + (Kl - Y) * (Bb - Ba) / (Kl - Ymin);
    CbCenterh = Ba + (Y - Kh) * (Bb - Ba) / (Ymax - Kh);
   
    CbCenter = CbCenterl .* Yl + CbCenterh .* Yh;

    % calc center values Cr, Equation 8
    Ra = 154;
    Rb = 144;
    Rc = 132;
    CrCenterl = Ra - (Kl - Y) * (Ra - Rb) / (Kl - Ymin);
    CrCenterh = Ra + (Y - Kh) * (Ra - Rc) / (Ymax - Kh);
    
    CrCenter = CrCenterl .* Yl + CrCenterh .* Yh;

    % calculate spread of b equation 6
    SpreadBl = clusterSpreadL(WLcb, Y, Ymin, Wcb, Kl);
    SpreadBh = clusterSpreadH(WHcb, Y, Ymax, Wcb, Kh);

    SpreadB = SpreadBl .* Yl + SpreadBh .* Yh;

    % calculate spread of r equation 6
    SpreadRl = clusterSpreadL(WLcr, Y, Ymin, Wcr, Kl);
    SpreadRh = clusterSpreadH(WHcr, Y, Ymax, Wcr, Kh);

    SpreadR = SpreadRl .* Yl + SpreadRh .* Yh;
    
    % actually calculate the new Cb and Cr, equation 5
    krConst = 168;
    kbConst = 184;
    CPrimB = cPrim(Cb, Wcb, SpreadB, CbCenter, kbConst);
    CPrimR = cPrim(Cr, Wcr, SpreadR, CrCenter, krConst);
    % combine the results of the different threshold images
    CPrimBi = Cb .* Yi;
    CprimB = CPrimB.*(Yl+Yh) + CPrimBi;
    CPrimRi = Cr .* Yi;
    CprimR = CPrimR.*(Yl+Yh) + CPrimRi;
    % merge into one image
    chroma_img = Y;
    chroma_img(:, :, 2) = CprimB;
    chroma_img(:, :, 3) = CprimR;
end

% Equation 5
function [res] = cPrim(C, Wc, clusterSpread, Ccenter, K)
    res = C - Ccenter;
    res = res * Wc ./ clusterSpread;
    res = res + K;
end

% Equation 6
function [res] = clusterSpreadL(WLc, Y, Ymin, Wc, Kl)
    res = WLc + ((Y - Ymin) * (Wc - WLc)) / (Kl - Ymin);
end

function [res] = clusterSpreadH(WHc, Y, Ymax, Wc, Kh)
    res = WHc + ((Ymax - Y) * (Wc - WHc)) / (Ymax - Kh);
end
