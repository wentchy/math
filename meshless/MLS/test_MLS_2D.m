
n_samples = 41;
[X Y] = meshgrid(-2:1:2);
nodes = [X(:), Y(:)];

[X Y] = meshgrid(-2:0.1:2);
pts = [X(:), Y(:)];

phis = zeros(n_samples*n_samples, 5*5);
dphidxs = zeros(n_samples*n_samples, 5*5);
di = 1.5;

for pt = 1:n_samples*n_samples
    [phi dphidx dphidy] = MLS_ShapeFunction_2D(pts(pt,:), nodes, di);
%    [phi dphidx] = circle_spline_1D(pts(pt), nodes, di);

    phis(pt, :) = phi;
    dphidxs(pt, :) = dphidx;
    dphidys(pt, :) = dphidy;
end
figure
hold on;
% $$$ zz = phis(:, 13);
zz = dphidys(:, 13);
Z = zeros(n_samples, n_samples);
for n = 1 : n_samples
    Z(n,:) = zz((n - 1)*n_samples+1 : n*n_samples);
end

surface(X, Y, Z);
