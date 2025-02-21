function [P_avg_vec, I_avg_vec, H_avg_vec] = get_losses_sum(design, R_dc, FR, GR, H_mat, I_sharing_vec)
% Compute the losses of the different strands.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2016-2020, ETH Zurich, T. Guillod
% (c) 2025-2025, Dartmouth College, T. Guillod
% Published under the 2-Clause BSD License
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extract the data
n = design.n;
H_x = design.H_x;
H_y = design.H_y;
perm = design.perm;
l_wire = design.l_wire;

% initialize the vectors
P_avg_vec = zeros(n, 1);
I_avg_vec = zeros(n, 1);
H_avg_vec = zeros(n, 1);

% sum the contribution of the different permutations
for i=1:length(perm)
    idx = perm{i};
    wgt = 1./length(perm);

    [I_vec_tmp, H_vec_tmp] = get_excitation_strand(H_mat, H_x, H_y, I_sharing_vec, idx);
    P_vec_tmp = get_losses_strand(R_dc, FR, GR, I_vec_tmp, H_vec_tmp);
    
    P_avg_vec = P_avg_vec+l_wire.*wgt.*P_vec_tmp;
    I_avg_vec = I_avg_vec+wgt.*I_vec_tmp;
    H_avg_vec = H_avg_vec+wgt.*H_vec_tmp;
end

end


function [I_vec, H_vec] = get_excitation_strand(H_mat, H_x, H_y, I_sharing_vec, idx)
% Compute the current and magnetic field for the different strands.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% permute the current
I_vec = I_sharing_vec(idx);

% extract the magnetic field
H_x_vec = H_mat.x*I_vec+H_x;
H_y_vec = H_mat.y*I_vec+H_y;
H_vec = hypot(H_x_vec, H_y_vec);

% extract the current field
I_vec = abs(I_vec);

end

function P_vec = get_losses_strand(R_dc, FR, GR, I_vec, H_vec)
% Compute the skin and proximity losses for a given excitation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compute the losses
P_skin = R_dc.*FR.*I_vec.^2;
P_proxy = R_dc.*GR.*H_vec.^2;
P_vec = P_skin+P_proxy;

end