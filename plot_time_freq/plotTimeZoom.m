function ha=plotTimeZoom(t_zoom,gap,marg_h,marg_w,weight_w,legend_logic,varargin)

%%

args_in=varargin;

plotTime(args_in{:});
h_fig1=gcf;
h_ax1=getsortedaxes(h_fig1);

t=args_in{1};
% ind_zoom=indexClose(t_zoom,t);

if size(t_zoom,1)==1
    t_zoom=repmat(t_zoom,length(h_ax1),1);
end

args_in_copy=args_in;

% for k=1:length(args_in_copy)
%     k
%     if ~isnumeric(args_in_copy{k}); break; end
%     
%     ind_zoom=indexClose(t,t_zoom(k,:));
%     ind_zoom=[ind_zoom(1):ind_zoom(2)];
% %     args_in_copy{k}=args_in_copy{k}(:,ind_zoom);
%     t_zoom(k,:);
% end

plotTime(args_in_copy{:});
h_fig2=gcf;
h_ax2=getsortedaxes(h_fig2);

figure();
ha=tight_subplot(length(h_ax1),2,gap,marg_h,marg_w,[],weight_w);

copyaxescontent(h_ax1,ha(1:2:end),true,false);
copyaxescontent(h_ax2,ha(2:2:end),true,false);

for k=2:2:length(ha)
    
    YLabelProp=get(ha(k),'YLabel');
    set(YLabelProp,'Visible','off');
    
%     set(ha(k),'YLabel','off');
end


for k=1:2:length(ha)
    
    if legend_logic(1)==false
        leg=get(ha(k),'legend');
        set(leg,'Visible','off');
    end
    
end

for k=2:2:length(ha)
    
    if legend_logic(2)==false
        leg=get(ha(k),'legend');
        set(leg,'Visible','off');
    end
    
end

no=0;
for k=2:2:length(ha)
    no=no+1;
    axesfast(gcf,ha(k));
    
    hc=get(ha(k),'Children');
    
    for j=1:length(hc)
        
%     xlim([t_zoom(no,1) t_zoom(no,2)]);
    ind_zoom=indexargmin(t,t_zoom(no,:)); ind_zoom=[ind_zoom(1):ind_zoom(2)];
    
    hc(j).XData=hc(j).XData(:,ind_zoom);
    hc(j).YData=hc(j).YData(:,ind_zoom);
    
    end
    axistight(gca,[0 0.05],'x','y');
end




