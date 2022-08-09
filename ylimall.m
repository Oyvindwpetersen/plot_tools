function ylimall(hfig,ylimit)

%% Set ylimit to multiple axes
%
% Inputs:
% hfig: figure handleor figure number
% ylimit: [lower, upper] limit
%
% Outputs:
%
%%

if isnumeric(hfig)
    
    for j=1:length(hfig)
        ha=getsortedaxes(figure(hfig(j)));
        for k=1:length(ha)
            axesfast(ha(k));
            ylim(ylimit);
        end
    end
    
else
    ha=getsortedaxes(hfig);
    for k=1:length(ha)
        axesfast(ha(k));
        ylim(ylimit);
        
    end
end