clear all;

x = -20:0.5:20;
y = -15:0.5:15;

[X, Y] = meshgrid(x,y);

Z = exp(-(X.^2+Y.^2)).*cos(3*X).*cos(3*Y);
surf(X, Y, Z);
shading interp;
colorbar;
xlabel('x axis');
ylabel('y axis');
zlabel('Z_{result}')
title('surface graph', 'fontsize', 20);

DATA=[y' Z];
DATA = [0 x; DATA];

dlmwrite('xyZ.csv', DATA, ',')
