% расчёт координаты тензора dtensor в ск, описываемой поворотом матрицей А
function dtensor_new = d_tensor_rotate (dtensor_old, A)
  dtensor_new=zeros(3,3,3); %заготовка для выходного тензора
  for i=1:3                 % проходим по всем коэффициентам тензора в повернутой СК
    for j=1:3
      for k=1:3
        % Суммируем по всем координатам тензора в старой СК
        for l=1:3
          for m=1:3
            for n=1:3
              dtensor_new(i,j,k)=dtensor_new(i,j,k)+...
                dtensor_old(l,m,n)*A(i,l)*A(j,m)*A(k,n);
            endfor
          end
        end
       end
    end
  end



end
