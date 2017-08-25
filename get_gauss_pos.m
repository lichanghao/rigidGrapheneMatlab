%==============================================================
% FileName: get_gauss_pos.m
% Description: get gauss point position in global coordinate system
% Author: Changhao Li
% Date created: 20 Jul 2017
% Version: 1.00
% Date last revised: 20 Jul 2017
% Revised by: Changhao Li
%==============================================================
function gauss_pos = get_gauss_pos(elelist, nodedof, xedge, yedge)
%==============================================================
% input parameters:
% i: element number
% elelist: mesh information
% d0: z-direction distance between two sheets
% indentx: relative displacement between two sheets in x-direction
% indenty: relative displacement between two sheets in y-direction
%==============================================================
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
%==============================================================
elenum = size(elelist, 1);
gauss_pos = zeros(elenum, 12, 2);     
% calculate global coordinate of 12 gauss points in every element
for i = 1: elenum
    % reverse triangle element(element number = 2 4 6 8 10......)
    if mod(i, 2) == 0
        refnode = elelist(i, 2);
        for ng = 1:12
            gauss_pos(i, ng, 1) = nodedof(2*refnode - 1) - gauss_ref_pos(ng, 1)*xedge;
            gauss_pos(i, ng, 2) = nodedof(2*refnode)  - gauss_ref_pos(ng, 2)*yedge;
        end
    % triangle element(element number = 1 3 5 7 9......)
    else
        refnode = elelist(i, 1);
        for ng = 1:12
            gauss_pos(i, ng, 1) = nodedof(2*refnode - 1) + gauss_ref_pos(ng, 1)*xedge;
            gauss_pos(i, ng, 2) = nodedof(2*refnode)  + gauss_ref_pos(ng, 2)*yedge;
        end    
    end
end