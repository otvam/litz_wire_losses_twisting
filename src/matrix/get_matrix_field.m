function matrix = get_matrix_field(n, x_vec, y_vec)
% Compute the matrices for computing the magnetic field in the center of the wires
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2016-2020, ETH Zurich, T. Guillod
% (c) 2025-2025, Dartmouth College, T. Guillod
% Published under the 2-Clause BSD License
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% find the distance between the given conductors
[x_mat,x_c_mat] = get_matrix_coordinate(x_vec, x_vec);
[y_mat,y_c_mat] = get_matrix_coordinate(y_vec, y_vec);
d_square_mat = (x_mat-x_c_mat).^2+(y_mat-y_c_mat).^2;
x_mat = x_mat-x_c_mat;
y_mat = y_mat-y_c_mat;

% set the current
I_vec = eye(n, n);

% compute the field
[H_x, H_y] = get_H_xy_sub(x_mat, y_mat, d_square_mat, I_vec);

% assign matrices
matrix.x = H_x;
matrix.y = H_y;

end

function [H_x, H_y] = get_H_xy_sub(x_mat, y_mat, d_square_mat, I_vec)
% Get the vector magnetic field produced by the conductors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compute the distance
H_x_tmp = -y_mat./d_square_mat;
H_y_tmp = x_mat./d_square_mat;

% remove the ill-defined elements
idx_nan = d_square_mat==0;
H_x_tmp(idx_nan) = 0.0;
H_y_tmp(idx_nan) = 0.0;

% compute the field
cst = 1.0./(2.*pi);
H_x = cst.*H_x_tmp*I_vec;
H_y = cst.*H_y_tmp*I_vec;

end

function [v1_mat,v2_mat] = get_matrix_coordinate(v1, v2)
% Meshgrid the space formed by two vectors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

v1_mat = (v1.')*ones(1,length(v2));
v2_mat = ones(length(v1),1)*v2;

end
