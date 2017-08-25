%==============================================================
% FileName: garapheneMesh.m
% Description: Generate finite element mesh for rigid rectangular garaphene
%  sheet
% Author: Changhao Li
% Date created: 17 Jul 2017
% Version: 1.00
% Date last revised: 17 Jul 2017
% Revised by: Changhao Li
%==============================================================

function [elelist, nodedof, nodenum, elenum, xmax, ymax] = garapheneMesh(edgelenx, edgeleny, nodex, nodey)

nodenum = nodex * nodey;
elenum = 2*(nodex-1)*(nodey-1);
nodedof = zeros(2*(nodenum + 0), 1);
xmax = edgelenx * (nodex-1);
ymax = edgeleny * (nodey-1);
% dofs of real nodes
for i = 0: nodey-1
    for j = 1: nodex
        nodedof(2*(i*nodex + j) - 1) = (j -1) * edgelenx;
        nodedof(2*(i*nodex + j) ) = (i) * edgeleny;
    end
end
% dofs of ghost nodes(not implemented)

elelist = zeros(elenum, 3);
% connect nodes into elements
% nodex-1 is the number of element in x direction, so does y
for i = 0: nodey-2
    for j = 1: nodex-1
        elelist(2*(i*(nodex-1) + j) - 1, 1) = (i*nodex + j);
        elelist(2*(i*(nodex-1) + j) - 1, 2) = (i*nodex  + j) + 1;
        elelist(2*(i*(nodex-1) + j) - 1, 3) = (i*nodex  + j) + nodex ;
        
        elelist(2*(i*(nodex-1) + j), 1) = (i*nodex + j) + 1;
        elelist(2*(i*(nodex-1) + j), 2) = (i*nodex + j) + 1+ nodex ;
        elelist(2*(i*(nodex-1) + j), 3) = (i*nodex + j) + nodex;
    end
end