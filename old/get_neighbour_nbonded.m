%==============================================================
% FileName: get_neighbour_bonded.m
% Description: find bonded neighbour of every gauss point(distance <= A0)
% Author: Changhao Li
% Date created:20 Jul 2017
% Version: 1.00
% Date last revised: 20 Jul 2017
% Revised by: Changhao Li
%==============================================================
function ele_neighbour_nbonded = get_neighbour_nbonded(elelist, nodedof, xele, yele, d0, xindent, yindent, theta, edgex, edgey, xmax, ymax, c_r)
%==============================================================
% input parameters:
% d0: z-direction distance between two planar sheets
% xindent: relative displacement between two sheets in x-direction
% yindent: relative displacement between two sheets in y-direction
% output parameter:
% gauss_neighbour_nbonded(ngauss, max_nei+1)
%==============================================================

nele = xele*yele*2;
xeleindent = fix(xindent / edgex);
yeleindent = fix(yindent / edgey);
xx = mod(xindent, edgex);
yy = mod(yindent, edgey);

inplane_c_r = sqrt(c_r^2 - d0^2);
xele_cut = fix(inplane_c_r/edgex);
yele_cut = fix(inplane_c_r/edgey);

all_num = (2*xele_cut+1) * (2*yele_cut+1) * 2; % maximum number of neighbour elements
ele_neighbour_nbonded = zeros(nele, all_num);

for iele = 0: yele-1
    for jele = 1: xele
%==============================================================       
% determine the neighbour rectangular region, whose diagonal is (x1, y1)
% to (x2, y2).      x1, x2, y1, y2 is line or column number of elements
        if(iele - yele_cut - yeleindent >= 0)
            y1 = iele - yele_cut - yeleindent;
        else
            y1 = 0;
        end
        if(iele + yele_cut - yeleindent <= yele - 1)
            y2 = iele + yele_cut - yeleindent;
        else
            y2 = yele - 1;
        end
        if(jele - xele_cut - xeleindent >= 1)
            x1 = jele - xele_cut - xeleindent;
        else
            x1 = 1;
        end        
        if(jele + xele_cut - xeleindent <= xele)
            x2 = jele + xele_cut - xeleindent;
        else
            x2 = xele;
         end   
%==============================================================
% Find neighbour
% note:  ele_neighbour_nbonded(i, 1) is the number of neighbour elements of
% ith element
        for i = 0: y2-y1
            for j = 0: x2-x1
                ele_neighbour_nbonded(2*(iele*xele + jele) - 1, 2*(i*(x2-x1+1)+j+1)-1 + 1) = 2*((y1+i)*(xele)+(j+x1)) - 1;
                ele_neighbour_nbonded(2*(iele*xele + jele) - 1, 2*(i*(x2-x1+1)+j+1) + 1) = 2*((y1+i)*(xele)+(j+x1));
                ele_neighbour_nbonded(2*(iele*xele + jele)  , 2*(i*(x2-x1+1)+j+1)-1 + 1) = 2*((y1+i)*(xele)+(j+x1)) - 1;
                ele_neighbour_nbonded(2*(iele*xele + jele)  , 2*(i*(x2-x1+1)+j+1) + 1) = 2*((y1+i)*(xele)+(j+x1)) ;
                
                ele_neighbour_nbonded(2*(iele*xele + jele) - 1, 1) = ele_neighbour_nbonded(2*(iele*xele + jele) - 1, 1) + 2;
                ele_neighbour_nbonded(2*(iele*xele + jele), 1) = ele_neighbour_nbonded(2*(iele*xele + jele), 1) + 2;
            end
        end
    end
end

rot_ele_neighbour_nbonded = ele_neighbour_nbonded;

if theta ~= 0
     rotation = [cos(theta), -sin(theta); sin(theta), cos(theta)];
     ref_point = [xmax/2; ymax/2];
     for i = 1: elenum
         nod1 = elelist(i,1); nod2 = elelist(i,2); nod3 = elelist(i,3);
         mid = [1/3*(nodedof(2*nod1-1)+nodedof(2*nod2-1)+nodedof(2*nod3-1))...
               ;1/3*(nodedof(2*nod1)+nodedof(2*nod2)+nodedof(2*nod3))];
         rot_mid = rotation*(mid - ref_point) + ref_point;
         rot_elenum = find_rot_elenum(rot_mid, xmax, ymax, edgex, edgey, xele);
         rot_ele_neighbour_nbonded(i, :) = ele_neighbour_nbonded(rot_elenum, :);
     end

end


