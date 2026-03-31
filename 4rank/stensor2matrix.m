function smatrix = stensor2matrix (stensor)
  %заготовка для матрицы dmatrix
  smatrix=zeros(3,6);
  % пробегаем по всем коэффициентам тензора
  for i=1:3
    for j=1:3
      for k=1:3
        for l=1:3
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

          % составляем матрицу
          if (m <= 3) && (n <=3)
            smatrix(m,n) = stensor(i,j,k,l);
          elseif (m > 3) && (n > 3)
            smatrix(m,n) = stensor(i,j,k,l)*4;
          else
            smatrix(m,n) = stensor(i,j,k,l)*2;
          end
        end
      end
    end
  end

end
