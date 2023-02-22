function buttonplotsub(source,event)

%% Button function to create new figure of a subplot
%
% Inputs:
% source: 
% event: 
%
% Outputs:
%
%%

ha_new=plotsub(gca,[0.15 0.1],[0.15 0.175],[0.075 0.05]);

btnLog = uicontrol('Style', 'pushbutton', 'String', 'Log',...
        'Position', [20 10 50 20],...
        'Callback', {@buttonlogscale ha_new}); 
    
end

