function zlog(ha)

%% Function to set scaling of z-axis of axes handle ha to log (on/off)
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
    
    if strcmpi(get(ha(k),'ZScale'),'linear')
        set(ha(k),'ZScale','log');
    elseif strcmpi(get(ha(k),'ZScale'),'log')
        set(ha(k),'ZScale','linear');
    end
    
end