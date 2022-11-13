function [data_cell,parameter_struct,ind_data]=separatedataparameter(varargin)
%% Split numeric data and graphical settings in plotting
% 
% Inputs:
% varargins: inputs from function
%
% Outputs:
% data_cell: cell with numeric data
% parameter_struct: struct with plotting parameters
% ind_data: index of data among all varargins
%
%%

% Split where numeric data ends
ind_data=nargin;
for k=1:nargin
    if ischar(varargin{k}) | isstruct(varargin{k})
        ind_data=k-1; break;
	end
end

data_cell=varargin(1:ind_data);

parameters=varargin(ind_data+1:end);

if isempty(parameters)
    parameter_struct=struct();
    return
end

% Check if input consist of parameters in cell, and then one struct at end with several parameters
for k=1:length(parameters)
    
    struct_at_end=false;
    if isstruct(parameters{k})
        struct_at_end=true;
        ind_struct=k; break
    end
    
end

if struct_at_end
    
    % Cell part
    parameter_struct_1=convertcs(parameters(1:(ind_struct-1)));
    
    % Struct part at end
    parameter_struct_2=parameters{ind_struct};

    % Merge to one struct
    parameter_struct=mergestruct(parameter_struct_1,parameter_struct_2);
    
else
    
    % Conver to struct
    parameter_struct=convertcs(parameters(:));
    
end




