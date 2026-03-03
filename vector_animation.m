%============================
%      анимация поворота

clear;
v = [1/sqrt(3); 1/sqrt(3); 1/sqrt(3)]; % единичный вектор
%                    декартовой СК, отсекающий одинаковые
%                    отрезки по осям



% построим в поле графика исходный базис
e1 = [1;0;0];
e2 = [0;1;0];
e3 = [0;0;1];

figure;
hold on;
quiver3(0, 0, 0, e1(1), e1(2), e1(3),    1,...
       'MaxHeadSize', 0.05, 'Color', 'red',...
       'LineStyle', '--', 'DisplayName', 'x_{old}');
quiver3(0, 0, 0, e2(1), e2(2), e2(3),    1,...
       'MaxHeadSize', 0.05, 'Color', 'g',...
       'LineStyle', '--', 'DisplayName', 'y_{old}');
quiver3(0, 0, 0, e3(1), e3(2), e3(3),    1,...
       'MaxHeadSize', 0.05, 'Color', 'b',...
       'LineStyle', '--', 'DisplayName', 'z_{old}');
quiver3(0, 0, 0, v(1), v(2), v(3),    1,...
       'MaxHeadSize', 0.05, 'Color', 'k',...
       'LineStyle', '-', 'DisplayName', 'v');

daspect([1 1 1]);
xlabel('e_{1}', 'FontSize', 15);
ylabel('e_{2}', 'FontSize', 15);
zlabel('e_{3}', 'FontSize', 15);

legend('FontSize', 15);

view([120 30]); % угол зрения на график

angle_inc = 2; % шаг для поворота СК

% необходимо поворачивать СК e1 e2 e3 в неподвижной СК Octave
% => относимся к векторам e1 e2 e3 как к обычным

% углы в градусах
alpha = 60; % Z'
beta = 46;  % X'
gamma = 70; % Z''

A_z1 = rotz(alpha);
A_x2 = rotx(beta);
A_z3 = rotz(gamma);

alpha_array = angle_inc: angle_inc: alpha;
beta_array = angle_inc: angle_inc: beta;
gamma_array = angle_inc: angle_inc: gamma;

% сохраним исходные векторы базиса
e1_prev = e1;
e2_prev = e2;
e3_prev = e3;

v_prev = v;

% заготовки для координат повернутых векторов базиса
e1_next = zeros(size(e1));
e2_next = e1_next;
e3_next = e1_next;

v_next = e1_next;


A_z = rotz(angle_inc);

