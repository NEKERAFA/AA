function [ media_v ] = analizar_temp( temp_v, n )
%analizar_temp Obtiene las medias de las temperaturas en marcos de n
%muestras
%       analizar_temp( temp_v, n )
%           · temp_v: Vector columna con los datos de las temperaturas
%           · n: Número de muestras
    marcos = mat2cell(temp_v, diff([0:n:length(temp_v)-1 length(temp_v)]));
    
    media_v = zeros(length(marcos), 1);
    
    for i=1:length(marcos)
        media_v(i) = mean(marcos{i});
    end
end
