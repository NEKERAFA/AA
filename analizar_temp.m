function [ media_v ] = analizar_temp( temp_v, n )
%analizar_temp Obtiene las medias de las temperaturas en marcos de n
%muestras
%       analizar_temp( temp_v, n )
%           · temp_v: Vector columna con los datos de las temperaturas
%           · n: Número de muestras
    % Se obtiene el vector con las posiciones que indican el inicio de cada
    % marco
    pos_marcos = [0:n:length(eeg_v)-1 length(eeg_v)];
    
    % Se obtiene cada marco pasandole el vector origen y el vector con los
    % tamaños de cada marco
    marcos = mat2cell(eeg_v, diff(pos_marcos));
    
    % Se inicializa el vector de medias
    media_v = zeros(length(marcos), 1);
    
    % Se calculan las medias
    for i=1:length(marcos)
        media_v(i) = mean(marcos{i});
    end
end
