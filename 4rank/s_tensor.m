clear all;
% матрица податливостей для керамики PZT 855
s_E_matrix=zeros(6,6); % ТПа^-1

s_E_matrix(1,1) = 16.5;
s_E_matrix(3,3) = 20.7;
s_E_matrix(4,4) = 43.5;
s_E_matrix(6,6) = 42.6;
s_E_matrix(1,2) = -4.78;
s_E_matrix(1,3) = -8.45;

s_E_matrix(2,2) = s_E_matrix(1,1);
s_E_matrix(5,5) = s_E_matrix(4,4);
s_E_matrix(2,1) = s_E_matrix(1,2);
s_E_matrix(2,3) = s_E_matrix(1,3);
s_E_matrix(3,2) = s_E_matrix(2,3);
s_E_matrix(3,1) = s_E_matrix(1,3);

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

theta = 0:15:360; %поворот вокруг x3
phi = 0: 15: 180; %потворот вокруг x2'



s_E_33 = zeros(length(theta),length(phi));
% заготовка для значений продольного коэффициента
tic
for i=1:length(theta)
  for j=1:length(phi)
    % матрица поворота СК для каждой пары углов тета, фи генерируем
    rot_matrix=roty(phi(j))'*rotz(theta(i))';
    % самый неоптимальный вариант
    % считаем всю матрицу на каждой итерации, каждый коэффициент из 27
     s_E_tensor_new=s_tensor_rotate(s_E_tensor, rot_matrix);

    s_E_33(i,j)=s_E_tensor_new(3,3,3,3);


    % 1 оптимизация
    % d_tensor_new = d_tensor_d33_rotate(d_tensor, rot_matrix);
    % d33(i,j) = d_tensor_new(3,3,3);

    % оптимизированный вариант через матричные умножения
    %d_tensor_new = d_tensor_rotate_fast(d_tensor, rot_matrix);

    %d33(i, j) = d_tensor_new(3,3,3);

    % оптимизированный вариант без перехода к тензору
    %d_matrix_new = dmatrix_rotate(d_matrix, rot_matrix);
    %d33(i,j) = d_matrix_new(3,3);

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
