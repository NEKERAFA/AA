function [temp_v] = normalizar_temp (temp_v)
%normalizar_temp Obtiene un valor normalizado de una distribuci�n
% caracterizada por los argumentos media y desviaci�n t�pica.
%       normalizar_temp( temp_v )
%           � temp_v: Vector columna con los datos de las temperaturas

    % Se calcula la media y la desviaci�n t�pica del vector temperatura
    media = mean(temp_v);
    desv = std(temp_v);
    
    % Se normaliza con media - desviaci�n
    temp_v = (temp_v - media) / desv;
   
end
