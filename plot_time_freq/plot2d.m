function [ha,hp]=plot2d(x,y,nw,nh,plotopt_all,axesopt,figopt)

%%

nSignals=size(y{1},1);
nSources=length(y);

%%

range=rangebin(nSignals,nh*nw);
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
    
    for kk=1:length(range{k}) %(n1*n2)
        
        signalNo=range{k}(kk);
        
        axesfast(ha{k}(kk)); hold on; grid on;
        
        xlabel(axesopt.xlabel{signalNo},'interpreter',axesopt.interpreter,'FontSize',axesopt.fontsize);
        ylabel(axesopt.ylabel{signalNo},'interpreter',axesopt.interpreter,'FontSize',axesopt.fontsize);
        
        if axesopt.complexdata==false
            for j=1:nSources
                hp{k}(kk,j)=plot(x{j},y{j}(signalNo,:),plotopt_all{j});
            end
        else
            for j=1:nSources
                
                plotopt_all_re{j}=plotopt_all{j}; plotopt_all_re{j}.displayname= ['Re(' plotopt_all{j}.displayname ')'];
                plotopt_all_im{j}=plotopt_all{j}; plotopt_all_im{j}.displayname= ['Im(' plotopt_all{j}.displayname ')']; plotopt_all_im{j}.linestyle='--';
                
                hp{k}(kk,j)=plot(x{j},real(y{j}(signalNo,:)),plotopt_all_re{j});
                hp{k}(kk,j+nSources)=plot(x{j},imag(y{j}(signalNo,:)),plotopt_all_im{j});
            end
            
        end
        
        if axesopt.log==true
            set(gca,'yscale','log');
            if ~isempty(axesopt.xlimit); xlim(axesopt.xlimit); end
            axistight(gca,[0.05],'ylog2');
        else
            axistight(gca,[0 0.05],'x','y');
            if ~isempty(axesopt.xlimit); xlim(axesopt.xlimit); end
        end
        
    end
    
    axesfast(ha{k}(1));
    
    if axesopt.legendshow
        legend(ha{k}(1),'FontSize',axesopt.fontsize,'Location',axesopt.location,'Interpreter',axesopt.interpreter);
    end
    
    if strcmpi(figopt.button,'on') | strcmpi(figopt.button,'yes')
        % Create push button
        btnPlotSub = uicontrol('Style', 'pushbutton', 'String', 'Big',...
            'Position', [20 20 50 20],...
            'Callback', {@buttonplotsub });
        
        % Create push button
        btnLogScale = uicontrol('Style', 'pushbutton', 'String', 'Log',...
            'Position', [20 0 50 20],...
            'Callback', {@buttonlogscale ha{k}});
    end
    
end
