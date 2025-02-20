function run_litz()
% compute Litz wire losses with custom twisting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2016-2020, ETH Zurich, T. Guillod
% (c) 2025-2025, Dartmouth College, T. Guillod
% Published under the 2-Clause BSD License
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close('all');
addpath(genpath('code'))

%% set the twisting type
twisting = 'twisted'; % straight or twisted

%% load the wire geometry
geom = load('geom.mat');

%% set the parameters
design.n = geom.n; % number of strands
design.x_vec = geom.x_vec; % x-coordinates of the strands
design.y_vec = geom.y_vec; % y-coordinates of the strands
design.d_strand = geom.d_strand; % dianeter of the strands
design.d_cond = geom.d_cond; % dianeter of the wire
design.fill = geom.fill; % wire copper fill factor

% get the permutation between the strands defining the twisting
switch twisting
    case 'straight' % the strands are not twisted
        perm{1} = 1:geom.n;
    case 'twisted' % the strands are fully twisted
        for i=1:geom.n
            perm{i} = circshift(1:geom.n, i);
        end
    otherwise
        error('invalid twisting')
end

% get the operating frequency
switch twisting
    case 'straight'
        f = 50e3;
    case 'twisted'
        f = 250e3;
    otherwise
        error('invalid twisting')
end

design.sigma = 5.7e7; % strand conductivitiy
design.I = 10.0; % total peak current in the wire
design.H_x = 1000.0; % x-component of the background field
design.H_y = 0.0; % y-component of the background field
design.d_pole = 1.0; % pole distance (self-inductance in 2D is infinite)
design.perm = perm; % permutation between the strands defining the twisting
design.f = f; % operating frequency

%% plot the geometry
plot_geom(design, 'Geometry');

%% get the analytical solution
switch twisting
    case 'straight'
        [P_tot, P_skin, P_proxy] = run_analytical_plain(design);
        fprintf('analytical\n')
        fprintf('    P_tot = %.3f mW\n', 1e3.*P_tot)
        fprintf('    P_skin = %.3f mW\n', 1e3.*P_skin)
        fprintf('    P_proxy = %.3f mW\n', 1e3.*P_proxy)
    case 'twisted'
        [P_tot, P_skin, P_proxy_int, P_proxy_ext] = run_analytical_litz(design);
        fprintf('analytical\n')
        fprintf('    P_tot = %.3f mW\n', 1e3.*P_tot)
        fprintf('    P_skin = %.3f mW\n', 1e3.*P_skin)
        fprintf('    P_proxy_int = %.3f mW\n', 1e3.*P_proxy_int)
        fprintf('    P_proxy_ext = %.3f mW\n', 1e3.*P_proxy_ext)
    otherwise
        error('invalid twisting')
end

%% get the numerical solution
[I_vec, P_vec] = run_numerical(design);
plot_field(design, 1e3.*I_vec, 'Current (mA)');
plot_field(design, 1e3.*P_vec, 'Losses (mW)');
fprintf('numerical\n')
fprintf('    P_tot = %.3f mW\n', 1e3.*sum(P_vec))
fprintf('    P_std = %.3f mW\n', 1e3.*std(P_vec))
fprintf('    err = %.3f %%\n', 1e2.*abs(sum(P_vec)-P_tot)./P_tot)

end