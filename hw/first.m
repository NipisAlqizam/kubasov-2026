x = linspace(-10, 10, 10000);
y1 = sin(x).*exp(x);
y2 = cos(x).*sin(x).*x.^3;
plot(x, y1);
hold on;
plot(x, y2);
