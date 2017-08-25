function plotEnergy(ele_energy, nodedof, elelist, elenum, edgex, edgey, xmax, ymax)

for iele = 1:elenum
    nod1 = elelist(iele, 1); nod2 = elelist(iele, 2); nod3 = elelist(iele, 3);
    xx(iele) = 1/3 * (nodedof(2*nod1-1)+nodedof(2*nod2-1)+nodedof(2*nod3-1));
    yy(iele) = 1/3 * (nodedof(2*nod1)+nodedof(2*nod2)+nodedof(2*nod3));
end

[X,Y] = meshgrid(edgex:edgex:xmax-edgex,edgey:edgey:ymax-edgey);
Z = griddata(xx,yy,ele_energy,X,Y);
% scatter(xx, yy, 50, ele_energy, 'fill');
[XI,YI] = meshgrid(edgex:edgex/2:xmax-edgex,edgey:edgey/2:ymax-edgey);
ZI = interp2(X, Y, Z, XI, YI, 'spline');
surf(XI, YI, ZI);
xlabel('x/nm');
ylabel('y/nm');
zlabel('E/meV');