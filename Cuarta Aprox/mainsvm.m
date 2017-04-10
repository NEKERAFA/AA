clear all;
close all;

% BD procesada
bd_proc = 'bd_proc';

% Numero de veces que se entrena el clasificador
n = 1;

% Preparamos los patrones para pasarselos despues al clasificador
disp('Preparando entradas y salidas deseadas...');
% entradas: nº características x nº patrones = 3 x N
% salidas_deseadas: nº estados x nº patrones = 3 x N
[entradas, salidas_deseadas] = procesado_patrones(bd_proc);

% Fracción de muestras mal clasificadas
conf = zeros(1,n);

mejor_conf = 1;

% Entrenamos el clasificador varias veces
for i=1:n
    % Entrenamos el clasificador
    [models, particion] = entrenarsvm(entradas, salidas_deseadas);
    
    % Probamos los patrones totales
    disp('Probando los patrones de test y train');
    salidas = zeros(length(salidas_deseadas), 4);
    scores = zeros(length(salidas_deseadas), 4);
    
    % Lanzamos un predict para cada clase
    for clase = 1:size(salidas_deseadas)
        % Cogemos las entradas de test
        [clases, scores_clase] = predict(models{clase}, entradas');
        scores(:, clase) = scores_clase(:, 2);
    end
    
    % Recorremos los patrones para saber de que clase es
    for patron = 1:length(salidas_deseadas)
        scores_patron = scores(patron, :);
        salidas_patron = max(scores_patron) == scores_patron;
        salidas(patron, :) = salidas_patron;
    end
    
    % Obtenemos las particiones
    disp('Obteniendo particiones de test y train');
    salidas_deseadas = salidas_deseadas';
    salidas_deseadas_test = salidas_deseadas(particion.test(1), :);
    salidas_deseadas_train = salidas_deseadas(particion.training(1), :);
    salidas_test = salidas(particion.test(1), :);
    salidas_train = salidas(particion.training(1), :);
    % Lo permuto para que no haga cosas raras en la siguiente iteración
    salidas_deseadas = salidas_deseadas';
    
    confusiones_test = confusion(salidas_deseadas_test', salidas_test');
    confusiones_train = confusion(salidas_deseadas_train', salidas_train');
    conf(1,i) = confusiones_test;
    conf(2,i) = confusiones_train;
    if (confusiones_test < mejor_conf)
        mejor_svm = models;
        mejor_particion = particion;
        mejor_target = salidas_deseadas_test';
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
