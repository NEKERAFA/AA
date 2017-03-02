% BD de entrada
bd = 'sleep-EDF';

% BD procesada
bd_proc = 'bd_proc';

% Numero de veces que se entrena el clasificador
n = 50;

% Tipo de clasificador
type = 'rna';

% Capas ocultas en RNA
hiddenSize = [6 3];

% Procesamos los datos de la BD de entrada
%disp('Analizando BD de entrada...');
%analizar_bd(bd, bd_proc);

% Preparamos los patrones para pasarselos despues al clasificador
disp('Preparando entradas y salidas deseadas...');
[entradas, salidas_deseadas] = procesado_patrones(bd_proc);

% Fracción de muestras mal clasificadas
conf = 0;
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
    [rna, tr] = entrenar(entradas, salidas_deseadas, hiddenSize);
    targets = entradas(:,tr.testInd);
    outputs = rna(targets);
    conf_actual = confusion(salidas_deseadas(:,tr.testInd), outputs);
    if (conf_actual < mejor_conf)
        mejor_rna = rna;
        mejor_target = salidas_deseadas(:,tr.testInd);
        mejor_outputs = outputs;
        mejor_conf = conf_actual;
    end
    
    conf = conf + conf_actual;
end

% Media de las confusiones
conf = conf/n;

plotconfusion(mejor_target,mejor_outputs);
