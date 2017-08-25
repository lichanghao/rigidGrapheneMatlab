clear;
xsteps = 25; ysteps = 25;
xmax = 0.5; ymax = 0.5;
data = zeros(xsteps+1, ysteps+1, 2);
A0 = 0.142; % lattice parameter (in nm)

data_dat = fopen('indent_data.dat', 'w');
for i = 0:xsteps % x steps
     for j = 0:ysteps % y steps
         xindent = i*xmax/xsteps;
         yindent = j*ymax/ysteps;
         temp = VdwGaussian(xindent, yindent);
         data(i+1, j+1, 1) = temp(1);
         data(i+1, j+1, 2) = temp(2);
         fprintf(data_dat, '%2.6f %2.6f %8.4f\n', xindent, yindent, data(i+1,j+1,1)/data(i+1,j+1,2));
     end
end


