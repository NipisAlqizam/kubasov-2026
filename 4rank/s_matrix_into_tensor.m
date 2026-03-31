% функция преобразует матрицу пьезомодулей в тензор
function stensor = s_matrix_into_tensor (smatrix)
  % заготовка для тензора на выход из функции
  stensor=zeros(3,3,3,3);
  % матричные индексы m и n
  for i=1:3
    for j =1:3
      for k =1:3
        for l = 1:3
          % получаем матричные индексы
          if i == j
            m = i;
          else
            m = 9-(i+j);
          end

          if k == l
            n = k;
          else
            n = 9-(k+l);
          end

          % составляем тензор
          if (m <= 3) && (n <=3)
            stensor(i,j,k,l) = smatrix(m,n);
          elseif (m > 3) && (n > 3)
            stensor(i,j,k,l) = smatrix(m,n)/4;
          else
            stensor(i,j,k,l) = smatrix(m,n)/2;
          end

        end
      end
    end
  end
end
