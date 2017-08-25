clear;
for i = 1:61
   d0 = (3.42) * 0.1;
   AA(i) = VdwGaussian(d0, 3.1415926/2/90 * (i-1)*2, 'gaussian');
   AB(i) = VdwGaussian(d0, 3.1415926/2/90 * (i-1)*2, 'gaussian');
end
AA = AA./10000;
AB = AB./10000;

XX = 0:0.5:120;
IA = interp1(0:2:120, AA, XX, 'spline');


plot(XX, IA, 'LineWidth', 2);
hold on
xlabel('Rotation Angle/deg');
ylabel('Interation/(meV/atom)');
title('Interlayer Interations');


