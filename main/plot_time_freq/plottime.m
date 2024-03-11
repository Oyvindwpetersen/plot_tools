function plottime(varargin)

%% Input handling

% Separate into numeric and varargin
[data_cell,parameter_struct_in]=separatedataparameter(varargin{:});

% Separate x and y data
[x,y,nSignals,nSources]=separatexy(data_cell);


%% Default parameters

parameter_struct=struct();

parameter_struct_default.xlabel=repcell('Time [s]',1,nSignals);

parameter_struct=mergestruct(parameter_struct_default,parameter_struct_in);

%% Plot

[ha hp]=plot_main(x,y,parameter_struct);



