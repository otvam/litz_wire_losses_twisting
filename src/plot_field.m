function plot_field(design, v_vec, name)
% Plot the absolute value of a scalar field for the different strands.
%
%    Parameters:
%        design (struct): Structure with the problem definition.
%        v_vec (vector): Variable to be displayed.
%        name (string): Title of the plot.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2016-2020, ETH Zurich, T. Guillod
% (c) 2025-2025, Dartmouth College, T. Guillod
% Published under the 2-Clause BSD License
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extract the data
x_vec = design.x_vec;
y_vec = design.y_vec;

% plot the scalar field
figure()
scatter(x_vec, y_vec, 25, abs(v_vec), 'filled')
colorbar()
axis('equal')
xlabel('x (mm)')
ylabel('y (mm)')
title(name)

end