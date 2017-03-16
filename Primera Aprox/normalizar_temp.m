function [temp_v] = normalizar_temp (temp_v)
%normalizar_temp Obtiene un valor normalizado de una distribución
% caracterizada por los argumentos media y desviación típica.
%       normalizar_temp( temp_v )
%           · temp_v: Vector columna con los datos de las temperaturas

    % Se calcula la media y la desviación típica del vector temperatura
    media = mean(temp_v);
    desv = std(temp_v);
    
    % Se normaliza con media - desviación
    temp_v = (temp_v - media) / desv;
   
end
