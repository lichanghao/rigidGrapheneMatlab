function rot_elenum = find_rot_elenum(rot_mid, xmax, ymax, edgex, edgey, xelenum)

xx = rot_mid(1,1);
yy = rot_mid(2,1);

if xx > xmax
    xx = xmax - 0.001;
end
if xx < 0
    xx = 0.001;
end
if yy > ymax
    yy = ymax - 0.001;
end
if yy < 0
    yy = 0.001;
end

xnum = floor(xx/edgex) + 1;
ynum = floor(yy/edgey);
rot_elenum = 2*(ynum * xelenum + xnum) - 1;
