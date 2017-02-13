function entrenar( nombre)

    disp('Empezando entrenamiento');
    bd_datos = load(nombre);
    
    % Nombre del campo temperatura
    temp = 'Temp_body';
    
    % Nombre del campo del hypnograma
    salidas_deseadas = 'Hypnograma';

    % Obtener el nombre de los sujetos en la bd
    nombre_sujetos = fieldnames(bd_datos);
    
    % Número de marcos
    n_marcos = length(bd_datos.(nombre_sujetos{1}).(temp));
    
    % Número de estados a clasificar
    n_estados = 2;
    
    % Capas ocultas
    hiddenSize = [5];
    
    % Como se recorre la BD
    % Para cada sujeto
    for sujeto=1:length(nombre_sujetos)
        % Para cada marco
        for marco=1:n_marcos
            Entradas(1, marco) = sujeto.(temp)(marco);
            %Entradas(2, marco) = media_eeg
            %Entradas(3, marco) = desv_eeg
            SalidasDeseadas(:,marco) = zeros(1, n_estados);
            estado = sujeto.(salidas_deseadas)(marco);
            SalidasDeseadas(estado,marco) = 1;
        end
    end
    
    rna = patternnet(hiddenSize);
    rna = train(rna, Entradas, SalidasDeseadas);
    
        