function [R_mat, L_mat, H_mat] = get_matrix(n, x_vec, y_vec, sigma, d_strand, d_pole)
% Extract the inductance, magnetic field, and resistance matrices (static matrices).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2016-2020, ETH Zurich, T. Guillod
% (c) 2025-2025, Dartmouth College, T. Guillod
% Published under the 2-Clause BSD License
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% inductance
L_mat = get_matrix_inductance(x_vec, y_vec, d_strand, d_pole);

% magnetic field
H_mat = get_matrix_field(n, x_vec, y_vec);

% resistance
R_mat = get_matrix_resistance(n, sigma, d_strand);

end