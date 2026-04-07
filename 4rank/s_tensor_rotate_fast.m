% расчёт координаты тензора stensor в ск, описываемой поворотом матрицей А
function stensor_new = s_tensor_rotate_fast (stensor_old, A)
  stensor_new=zeros(3,3,3,3); %заготовка для выходного тензора

  % матрица обратного поворота (транспонированная А)
  A_inv = A';

  % четырёхмерный массив для результатов временного умножения (заготовка)
  tmp = stensor_new;

  tmp(:, :, 1,1) = A*stensor_old(:, :, 1,1) * A_inv;
  tmp(:, :, 1,2) = A*stensor_old(:, :, 1,2) * A_inv;
  tmp(:, :, 1,3) = A*stensor_old(:, :, 1,3) * A_inv;
  tmp(:, :, 2,2) = A*stensor_old(:, :, 2,2) * A_inv;
  tmp(:, :, 2,3) = A*stensor_old(:, :, 2,3) * A_inv;
  tmp(:, :, 3,3) = A*stensor_old(:, :, 3,3) * A_inv;

  % воспользуемся симметрией по последней паре индексов
  tmp(:, :, 2, 1) = tmp(:, :, 1, 2);
  tmp(:, :, 3, 1) = tmp(:, :, 1, 3);
  tmp(:, :, 2, 3) = tmp(:, :, 3, 2);

  % переставим в tmp "измерения" (индексы)
  tmp = permute(tmp, [3, 4, 1, 2]);

  % получаем тензор s в новой системе координат
  stensor_new(1,1, :, :) = A*tmp(:, :, 1,1) * A_inv;
  stensor_new(1,2, :, :) = A*tmp(:, :, 1,2) * A_inv;
  stensor_new(1,3, :, :) = A*tmp(:, :, 1,3) * A_inv;
  stensor_new(2,2, :, :) = A*tmp(:, :, 2,2) * A_inv;
  stensor_new(2,3, :, :) = A*tmp(:, :, 2,3) * A_inv;
  stensor_new(3,3, :, :) = A*tmp(:, :, 3,3) * A_inv;

  stensor_new(2, 1, :, :) = stensor_new(1, 2, :, :);
  stensor_new(3, 1, :, :) = stensor_new(1, 3, :, :);
  stensor_new(3, 2, :, :) = stensor_new(2, 3, :, :);

end
