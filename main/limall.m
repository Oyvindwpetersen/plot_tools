function limall(var,var_limit,h_handle)

%% Set limit to multiple axes
%
% Inputs:
% var: 'x', 'y', or 'z'
% var_limit: [lower, upper] limit
% hfig: figure handle or figure number
%
% Outputs: none
%
%%

if strcmpi(var,'x')
    limname='xlim';
elseif strcmpi(var,'y')
    limname='ylim';
elseif strcmpi(var,'z')
    limname='zlim';
end

if nargin<3
    h_handle=gcf;
end

if strcmp(get(h_handle(1),'type'),'axes')
    ha=h_handle;
elseif strcmp(get(h_handle(1),'type'),'figure')
    ha=getsortedaxes(h_handle);
end

for k=1:length(ha)
    set(ha(k),limname,var_limit);
end

