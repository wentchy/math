function [phi, dphidx] = MLS_ShapeFunction_1D(pt, all_node, di)
    A = zeros(2,2);
    dAdx = zeros(2,2);
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
        [wi wix] = circle_spline_1D(pt, xI, di);
        ppT = [1 xI]' * [1 xI];
        A = A + wi * ppT;
        dAdx = dAdx + wix * ppT;
        w(I) = wi;
        wx(I) = wix;
    end
    c = A \ [1 pt]';
    px = [0 1]';
    bx = - dAdx*c + px;
    cx = A \ bx;
    
    phi = zeros(1, m);
    dphidx = zeros(1, m);
    for I = 1 : m
        xI = node(I);
        pI = [1 xI]';
        phi(I) = c'*pI*w(I);
        dphidx(I) = cx'*pI*w(I) + c'*pI*wx(I);
    end
    
