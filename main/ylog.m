function ylog(ha)

%% Function to set scaling of y-axis of axes handle ha to log (on/off)
%
% Inputs:
% ha: axes handle or figure handle
%
% Outputs: none
%
%%

if nargin==0
    ha=gca;
end

if strcmpi(get(ha,'Type'),'figure')
    ha=gethandle(ha);
end

for k=1:length(ha)
    
    if strcmpi(get(ha(k),'YScale'),'linear')% | forcelog
        set(ha(k),'YScale','log');
    else %strcmpi(get(ha(k),'YScale'),'log')
        set(ha(k),'YScale','linear');
    end
    
end