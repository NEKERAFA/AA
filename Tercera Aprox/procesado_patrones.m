function [ Entradas, SalidasDeseadas ] = procesado_patrones(nombre)

    disp('Cargando datos')
    bd_datos = load(nombre);
    
    % Nombre del campo temperatura
    temp = 'Temp_body';
    
    % Nombre del campo media EEG
    eeg_mean = 'EEG_Fpz_Cz_mean';
    % Nombre del campo desviación típica EEG
    eeg_desv = 'EEG_Fpz_Cz_std';
    % Nombre de la media de la primera franja:
    mean_franjas0a5 = 'EEG_Fpz_Cz_mean_franjas0a5';    
    % Nombre de la media de la segunda franja:
    mean_franjas5a10 = 'EEG_Fpz_Cz_mean_franjas5a10';  
    % Nombre de la desviación de la primera franja:
    desv_franjas0a5 = 'EEG_Fpz_Cz_mean_franjas0a5';    
    % Nombre de la desviación de la segunda franja:
    desv_franjas5a10 = 'EEG_Fpz_Cz_mean_franjas5a10'; 
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
    Entradas = zeros(5,n_patrones);
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
            %Entradas(4, patron) = sujeto.(mean_franjas0a5)(marco);
            %Entradas(5, patron) = sujeto.(mean_franjas5a10)(marco);
            Entradas(4, patron) = sujeto.(desv_franjas0a5)(marco);
            Entradas(5, patron) = sujeto.(desv_franjas5a10)(marco);
            
            % Obtenemos las salidas deseadas
            SalidasDeseadas(:, patron) = sujeto.(salidas_deseadas)(:, marco);
            % Siguiente patron
            patron = patron + 1;
        end
    end
end

