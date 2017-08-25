%==============================================================
% FileName: elem_nbenergy.m
% Description: Get non-bonded energy in a element
% Author: Changhao Li
% Date created: 20 Jul 2017
% Version: 1.00
% Date last revised: 20 Jul 2017
% Revised by: Changhao Li
%==============================================================
function [energy, ele_energy, gauss_energy] = get_nbenergy(ele_neighbour_nbonded, elelist, gauss_pos, d0, indentx, indenty,  xedge, yedge, wei_g, wei_h)
%==============================================================
% input parameters:
% i: element number
% elelist: mesh information
% d0: z-direction distance between two sheets
% indentx: relative displacement between two sheets in x-direction
% indenty: relative displacement between two sheets in y-direction
%==============================================================
elenum = size(elelist, 1);
%==============================================================
J = xedge*yedge*0.5; % Jacobian matrix of a element
energy = 0;
e = 2.39*1.6/1000/10; % parameter used in 6-12 potential
sig = 0.341; % parameter used in 6-12 potential
%==============================================================
% indent is relative displacement of two graphene sheets
gauss_pos1(:, :, 1) = gauss_pos(:, :, 1) + indentx;
gauss_pos1(:, :, 2) = gauss_pos(:, :, 2) + indenty;

%==============================================================
% calculate energy density in every gauss point, then integrate
ele_energy = zeros(elenum, 1);
gauss_energy = zeros(elenum, 12);


parfor iele = 1: elenum
    neinum =  ele_neighbour_nbonded(iele, 1);
    for j = 1: neinum
        jele =  ele_neighbour_nbonded(iele, j+1);
        for ig = 1:12
            for jg = 1:12
                d = sqrt((gauss_pos(iele, ig, 1) - gauss_pos1(jele, jg, 1))^2 + (gauss_pos(iele, ig, 2) - gauss_pos1(jele, jg, 2))^2 + d0^2);
                inte = R(d*10, d0*10)*J*J*wei_g(iele, ig)*wei_h(jele, jg);
                ele_energy(iele, 1) = ele_energy(iele, 1) + inte;
                gauss_energy(iele, ig) = gauss_energy(iele, ig) + inte;
                energy = energy + inte;
            end
        end
    end
end

