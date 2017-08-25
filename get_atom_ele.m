%==============================================================
% FileName: get_atom_ele.m
% Description: Find which element the gauss points belong to
% Author: Changhao Li
% Date created: 17 Jul 2017
% Version: 1.00
% Date last revised: 17 Jul 2017
% Revised by: Changhao Li
%==============================================================
function atom_ele = get_atom_ele(atom, nodedof, elelist, edgelenx, edgeleny, nelex, xmax, ymax)
%==============================================================
% input parameters
% atom(natom, 2): all dofs of atoms
% nodedof(2*nodenum): all dofs of nodes
% elelist(nele, 3): contain node number in elements
% edgelenx: x lenth of element edges, so does edgeleny
% nelex: the number of element in x direction
% xmax: the maximum of x coordinate, so does ymax
% output parameters
% atom_ele(natom): atom(i) is the number of element that the ith atom belongs
%==============================================================
natom = size(atom, 1);
nele = size(elelist, 1);
atom_ele = zeros(natom,1);
  
for i = 1:natom
    
    % boundary approximation    
    if (atom(i, 1) > xmax)
        atom(i, 1) = xmax - 0.001;
    end
    if (atom(i, 1) < 0)
        atom(i, 1) = 0.001;
    end
    if (atom(i, 2) > ymax)
        atom(i, 2) = ymax - 0.001;
    end
    if (atom(i, 2) < 0)
        atom(i, 2) = 0.001;
    end
    
    xx = mod(atom(i, 1), edgelenx);
    yy = mod(atom(i, 2), edgeleny);
    xth = floor(atom(i, 1) / edgelenx);
    yth = floor(atom(i, 2) / edgeleny);
    
    if (xx*edgeleny+yy*edgelenx < edgelenx*edgeleny)
        atom_ele(i) = 2 * (yth*nelex+xth+1) - 1;
    elseif (xx*edgeleny+yy*edgelenx >= edgelenx*edgeleny)
        atom_ele(i) = 2 * (yth*nelex+xth+1);
    end
    
end


