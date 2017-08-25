%==============================================================
% FileName: get_spline_neighbour.m
% Description: Calculate 12 neighbour nodes number for shape function value
% Author: Changhao Li
% Date created: 30 Jul 2017
% Version: 1.00
% Date last revised: 30 Jul 2017
% Revised by: Changhao Li
%==============================================================
function spline_neighbour = get_spline_neighbour(iele, elelist, xnodnum, ynodnum)

nodlist = elelist(iele, :);
spline_neighbour = zeros(12, 1);
zerolist = [];
% normal element
if mod(iele, 2) == 1
    spline_neighbour(1) = nodlist(1) - xnodnum;
    spline_neighbour(2) = nodlist(1) - 1;
    spline_neighbour(3) = spline_neighbour(2) - xnodnum;
    spline_neighbour(4) = nodlist(1);
    spline_neighbour(5) = nodlist(3) - 1;
    spline_neighbour(6) = nodlist(2) - xnodnum + 1;
    spline_neighbour(7) = nodlist(2);
    spline_neighbour(8) = nodlist(3);
    spline_neighbour(9) = nodlist(3) + xnodnum - 1;
    spline_neighbour(10) = nodlist(2) + 1;
    spline_neighbour(11) = nodlist(3) + 1;
    spline_neighbour(12) = nodlist(3) + xnodnum;
    % trivial boundary problem 
    if mod(nodlist(3),xnodnum) == 1 % left
        zerolist = [zerolist, 2, 5, 9];
    end
    if floor(nodlist(1)/xnodnum) == 0 % down
        zerolist = [zerolist, 1, 3, 6];
    end
    if mod(nodlist(2),xnodnum) == 0 % right
        zerolist = [zerolist, 6, 10];
    end
    if floor(nodlist(3)/xnodnum) == ynodnum - 1 % up
        zerolist = [zerolist, 9, 12];
    end
end
% reverse element
if mod(iele, 2) == 0
    spline_neighbour(1) = nodlist(2) + xnodnum;
    spline_neighbour(2) = nodlist(2) + 1;
    spline_neighbour(3) = nodlist(3) + xnodnum;
    spline_neighbour(4) = nodlist(2);
    spline_neighbour(5) = nodlist(1) + 1;
    spline_neighbour(6) = nodlist(3) + xnodnum - 1;
    spline_neighbour(7) = nodlist(3);
    spline_neighbour(8) = nodlist(1);
    spline_neighbour(9) = nodlist(1) - xnodnum + 1;
    spline_neighbour(10) = nodlist(3) - 1;
    spline_neighbour(11) = nodlist(1) - 1;
    spline_neighbour(12) = nodlist(1) - xnodnum + 1;
    % trivial boundary problem 
    if mod(nodlist(3),xnodnum) == 1 % left
        zerolist = [zerolist, 6, 10];
    end
    if floor(nodlist(1)/xnodnum) == 0 % down
        zerolist = [zerolist, 9, 12];
    end
    if mod(nodlist(2),xnodnum) == 0 % right
        zerolist = [zerolist, 2, 5, 9];
    end
    if floor(nodlist(3)/xnodnum) == ynodnum - 1 % up
        zerolist = [zerolist, 1, 3, 6];
    end
end
% trivial boundary problem 
for i = zerolist
    spline_neighbour(i) = 0;
end

 