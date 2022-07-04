function xlimall(hfig,xlimit)

%% Set xlimit to multiple axes
%
% Inputs:
% hfig: figure handleor figure number
% xlimit: [lower, upper] limit
%
% Outputs:
%
%% 

if isnumeric(hfig)
    
    for j=1:length(hfig)
        ha=getsortedaxes(figure(hfig(j)));
        for k=1:length(ha)
            axesfast(ha(k));
            xlim(xlimit);
        end
    end
    
else
    ha=getsortedaxes(hfig);
    for k=1:length(ha)
        axesfast(ha(k));
        xlim(xlimit);
        
    end
end