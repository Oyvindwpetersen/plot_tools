function [ha,hp]=plot_tile(x,y,nSignals,nSources,nw,nh,plotopt_all,axesopt,figopt)


%%

range=rangebin(nSignals,nh*nw); %number of subplots per figure;
nFig=length(range);

[figno_new,figno_taken]=availablefigno(1,100,nFig);

if nFig>20
    error(['Number of figures exceeding limit: ' num2str(nFig)])
end

for k=1:nFig
    
    n1=length(range{k})/nw; n1=ceil(n1);
    n2=nw;
    
    figure(k-1+figno_new); sizefig();
    ha{k}=tight_subplot(n1,n2,axesopt.gap,axesopt.marg_h,axesopt.marg_w); 

    for kk=1:nSources
        axesfast( ha{k}(kk) ); hold on; grid on;

        signalNo=range{k}(kk);
        if figopt.plotreg=true;
            for j=1:nSources
                hp{k}(kk,j)=plot(x{j},y{j}(signalNo,:),plotopt_all{j});
            end
        end      
        
        xlabel(axesopt.xlabel{signalNo},'interpreter',axesopt.interpreter,'FontSize',8);
        ylabel(axesopt.ylabel{signalNo},'interpreter',axesopt.interpreter,'FontSize',8);
        
        if strcmpi(axesopt.log,'yes')
            set(gca,'yscale','log');
            if ~isempty(axesopt.xlimit); xlim(axesopt.xlimit); end
            axistight(gca,[0.05],'ylog2');   
        else
        	axistight(gca,[0 0.05],'x','y');
        end

    end
    
%     axesfast(ha{k}(1));
    
    if axesopt.legendshow
        legend(ha{k}(1),'FontSize',8,'Location',axesopt.location,'Interpreter',axesopt.interpreter);
    end
    
    if strcmpi(figopt.button,'on') | strcmpi(figopt.button,'yes')
        
        % Create push button
        btnSize = uicontrol('Style', 'pushbutton', 'String', 'Big',...
                'Position', [20 20 50 20],...
                'Callback', {@plotsubbutton }); 

        % Create push button
        btnLog = uicontrol('Style', 'pushbutton', 'String', 'Log',...
                'Position', [20 0 50 20],...
                'Callback', {@logscalebutton ha}); 
    end

end
