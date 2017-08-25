%==============================================================
% FileName: elem_nbenergy.m
% Description: Get non-bonded energy in a element
% Author: Changhao Li
% Date created: 20 Jul 2017
% Version: 1.00
% Date last revised: 20 Jul 2017
% Revised by: Changhao Li
%==============================================================
function energy = get_nbenergy(elelist, gauss_pos, d0, indentx, indenty,  xedge, yedge, A0, wei)
%==============================================================
% input parameters:
% i: element number
% elelist: mesh information
% d0: z-direction distance between two sheets
% indentx: relative displacement between two sheets in x-direction
% indenty: relative displacement between two sheets in y-direction
%==============================================================
elenum = size(elelist, 1);
% calculate global coordinate of 12 gauss points in every element
%==============================================================
J = xedge*yedge*0.5; % Jacobian matrix of a element
s0 = 1.5*sqrt(3)*A0*A0/2 ; % the average area of one atom in graphene sheet
energy = 0;
e = 2.39*1.6/1000/10; % parameter used in 6-12 potential
sig = 0.341; % parameter used in 6-12 potential
%==============================================================
% indent is relative displacement of two graphene sheets
gauss_pos1(:, :, 1) = gauss_pos(:, :, 1) + indentx;
gauss_pos1(:, :, 2) = gauss_pos(:, :, 2) + indenty;
%==============================================================
% calculate energy density in every gauss point, then integrate
parpool(4);
parfor iele = 1: elenum
    for jele = 1:elenum
        for ig = 1:12
            for jg = 1:12
                d = sqrt((gauss_pos(iele, ig, 1) - gauss_pos1(jele, jg, 1))^2 + (gauss_pos(iele, ig, 2) - gauss_pos1(jele, jg, 2))^2 + d0^2);
                inte = E(d, e, sig)/(s0*s0)*J*J*wei(iele, ig)*wei(jele, jg);
                energy = energy + inte;
            end
        end
    end
end

