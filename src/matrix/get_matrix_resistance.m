function R = get_matrix_resistance(n, sigma, d_strand)
% Compute the resistance matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2016-2020, ETH Zurich, T. Guillod
% (c) 2025-2025, Dartmouth College, T. Guillod
% Published under the 2-Clause BSD License
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

R = 1./(sigma.*pi.*(d_strand./2.0).^2);
R = diag(R.*ones(1, n));

end
