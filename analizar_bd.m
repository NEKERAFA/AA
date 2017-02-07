function analizar_bd( nombre, salida )
%analizar_bd Lee de una bd y procesa los campos
    % Cargar la BD
    disp('Cargando BD');
    bd_entrada = load(nombre);
    
    % Muestras por marco (30s)
    f_temp = 1;
    marco_temp = f_temp*30;
    
    % Nombre del campo temperatura
    temp = 'Temp_body';

    % Obtener el nombre de los sujetos en la bd
    nombre_sujetos = fieldnames(bd_entrada);

    % BD procesada
    bd_salida = struct;
    
    % Como se recorre la BD
    for i=1:length(nombre_sujetos)
        % Obtenemos el sujeto
        sujeto = bd_entrada.(nombre_sujetos{i});
        disp(strcat('Analizando sujeto', {' '}, nombre_sujetos{i}));
        % Analizamos la temperatura del sujeto
        if isfield(sujeto, temp)
            temp_sujeto = analizar_temp(sujeto.(temp), marco_temp);
            % Añadimos el campo a la bd de salida
            bd_salida.(nombre_sujetos{i}).(temp) = temp_sujeto;
        end
    end

    % Cerramos la primera BD
    clear bd_entrada;
    % Guardamos la segunda BD
    % -struct guarda los campos de la bd por separado
    save(salida, '-struct', 'bd_salida');
end

