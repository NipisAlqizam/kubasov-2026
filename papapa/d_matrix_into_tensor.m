% функция преобразует матрицу пьезомодулей в тензор
function dtensor = d_matrix_into_tensor (dmatrix)
  % заготовка для тензора на выход из функции
  dtensor=zeros(3,3,3);
  for i=1:3
    for j =1:3
      for k =1:3
        if j==k
          dtensor(i,j,k)=dmatrix(i,j);
        else
          dtensor(i,j,k)=dmatrix(i,9-(j+k))/2;
        end
      end
    end
  end
end