% Поворот вокруг Z на alpha
for k=1:length(alpha_array)
  % строим исходные (не повернутые) векторы заново (базиса и е)
  quiver3(0, 0, 0,...
        e1(1), e1(2), e1(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'r',...
        'LineStyle','--','DisplayName','x_{old}');
  hold on;
  quiver3(0, 0, 0,...
        e2(1), e2(2), e2(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'g',...
        'LineStyle','--','DisplayName','y_{old}');

  quiver3(0, 0, 0,...
        e3(1), e3(2), e3(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'blue',...
        'LineStyle','--','DisplayName','z_{old}');

  quiver3(0, 0, 0,...
        v(1), v(2), v(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'k',...
        'LineStyle','-','DisplayName','v');
        %считаем координаты повернутых векторов вокруг оси z
        % на каждой итерации

  e1_next=A_z*e1_prev;
  e2_next=A_z*e2_prev;
  e3_next=A_z*e3_prev;
  v_next=A_z'*v_prev; % хотим чтоб вектор оставался неподвижен поэтому транспонируем


   quiver3(0, 0, 0,...
        e1_next(1), e1_next(2), e1_next(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'r',...
        'LineStyle','-','DisplayName','x_{new}');
  quiver3(0, 0, 0,...
        e2_next(1), e2_next(2), e2_next(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'g',...
        'LineStyle','-','DisplayName','y_{new}');

  quiver3(0, 0, 0,...
        e3_next(1), e3_next(2), e3_next(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'blue',...
        'LineStyle','-','DisplayName','z_{new}');

  quiver3(0, 0, 0,...
        v(1), v(2), v(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'k',...
        'LineStyle','-','DisplayName','v');
  daspect([1 1 1]);
  xlabel('x','FontSize', 15);
  ylabel('y', 'FontSize',15);
  zlabel('z', 'FontSize',15);
  view([120 30]);
  pause(0.05);
        hold off;
  %обновляем координаты векторов базиса
  e1_prev=e1_next;
  e2_prev=e2_next;
  e3_prev=e3_next;


end

A_x = A_z1*rotx(angle_inc)*A_z1';

% Поворот вокруг Z на alpha
for k=1:length(beta_array)
  % строим исходные (не повернутые) векторы заново (базиса и е)
  quiver3(0, 0, 0,...
        e1(1), e1(2), e1(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'r',...
        'LineStyle','--','DisplayName','x_{old}');
  hold on;
  quiver3(0, 0, 0,...
        e2(1), e2(2), e2(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'g',...
        'LineStyle','--','DisplayName','y_{old}');

  quiver3(0, 0, 0,...
        e3(1), e3(2), e3(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'blue',...
        'LineStyle','--','DisplayName','z_{old}');

  quiver3(0, 0, 0,...
        v(1), v(2), v(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'k',...
        'LineStyle','-','DisplayName','v');
        %считаем координаты повернутых векторов вокруг оси z
        % на каждой итерации

  e1_next=A_x*e1_prev;
  e2_next=A_x*e2_prev;
  e3_next=A_x*e3_prev;
  v_next=A_x'*v_prev; % хотим чтоб вектор оставался неподвижен поэтому транспонируем


   quiver3(0, 0, 0,...
        e1_next(1), e1_next(2), e1_next(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'r',...
        'LineStyle','-','DisplayName','x_{new}');
  quiver3(0, 0, 0,...
        e2_next(1), e2_next(2), e2_next(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'g',...
        'LineStyle','-','DisplayName','y_{new}');

  quiver3(0, 0, 0,...
        e3_next(1), e3_next(2), e3_next(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'blue',...
        'LineStyle','-','DisplayName','z_{new}');

  quiver3(0, 0, 0,...
        v(1), v(2), v(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'k',...
        'LineStyle','-','DisplayName','v');
  daspect([1 1 1]);
  xlabel('x','FontSize', 15);
  ylabel('y', 'FontSize',15);
  zlabel('z', 'FontSize',15);
  view([120 30]);
  pause(0.05);
        hold off;
  %обновляем координаты векторов базиса
  e1_prev=e1_next;
  e2_prev=e2_next;
  e3_prev=e3_next;


end

A_z = rotz(angle_inc);
rotation = A_z1*A_x2;
A_z = rotation*A_z*rotation';
e3_next
A_z*e3_next


% Поворот вокруг Z на alpha
for k=1:length(gamma_array)
  % строим исходные (не повернутые) векторы заново (базиса и е)
  quiver3(0, 0, 0,...
        e1(1), e1(2), e1(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'r',...
        'LineStyle','--','DisplayName','x_{old}');
  hold on;
  quiver3(0, 0, 0,...
        e2(1), e2(2), e2(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'g',...
        'LineStyle','--','DisplayName','y_{old}');

  quiver3(0, 0, 0,...
        e3(1), e3(2), e3(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'blue',...
        'LineStyle','--','DisplayName','z_{old}');

  quiver3(0, 0, 0,...
        v(1), v(2), v(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'k',...
        'LineStyle','-','DisplayName','v');
        %считаем координаты повернутых векторов вокруг оси z
        % на каждой итерации

  e1_next=A_z*e1_prev;
  e2_next=A_z*e2_prev;
  e3_next=A_z*e3_prev;
  v_next=A_z'*v_prev; % хотим чтоб вектор оставался неподвижен поэтому транспонируем


   quiver3(0, 0, 0,...
        e1_next(1), e1_next(2), e1_next(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'r',...
        'LineStyle','-','DisplayName','x_{new}');
  quiver3(0, 0, 0,...
        e2_next(1), e2_next(2), e2_next(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'g',...
        'LineStyle','-','DisplayName','y_{new}');

  quiver3(0, 0, 0,...
        e3_next(1), e3_next(2), e3_next(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'blue',...
        'LineStyle','-','DisplayName','z_{new}');

  quiver3(0, 0, 0,...
        v(1), v(2), v(3),...
        1, 'MaxHeadSize', 0.05, 'Color', 'k',...
        'LineStyle','-','DisplayName','v');
  daspect([1 1 1]);
  xlabel('x','FontSize', 15);
  ylabel('y', 'FontSize',15);
  zlabel('z', 'FontSize',15);
  view([120 30]);
  pause(0.05);
        hold off;
  %обновляем координаты векторов базиса
  e1_prev=e1_next;
  e2_prev=e2_next;
  e3_prev=e3_next;


end
