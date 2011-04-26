
n_samples = 101;
pts = [0:0.04:4];
nodes = [0 1 2 3 4];

phis = zeros(n_samples, 5);
dphidxs = zeros(n_samples, 5);
di = 1.5;

for pt = 1:n_samples
     [phi dphidx] = MLS_ShapeFunction_1D(pts(pt), nodes, di);
%    [phi dphidx] = circle_spline_1D(pts(pt), nodes, di);
    phis(pt, :) = phi;
    dphidxs(pt, :) = dphidx;
end
figure
hold on;
plot(pts, phis(:,1),'b');
plot(pts, phis(:,2),'g');
plot(pts, phis(:,3),'r');
plot(pts, phis(:,4),'g');
plot(pts, phis(:,5),'b');
figure
hold on;
plot(pts, dphidxs(:,1),'b');
plot(pts, dphidxs(:,2),'g');
plot(pts, dphidxs(:,3),'r');
plot(pts, dphidxs(:,4),'g*');
plot(pts, dphidxs(:,5),'b*');
