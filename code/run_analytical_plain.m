function [P_tot, P_skin, P_proxy] = run_analytical_plain(design)
% analytical formula for the losses of a untwisted Litz wire
%     - the strands are not twisted
%     - the formula for solid wire is used
%     - the conductictivity is adapted with the fill factor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extract the skin and proximity coefficients
f = design.f;
sigma = design.sigma;
fill = design.fill;
d = design.d_cond;
coeff = get_bessel_coeff(sigma.*fill, d, f);

% compute the losses
[P_tot, P_skin, P_proxy] = get_losses(coeff, design);

end

function [P_tot, P_skin, P_proxy] = get_losses(coeff, design)
% compute the losses
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
P_skin = R_dc.*FR.*I.^2;
P_proxy = R_dc.*GR.*hypot(H_x, H_y).^2;

% sum the spectral components
P_tot = sum(P_skin+P_proxy);

end