function [R_dc, FR, GR] = get_bessel_coeff(sigma, d, f)
% Compute the Bessel functions for the losses (skin and proximity) in a round wire.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2016-2020, ETH Zurich, T. Guillod
% (c) 2025-2025, Dartmouth College, T. Guillod
% Published under the 2-Clause BSD License
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FR = get_bessel_FR(sigma, d, f);
GR = get_bessel_GR(sigma, d, f);
R_dc = 1./(sigma.*pi.*(d./2.0).^2);

end
