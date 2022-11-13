function limall(var,var_limit,hfig)

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
    hfig=gcf;
end

if isnumeric(hfig)
    for j=1:length(hfig)
        ha=getsortedaxes(figure(hfig(j)));
        for k=1:length(ha)
            set(ha(k),limname,var_limit);
        end
    end
else
    ha=getsortedaxes(hfig);
    for k=1:length(ha)
        set(ha(k),limname,var_limit);
    end
end