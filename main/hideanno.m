function hideanno(h_handle)

%% Hide annonation (legend) for selected objects
%
% Inputs:
% h_handle: axes handle or cell with axes handles
%
% Outputs: none
%
%% 

if iscell(h_handle)
    for k=1:length(h_handle)
        h_anno=get(h_handle{k},'Annotation');
        set(get(h_anno,'LegendInformation'),'IconDisplayStyle','off');
    end
end

if ishandle(h_handle)
    for k=1:length(h_handle)
        h_anno=get(h_handle(k),'Annotation');
        set(get(h_anno,'LegendInformation'),'IconDisplayStyle','off');
    end
end
