function [R_mat, L_mat, H_mat] = get_matrix(n, x_vec, y_vec, sigma, d_strand, d_pole)
% extract the inductance, magnetic field, and resistance matrices (static matrices)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% inductance
L_mat = get_matrix_inductance(x_vec, y_vec, d_strand, d_pole);

% magnetic field
H_mat = get_matrix_field(n, x_vec, y_vec);

% resistance
R_mat = get_matrix_resistance(n, sigma, d_strand);

end