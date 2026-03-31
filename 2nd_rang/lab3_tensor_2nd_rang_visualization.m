clear;
% Создадим симметричный тензор 2 ранга (матрица 3 на 3)
S = [10  0   0;
     0  15   0;
     0  0   20];

% сканируем по всему телесному углу,
% достаточно двух поворотов для того,
% чтобы пробежать по всем возможным
% направлениям единичного указательного
% вектора l

% первый поворот на угол theta вокруг оси X3 (Z)
% второй поворот на угол phi вокруг оси X2' (Y')

theta = linspace(0, 360, 101);
phi = linspace(0, 180, 51); % возможно перепутаны

sigma = zeros(length(phi), length(theta));
for i=1:length(phi)
  for j=1:length(theta)

    l = [sind(phi(i))*cosd(theta(j));...
         sind(phi(i))*sind(theta(j));...
         cosd(phi(i))];

    for k = 1:3
      for m = 1:3
        sigma(i,j) = sigma(i,j) + S(k,m) * l(k) * l(m);
      end
    end

  end % endfor в матлабе не работает
end

% создадим сетку
[PHI, THETA] = meshgrid(deg2rad(phi), deg2rad(theta));

% результаты вычисления sigma(i,j) получены
% для сферической СК (sigma(i,j) - длина
% вектора r в направлении l)
% Octave не умеет строить в сферической СК

% транспонируем sigma, чтобы соответствовать размерности PHI и THETA
sigma = sigma';

% перейдём к декартовой прямоугольной СК
% abs(sigma) на случай если радиус-вектор отрицателен
[X, Y, Z] = sph2cart(THETA, -(PHI-pi/2), abs(sigma));

figure
surf(X, Y, Z, sigma);
daspect([1 1 1]);
shading interp;
colorbar;
