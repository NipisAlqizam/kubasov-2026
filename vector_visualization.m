% Визуализация вектора-стрелки с помощью команды quiver3
clear

start_point = [0;0;0];
v=[1;2;3];

figure;

quiver3(start_point(1), start_point(2),...
        start_point(3), v(1),v(2), v(3),...
        1, 'maxheadsize', 0.05);

daspect([1 1 1]);
xlabel('x', 'FontSize', 15);
ylabel('y', 'FontSize', 15);
zlabel('z', 'FontSize', 15);

% Расчет координат вектора в повернутой СК
% и расчёт координат повернутого вектора в
% неподвижной СК
% последовательность Эйлеровых поворотов ZXZ

% углы в градусах
alpha = 60; % Z'
beta = 45;  % X'
gamma = 70; % Z''

%A_z1 = [cosd(alpha)  sind(alpha) 0; ...
%        -sind(alpha) cosd(alpha) 0; ...
%        0            0           1]

A_z1 = rotz(alpha)';
A_x2 = rotx(beta)';
A_z3 = rotz(gamma)';

A = A_z3 * A_x2 * A_z1;


v_new = A*v;

% Если бы СК была неподвижна, то
% поворот описывался обратной к A матрицей

%<объяснят на следующей паре>
A_b = rotz(gamma)*rotx(beta)*rotz(alpha);

A_b1 = (A^-1)'


