function logic = isfigure(h_handle)
%% Check if figure
%
% Inputs:
% h_handle: query handle
%
% Outputs:
% logic: true/false 
%
%% 

try
    logic = strcmp(get(h_handle, 'type'), 'figure');
catch
    logic = false;
end
