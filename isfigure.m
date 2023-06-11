function logic = isfigure(h_handle)
try
    logic = strcmp(get(h_handle, 'type'), 'figure');
catch
    logic = false;
end
end