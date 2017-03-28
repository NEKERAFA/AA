function [salidasKnnBinario] = toBinary(salidasKnn)
%Transforma las salidas de un sistema knn (vector columna) en una matriz de
%n filas (1 por estado) y m columnas (1 por patrón), donde matriz[ni,mi]==1
%si el patrón mi pertenece a la clase ni
    
    % Creamos la variable de salida
    salidasKnnBinario = zeros(max(salidasKnn), length(salidasKnn));

    for i=1:length(salidasKnn)
       switch salidasKnn(i)
           case 1
               salidasKnnBinario(1,i) = 1;
           case 2
               salidasKnnBinario(2,i) = 1;
           case 3
               salidasKnnBinario(3,i) = 1;
       end
    end

end

