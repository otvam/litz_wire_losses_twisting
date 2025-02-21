function [P_tot, P_skin, P_proxy_int, P_proxy_ext] = run_analytical_litz(design)
% Analytical formula for the losses of a perfectecly twisted Litz wire
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2016-2020, ETH Zurich, T. Guillod
% (c) 2025-2025, Dartmouth College, T. Guillod
% Published under the 2-Clause BSD License
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extract the skin and proximity coefficients
f = design.f;
sigma = design.sigma;
d_strand = design.d_strand;
l_wire = design.l_wire;
coeff = get_bessel_coeff(sigma, d_strand, f);

% compute the losses
[P_tot, P_skin, P_proxy_int, P_proxy_ext] = get_losses(coeff, design);

% scale losses
P_tot = l_wire.*P_tot;
P_skin = l_wire.*P_skin;
P_proxy_int = l_wire.*P_proxy_int;
P_proxy_ext = l_wire.*P_proxy_ext;

end

function [P_tot, P_skin, P_proxy_int, P_proxy_ext] = get_losses(coeff, design)
% Compute the losses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extract the data
FR = coeff.FR;
GR = coeff.GR;
R_dc = coeff.R_dc;

% extract the data
n = design.n;
I = design.I;
H_x = design.H_x;
H_y = design.H_y;
d_cond = design.d_cond;

% skin effect losses
P_skin = (n.*R_dc.*FR).*(abs(I)./n).^2;

% internal proximity losses
area = pi.*(d_cond./2.0).^2;
H_int_square = 1./(8.*pi);
P_proxy_int = (H_int_square./area).*(n.*R_dc.*GR).*abs(I).^2;

% external proximity losses
P_proxy_ext = n.*R_dc.*GR.*hypot(H_x, H_y).^2;

% sum the spectral components
P_tot = sum(P_skin+P_proxy_int+P_proxy_ext);

end