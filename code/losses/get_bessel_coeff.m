function coeff = get_bessel_coeff(sigma, d, f)
% compute the Bessel functions for the losses (skin and proximity) in a round wire
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

coeff.FR = get_bessel_FR(sigma, d, f);
coeff.GR = get_bessel_GR(sigma, d, f);
coeff.R_dc = 1./(sigma.*pi.*(d./2.0).^2);

end
