function entrenar(nombre)

    disp('Empezando entrenamiento');
    bd_datos = load(nombre);
    
    % Nombre del campo temperatura
    temp = 'Temp_body';
    
    % Nombre del campo del hypnograma
    salidas_deseadas = 'Hypnogram';

    % Obtener el nombre de los sujetos en la bd
    nombre_sujetos = fieldnames(bd_datos);
    
    % Número de estados a clasificar
    n_estados = 2;
    
    % Capas ocultas
    hiddenSize = [3];
    
    % Como se recorre la BD
    % Para cada sujeto
    for i=1:length(nombre_sujetos)
        % Número de marcos
        n_marcos = length(bd_datos.(nombre_sujetos{i}).(temp));
        sujeto = bd_datos.(nombre_sujetos{i});
        % Para cada marco
        for marco=1:n_marcos
            Entradas(1, marco) = sujeto.(temp)(marco);
            %Entradas(2, marco) = media_eeg
            %Entradas(3, marco) = desv_eeg
            SalidasDeseadas(:,marco) = zeros(1, n_estados);
            estado = sujeto.(salidas_deseadas)(marco);
            SalidasDeseadas(estado+1,marco) = 1;
        end
    end
    
    rna = patternnet(hiddenSize);
    rna = train(rna, Entradas, SalidasDeseadas);
    
        
