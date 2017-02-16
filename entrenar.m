function entrenar(nombre)

    disp('Empezando entrenamiento');
    bd_datos = load(nombre);
    
    % Nombre del campo temperatura
    temp = 'Temp_body';
    
    % Nombre del campo media EEG
    eeg_mean = 'EEG_Fpz_Cz_mean';
    
    % Nombre del campo desviación típica EEG
    eeg_desv = 'EEG_Fpz_Cz_std';
    
    % Nombre del campo del hypnograma
    salidas_deseadas = 'Hypnogram';

    % Obtener el nombre de los sujetos en la bd
    nombre_sujetos = fieldnames(bd_datos);
    
    % NÃºmero de estados a clasificar
    n_estados = 2;
    
    % Capas ocultas
    hiddenSize = [6 3];
    
    % Como se recorre la BD
    % Para cada sujeto
    for i=1:length(nombre_sujetos)
        % NÃºmero de marcos
        n_marcos = length(bd_datos.(nombre_sujetos{i}).(temp));
        sujeto = bd_datos.(nombre_sujetos{i});
        % Para cada marco
        for marco=1:n_marcos
            Entradas(1, marco) = sujeto.(temp)(marco);
            Entradas(2, marco) = sujeto.(eeg_desv)(marco);
            Entradas(3, marco) = sujeto.(eeg_mean)(marco);
            SalidasDeseadas(:,marco) = zeros(1, n_estados);
            estado = sujeto.(salidas_deseadas)(marco);
            SalidasDeseadas(estado+1,marco) = 1;
        end
    end
    
    rna = patternnet(hiddenSize);
    rna = train(rna, Entradas, SalidasDeseadas);
    
        
