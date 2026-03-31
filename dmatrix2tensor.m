% преобразуем матрицу пьезоэлектрических
% коэффициентов в тензор
function dtensor = dmatrix2tensor (dmatrix)
  dtensor = zeros(3,3,3);
  for i=1:3
    for j=1:3
      for k=1:3
        if j == k
          dtensor(i, j, k) = dmatrix(i,j);
        else
          dtensor(i, j, k) = dmatrix(i, 9-j-k)/2;
        end
      end
    end
  end
end
