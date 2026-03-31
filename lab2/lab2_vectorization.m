% vectorization
clear all;
x = linspace(0,1,1E5);
tic
y1 = zeros(size(x));
for i=1:length(x) %1:numel(x)
    y1(i)=sin(x(i))*exp(-x(i));
end
toc

pause
y2 = zeros(size(x));
tic
y2 = sin(x).*exp(-x);
toc

dot(y1-y2, y1-y2)
