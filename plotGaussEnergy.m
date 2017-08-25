function plotGaussEnergy(gauss_energy, gauss_pos, elelist, elenum, edgex, edgey, xmax, ymax)

% ===============
% xx = [];
% yy = [];
% fx = [];
% fy = [];
% nele = size(elelist, 1);
% for i = 1:nele
%     for j = 1:12
%         xx = [xx, gauss_pos(i, j, 1)];
%         yy = [yy, gauss_pos(i, j, 2)];
%         fx = [fx, 1000*gauss_energy(i, j, 1)];
%         fy = [fy, 1000*gauss_energy(i, j, 2)];
%     end
% end
% quiver(xx, yy, fx, fy, 20)
% ===============


% ===================
xx = [];
yy = [];
zz = [];
nele = size(elelist, 1);
for i = 1:nele
    for j = 1:12
        xx = [xx, gauss_pos(i, j, 1)];
        yy = [yy, gauss_pos(i, j, 2)];
        zz = [zz, gauss_energy(i, j)];
    end
end
% tabulate(xx);tabulate(yy);
% scatter3(xx,yy,zz)
[X,Y] = meshgrid(edgex:edgex/8:xmax-edgex,edgey:edgey/8:ymax-edgey);
Z = griddata(xx,yy,zz,X,Y,'natural');
surf(X, Y, Z);
shading interp


% scatter(xx, yy, 50, ele_energy, 'fill');
% [XI,YI] = meshgrid(edgex:edgex/8:xmax-edgex,edgey:edgey/8:ymax-edgey);
% ZI = interp2(X, Y, Z, XI, YI, 'spline');
% surf(XI, YI, ZI);
% xlabel('x/nm');
% ylabel('y/nm');
% zlabel('E/meV');
% shading interp

% ===================