function [w wx] = circle_spline_1D(pt, xI, di)
    r = abs(pt - xI) / di;
    if r <= 1
        w  = 1 - 6*r^2 + 8*r^3 - 3*r^4;
        wx = (-12*r^2 + 24*r - 12) * (pt - xI) / di^2;
    else
        w = 0;
        wx = 0;
    end
