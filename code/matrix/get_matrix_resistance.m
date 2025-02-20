function R = get_matrix_resistance(n, sigma, d_strand)
% compute the resistance matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

R = 1./(sigma.*pi.*(d_strand./2.0).^2);
R = diag(R.*ones(1, n));

end
