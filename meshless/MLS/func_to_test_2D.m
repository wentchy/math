function z = func_to_test_2D(pt)
%    z = naca_0012_2D(pt);
    xx = pt(:, 1) / 4 + 2;
    yy = pt(:, 2) / 4 + 2;
    theta = 45;
    x = xx .* cos(theta) + yy .* sin(theta);
    y = xx .* (-sin(theta)) + yy .* cos(theta);
    
    z = cos(3*x);

