function force = F(d, e, sig)
% 6-12 Leonard-Jones potential
force = -4*e*(1/sig)*(-12*(sig/d)^13 + 6*(sig/d)^7);