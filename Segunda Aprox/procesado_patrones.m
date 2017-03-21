function [ Entradas, SalidasDeseadas ] = procesado_patrones(nombre)

    disp('Cargando datos')
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
    
    % Numero de estados a clasificar
    n_estados = 3;
    
    % Calculamos el num de patrones totales
    n_patrones = 0;
    for i=1:length(nombre_sujetos)
        % Numero de patrones de cada sujeto
        n_patrones = n_patrones + length(bd_datos.(nombre_sujetos{i}).(temp));
    end
    
    % Inicializamos Entradas y SalidasDeseadas
    Entradas = zeros(3,n_patrones);
    SalidasDeseadas = zeros(n_estados, n_patrones);
    
    % Iterador de patrones
    patron = 1;
    
    % Como se recorre la BD
    % Para cada sujeto
    for i=1:length(nombre_sujetos)
        % Numero de marcos
        n_marcos = length(bd_datos.(nombre_sujetos{i}).(temp));
        
        % Sujeto correspondiente a esta iteracion
        sujeto = bd_datos.(nombre_sujetos{i});

        % Para cada marco
        for marco=1:n_marcos
            % Asignamos 3 valores a la entrada correspondiente a este marco
            Entradas(1, patron) = sujeto.(temp)(marco);
            Entradas(2, patron) = sujeto.(eeg_desv)(marco);
            Entradas(3, patron) = sujeto.(eeg_mean)(marco);
            % Obtenemos las salidas deseadas
            SalidasDeseadas(:, patron) = sujeto.(salidas_deseadas)(:, marco);
            % Siguiente patron
            patron = patron + 1;
        end
    end
end

