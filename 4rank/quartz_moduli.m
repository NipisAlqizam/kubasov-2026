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

% задача №3: построить графики зависимости модуля Юнга, Пуассона
% и модуля сдвига от угла вокруг нормали к плоскости пластинки
% кварца SC-среза

% расчитаем полный тензор упругих податливостей для SC среза
s_E_tensor_SC = s_tensor_rotate(s_E_tensor, rotx(-33.88)'*rotz(22.4)');

phi = 0:2:360; % поворот вокруг x2'

s11_SC = zeros(size(phi));
s12_SC = zeros(size(phi));
s13_SC = zeros(size(phi));

for i = 1:length(phi)
  s_E_SC = s_tensor_rotate_fast(s_E_tensor_SC, roty(phi(i))');

  s11_SC(i) = s_E_SC(1, 1, 1, 1);
  s12_SC(i) = s_E_SC(1, 1, 2, 2);
  s13_SC(i) = s_E_SC(1, 1, 3, 3);
end

figure
plot(phi, 1./s11_SC, 'DisplayName', 'Модуль Юнга');
grid on
grid minor
legend

figure
plot(phi, -s13_SC./s11_SC, 'DisplayName', 'Коэффициент Пуассона в плоскости пластинки');
hold on
plot(phi, -s12_SC./s11_SC, 'DisplayName', 'Коэффициент Пуассона перпендикулярно плоскости пластинки');
grid on
grid minor
legend

figure
plot(phi, 1./(2*(s11_SC - s13_SC)), 'DisplayName', 'Модуль сдвига в плоскости пластинки');
hold on
plot(phi, 1./(2*(s11_SC - s12_SC)), 'DisplayName', 'Модуль сдвига перпендикулярно плоскости пластинки');
grid on
grid minor
legend

% полярные графики

figure
polar(deg2rad(phi), 1./s11_SC);
grid on
grid minor
legend ('Модуль Юнга');

figure
polar(deg2rad(phi), -s13_SC./s11_SC);
hold on
polar(deg2rad(phi), -s12_SC./s11_SC);
grid on
grid minor
legend ('Коэффициент Пуассона в плоскости пластинки', 'Коэффициент Пуассона перпендикулярно плоскости пластинки')

figure
polar(deg2rad(phi), 1./(2*(s11_SC - s13_SC)));
hold on
polar(deg2rad(phi), 1./(2*(s11_SC - s12_SC)));
grid on
grid minor
legend ('Модуль сдвига в плоскости пластинки', 'Модуль сдвига перпендикулярно плоскости пластинки')

