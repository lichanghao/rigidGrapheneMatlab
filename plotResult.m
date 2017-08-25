[X,Y] = meshgrid(0:0.05:1,0:0.05:1);
x = 0:0.1:1;
y = 0:0.1:1;
[xmesh, ymesh] = meshgrid(x, y);
z = zeros(11, 11);
for i = 1: 11
    for j = 1: 11
        k = 11*(i-1) + j;
        z(i, j) = out1(5*k-3 ,5);
    end
end

Z = interp2(xmesh, ymesh, z, X, Y, 'spline');
surf(X, Y, Z);
xlabel('x/lattice parameter');
ylabel('y/lattice parameter');
zlabel('z/nN*nm')

minZ = min(min(Z));
[a, b] = find(Z == minZ);
