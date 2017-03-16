function [rna, tr] = entrenar(entradas, salidas, hiddenSize)

    disp('Empezando entrenamiento');
    % Configuramos la red de neuronas artificiales
    rna = patternnet(hiddenSize);
    rna.trainParam.showWindow=0;
    rng('shuffle');
    % Comenzamos el entrenamiento con las Entradas y Salidas calculadas
    [rna, tr] = train(rna, entradas, salidas);
end
