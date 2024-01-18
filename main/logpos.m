function logpos(ha,var,range)

%% Scale axis in so that data values falls between positive values A and B
%
% Inputs:
% ha: axes handle
% var: axis, 'x' or 'y' or 'z'
% range: values [lower upper]
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

if range_low>=range_up
    range
    error('Lower range must be less than upper range');
end

%%

% Get all objects from current axis
O=findobj(ha);
Otype=get(O,'type');

ind_del=[];
for k=1:length(Otype)

    if strcmp(Otype{k},'axes')
        ind_del=[ind_del k];
    elseif strcmp(Otype{k}, 'legend')
        ind_del=[ind_del k];
    elseif strcmp(Otype{k}, 'datatip')
        ind_del=[ind_del k];
    end

end
O(ind_del)=[];

if strcmpi(var,'unknown')

    var='z';

    zl=get(gca,'Zlim');
    if zl(1)==-1 & zl(2)==1
        var='y';
    end
end

% Get data values from all objects
Data_var=get(O,[var 'Data']);

if ~iscell(Data_var)
    Data_var={Data_var};
end

for k=1:length(Data_var)
    Data_min(k)=min(min(Data_var{k}));
    Data_max(k)=max(max(Data_var{k}));
end

Data_min=min(Data_min);
Data_max=max(Data_max);

% Scale factors, y_scaled=a*y+b
a=(range_up-range_low)/(Data_max-Data_min);
b=range_low-a*Data_min;

% Transform Y values for each object
for u=1:length(O)

    if strcmpi(get(O(u),'Type'),'patch')

        value_scaled=a*Data_var{u}+b;

        Data_c=get(O(u),['CData']);
        Data_c2=get(O(u),['FaceVertexCData']);
        set(O(u),'CData',a*Data_c+b,'FaceVertexCData',a*Data_c2+b);

        Data_v=get(O(u),['Vertices']);
        Data_face=get(O(u),['Faces']);

        Data_v_scaled=Data_v; Data_v_scaled(:,3)=a*Data_v_scaled(:,3)+b;
        set(O(u),[var 'Data'],value_scaled,'Vertices',Data_v_scaled,'Faces',Data_face);

    else

        value_scaled=a*Data_var{u}+b;
        set(O(u),[var 'Data'],value_scaled);

    end

end

set(ha,[var 'Scale'],'log');


