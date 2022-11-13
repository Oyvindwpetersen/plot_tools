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

% [y,parameter_struct]=data_reim_split(y,parameter_struct);

%% Plot

[ha hp]=plot_main(x,y,parameter_struct);

if nargout==1; varargout{1}=ha;
elseif nargout==2; varargout{1}=ha; varargout{2}=hp;
end

%%

% if strcmpi(parameter_struct.type,'auto')
%     
%     for k=1:length(y)
%         y{k}=diag3d(y{k});
%     end
%     
%     nSignals=size(y{1},1);
%     nSources=length(y);
%     
%     if ~isfield(parameter_struct,'nh')
%         
%         if any(nSignals==[1]); parameter_struct.nh=1; parameter_struct.nw=1;
%         elseif any(nSignals==[2 4 8]); parameter_struct.nh=2; parameter_struct.nw=ceil(nSignals/2);
%         elseif any(nSignals==[3 6 9]); parameter_struct.nh=3; parameter_struct.nw=nSignals/3;
%         else; parameter_struct.nh=ceil(sqrt(nSignals)); parameter_struct.nw=ceil(nSignals/parameter_struct.nh);
%         end
%         
%     end
%     
% 	if length(parameter_struct.xlabel)~=nSignals
%         if ~iscell(parameter_struct.xlabel); parameter_struct.xlabel={parameter_struct.xlabel}; end
%         parameter_struct.xlabel=repcell(parameter_struct.xlabel{1},1,nSignals);
%     end
%     
%     
% end

%%

%%
    
% elseif strcmpi(parameter_struct.type,'all')
%     
%     if isfield(parameter_struct,'comp')
%          [x,y,nSignals]=compcut(x,y,parameter_struct.comp,[]);
%          parameter_struct.comp=[];
%     end
%     
%     parameter_struct.nh=size(y{1},1);
%     parameter_struct.nw=parameter_struct.nh;
%     
%     y_2d=cell(size(y));
%     for k=1:length(y)
%        y_2d{k}=reshape(permute(y{k},[2 1 3]),size(y{k},1)*size(y{k},2),[]);
%        
%        y_2d{k}=real(y_2d{k});
%     end
%     
%     nSignals=size(y{1},1);
%     nSources=length(y);
%     
%     y=y_2d;
%     
% end



