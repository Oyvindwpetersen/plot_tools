function lim=ylimxRange(h_handle,x_range,Pax)


%%

warning('Obsolete, use axistightrangex instead');

axistightrangex(h_handle,x_range,'y')


%%

h_axes=gethandle(h_handle);

if nargin==2
Pax=0.1;
end

%% Log axes

for j=1:length(h_axes)

	yScaleType=get(h_axes(j),'YScale');
	
	if ~strcmpi(yScaleType,'log'); continue; end

	HgetChildren=get(h_axes(j),'Children'); 

    for k=1:size(HgetChildren,1)
        
        htype=get(HgetChildren(k),'type');
        
        if ~strcmpi(htype,'line')
            min_y(k)=NaN; max_y(k)=NaN;
            continue
        end
        
        Hxdata=HgetChildren(k).XData;
        Hydata=HgetChildren(k).YData;
        
        Hydata(isinf(Hydata))=NaN;
        Hydata(Hydata==0)=NaN;
        
        [~,ind_low(k)]=min(abs(x_range(1)-Hxdata));
        [~,ind_high(k)]=min(abs(x_range(2)-Hxdata));

        min_y(k)=min(Hydata(ind_low(k):ind_high(k)));
        max_y(k)=max(Hydata(ind_low(k):ind_high(k)));
    end
    
    min_y(min_y==0)=[];
    max_y(max_y==Inf)=[];
    
    if isempty(min_y); ylim_current=get(h_axes(j),'ylim'); min_y=ylim_current(1); end
    if isempty(max_y); ylim_current=get(h_axes(j),'ylim'); max_y=ylim_current(2); end
        
    min_y_all=min(min_y);
    max_y_all=max(max_y);
    
    lim_range=log10(max_y_all)-log10(min_y_all);
    
    lim = 10.^[log10(min_y_all)-Pax*1*lim_range log10(max_y_all)+Pax*lim_range];
    % set(h_axes(j),'xlim',x_range);
    set(h_axes(j),'ylim',lim);


end

%% Linear axes

for j=1:length(h_axes)

	yScaleType=get(h_axes(j),'YScale');
	
	if ~strcmpi(yScaleType,'linear'); continue; end

	HgetChildren=get(h_axes(j),'Children'); 

    for k=1:size(HgetChildren,1)
        
        htype=get(HgetChildren(k),'type');
        
        if ~strcmpi(htype,'line')
            min_y(k)=NaN; max_y(k)=NaN;
            continue
        end
        
        if strcmpi(HgetChildren(k).Tag,'linevertical')
            min_y(k)=NaN; max_y(k)=NaN;
            continue
        end
        
        Hxdata=HgetChildren(k).XData;
        Hydata=HgetChildren(k).YData;
        

        Hydata(isinf(Hydata))=NaN;
        Hydata(Hydata==0)=NaN;
        
        [~,ind_low(k)]=min(abs(x_range(1)-Hxdata));
        [~,ind_high(k)]=min(abs(x_range(2)-Hxdata));

        min_y(k)=min(Hydata(ind_low(k):ind_high(k)));
        max_y(k)=max(Hydata(ind_low(k):ind_high(k)));
    end
    
    min_y(min_y==0)=[];
    max_y(max_y==Inf)=[];
    
    if isempty(min_y); ylim_current=get(h_axes(j),'ylim'); min_y=ylim_current(1); end
    if isempty(max_y); ylim_current=get(h_axes(j),'ylim'); max_y=ylim_current(2); end
        
    min_y_all=min(min_y);
    max_y_all=max(max_y);
	
    lim_range=(max_y_all)-(min_y_all);
    
    lim = [(min_y_all)-Pax*1*lim_range (max_y_all)+Pax*lim_range];
    % set(h_axes(j),'xlim',x_range);
    set(h_axes(j),'ylim',lim);


end