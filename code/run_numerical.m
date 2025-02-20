function [I_vec, P_vec] = run_numerical(design)
% numerical solution for the losses of a Litz wire with custom twisting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extract the matrices
n = design.n;
x_vec = design.x_vec;
y_vec = design.y_vec;
sigma = design.sigma;
d_strand = design.d_strand;
d_pole = design.d_pole;
[R_mat, L_mat, H_mat] = get_matrix(n, x_vec, y_vec, sigma, d_strand, d_pole);

% extract the skin and proximity coefficients
f = design.f;
sigma = design.sigma;
d = design.d_strand;
coeff = get_bessel_coeff(sigma, d, f);

% solve the current sharing problem
I_vec = get_current_sharing(design, R_mat, L_mat);

% evaluate the losses of the strands
P_vec = get_losses_sum(design, coeff, H_mat, I_vec);

end

