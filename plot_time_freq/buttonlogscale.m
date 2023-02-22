function buttonlogscale(source,event,ha)

%% Button function to switch between log/linear scale
%
% Inputs:
% source: 
% event: 
% ha: handle to axes
%
% Outputs:
%
%%

if iscell(ha)
    ha=ha{1};
end

isLog=strcmpi(get(ha(1),'YScale'),'log');

for k=1:length(ha)
    
    if isLog
        set(ha(k),'YScale','linear');
    else
        set(ha(k),'YScale','log');
    end
    
end

end