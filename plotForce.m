function plotForce(nbforce, nodedof, nodenum, xmax, ymax, nodex, nodey, edgex, edgey)

% for i = 1:elenum
%     for ng = 1:12
%         gauss_x((i-1)*12+ng) = gauss_pos(i,ng,1);
%         gauss_y((i-1)*12+ng) = gauss_pos(i,ng,2);
%         x_nbforce((i-1)*12+ng) = gauss_nbforce(i,ng,1);
%         y_nbforce((i-1)*12+ng) = gauss_nbforce(i,ng,2);
%         z_nbforce((i-1)*12+ng) = gauss_nbforce(i,ng,3);
%         all_nbforce((i-1)*12+ng) = sqrt(gauss_nbforce(i,ng,1)^2 + gauss_nbforce(i,ng,2)^2 + gauss_nbforce(i,ng,3)^2);
%     end
% end
% scatter3(gauss_x,gauss_y,all_nbforce);

all_nbforce = zeros(nodenum,1);
for i = 1:nodenum
    all_nbforce(i) = sqrt(nbforce(i,1)^2+nbforce(i,2)^2);
end

% scatter3(node_x,node_y,all_nbforce);

[X,Y] = meshgrid(0:edgex/8:xmax,0:edgex/8:ymax);
x = 0:edgex:xmax;
y = 0:edgey:ymax;
[xmesh, ymesh] = meshgrid(x, y);
z = zeros(nodex, nodey);
for i = 1:nodey
    for j = 1:nodex
        z(i, j) = all_nbforce((i-1)*nodex+j);
    end
end

Z = interp2(xmesh, ymesh, z, X, Y, 'spline');
surf(X, Y, Z);
xlabel('x/nm');
ylabel('y/nm');
zlabel('F/nN');
colorbar('hot');
shading interp
