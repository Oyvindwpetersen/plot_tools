function plotpsd_new(varargin)

%% Input handling

plotdim=3;

% Separate into numeric and varargin
[data_cell,parameter_cell]=separatedataparameter(varargin{:});

% Separate x and y data
[x,y,nSignals,nSources]=separatexy(data_cell,plotdim);

%% Default parameters

parameter_struct=struct();
for k=1:length(parameter_cell)/2
    parameter_struct=setfield(parameter_struct,parameter_cell{2*k-1},parameter_cell{2*k});
end

if ~isfield(parameter_struct,'type')
    parameter_struct=setfield(parameter_struct,'type','all');
end

if strcmpi(parameter_struct.type,'auto')
    
    plotdim=2;
    for k=1:length(y)
        y{k}=diag3d(y{k});
    end
    
    if ~isfield(parameter_struct,'nh')
        parameter_struct=setfield(parameter_struct,'nh',ceil(sqrt(size(y{k},1))).^2);
        parameter_struct=setfield(parameter_struct,'nw',ceil(sqrt(size(y{k},1))).^2);
    end
    
    nSignals=size(y{1},1);
    nSources=length(y);
    
elseif strcmpi(parameter_struct.type,'all')
    
    nh=size(y{1},1);
    nw=nh;
end

if ~isfield(parameter_struct,'xlabel')
    parameter_struct=setfield(parameter_struct,'xlabel',repcell('Frequency',1,nSignals));
end

if ~isfield(parameter_struct,'plotdim')
    parameter_struct=setfield(parameter_struct,'plotdim',plotdim);
end

%% Plot

[ha hp]=plot_main(x,y,parameter_struct);




