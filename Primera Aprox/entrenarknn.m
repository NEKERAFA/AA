function [model, particion] = entrenarknn(entradas, salidas)
%Entrena un sistema knn a partir de unas entradas y unas salidas deseadas
%   También se encarga de realizar la división en patrones de entrenamiento
%   y test

    disp('Empezando entrenamiento');
    % Dividimos entrenamiento y test
    % Nos quedamos solo con la primera fila de salidas
    salidas = salidas(1,:);
    particion = cvpartition(salidas, 'holdout',1/3);
    entradas_training = entradas(particion.training(1),:);
    %salidas_training = salidas(particion.training(1),:);
    salidas_training = salidas(particion.training(1));
    
    % Configuramos el sistema
    disp('Configurando el sistema knn');
    model = fitcknn(entradas_training, salidas_training, 'NumNeighbors', 3);

end

