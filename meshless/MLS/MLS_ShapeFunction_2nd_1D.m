function [phi, dphidx] = MLS_ShapeFunction_2nd_1D(pt, all_node, di)
    A = zeros(3,3);
    dAdx = zeros(3,3);
% $$$     m = size(all_node, 2);
% $$$     node = [];
% $$$     for I = 1 : m
% $$$         if abs(all_node(I) - pt) <= di
% $$$             node = [node all_node(I)];
% $$$         end
% $$$     end
    node = all_node;
    m = size(node, 2);
    w = zeros(1, m);
    wx = zeros(1, m);
    for I = 1 : m
        xI = node(I);
        xI2 = xI*xI;
        [wi wix] = circle_spline_1D(pt, xI, di);
        ppT = [1 xI xI2]' * [1 xI xI2];
        A = A + wi * ppT;
        dAdx = dAdx + wix * ppT;
        w(I) = wi;
        wx(I) = wix;
    end
    c = A \ [1 pt pt^2]';
    px = [0 1 2*pt]';
    bx = - dAdx*c + px;
    cx = A \ bx;
    
    phi = zeros(1, m);
    dphidx = zeros(1, m);
    for I = 1 : m
        xI = node(I);
        pI = [1 xI xI^2]';
        phi(I) = c'*pI*w(I);
        dphidx(I) = cx'*pI*w(I) + c'*pI*wx(I);
    end
    
