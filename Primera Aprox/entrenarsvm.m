function [model, particion] = entrenarsvm(entradas, salidas)

    % entradas: n� patrones x n� caracter�sticas = N x 3
    % salidas_deseadas: n� estados x n� patrones = 2 x N

    disp('Empezando entrenamiento');
    %entradas = entradas';
    % Dividimos entrenamiento y test
    salidas = salidas(1,:);
    % Nos quedamos solo con la primera fila de salidas
    particion = cvpartition(salidas, 'holdout',1/3);
    entradas_training = entradas(particion.training(1),:);
    %salidas_training = salidas(particion.training(1),:);
    salidas_training = salidas(particion.training(1));
    
    % Configuramos la svm
    disp('Configurando la svm');
    %rna = patternnet([8]);
    %[model, confusiones_test] = train(rna, entradas_training', salidas_training');
    model = fitcsvm(entradas_training, salidas_training, 'KernelFunction', 'rbf');
end
