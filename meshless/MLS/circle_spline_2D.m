function [w wx wy] = circle_spline_2D(pt, xI, di)
    r = sqrt((pt(1) - xI(1))^2 + (pt(2) - xI(2))^2) / di;
    if r <= 1
        w  = 1 - 6*r^2 + 8*r^3 - 3*r^4;
        wx = (-12*r^2 + 24*r - 12) * (pt(1) - xI(1)) / di^2;
        wy = (-12*r^2 + 24*r - 12) * (pt(2) - xI(2)) / di^2;
    else
        w = 0;
        wx = 0;
        wy = 0;
    end
