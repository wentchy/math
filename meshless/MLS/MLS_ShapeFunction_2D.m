function [phi, dphidx, dphidy] = MLS_ShapeFunction_2D(pt, node, di)
    
    A = zeros(3,3);
    dAdx = zeros(3,3);
    dAdy = zeros(3,3);
    m = size(node, 1);
    w = zeros(1, m);
    wx = zeros(1, m);
    wy = zeros(1, m);
    for I = 1 : m
        xI = [node(I, 1), node(I, 2)];
        %xI
        [wi, dwidx, dwidy] = circle_spline_2D(pt, xI, di);
        ppT = [1 xI(1) xI(2)]' * [1 xI(1) xI(2)];
        %ppT
        A = A + wi*ppT;
        %A
        dAdx = dAdx + dwidx*ppT;
        dAdy = dAdy + dwidy*ppT;
        % store weight function and derivatives at node I
        w(I) = wi;
        wx(I) = dwidx;
        wy(I) = dwidy;
    end
    
    
% $$$     A
% $$$     dAdx
% $$$     dAdy
    p = [1; pt(1); pt(2)];
    px = [0; 1; 0];
    py = [0; 0; 1];
    
    
    % compute matrix c(x), c, k(x)
    %[L,U,PERM] = lu(A);
    c = A \ p;
    bx = -dAdx*c + px;
    by = -dAdy*c + py;
% $$$     by
    cx = A \ bx;
    cy = A \ by;
    
    phi = zeros(1, m);
    dphidx = zeros(1, m);
    dphidy = zeros(1, m);
% $$$     cy
% $$$     wy
    for I = 1 : m
        xI = [node(I, 1) node(I, 2)];
        pI = [1 xI(1) xI(2)]';
        phi(I) = c'*pI*w(I);
        dphidx(I) = cx'*pI*w(I) + c'*pI*wx(I);
        dphidy(I) = cy'*pI*w(I) + c'*pI*wy(I);
    end
    
    
