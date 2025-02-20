function [I_vec, H_x, H_y] = get_current_sharing(design, R_mat, L_mat)
% solve the current sharing problem between the strands
%     - the wires are parallel connected and the total current is imposed
%     - the static inductance and resistance matrices are used
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extract the data
n = design.n;
f = design.f;
I = design.I;
H_x = design.H_x;
H_y = design.H_y;
perm = design.perm;

% compute the impedance and the induced voltage
s = 2.*pi.*1i.*f;
Z_self = s.*L_mat.self+R_mat;
V_ext = s.*L_mat.ext_x.*H_x+s.*L_mat.ext_y.*H_y;

% twisting of the wire (permutation)
Z_self = permute_matrix(n, Z_self, perm);
V_ext = permute_vector(n, V_ext, perm);

% set the equation system (the strands are parallel connected)
A = [Z_self -eye(n, n) zeros(n,1) ; ones(1, n) zeros(1, n+1) ; zeros(n, n) eye(n, n) -ones(n,1)];
b = [-V_ext ; I ; zeros(n,1)];

% solve the current sharing problem
x = A\b;

% extract the strand currents
I_vec = x(1:n);

end

function mat_perm = permute_matrix(n, mat, perm)
% compute the permutations for the a matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mat_perm = zeros(n, n);

for i=1:length(perm)
    idx = perm{i};
    wgt = 1./length(perm);

    mat_tmp = wgt.*mat(idx, idx);
    mat_perm = mat_perm+mat_tmp;
end

end

function vec_perm = permute_vector(n, vec, perm)
% compute the permutations for the a vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vec_perm = zeros(n, 1);

for i=1:length(perm)
    idx = perm{i};
    wgt = 1./length(perm);

    vec_tmp = wgt.*vec(idx);
    vec_perm = vec_perm+vec_tmp;
end

end