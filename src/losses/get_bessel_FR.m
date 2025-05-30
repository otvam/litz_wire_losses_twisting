function FR = get_bessel_FR(sigma, d, f)
% Compute the Bessel functions for the skin losses in a round wire.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2016-2020, ETH Zurich, T. Guillod
% (c) 2025-2025, Dartmouth College, T. Guillod
% Published under the 2-Clause BSD License
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% get the skin depth
mu0 = 4*pi*1e-7;
delta = 1./sqrt(pi.*mu0.*sigma.*f);
chi = d./(sqrt(2).*delta);

% coefficient for the skin effect
num_1 = KelvinBer(0,chi).*KelvinBei(1,chi)-KelvinBer(0,chi).*KelvinBer(1,chi);
num_2 = KelvinBei(0,chi).*KelvinBer(1,chi)+KelvinBei(0,chi).*KelvinBei(1,chi);
den = KelvinBer(1,chi).^2+KelvinBei(1,chi).^2;
FR = chi./(4.*sqrt(2)).*((num_1-num_2)./den);

end

function out = KelvinBer(v,x)
% Get the Kelvin function (real part).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

out = real(besselj(v, x.*exp(3.*1i.*pi./4)));

end

function out = KelvinBei(v,x)
% Get the Kelvin function (image part).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

out = imag(besselj(v, x.*exp(3.*1i.*pi./4)));

end
