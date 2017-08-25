%==============================================================
% FileName: get_nbforce.m
% Description: Calculate vdW forces in every node
% Author: Changhao Li
% Date created: 30 Jul 2017
% Version: 1.00
% Date last revised: 30 Jul 2017
% Revised by: Changhao Li
%==============================================================
function [nbforce, gauss_nbforce, spline_neighbour] = get_nbforce(elelist, gauss_pos, ele_neighbour_nbonded,...
    wei_g, wei_h, shapef, xedge, yedge, xmax, ymax, d0, indentx, indenty, theta, nodenum, nodex, nodey)

elenum = size(elelist, 1);
%==============================================================
J = xedge*yedge*0.5; % Jacobian matrix of a element
e = 2.39*1.6/1000/10; % parameter used in 6-12 potential
sig = 0.341; % parameter used in 6-12 potential
%==============================================================
% indent is relative displacement of two graphene sheets, theta is relative
%  rotational angle between two sheets
% rotation = [cos(theta), -sin(theta); sin(theta), cos(theta)];
 gauss_pos1 = gauss_pos;
% ref_point = [xmax/2; ymax/2];
% for iele = 1:elenum
%     for ig = 1:12
%          a(1,1) = gauss_pos(iele, ig, 1);
%          a(2,1) = gauss_pos(iele, ig, 2);
%          b = rotation* (a-ref_point) + ref_point;
%          gauss_pos1(iele, ig, 1) = b(1,1) + indentx;
%          gauss_pos1(iele, ig, 2) = b(2,1) + indenty;
%     end 
% end

% calculate vdW force in every gauss point
gauss_nbforce = zeros(elenum, 12, 3); % vdW force in x/y/z direction(Global coordinate)

for iele = 1: elenum
    neinum =  ele_neighbour_nbonded(iele, 1);
    for j = 1: neinum
        jele =  ele_neighbour_nbonded(iele, j+1);
        for ig = 1:12
            for jg = 1:12
%                 d = sqrt((gauss_pos(jele, jg, 1) - gauss_pos1(iele, ig, 1))^2 + (gauss_pos(jele, jg, 2) - gauss_pos1(iele, ig, 2))^2 + d0^2);
                xx = gauss_pos(jele, jg, 1) - gauss_pos1(iele, ig, 1);
                yy = gauss_pos(jele, jg, 2) - gauss_pos1(iele, ig, 2);
                gauss_nbforce(iele, ig, 1) = gauss_nbforce(iele, ig, 1) + RFx(10*xx, 10*yy, 10*d0)*J*J*wei_g(iele, ig)*wei_h(jele, jg);
                gauss_nbforce(iele, ig, 2) = gauss_nbforce(iele, ig, 2) + RFy(10*xx, 10*yy, 10*d0)*J*J*wei_g(iele, ig)*wei_h(jele, jg);
                gauss_nbforce(iele, ig, 3) = gauss_nbforce(iele, ig, 3) + RFz(10*xx, 10*yy, 10*d0)*J*J*wei_g(iele, ig)*wei_h(jele, jg);
%                 force = F(d,e,sig)*J*J*wei_g(iele, ig)*wei_h(jele, jg);
%                 gauss_nbforce(iele, ig, 1) = gauss_nbforce(iele, ig, 1) + force * xx/d;
%                 gauss_nbforce(iele, ig, 2) = gauss_nbforce(iele, ig, 2) + force * yy/d;
%                 gauss_nbforce(iele, ig, 3) = gauss_nbforce(iele, ig, 3) + force * d0/d;
            end
        end
    end
end

spline_neighbour = zeros(iele, 12);
nbforce = zeros(nodenum, 3);
for iele = 1:elenum
      spline_neighbour(iele, :) = get_spline_neighbour(iele, elelist, nodex, nodey);
      for ig = 1:12
           for i = 1:12
               inod = spline_neighbour(iele, i);
               if inod ~= 0
                   nbforce(inod, 1) = nbforce(inod, 1) + gauss_nbforce(iele, ig, 1) * shapef(ig, i);
                   nbforce(inod, 2) = nbforce(inod, 2) + gauss_nbforce(iele, ig, 2) * shapef(ig, i);
                   nbforce(inod, 3) = nbforce(inod, 3) + gauss_nbforce(iele, ig, 3) * shapef(ig, i);
               end
           end
      end
end
