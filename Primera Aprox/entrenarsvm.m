function [model, particion] = entrenarsvm(entradas, salidas)

    % entradas: nº patrones x nº características = N x 3
    % salidas_deseadas: nº estados x nº patrones = 2 x N

    disp('Empezando entrenamiento');
    % Dividimos entrenamiento y test
    salidas = salidas(1,:);
    % Nos quedamos solo con la primera fila de salidas
    particion = cvpartition(salidas, 'holdout',0.15);
    entradas_training = entradas(particion.training(1),:);
    salidas_training = salidas(particion.training(1));
    
    % Configuramos la svm
    disp('Configurando la svm');
    
    model = fitcsvm(entradas_training, salidas_training, 'KernelFunction', 'rbf');
end
