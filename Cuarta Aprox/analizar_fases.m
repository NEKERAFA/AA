function [hypnogram_salida] = analizar_fases (hypnogramV)
    
    hypnogram_salida = zeros(4,length(hypnogramV));

    %bucle que recorre el hipnograma
    for i=1:length(hypnogramV)
        %valor de la posicion
        hypnogram = hypnogramV(i);
        
        %algoritmo de deteccion de la fase
        if ((hypnogram == 3) || (hypnogram == 4))
            hypnogram_salida(3,i) = 1;
        elseif (hypnogram == 5)
            hypnogram_salida(4,i) = 1;
        else
            hypnogram_salida(hypnogram,i) = 1;
        end
    end
end