function run_twisted()
% Compute Litz wire losses with fully twisted strands.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2016-2020, ETH Zurich, T. Guillod
% (c) 2025-2025, Dartmouth College, T. Guillod
% Published under the 2-Clause BSD License
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close('all');
addpath(genpath('src'))

%% get the parameters

% get the wire geometry
[n, design] = get_wire();

% get the permutation between the strands defining the twisting
for i=1:n
    perm{i} = circshift(1:n, i);
end

% set the excitation and twisting
design.f = 250e3; % operating frequency
design.I = 10.0; % total peak current in the wire
design.H_x = 1000.0; % x-component of the background field
design.H_y = 0.0; % y-component of the background field
design.perm = perm; % permutation between the strands defining the twisting

%% plot the geometry
plot_geom(design, 'Geometry');

%% get the analytical solution
[P_tot, P_skin, P_proxy_int, P_proxy_ext] = run_analytical_litz(design);

fprintf('analytical\n')
fprintf('    P_tot = %.3f mW\n', 1e3.*P_tot)
fprintf('    P_skin = %.3f mW\n', 1e3.*P_skin)
fprintf('    P_proxy_int = %.3f mW\n', 1e3.*P_proxy_int)
fprintf('    P_proxy_ext = %.3f mW\n', 1e3.*P_proxy_ext)

%% get the numerical solution
[I_sharing_vec, P_avg_vec, I_avg_vec, H_avg_vec] = run_numerical(design);

plot_field(design, 1e3.*P_avg_vec, 'Losses (mW)');
plot_field(design, 1e3.*I_avg_vec, 'Current (mA)');
plot_field(design, 1e-3.*H_avg_vec, 'Field (kA/m)');
plot_sharing(1e3.*I_sharing_vec, 'Current (mA)');

fprintf('numerical\n')
fprintf('    P_tot = %.3f mW\n', 1e3.*sum(P_avg_vec))
fprintf('    P_std = %.3f mW\n', 1e3.*std(P_avg_vec))
fprintf('    P_mean = %.3f mW\n', 1e3.*mean(P_avg_vec))
fprintf('    err = %.3f %%\n', 1e2.*abs(sum(P_avg_vec)-P_tot)./P_tot)

end