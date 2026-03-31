function dmatrix_new = dmatrix_rotate (dmatrix, A)
  % заготовка для ответа
  dmatrix_new = zeros(3,6);

  % матрица обратного поворота
  A_inv = A';

  % заготовка для матрицы A^(T)
  A_T = zeros (6,6);

  A_T(1:3, 1:3) = A_inv.*A_inv;

  % нижняя левая четверть
  A_T(4, 1:3) = A_inv(2, :).*A_inv(3, :);
  A_T(5, 1:3) = A_inv(3, :).*A_inv(1, :);
  A_T(6, 1:3) = A_inv(1, :).*A_inv(2, :);

  % верхняя правая четверть
  A_T(1:3, 4) = 2*A_inv(:, 2).*A_inv(:, 3);
  A_T(1:3, 5) = 2*A_inv(:, 3).*A_inv(:, 1);
  A_T(1:3, 6) = 2*A_inv(:, 1).*A_inv(:, 2);

  % нижняя правая четверть

  %{

  тут мы заполним матрицу A_T

  %}

  % коэффциенты матрицы d в повернутой СК
  dmatix_new = A*dmatrix*A_T;
endfunction
