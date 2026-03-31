clear all;
d_matrix_LN =  [0     0     0     0      68   -42;...
                -21   21    0     68     0     0;...
                -1    -1    6     0      0     0]; %пКл/Н или м/В

% стандартный метод
% перенесём ряд действий в функции
d_tensor_LN=d_matrix_into_tensor(d_matrix_LN);

% для ниобата лития
% первый поворот вокруг оси X
theta_LN = 128; % в градусах
% второй поворот вокруг оси Y' <=> X2'
phi_LN = 0; % в градусах

% матрица общего поворота СК
rot_matrix_LN = roty(phi_LN)'*rotx(theta_LN)';

%посчитать один раз матрицу в новой ск повернутой
d_tensor_new_LN = d_tensor_rotate(d_tensor_LN, rot_matrix_LN);

%переводим тензор в матрицу
d_matrix_new_LN = dtensor2matrix(d_tensor_new_LN)


