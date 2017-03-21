clear all;
close all;

% BD procesada
bd_proc = 'bd_proc';

% Numero de veces que se entrena el clasificador
n = 5;

% Capas ocultas en RNA
hiddenSize = [8 3];

% Preparamos los patrones para pasarselos despues al clasificador
disp('Preparando entradas y salidas deseadas...');
[entradas, salidas_deseadas] = procesado_patrones(bd_proc);
salidas_deseadas = salidas_deseadas(1,:);

% Fracción de muestras mal clasificadas
conf = zeros(3,n);

mejor_conf = 1;


% Entrenamos el clasificador varias veces
for i=1:n
    
    % Entrenamos el clasificador
    [rna, tr] = entrenar(entradas, salidas_deseadas, hiddenSize);
    
    % Porcentaje de patrones escogidos para validación y test
    valRatio = rna.divideParam.valRatio;
    testRatio = rna.divideParam.testRatio;
    
    % Obtenemos los patrones utilizados como entrenamiento, test y
    % validación
    targets_test = entradas(:,tr.testInd);
    targets_train = entradas(:,tr.trainInd);
    targets_val = entradas(:,tr.valInd);
    
    % Obtenemos las salidas de la red para los patrones de cada conjunto
    outputs_test = rna(targets_test);
    outputs_train = rna(targets_train);
    outputs_val = rna(targets_val);
    
    % Obtenemos la confusión para cada conjunto
    conf_actual_test = confusion(salidas_deseadas(:,tr.testInd), outputs_test);
    conf_actual_train = confusion(salidas_deseadas(:,tr.trainInd), outputs_train);
    conf_actual_val = confusion(salidas_deseadas(:,tr.valInd), outputs_val);
    conf(1,i) = conf_actual_test;
    conf(2,i) = conf_actual_train;
    conf(3,i) = conf_actual_val;
    
    % Guardamos los datos de la mejor RNA
    if (conf_actual_test < mejor_conf)
        mejor_rna = rna;
        mejor_target_test = salidas_deseadas(:,tr.testInd);
        mejor_outputs_test = outputs_test;
        mejor_conf = conf_actual_test;
    end
end

% Media de las confusiones
mean_conf_test = mean2(conf(1,:));
mean_conf_train = mean2(conf(2,:));
mean_conf_val = mean2(conf(3,:));
desv_conf_test = std(conf(1,:));
desv_conf_train = std(conf(2,:));
desv_conf_val = std(conf(3,:));

plotconfusion(mejor_target_test,mejor_outputs_test);