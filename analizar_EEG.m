function [ media_v, desv_v ] = analizar_EEG( eeg_v, n )
%analizar_EEG Obtiene las medias y desviaciones de los electroencefalogramas
% en marcos de n muestras
%       analizar_EEG( eeg_v, n )
%           · eeg_v: Vector columna con los datos del electroencefalograma
%           · n: Número de muestras

    % Prueba (borrar luego)
    %eeg_v = normalizar_temp(eeg_v);
    
    % Se obtiene el vector con las posiciones que indican el inicio de cada
    % marco
    pos_marcos = [0:n:length(eeg_v)-1 length(eeg_v)];
    
    % Se obtiene cada marco pasandole el vector origen y el vector con los
    % tamaños de cada marco
    marcos = mat2cell(eeg_v, diff(pos_marcos));
    
    % Inicializamos los vectores de medias y dewviaciones
    media_v = zeros(length(marcos), 1);
    desv_v = zeros(length(marcos), 1);
   
    % Recorremos los marcos
    for i=1:length(marcos)
        % Longitud del marco
        L = length(marcos{i});
        
        % Calculamos la transformada de Fourier
        % fft Devuelve de 0 a f/2 la parte positiva, y luego la parte
        % negativa del espectro
        transformada = fft(marcos{i}(1:L/2));
        
        % Calculamos su media
        media_v(i) = abs(mean(transformada));
        
        % Calculamos su deviación típica
        desv_v(i) = std(transformada);
    end
end

