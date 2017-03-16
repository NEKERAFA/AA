function [model, confusiones_test] = entrenarsvm(entradas, salidas)

    % entradas: nº patrones x nº características = N x 3
    % salidas_deseadas: nº estados x nº patrones = 2 x N

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
    model = fitcsvm(entradas_training, salidas_training);
   
    disp('Obteniendo particiones test');
    entradas_test = entradas(particion.test(1),:);
    %salidas_deseadas_test = salidas(particion.test(1),:);
    salidas_deseadas_test = salidas(particion.test(1));
    
    % Probamos los patrones de test
    disp('Probando los patrones de test');
    [salidas_test scores] = predict(model, entradas_test);
    
    confusiones_test = confusion(salidas_deseadas_test, salidas_test');
end
