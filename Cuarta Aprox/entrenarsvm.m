function [models, particion] = entrenarsvm(entradas, salidas)
    % entradas: n� patrones x n� caracter�sticas = N x 3
    % salidas_deseadas: n� estados x n� patrones = 2 x N

    disp('Empezando entrenamiento');
    % Dividimos entrenamiento y test
    particion = cvpartition(salidas(1, :), 'holdout', 0.15);
    
    % Cogemos los datos de entrenamiento
    entradas_training = entradas(:, particion.training(1));
    targets = salidas(:, particion.training(1));
    models = cell(3);
    
    % Iteramos cada clase
    for clase = 1:size(targets);
        salidas_training = targets(clase, :);
        
        % Configuramos la svm
        fprintf('Configurando la svm de la clase %d\n', clase);
        svm = fitcsvm(entradas_training', salidas_training', 'KernelFunction', 'rbf', 'KernelScale', 1.5);

        models{clase} = svm;
    end
end
