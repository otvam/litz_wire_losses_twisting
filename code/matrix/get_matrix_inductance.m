function matrix = get_matrix_inductance(x_vec, y_vec, d_strand, d_pole)
% compute the resistance matrix (including the contribution of the background field)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% inductance matrix between the conductors
L = get_L_intern(x_vec, y_vec, d_strand, d_pole);

% add the contribution from the background field
mu0 = 4*pi*1e-7;
L_ext_x = -mu0.*y_vec.';
L_ext_y = -mu0.*x_vec.';

% assign matrices
matrix.self = L;
matrix.ext_x = L_ext_x;
matrix.ext_y = L_ext_y;

end

function L = get_L_intern(x_vec, y_vec, d_strand, d_pole)
% get the inductance matrix between the conductor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% find the distance between the original conductors
[x_c_mat_1,x_c_mat_2] = get_matrix_coordinate(x_vec, x_vec);
[y_c_mat_1,y_c_mat_2] = get_matrix_coordinate(y_vec, y_vec);
d_square_mat = (x_c_mat_1-x_c_mat_2).^2+(y_c_mat_1-y_c_mat_2).^2;

% correction if the conductor radius if the field is evaluated inside a conductor
r_conductor_square = (d_strand./2.0).^2.*exp(-1.0./2.0);
d_square_mat(logical(eye(size(d_square_mat)))) = r_conductor_square;

% compute the matrix
L = get_L_sub(d_pole, d_square_mat);

end

function L = get_L_sub(d_pole, d_square_mat)
% get the inductance between conductors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compute the inductance
mu0 = 4*pi*1e-7;
d_pole_square = d_pole.^2;
cst = mu0./(2.0.*pi);
L = cst.*(0.5.*log(d_pole_square./d_square_mat));

% remove the ill-defined elements
idx_nan = d_square_mat==0;
L(idx_nan) = 0.0;

end

function [v1_mat,v2_mat] = get_matrix_coordinate(v1, v2)
% meshgrid the space formed by two vectors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

v1_mat = (v1.')*ones(1,length(v2));
v2_mat = ones(length(v1),1)*v2;

end
