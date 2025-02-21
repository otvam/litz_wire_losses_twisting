function [P_tot, P_skin, P_proxy] = run_analytical_plain(design)
% Analytical formula for the losses of a untwisted Litz wire
%    - The strands are not twisted.
%    - The formula for solid wire is used for the complete wire.
%    - The conductictivity is adapted with the fill factor.
%
%    Parameters:
%        design (struct): Structure with the problem definition.
%
%    Returns:
%        P_tot (scalar): Total losses.
%        P_skin (scalar): Skin effect losses.
%        P_proxy (scalar): Proximity effect losses.
%
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
[R_dc, FR, GR] = get_bessel_coeff(sigma.*fill, d_cond, f);

% compute the losses
[P_tot, P_skin, P_proxy] = get_losses(R_dc, FR, GR, design);

% scale losses
P_tot = l_wire.*P_tot;
P_skin = l_wire.*P_skin;
P_proxy = l_wire.*P_proxy;

end

function [P_tot, P_skin, P_proxy] = get_losses(R_dc, FR, GR, design)
% Compute the losses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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