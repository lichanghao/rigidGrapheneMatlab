function energy_density = E(d, e, sig)
% 6-12 Leonard-Jones potential
energy_density = 4*e*((sig/d)^12 - (sig/d)^6);