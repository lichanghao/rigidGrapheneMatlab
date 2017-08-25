clear;

edge = 0.4; % the length of element edge in x direction
%edgeleny = 0.4; % the length of element edge in y direction
node = 21; % the number of node in x direction
%nodey = 21; % the number of node in y direction
A0 = 0.142; % lattice parameter
sigma = A0/6; % 2D Gauss function parameter
cut_r = 2; % cut-off radius for van der Waals potential
%d0 = 0.342 * 1.0; % z-direction distance between two graphene sheets
%xindent = A0*sqrt(3)*0.4; % x direction relative displacement between two sheets
%yindent = A0*0.7; % y direction relative displacement between two sheets

outputfile1 = fopen('out1.dat', 'w');
fprintf(outputfile1, '%s\t\t %s\t\t %s\t\t %s\t\t %s \n', 'xindent', 'yindent', 'd0', 'edge', 'energy');
parpool(4);
for xx = 0:0.1:1
    for yy = 0:0.1:1
        for dd = 0.8:0.1:1.2
                yindent = yy * A0; xindent = xx * A0 * sqrt(3); 
                d0 = dd * 0.341;
                energy = VdwGaussian(edge, edge, node, node, A0, sigma, cut_r, d0, xindent, yindent);
                fprintf(outputfile1, '%2.6f %2.6f %2.6f %2.6f %12.6f \n', xindent, yindent, d0, edge, energy);
        end
    end
end

edge = 0.2;
node = 41;

outputfile2 = fopen('out2.dat', 'w');
fprintf(outputfile2, '%s  %s  %s  %s  %s \n', 'xindent', 'yindent', 'd0', 'edge', 'energy');
for xx = 0:0.1:1
    for yy = 0:0.1:1
        for dd = 0.8:0.1:1.2
                yindent = yy * A0; xindent = xx * A0 * sqrt(3); 
                d0 = dd * 0.341;
                energy = VdwGaussian(edge, edge, node, node, A0, sigma, cut_r, d0, xindent, yindent);
                fprintf(outputfile2, '%7.6f %7.6f %7.6f %7.6f %12.2f \n', xindent, yindent, d0, edge, energy);
        end
    end
end