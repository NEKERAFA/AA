function representar_marcos (transformada)

Xdef = fftshift(transformada);
fs = 100;
L = length(transformada);
f=-fs/2+fs/L:fs/L:fs/2;
selector = (f >= 0) & (f <= 50);
plot(f(selector), abs(Xdef(selector)/max(abs(Xdef(selector)))));

end