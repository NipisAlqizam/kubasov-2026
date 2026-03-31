% расчёт координаты тензора dtensor в ск, описываемой поворотом матрицей А
function dtensor_new = d_tensor_d33_rotate (dtensor_old, A)
  dtensor_new=zeros(3,3,3); %заготовка для выходного тензора

        % Суммируем по всем координатам тензора в старой СК
        for l=1:3
          for m=1:3
            for n=1:3
              dtensor_new=dtensor_new+...
                dtensor_old(l,m,n)*A(3,l)*A(3,m)*A(3,n);
            endfor
          end
        end
end
