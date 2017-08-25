%==============================================================
% FileName: get_ref_atom_pos.m
% Description: Get referential position of atoms in their elements
% Author: Changhao Li
% Date created: 17 Jul 2017
% Version: 1.00
% Date last revised: 17 Jul 2017
% Revised by: Changhao Li
%==============================================================
function ref_atom_pos = get_ref_atom_pos(atom, atom_ele, nodedof, elelist, edgelenx, edgeleny)
%==============================================================
% input parameters
% atom(natom, 2): all dofs of atoms
% atom_ele(natom): generated by get_atom_ele.m
% nodedof(2*nodenum): all dofs of nodes
% elelist(nele, 3): contain node number in elements
% edgelenx: x lenth of element edges, so does edgeleny
% output parameters
% ref_atom_pos(natom, 2): atom position under reference frame
%==============================================================
natom = size(atom, 1);
ref_atom_pos = zeros(natom, 2);
nele = size(elelist, 1);
for i = 1: natom
    iele = atom_ele(i);
    if iele > nele
        disp('error 1'), disp(i), disp(iele)
    end
    if mod(iele, 2) == 0 % if the element is 'reverse triangle element'
        refnode = elelist(iele, 2); % reference node
        ref_atom_pos(i ,1) = -(atom(i, 1) - nodedof(2*refnode - 1)) / edgelenx; % x position
        ref_atom_pos(i ,2) = -(atom(i, 2) - nodedof(2*refnode)) / edgeleny; % y position
    else
        refnode = elelist(iele, 1); % reference node
        ref_atom_pos(i ,1) = (atom(i, 1) - nodedof(2*refnode - 1)) / edgelenx; % x position
        ref_atom_pos(i ,2) = (atom(i, 2) - nodedof(2*refnode)) / edgeleny; % y position
    end
end

