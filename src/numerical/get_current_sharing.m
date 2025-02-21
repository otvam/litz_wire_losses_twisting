function I_sharing_vec = get_current_sharing(design, R_mat, L_mat)
% Solve the current sharing problem between the strands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2016-2020, ETH Zurich, T. Guillod
% (c) 2025-2025, Dartmouth College, T. Guillod
% Published under the 2-Clause BSD License
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extract the data
n = design.n;
f = design.f;
I = design.I;
H_x = design.H_x;
H_y = design.H_y;
perm = design.perm;
l_wire = design.l_wire;

% compute the impedance and the induced voltage
s = 2.*pi.*1i.*f;
Z_self = s.*L_mat.self+R_mat;
V_ext = s.*L_mat.ext_x.*H_x+s.*L_mat.ext_y.*H_y;

% twisting of the wire (permutation)
Z_self = permute_matrix(n, Z_self, perm, l_wire);
V_ext = permute_vector(n, V_ext, perm, l_wire);

% set the equation system (the strands are parallel connected)
A = [Z_self -eye(n, n) zeros(n,1) ; ones(1, n) zeros(1, n+1) ; zeros(n, n) eye(n, n) -ones(n,1)];
b = [-V_ext ; I ; zeros(n,1)];

% solve the current sharing problem
x = A\b;

% extract the strand currents
I_sharing_vec = x(1:n);

end

function mat_perm = permute_matrix(n, mat, perm, l_wire)
% Compute the permutations for the a matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mat_perm = zeros(n, n);

for i=1:length(perm)
    idx = perm{i};
    wgt = 1./length(perm);

    rev = zeros(1, length(idx));
    rev(idx) = 1:length(idx);

    mat_perm = mat_perm+l_wire.*wgt.*mat(rev, rev);
end

end

function vec_perm = permute_vector(n, vec, perm, l_wire)
% Compute the permutations for the a vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vec_perm = zeros(n, 1);

for i=1:length(perm)
    idx = perm{i};
    wgt = 1./length(perm);

    rev = zeros(1, length(idx));
    rev(idx) = 1:length(idx);

    vec_perm = vec_perm+l_wire.*wgt.*vec(rev);
end

end