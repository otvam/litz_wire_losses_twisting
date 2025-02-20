function plot_field(design, v_vec, name)
% plot the absolute value of a scalar field for the different strands
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