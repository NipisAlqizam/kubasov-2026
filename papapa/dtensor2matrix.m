

function dmatrix = dtensor2matrix (dtensor)
  %заготовка для матрицы dmatrix
  dmatrix=zeros(3,6);
  % пробегаем по всем коэффициентам тензора
  for i=1:3;
    for j=1:3;
      for k=1:3;
        if j==k
          dmatrix(i,j)=dtensor(i,j,k);
        else
          dmatrix(i,9-(j+k))=dtensor(i,j,k)*2;
        end
      end
    end
  end

end
