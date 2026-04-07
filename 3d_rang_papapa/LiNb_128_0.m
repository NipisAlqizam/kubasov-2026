clear all;
d_matrix =  [0     0     0     0      68   -42;...
             -21   21    0     68     0     0;...
             -1    -1    6     0      0     0]; %пКл/Н или м/В

% стандартный метод
% перенесём ряд действий в функции
d_tensor=d_matrix_into_tensor(d_matrix);

% для ниобата лития
% первый поворот вокруг оси X
theta = 128; % в градусах
% второй поворот вокруг оси Y' <=> X2'
phi = 0; % в градусах

% матрица общего поворота СК
rot_matrix = roty(phi)'*rotx(theta)';

%посчитать один раз матрицу в новой ск повернутой
d_tensor_new = d_tensor_rotate(d_tensor, rot_matrix);

%переводим тензор в матрицу
d_matrix_new = dtensor2matrix(d_tensor_new);

% поворот на 128 градусов вокруг оси x1 для получения 
% y+128 градусного среза
d_tensor_128 = d_tensor_rotate_fast(d_tensor, rotx(128)');
% d_matix_128 = dmatrix_rotate(d_matrix, rotx(128)')

phi = 0:1:360; % поворот вокруг x2 (нормаль к пластинке среза y+128)
d23_128 = zeros(size(phi));

for i = 1:length(phi)
  d_128 = d_tensor_rotate_fast(d_tensor_128, roty(phi(i))');
  d23_128(i) = d_128(2, 3, 3);
end

figure
plot(phi, d23_128);
grid on
grid minor

% полярный график
d23_128_pos = zeros(size(phi));
d23_128_neg = zeros(size(phi));

d23_128_pos(d23_128 >= 0) = d23_128(d23_128 >= 0);
d23_128_neg(d23_128 < 0) = abs(d23_128(d23_128 < 0));

figure
polar(deg2rad(phi), d23_128_pos, '-g'); % не работает
hold on;
polar(deg2rad(phi), d23_128_neg, '--r');
grid on
grid minor
