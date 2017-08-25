function energy = R(d, d0)
% registry-dependent potential
energy = exp(-(d0-3.44)*3.444) * (Rj(sqrt(d^2-d0^2))) - (d/4.68)^(-6) + exp(-(d-4.00)*4.19);

