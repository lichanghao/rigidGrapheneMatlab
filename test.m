clear;

% x = 0; y = 0; xx = 0; yy = 0; xedge = 0.2; yedge = 0.2; 
%sigma = 0.142/6;

% 1/(2*pi*sigma^2) * exp(-(((x-xx)*xedge)^2+((y-yy)*yedge)^2)/(2*sigma^2))

% [x y]=meshgrid(0:0.001:0.2);
% z = 1/(2*pi*sigma^2).*exp((-(x-0.1).^2-(y-0.1).^2)/(2*sigma^2)) ;
% h= mesh(x,y,z);
% set(h,'edgecolor','none','facecolor','interp'); 

%N = Bspline(1,-1);
%sum(N);

elenum = size(elelist, 1);
theta = 3.1415926/2;
%==============================================================
%==============================================================
% indent is relative displacement of two graphene sheets, theta is relative
%  rotational angle between two sheets
rotation = [cos(theta), -sin(theta); sin(theta), cos(theta)];
ref_point = [8;8];
gauss_pos1 = gauss_pos;
for iele = 1:elenum
    for ig = 1:12
         a(1,1) = gauss_pos(iele, ig, 1);
         a(2,1) = gauss_pos(iele, ig, 2);
         b = rotation* (a-ref_point) + ref_point;
         gauss_pos1(iele, ig, :) = b(:,1);
    end
end