function [ media_v, desv_v, mean_franjas0a5, mean_franjas5a10, desv_franjas0a5, desv_franjas5a10, trans] = analizar_EEG(eeg_v,n)
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
    
    % Inicializamos los vectores de medias y deviaciones
    media_v = zeros(length(marcos), 1);
    desv_v = zeros(length(marcos), 1);
    
    % Pruebas de como coger el fft
     % Xdef = fftshift(fft(marcos{1}));
     % fs = 100;
     % L = length(marcos{1});
     % f=-fs/2+fs/L:fs/L:fs/2;
     % plot(f(L/2:L), abs(Xdef(L/2:L))/max(abs(Xdef(L/2:L))));
     
     mean_franjas0a5 = zeros(length(marcos),1);
     mean_franjas5a10 = zeros(length(marcos),1);
     desv_franjas0a5 = zeros(length(marcos),1);
     desv_franjas5a10 = zeros(length(marcos),1);
   
    % Recorremos los marcos
    for i=1:length(marcos)
        % Hay que hacerle un fftshift a fft en el momento de representar
        % para que ordene las frecuencias de forma ascendente:
        % fft Devuelve de 0 a f/2 y luego la parte negativa del espectro
        % The result of fft is (in your notation) indices (0:N-1)
        % fftshift simply converts that to [(N/2:N-1) (0:(N/2-1))]
        
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

