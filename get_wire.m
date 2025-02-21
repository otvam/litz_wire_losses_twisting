function  [n, design] = get_wire()
% Get the wire geometry.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2016-2020, ETH Zurich, T. Guillod
% (c) 2025-2025, Dartmouth College, T. Guillod
% Published under the 2-Clause BSD License
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% load the wire geometry
geom = load('geom.mat');
n = geom.n;
x_vec = geom.x_vec;
y_vec = geom.y_vec;
d_strand = geom.d_strand;

%% compute the wire parameters
d_cond = 2.*max(hypot(x_vec, y_vec))+d_strand;
fill = (n.*(d_strand./2).^2)./((d_cond./2).^2);

%% define parameters
sigma = 5.7e7;
d_pole = 1.0;
l_wire = 0.5;

%% set the parameters
design.n = n; % number of strands
design.fill = fill; % wire copper fill factor
design.sigma = sigma; % strand conductivitiy
design.x_vec = x_vec; % x-coordinates of the strands
design.y_vec = y_vec; % y-coordinates of the strands
design.l_wire = l_wire; % total length of the wire
design.d_strand = d_strand; % diameter of the strands
design.d_cond = d_cond; % external diameter of the wire
design.d_pole = d_pole; % pole distance (self-inductance in 2D is infinite)

end