function GR = get_bessel_GR(sigma, d, f)
% compute the Bessel functions for the proximity losses in a round wire
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% get the skin depth
mu0 = 4*pi*1e-7;
delta = 1./sqrt(pi.*mu0.*sigma.*f);
chi = d./(sqrt(2).*delta);

% coefficient for the proximity effect
num_1 = KelvinBer(2,chi).*KelvinBer(1,chi)+KelvinBer(2,chi).*KelvinBei(1,chi);
num_2 = KelvinBei(2,chi).*KelvinBei(1,chi)-KelvinBei(2,chi).*KelvinBer(1,chi);
den = KelvinBer(0,chi).^2+KelvinBei(0,chi).^2;
GR = -chi.*pi.^2.*d.^2./(2.*sqrt(2)).*((num_1+num_2)./den);

end

function out = KelvinBer(v,x)
% get the Kelvin function (real part)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

out = real(besselj(v, x.*exp(3.*1i.*pi./4)));

end

function out = KelvinBei(v,x)
% get the Kelvin function (image part)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

out = imag(besselj(v, x.*exp(3.*1i.*pi./4)));

end
