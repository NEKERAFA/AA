function analizar_bd( nombre, salida )
%analizar_bd Lee de una bd y procesa los campos
    % Cargar la BD
    disp('Cargando BD');
    bd_entrada = load(nombre);
    
    % Muestras de temperatura por marco (30s)
    f_temp = 1;
    marco_temp = f_temp*30;
    
    % Nombre del campo temperatura
    temp = 'Temp_body';

    % Muestras del electroencefalograma por marco (30s)
    f_eeg = 100;
    marco_eeg = f_eeg*30;
    
    % Nombre del campo del electroencefalograma
    eeg = 'EEG_Fpz_Cz';
    % Obtener el nombre de los sujetos en la bd
    nombre_sujetos = fieldnames(bd_entrada);

    % Nombre del hipnograma (Utilizado para la salida deseada)
    sleep = 'Hypnogram';
    
    % BD procesada
    bd_salida = struct;
    
    % Como se recorre la BD
    for i=1:length(nombre_sujetos)
        % Obtenemos el sujeto
        sujeto = bd_entrada.(nombre_sujetos{i});
        fprintf('Analizando sujeto %s\n', nombre_sujetos{i});
        % Miramos si el sujeto tiene el campo temperatura
        if isfield(sujeto, temp)
            % Analizamos la temperatura del sujeto
            temp_sujeto = analizar_temp(sujeto.(temp), marco_temp);
            
            % Analizamos la media y la desviaci�n t�pica
            [media_sujeto, desviacion_sujeto, mean_franjas0a5, mean_franjas5a10, desv_franjas0a5, desv_franjas5a10, transformada] = analizar_EEG(sujeto.(eeg), marco_eeg);
            
            % Eliminamos los marcos con valor err�neo en el hipnograma
            % Contador de las posiciones borradas
            borrados = 0;
            
            % Nos aseguramos que el hipnograma tiene la misma longitud que
            % el resto de datos
            longitud_marcos = min(length(media_sujeto), length(sujeto.(sleep)));
            hypnogram_sujeto = sujeto.(sleep)(1:longitud_marcos);
            
            for j = 1:longitud_marcos
                if ((sujeto.(sleep)(j) == 9)||(sujeto.(sleep)(j) == 6)||(sujeto.(sleep)(j) == 0))
                    temp_sujeto(j-borrados) = [];
                    media_sujeto(j-borrados) = [];
                    desviacion_sujeto(j-borrados) = [];
                    hypnogram_sujeto(j-borrados) = [];
                    mean_franjas0a5(j-borrados) = [];
                    mean_franjas5a10(j-borrados) = [];
                    desv_franjas0a5(j-borrados) = [];
                    desv_franjas5a10(j-borrados) = [];
                    borrados = borrados+1;
                end
            end
           
            % A�adimos los campos a la bd
            bd_salida.(nombre_sujetos{i}).(temp) = temp_sujeto;
            bd_salida.(nombre_sujetos{i}).(strcat(eeg, '_mean')) = media_sujeto;
            bd_salida.(nombre_sujetos{i}).(strcat(eeg, '_std')) = desviacion_sujeto;
            bd_salida.(nombre_sujetos{i}).(strcat(eeg, '_mean_franjas0a5')) = mean_franjas0a5;
            bd_salida.(nombre_sujetos{i}).(strcat(eeg, '_mean_franjas5a10')) = mean_franjas5a10;
            bd_salida.(nombre_sujetos{i}).(strcat(eeg, '_desv_franjas0a5')) = desv_franjas0a5;
            bd_salida.(nombre_sujetos{i}).(strcat(eeg, '_desv_franjas5a10')) = desv_franjas5a10;
            %bd_salida.(nombre_sujetos{i}).(strcat(eeg, '_trans')) = transformada;
            % A�adimos a la bd si el sujeto est� despierto o dormido
            bd_salida.(nombre_sujetos{i}).(sleep) = analizar_fases(hypnogram_sujeto);
        end
    end

    % Cerramos la primera BD
    clear bd_entrada;
    % Guardamos la segunda BD
    % -struct guarda los campos de la bd por separado
    save(salida, '-struct', 'bd_salida');
end

