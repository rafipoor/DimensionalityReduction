clear;
close all;

n = 1000000;
d = 1.1:.1:3;
s = zeros(size(d));
for i = 1:numel(d)
    s(i) = sum((2:n).^(-d(i)));
end

plot(d,s);