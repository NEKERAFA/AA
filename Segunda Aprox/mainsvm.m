% BD de entrada
bd = 'sleep-EDF';

% BD procesada
bd_proc = 'bd_proc';

% Numero de veces que se entrena el clasificador
n = 1;

% Tipo de clasificador
type = 'rna';

% Capas ocultas en RNA
hiddenSize = [5 4];

% Procesamos los datos de la BD de entrada
%disp('Analizando BD de entrada...');
%analizar_bd(bd, bd_proc);

% Preparamos los patrones para pasarselos despues al clasificador
disp('Preparando entradas y salidas deseadas...');
% entradas: nº características x nº patrones = 3 x N
% salidas_deseadas: nº estados x nº patrones = 2 x N
[entradas, salidas_deseadas] = procesado_patrones(bd_proc);

% Fracción de muestras mal clasificadas
conf = zeros(1,n);

mejor_conf = 1;


% Entrenamos el clasificador varias veces
for i=1:n
    % Dividimos los patrones en conjuntos de entrenamiento y test
    % No necesario en RNA
    if ~strcmp(type, 'rna') 
        disp('Dividiendo en conjuntos de entrenamiento y test...')
        % Aqui futura funcion que divida en conjuntos de entrenamiento y
        % test
        
    end
    
    % Entrenamos el clasificador
    %entradas = entradas';
    %salidas_deseadas = salidas_deseadas';
    [model, confusiones_test] = entrenarsvm(entradas', salidas_deseadas);
    %targets = entradas(:,tr.testInd);
    %outputs = rna(targets);
    %conf_actual = confusion(salidas_deseadas(:,tr.testInd), outputs);
    if (confusiones_test < mejor_conf)
        mejor_svm = model;
        %mejor_target = salidas_deseadas(:,tr.testInd);
        %mejor_outputs = outputs;
        mejor_conf = confusiones_test;
    end
    
    conf(i) = confusiones_test;
end

% Media de las confusiones
%conf = conf/n;
mean_conf = mean2(conf);
desv_conf = std(conf);

%plotconfusion(mejor_target,mejor_outputs);
