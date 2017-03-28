function [ media_v, desv_v, mean_franjas0a5, mean_franjas5a10, desv_franjas0a5, desv_franjas5a10, trans] = analizar_EEG(eeg_v,n)
%analizar_EEG Obtiene las medias y desviaciones de los electroencefalogramas
% en marcos de n muestras
%       analizar_EEG( eeg_v, n )
%           · eeg_v: Vector columna con los datos del electroencefalograma
%           · n: Número de muestras
    
    % Se obtiene el vector con las posiciones que indican el inicio de cada
    % marco
    pos_marcos = [0:n:length(eeg_v)-1 length(eeg_v)];
    
    % Se obtiene cada marco pasandole el vector origen y el vector con los
    % tamaños de cada marco
    marcos = mat2cell(eeg_v, diff(pos_marcos));
    
    % Inicializamos los vectores de medias y deviaciones
    media_v = zeros(length(marcos), 1);
    desv_v = zeros(length(marcos), 1);
     
     mean_franjas0a5 = zeros(length(marcos),1);
     mean_franjas5a10 = zeros(length(marcos),1);
     desv_franjas0a5 = zeros(length(marcos),1);
     desv_franjas5a10 = zeros(length(marcos),1);
   
    % Recorremos los marcos
    for i=1:length(marcos)
        
        % Longitud del marco
        % L = length(marcos{i});
        
        % Calculamos la transformada de Fourier
        transformada = abs(fft(marcos{i}));
        trans(i,:) = transformada;
        
        mean_franjas0a5(i) = mean(extraer_franja(transformada,0,5));
        mean_franjas5a10(i) = mean(extraer_franja(transformada,5,10));
        desv_franjas0a5(i) = std(extraer_franja(transformada,0,5));
        desv_franjas5a10(i) = std(extraer_franja(transformada,5,10));
        
        % Calculamos su media
        media_v(i) = mean(transformada);
        
        % Calculamos su deviación típica
        desv_v(i) = std(transformada);
    end
    
end

