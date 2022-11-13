function logpos(ha,var,range)

%% Scale axis in so that data values falls between positive values A and B
%
% Inputs:
% ha: axes handle
% var: axis, 'x' or 'y' or 'z'
% range: values, [lower upper]
%
% Outputs: none
%
%% Default inputs

if nargin<3
    range=[10^0 10^3];
end

if nargin<2
    var='unknown';
end

if nargin<1
    ha=gca;
end

range_low=range(1);
range_up=range(2);

%%

% Get all objects from current axis
O = findobj(ha);
Otype = get(O, 'type');

ind_del=[];
for k=1:length(Otype)
    
    if strcmp(Otype{k}, 'axes')
        ind_del=[ind_del k];
    elseif strcmp(Otype{k}, 'legend')
        ind_del=[ind_del k];
	elseif strcmp(Otype{k}, 'datatip')
        ind_del=[ind_del k];
    end
    
end

O(ind_del)=[];

if strcmpi(var,'unknown')
	zl=get(gca,'Zlim');
    if zl(1)==-1 & zl(2)==1
        var='y';
    else
        var='z';
    end
end

% Get data values from all objects
Data_var = get(O,[var 'Data']);

if ~iscell(Data_var)
	Data_var = {Data_var};
end

% Single vector of values
Data_all = cellfun(@(x) x(:)', Data_var, 'uniformoutput',0);
Data_all = [Data_all{:}];

Data_min=min(Data_all);
Data_max=max(Data_all);

a=(range_up-range_low)/(Data_max-Data_min);
b=range_low-a*Data_min;

% Transform Y values for each object
for u=1:length(O)
    value = Data_var{u};
    value_scaled=a*value+b;
    set(O(u),[var 'Data'],value_scaled);

    set(ha,[var 'Scale'],'log');    

end

