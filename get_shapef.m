%==============================================================
% FileName: get_shapef.m
% Description: Calculate shape function(Bspline, 12 nodes) in every gauss
%  point
% Author: Changhao Li
% Date created: 30 Jul 2017
% Version: 1.00
% Date last revised: 30 Jul 2017
% Revised by: Changhao Li
%==============================================================
function shapef = get_shapef()

pos1=0.873821971016996;
pos2=0.063089014491502;
pos11=0.501426509658179;
pos22=0.249286745170910;
pos111=0.636502499121399;
pos222=0.310352451033785;
pos333=0.053145049844816;
gauss_ref_pos = [pos1     pos2;     pos2      pos1;      pos2     pos2; ...
                               pos11   pos22;   pos22    pos11;   pos22    pos22; ...
                               pos111 pos222; pos111 pos333; pos222 pos333; ...
                               pos333 pos222; pos333 pos111; pos333 pos222];
shapef = zeros(12, 12);                      
for ig = 1:12
    shapef(ig, :) = Bspline(gauss_ref_pos(ig,1), gauss_ref_pos(ig,2));
end