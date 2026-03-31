clear all;
% матрица податливостей для кристалла кварца
c_E_matrix=zeros(6,6); % ГПа

c_E_matrix(1,1) = 86.74;
c_E_matrix(3,3) = 107.2;
c_E_matrix(4,4) = 57.94;
c_E_matrix(6,6) = 39.88;
c_E_matrix(1,2) = 6.99;
c_E_matrix(1,3) = 11.91;
c_E_matrix(1,4) = 17.91;
c_E_matrix(5,6) = 35.82;

c_E_matrix(2,4) = -c_E_matrix(1,4);

c_E_matrix(2,2) = c_E_matrix(1,1);
c_E_matrix(5,5) = c_E_matrix(4,4);
c_E_matrix(2,1) = c_E_matrix(1,2);
c_E_matrix(2,3) = c_E_matrix(1,3);
c_E_matrix(3,2) = c_E_matrix(2,3);
c_E_matrix(3,1) = c_E_matrix(1,3);
c_E_matrix(4,1) = c_E_matrix(1,4);
c_E_matrix(4,2) = c_E_matrix(2,4);
c_E_matrix(6,5) = c_E_matrix(5,6);


s_E_matrix = c_E_matrix^-1*1000; # ТПа ^ -1

% преобразуем матрицу в тензор
s_E_tensor=s_matrix_into_tensor(s_E_matrix);

% задача №1 посчитать коэффициенты матрицы в повернутой СК

% углы поворота СК
% первый поворот вокруг оси Z <=> X3
theta = 60; % в градусах
% второй поворот вокруг оси Y' <=> X2'
phi = 130; % в градусах

% матрица общего поворота СК
rot_matrix = roty(phi)'*rotz(theta)';

%посчитать один раз матрицу в новой ск повернутой
s_E_tensor_new = s_tensor_rotate(s_E_tensor, rot_matrix);

%переводим тензор в матрицу
s_E_matrix_new = stensor2matrix(s_E_tensor_new);

%задача 2: построить поверхность


%из трех продольных ПЭ коэф выбираем d33

theta = 0:2:360; %поворот вокруг x3
phi = 0: 2: 180; %потворот вокруг x2'



s_E_33 = zeros(length(theta),length(phi));
% заготовка для значений продольного коэффициента
tic
for i=1:length(theta)
  for j=1:length(phi)
    % матрица поворота СК для каждой пары углов тета, фи генерируем
    rot_matrix=roty(phi(j))'*rotz(theta(i))';
    % самый неоптимальный вариант
    % считаем всю матрицу на каждой итерации, каждый коэффициент из 27
    % s_E_tensor_new=s_tensor_rotate(s_E_tensor, rot_matrix);

    % s_E_33(i,j)=s_E_tensor_new(3,3,3,3);


    % 1 оптимизация
    % d_tensor_new = d_tensor_d33_rotate(d_tensor, rot_matrix);
    % d33(i,j) = d_tensor_new(3,3,3);

    % оптимизированный вариант через матричные умножения
    %d_tensor_new = d_tensor_rotate_fast(d_tensor, rot_matrix);

    %d33(i, j) = d_tensor_new(3,3,3);

    % оптимизированный вариант без перехода к тензору
    s_E_matrix_new = smatrix_rotate(s_E_matrix, rot_matrix);
    s_E_33(i,j) = s_E_matrix_new(3,3);

  end
end

% модуль Юнга в направлении оси x3
Y_33=1./s_E_33;
toc
% сетка для построения поверхности
[PHI, THETA] = meshgrid(deg2rad(phi), deg2rad(theta));
% переходим в декартову ск
[X, Y, Z] = sph2cart(THETA, -(PHI-pi/2), abs(s_E_33));
[X_Y, Y_Y, Z_Y] = sph2cart(THETA, -(PHI-pi/2), abs(Y_33));


figure
surf (X, Y, Z, s_E_33);
shading interp
colorbar
daspect([1, 1, 1]);

figure
surf (X_Y, Y_Y, Z_Y, Y_33);
shading interp
colorbar
daspect([1, 1, 1]);

% построим цветовую карту продольного пьезомодуля

figure
surf(rad2deg(THETA),rad2deg(PHI),s_E_33);
[X, Y, Z] = sph2cart(THETA, -(PHI-pi/2), abs(s_E_33));
daspect([1 1 1]);
shading interp;       % сглаживаем цвета


%повернем камеру
view ([0  90]);
ylim ([0  180]);
xlim ([0  360]);
colorbar;

figure
surf(rad2deg(THETA),rad2deg(PHI),Y_33);
[X, Y, Z] = sph2cart(THETA, -(PHI-pi/2), abs(Y_33));
daspect([1 1 1]);
shading interp;       % сглаживаем цвета


%повернем камеру
view ([0  90]);
ylim ([0  180]);
xlim ([0  360]);
colorbar;
