function logscalebutton(source,even,ha)

%%

if iscell(ha);
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