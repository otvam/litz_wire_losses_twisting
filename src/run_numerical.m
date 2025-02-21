function [I_sharing_vec, P_avg_vec, I_avg_vec, H_avg_vec] = run_numerical(design)
% Numerical solution for the losses of a Litz wire with custom twisting.
%
%    Parameters:
%        design (struct): structure with the problem definition.
%
%    Returns:
%        I_sharing_vec (vector): Vector with the complex current for each strands.
%            This corresponds to the complex current in each strands.
%            The strands are spatially moving with the twisting/permutation.
%            Therefore, these currents are not specific to a location.
%        P_avg_vec (vector): Average losses of the strands for the different spatial positions.
%            The losses are computed for each strands and for each permutations.
%            The average of the losses is computed at each location within all the permutations.
%            Therefore, the variable depicts to the average losses for each strand location.
%        I_avg_vec (scalar): Average currents of the strands for the different spatial positions.
%            The curents are computed for each strands and for each permutations.
%            The average of the absolute value is computed at each location within all the permutations.
%            Therefore, the variable depicts to the average current for each strand location.
%        H_avg_vec (scalar): Average fields of the strands for the different spatial positions.
%            The fields are computed for each strands and for each permutations.
%            The average of the field norm is computed at each location within all the permutations.
%            Therefore, the variable depicts to the average field for each strand location.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2016-2020, ETH Zurich, T. Guillod
% (c) 2025-2025, Dartmouth College, T. Guillod
% Published under the 2-Clause BSD License
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
I_sharing_vec = get_current_sharing(design, R_mat, L_mat);

% evaluate the losses of the strands
[P_avg_vec, I_avg_vec, H_avg_vec] = get_losses_sum(design, coeff, H_mat, I_sharing_vec);

end

