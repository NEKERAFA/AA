function [ media_v, desv_v ] = analizar_EEG( eeg_v, n )
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
    
    for i=1:length(marcos)
        % Hay que hacerle un fftshift a fft en el momento de representar
        % para que ordene las frecuencias de forma ascendente:
        % fft Devuelve de n a f/2 y luego la parte negativa del espectro
    end
end

