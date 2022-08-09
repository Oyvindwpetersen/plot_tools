function xlog(ha)

%% Function to set scaling of x-axis of axes handle ha to log (on/off)
%
% Inputs:
% ha: axes handle or figure handle
%
% Outputs:
%
%%

if nargin==0
    ha=gca;
end

if strcmpi(get(ha,'Type'),'figure')
    ha=gethandle(ha);
end

for k=1:length(ha)
    
    if strcmpi(get(ha(k),'XScale'),'linear')
        set(ha(k),'XScale','log');
    elseif strcmpi(get(ha(k),'XScale'),'log')
        set(ha(k),'XScale','linear');
    end
    
end