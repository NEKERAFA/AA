function [hypnogram_salida] = analizar_fases (hypnogramV)
    
    hypnogram_salida = zeros(3,length(hypnogramV));

    %bucle que recorre el hipnograma
    for i=1:length(hypnogramV)
        %valor de la posicion
        hypnogram = hypnogramV(i);
        
        %algoritmo de deteccion de la fase
        if (hypnogram == 0) 
            hypnogram_salida(1,i) = 1;
        elseif ((hypnogram == 5) || (hypnogram == 1))
            hypnogram_salida(2,i) = 1;
        else
            hypnogram_salida(3,i) = 1;
        end
    end
end