function P_vec = get_losses_sum(design, coeff, H_mat, I_vec)
% compute the losses of the different strands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extract the data
n = design.n;
H_x = design.H_x;
H_y = design.H_y;
perm = design.perm;

% initialize the losses
P_vec = zeros(n, 1);

% sum the contribution of the different permutations
for i=1:length(perm)
    idx = perm{i};
    wgt = 1./length(perm);

    I_vec_tmp = I_vec(idx);
    P_vec_tmp = wgt.*get_losses_strand(coeff, H_mat, H_x, H_y, I_vec_tmp);
    P_vec = P_vec+P_vec_tmp;
end

end


function P_vec = get_losses_strand(coeff, H_mat, H_x, H_y, I_vec)
% compute the skin and proximity losses for a given excitation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extract the magnetic field
H_x_vec = H_mat.x*I_vec+H_x;
H_y_vec = H_mat.y*I_vec+H_y;
H_vec = hypot(H_x_vec, H_y_vec);

% compute the losses
P_skin = coeff.R_dc.*coeff.FR.*(abs(I_vec).^2);
P_proxy = coeff.R_dc.*coeff.GR.*(abs(H_vec).^2);
P_vec = P_skin+P_proxy;

end