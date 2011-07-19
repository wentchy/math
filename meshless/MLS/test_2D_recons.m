
[X Y] = meshgrid(-2:1:2);
nodes = [X(:), Y(:)];% + rand(25, 2) - 0.5;
n_nodes = length(X);
z = func_to_test_2D(nodes);
Z = zeros(n_nodes, n_nodes);
for n = 1 : n_nodes
    Z(n,:) = z((n - 1)*n_nodes+1 : n*n_nodes);
end
figure
surface(X, Y, Z);
hold on;
n_samples = 81;
[X Y] = meshgrid(-2:(2 - (-2))/(n_samples-1):2);
pts = [X(:), Y(:)];
zz_real = func_to_test_2D(pts);
Z = zeros(n_samples, n_samples);
for n = 1 : n_samples
    Z(n,:) = zz_real((n - 1)*n_samples+1 : n*n_samples);
end
surface(X, Y, Z);

di = 5;
vandermonde = zeros(n_nodes*n_nodes, n_nodes*n_nodes);

for r = 1:n_nodes*n_nodes
    pt = nodes(r,:);
    [phi dphidx dphidy] = MLS_ShapeFunction_2D(pt, nodes, di);
    vandermonde(r, :) = phi;
end

U = vandermonde \ z;
zz = zeros(n_samples*n_samples, 1);
dzzdx = zeros(n_samples*n_samples, 1);
dzzdy = zeros(n_samples*n_samples, 1);

for pt_id = 1:n_samples*n_samples
    [phi dphidx dphidy] = MLS_ShapeFunction_2D(pts(pt_id,:), nodes, di);
    zz(pt_id) = phi * U;
    dzzdx(pt_id) = dphidx * U;
    dzzdy(pt_id) = dphidy * U;
end
hold on;
Z = zeros(n_samples, n_samples);
for n = 1 : n_samples
    Z(n,:) = zz((n - 1)*n_samples+1 : n*n_samples);
end

surface(X, Y, Z);
figure;
Z = zeros(n_samples, n_samples);
for n = 1 : n_samples
    Z(n,:) = zz((n - 1)*n_samples+1 : n*n_samples) - zz_real((n - 1)*n_samples+1 : n*n_samples);
end
surface(X, Y, Z);
