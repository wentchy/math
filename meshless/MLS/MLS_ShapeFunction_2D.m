function [phi, dphidx, dphidy] = MLS_ShapeFunction_2D(pt, index, node, di, ...
                                                      form)
    
    A = zeros(3,3);
    dAdx = zeros(3,3);
    dAdy = zeros(3,3);
    for m = 1 : size(index, 2)
        xi = [node(index(m), 1), node(index(m), 2)];
        [wi, dwidx, dwidy] = circle_spline(pt, xi, di, form);
        pTp = [1 xi(1,1) xi(1,2)]' * [1 xi(1,1) xi(1,2)];
        A = A + wi*pTp;
        dAdx = dAdx + dwidx*pTp;
        dAdy = dAdy + dwidy*pTp;
        % store weight function and derivatives at node I
        w(m) = wi;
        dwdx(m) = dwidx;
        dwdy(m) = dwidy;
    end
    
    p = [1; pt(1,1); pt(1,2)];
    
    % compute matrix c(x), c, k(x)
    %[L,U,PERM] = lu(A);
    
