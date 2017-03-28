clear all;
close all;

% BD procesada
bd_proc = 'bd_proc';

% Numero de veces que se entrena el clasificador
n = 1;

% Preparamos los patrones para pasarselos despues al clasificador
disp('Preparando entradas y salidas deseadas...');
% entradas: nº características x nº patrones = 3 x N
% salidas_deseadas: nº estados x nº patrones = 2 x N
[entradas, salidas_deseadas] = procesado_patrones(bd_proc);

% Fracción de muestras mal clasificadas
conf = zeros(1,n);

mejor_conf = 1;

entradas = entradas';
% Entrenamos el clasificador varias veces
for i=1:n
    % Entrenamos el clasificador
    
    [model, particion] = entrenarsvm(entradas, salidas_deseadas);
    
    disp('Obteniendo particiones test y train');
    entradas_test = entradas(particion.test(1),:);
    entradas_train = entradas(particion.training(1),:);
    salidas = salidas_deseadas(1,:);
    salidas_deseadas_test = salidas(particion.test(1));
    salidas_deseadas_train = salidas(particion.training(1));
    
    % Probamos los patrones de test
    disp('Probando los patrones de test y train');
    [salidas_test, scores_test] = predict(model, entradas_test);
    [salidas_train, scores_train] = predict(model, entradas_train);
    
    confusiones_test = confusion(salidas_deseadas_test, salidas_test');
    confusiones_train = confusion(salidas_deseadas_train, salidas_train');
    conf(1,i) = confusiones_test;
    conf(2,i) = confusiones_train;
    if (confusiones_test < mejor_conf)
        mejor_svm = model;
        mejor_particion = particion;
        mejor_target = salidas_deseadas_test;
        mejor_outputs = salidas_test';
        mejor_conf = confusiones_test;
    end
end

% Media de las confusiones
mean_conf_test = mean2(conf(1,:));
mean_conf_train = mean2(conf(2,:));
desv_conf_test = std(conf(1,:));
desv_conf_train = std(conf(2,:));
plotconfusion(mejor_target,mejor_outputs);
