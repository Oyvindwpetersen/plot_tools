function varargout=plotpsd(varargin)

%% Input handling

% Separate into numeric and varargin
[data_cell,parameter_struct_in]=separatedataparameter(varargin{:});

% Separate x and y data
[x,y,~,nSources]=separatexy(data_cell);

%% Default parameters

parameter_struct_default=struct();

parameter_struct_default.xlabel='Frequency';
parameter_struct_default.type='auto';
parameter_struct_default.complexdata=true;
parameter_struct_default.xlim=[0 3];

parameter_struct=mergestruct(parameter_struct_default,parameter_struct_in);

%% 

[y,parameter_struct]=data_3d_to_2d(y,parameter_struct);

%% Plot

[ha hp]=plot_main(x,y,parameter_struct);

if nargout==1; varargout{1}=ha;
elseif nargout==2; varargout{1}=ha; varargout{2}=hp;
end





