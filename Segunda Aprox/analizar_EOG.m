function [ desv_v ] = analizar_eog( eog_v, n )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    % Se obtiene el vector con las posiciones que indican el inicio de cada
    % marco
    pos_marcos = [0:n:length(eog_v)-1 length(eog_v)];
    
    % Se obtiene cada marco pasandole el vector origen y el vector con los
    % tamaños de cada marco
    marcos = mat2cell(eog_v, diff(pos_marcos));
    
    % Inicializamos los vectores de medias y deviaciones
    desv_v = zeros(length(marcos), 1);

    % Recorremos los marcos
    for i=1:length(marcos)
        % Calculamos su deviación típica
        desv_v(i) = std(marcos{i});
    end
end

