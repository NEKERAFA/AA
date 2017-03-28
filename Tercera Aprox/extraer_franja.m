function [franja] = extraer_franja (transformada, x1, x2)

Xdef = fftshift(transformada);
fs = 100;
L = length(transformada);
f=-fs/2+fs/L:fs/L:fs/2;
selector = (f >= x1) & (f <= x2);
franja = Xdef(selector);
%plot(f(selector), abs(Xdef(selector)/max(abs(Xdef(selector)))));
end