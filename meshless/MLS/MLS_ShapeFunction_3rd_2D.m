function [phi, dphidx, dphidy] = MLS_ShapeFunction_3rd_2D(pt, node, di)
    
    n_basis = 10; % 1, x, y, x^2, y^2, xy, x^3, y^3, x^2*y,x*y^2 --- 10 basis
    A = zeros(n_basis, n_basis); 
    dAdx = zeros(n_basis, n_basis);
    dAdy = zeros(n_basis, n_basis);
    m = size(node, 1);
    w = zeros(1, m);
    wx = zeros(1, m);
    wy = zeros(1, m);
    for I = 1 : m
        xI = [node(I, 1), node(I, 2)];
        %xI
        [wi, dwidx, dwidy] = circle_spline_2D(pt, xI, di);
        pI = [1; xI(1); xI(2); xI(1).^2; xI(2).^2; xI(1).*xI(2); xI(1).^3; ...
             xI(2).^3; xI(1).^2.*xI(2); xI(1).*xI(2).^2];
        ppT = pI*pI';
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
    p = [1; pt(1); pt(2); pt(1).^2; pt(2).^2; pt(1).*pt(2); pt(1).^3; ...
         pt(2).^3; pt(1).^2.*pt(2); pt(1).*pt(2).^2];
    px = [0; 1; 0; 2*pt(1); 0; pt(2); 3*pt(1).^2; 0; 2*pt(1).*pt(2); ...
          pt(2).^2 ];
    py = [0; 0; 1; 0; 2*pt(2); pt(1); 0; 3*pt(2).^2; pt(1).^2; 2*pt(1).*pt(2) ...
         ];
    
    
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
        pI = [1; xI(1); xI(2); xI(1).^2; xI(2).^2; xI(1).*xI(2); xI(1).^3; ...
             xI(2).^3; xI(1).^2.*xI(2); xI(1).*xI(2).^2];
        phi(I) = c'*pI*w(I);
        dphidx(I) = cx'*pI*w(I) + c'*pI*wx(I);
        dphidy(I) = cy'*pI*w(I) + c'*pI*wy(I);
    end
    
    
