clear;
for i = 1:43
   d0 = (2.8 + (i-1)*0.1) * 0.1;
   AA(i) = VdwGaussian(d0, 0, 'gaussian');
   AB(i) = VdwGaussian(d0, 3.1415926/2/90 * 60, 'gaussian');
   HM(i) = VdwGaussian(d0, 0, 'homogenized');
end
AA = AA./10000;
AB = AB./10000;
HM = HM./10000;

plot(2.8 : 0.1 : 7, AA, 'r--o');
hold on
plot(2.8 : 0.1 : 7, AB, 'b--o');
plot(2.8 : 0.1 : 7, HM, 'g--o');
xlabel('Layer seperation/A');
ylabel('Interation/(meV/atom)');
title('Interlayer Interations');


z = 2.8 : 0.01 : 7;
d = 4.68; 
r0 = 4.00;
lamda1 = 4.19;
lamda2 = 3.444;
z0 = 3.44;
delta = 0.568;
C0 = 11.964;
C2 = 6.728;
C4 = -18.418;
C6 = 9.836;
C8 = -1.8938;
C10 = -0.6391;
C12 = 0.08652;

w = 2/(3*sqrt(3)/2*1.42*1.42)*3.1415926*...
    (-d^6/2*z.^(-4) + 2*(1+lamda1*z).*exp(-lamda1*(z-r0))/lamda1^2 ...
    + delta^2*exp(-lamda2*(z-z0))*(1*C0+1*C2+factorial(2)*C4...
    + factorial(3)*C6 + factorial(4)*C8 + factorial(5)*C10 +...
     factorial(6)*C12));

plot(z, w, 'y');
legend('AA Stacking', 'AB Stacking', 'Numerical Homogenized atom distribution', 'Analytical Homogenized atom distribution');