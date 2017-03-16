function [temp_v] = normalizar_temp (temp_v)
%normalizar_temp Obtiene un valor normalizado de una distribución caracterizada por los argumentos media y desviación típica.
%       normalizar_temp( temp_v )
%           · temp_v: Vector columna con los datos de las temperaturas

    media = mean(temp_v);
    desv = std(temp_v);
    
    temp_v = (temp_v - media) / desv;
   
end
