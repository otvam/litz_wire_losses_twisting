function [P_tot, P_skin, P_proxy] = run_analytical_plain(design)
% Analytical formula for the losses of a untwisted Litz wire
%     - the strands are not twisted
%     - the formula for solid wire is used
%     - the conductictivity is adapted with the fill factor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2016-2020, ETH Zurich, T. Guillod
% (c) 2025-2025, Dartmouth College, T. Guillod
% Published under the 2-Clause BSD License
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extract the skin and proximity coefficients
f = design.f;
sigma = design.sigma;
fill = design.fill;
d_cond = design.d_cond;
l_wire = design.l_wire;
coeff = get_bessel_coeff(sigma.*fill, d_cond, f);

% compute the losses
[P_tot, P_skin, P_proxy] = get_losses(coeff, design);

% scale losses
P_tot = l_wire.*P_tot;
P_skin = l_wire.*P_skin;
P_proxy = l_wire.*P_proxy;

end

function [P_tot, P_skin, P_proxy] = get_losses(coeff, design)
% Compute the losses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extract the data
FR = coeff.FR;
GR = coeff.GR;
R_dc = coeff.R_dc;

% extract the data
I = design.I;
H_x = design.H_x;
H_y = design.H_y;

% compute the losses
P_skin = R_dc.*FR.*abs(I).^2;
P_proxy = R_dc.*GR.*hypot(H_x, H_y).^2;

% sum the spectral components
P_tot = sum(P_skin+P_proxy);

end