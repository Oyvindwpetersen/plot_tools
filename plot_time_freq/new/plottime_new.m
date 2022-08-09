function plottime_new(varargin)

%% Input handling

plotdim=2;

% Separate into numeric and varargin
[data_cell,parameter_cell]=separatedataparameter(varargin{:});

% Separate x and y data
[x,y,nSignals,nSources]=separatexy(data_cell,plotdim);

%% Default parameters

parameter_struct=struct();
for k=1:length(parameter_cell)/2
    parameter_struct=setfield(parameter_struct,parameter_cell{2*k-1},parameter_cell{2*k});
end

if ~isfield(parameter_struct,'xlabel')
    parameter_struct=setfield(parameter_struct,'xlabel',repcell('Time [s]',1,nSignals));
end

if ~isfield(parameter_struct,'plotdim')
    parameter_struct=setfield(parameter_struct,'plotdim',plotdim);
end

%% Plot

[ha hp]=plot_main(x,y,parameter_struct);



