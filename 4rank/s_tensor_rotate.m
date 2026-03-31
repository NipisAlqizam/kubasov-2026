% расчёт координаты тензора dtensor в ск, описываемой поворотом матрицей А
function stensor_new = s_tensor_rotate (stensor_old, A)
  stensor_new=zeros(3,3,3,3); %заготовка для выходного тензора
  for i=1:3                 % проходим по всем коэффициентам тензора в повернутой СК
    for j=1:3
      for k=1:3
        for l=1:3
          % Суммируем по всем координатам тензора в старой СК
          for m=1:3
            for n=1:3
              for o=1:3
                for p=1:3
                  stensor_new(i,j,k,l)=stensor_new(i,j,k,l)+...
                                stensor_old(m,n,o,p)*A(i,m)*A(j,n)*A(k,o)*A(l,p);
                end
              end
            end
          end
        end
       end
    end
  end
end
