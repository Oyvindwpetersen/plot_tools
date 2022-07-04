function logic = isaxes(h_handle)

%% Check if axes
%
% Inputs:
% h_handle: query handle
%
% Outputs:
% 
%
%% 

try
    logic = strcmp(get(h_handle, 'type'), 'axes');
catch
    logic = false;
end
end