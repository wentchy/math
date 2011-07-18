
x = [0.9,1,2,3,4,5,6,6.1];
z = 2 .* x.^2 - 5 * x - 1;
z = z';
%z = [0.5,0.7,1.2,1.5,2,2.1,4,5]';
n_nodes = length(x);
figure
plot(x, z);
hold on;
di = 4;
vandermonde = zeros(n_nodes, n_nodes);

for r = 1:n_nodes
    pt = x(r);
    [phi dphidx] = MLS_ShapeFunction_1D(pt, x, di);
    vandermonde(r, :) = phi;
end
% $$$ vandermonde
% $$$ z
U = vandermonde \ z;
n_samples = 101;
pts = [0:0.08:8];
zz = zeros(n_samples, 1);
for pt = 1:n_samples
     [phi dphidx] = MLS_ShapeFunction_1D(pts(pt), x, di);
     zz(pt) = phi * U;
end
plot(pts, zz, 'r')

