function plot_geom(design, name)
% Plot the wire geometry.
%
%    Parameters:
%        design (struct): Structure with the problem definition.
%        name (string): Title of the plot.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2016-2020, ETH Zurich, T. Guillod
% (c) 2025-2025, Dartmouth College, T. Guillod
% Published under the 2-Clause BSD License
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extract the data
n = design.n;
x_vec = design.x_vec;
y_vec = design.y_vec;
d_strand = design.d_strand;
d_cond = design.d_cond;

% circle boundary
phi = linspace(0, 2.*pi);
x_tmp = sin(phi);
y_tmp = cos(phi);

% plot the strands
figure()
for i=1:n
    x_plt = x_vec(i)+(d_strand./2).*x_tmp;
    y_plt = y_vec(i)+(d_strand./2).*y_tmp;
    plot(1e3.*x_plt, 1e3.*y_plt, 'b')
    hold('on')
end
x_plt = (d_cond./2).*x_tmp;
y_plt = (d_cond./2).*y_tmp;
plot(1e3.*x_plt, 1e3.*y_plt, 'r')
axis('equal')
xlabel('x (mm)')
ylabel('y (mm)')
title(name)

end