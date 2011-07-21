function z = naca_0012_2D(pt)
    xx = pt(:, 1) / 4 + 2;
    yy = pt(:, 2) / 4 + 2;
    theta = 0;
    x = xx .* cos(theta) + yy .* sin(theta);
    y = xx .* (-sin(theta)) + yy .* cos(theta);
    %    z = (x.^2 + y.^2).^.5;
    %    z = (x.^10 + y.^10).^0.1;
    %    z = ((x-2).*(y-2)).^(-1.);
    %    z = exp(x).*exp(y);
    %    z = (1024 - x.^10 + y.^5).^(1./2);
    c = 6;
    xoc = abs(x) ./ c;
    t = 0.1;
    z = 0.2969 .* xoc.^.5;
    z = z - 0.1260 .* xoc;
    z = z - 0.3516 .* xoc.^2;
    z = z + 0.2843 .* xoc.^3;
    z = z - 0.1015 .* xoc.^4;


