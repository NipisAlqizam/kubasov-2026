% расчёт координаты тензора dtensor в ск, описываемой поворотом матрицей А
function dtensor_new = d_tensor_rotate_fast (dtensor_old, A)
  dtensor_new=zeros(3,3,3); %заготовка для выходного тензора

  % матрица обратного поворота (транспонированная А)
  A_inv = A';

  % трехмерный массив для результатов временного умножения (заготовка)
  tmp = dtensor_new;

  tmp(:, :, 1) = A*dtensor_old(:, :, 1) * A_inv;
  tmp(:, :, 2) = A*dtensor_old(:, :, 2) * A_inv;
  tmp(:, :, 3) = A*dtensor_old(:, :, 3) * A_inv;

  % переставим в tmp "измерения" (индексы)
  tmp = permute(tmp, [2, 3, 1]);

  % получаем тензор d в новой системе координат
  dtensor_new(1, :, :) = tmp(:, :, 1) * A_inv;
  dtensor_new(2, :, :) = tmp(:, :, 2) * A_inv;
  dtensor_new(3, :, :) = tmp(:, :, 3) * A_inv;
end
