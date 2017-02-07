% Cargar la BD
bd = load('database')

% Obtener el nombre de los campos
fields = fieldnames(bd)

% Como se recorre la BD
for i=1:length(fields)
    cell = bd.(fields{i})
end