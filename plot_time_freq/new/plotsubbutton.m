function plotsubbutton(source,event)

%%

ha_new=plotsub(gca,[0.15 0.1],[0.15 0.175],[0.075 0.05]);

btnLog = uicontrol('Style', 'pushbutton', 'String', 'Log',...
        'Position', [20 10 50 20],...
        'Callback', {@logscalebutton ha_new}); 
    
end

