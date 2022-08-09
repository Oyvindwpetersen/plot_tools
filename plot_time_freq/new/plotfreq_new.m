function plotfreq_new(varargin)

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
    parameter_struct=setfield(parameter_struct,'xlabel',repcell('Frequency [Hz]',1,nSignals));
end

if ~isfield(parameter_struct,'plotdim')
    parameter_struct=setfield(parameter_struct,'plotdim',plotdim);
end

if ~isfield(parameter_struct,'xlim')
    parameter_struct=setfield(parameter_struct,'xlim',[0 3]);
end

%% Plot

for k=1:length(x)
    dt=diff(x{1}(1:2));
    [x_freq{k},y_freq{k}]=fft_function(y{k},dt,2);
    
    % Delete negative part
    ind_del=x_freq{k}<0;
    x_freq{k}(ind_del)=[];
    y_freq{k}(:,ind_del)=[];
    
    y_freq{k}=abs(y_freq{k});    
    
end

[ha hp]=plot_main(x_freq,y_freq,parameter_struct);



