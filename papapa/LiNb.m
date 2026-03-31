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

theta = 0:2:360; %поворот вокруг x1
phi = 0: 2: 180; %потворот вокруг x2'

d33 = zeros(length(theta),length(phi));
% заготовка для значений продольного коэффициента
tic
for i=1:length(theta)
  for j=1:length(phi)
    % матрица поворота СК для каждой пары углов тета, фи генерируем
    rot_matrix=roty(phi(j))'*rotx(theta(i))';
    % самый неоптимальный вариант
    % считаем всю матрицу на каждой итерации, каждый коэффициент из 27
    % d_tensor_new=d_tensor_rotate(d_tensor, rot_matrix);

    %d33(i,j)=d_tensor_new(3,3,3);

    % 1 оптимизация
    % d_tensor_new = d_tensor_d33_rotate(d_tensor, rot_matrix);
    % d33(i,j) = d_tensor_new(3,3,3);

    % оптимизированный вариант через матричные умножения
    %d_tensor_new = d_tensor_rotate_fast(d_tensor, rot_matrix);

    %d33(i, j) = d_tensor_new(3,3,3);

    % оптимизированный вариант без перехода к тензору
    d_matrix_new = dmatrix_rotate(d_matrix, rot_matrix);
    d33(i,j) = d_matrix_new(3,3);

  end
end
toc

% сетка для построения поверхности
[PHI, THETA] = meshgrid(deg2rad(phi), deg2rad(theta));
% переходим в декартову ск
[X, Y, Z] = sph2cart(THETA, -(PHI-pi/2), abs(d33));

figure
surf (X, Y, Z, d33);
shading interp
colorbar
daspect([1, 1, 1]);
% 3д картинка не верна, картинка ниже верна

% построим цветовую карту продольного пьезомодуля

figure
surf(rad2deg(THETA),rad2deg(PHI),d33);
[X, Y, Z] = sph2cart(THETA, -(PHI-pi/2), abs(d33));
daspect([1 1 1]);
shading interp;       % сглаживаем цвета


%повернем камеру
view ([0  90]);
ylim ([0  180]);
xlim ([0  360]);
colorbar;


