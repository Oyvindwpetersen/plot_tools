function axistightrangex(h_handle,x_range,type)


warning('Consider using axistight.m instead')

%%
%%

if nargin==2
    type='y';
end


if strcmp(get(h_handle,'type'),'figure'); % ishandle(h_handle)
	h_axes = findall(h_handle,'type','axes');
else
	h_axes = h_handle;
end

if ~iscell(x_range)
    x_range=repcell(x_range,1,length(h_axes));
end

%%

for j=1:length(h_axes)

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
        
        [~,ind_low(k)]=min(abs(x_range{j}(1)-Hxdata));
        [~,ind_high(k)]=min(abs(x_range{j}(2)-Hxdata));

        min_y(k)=min(Hydata(ind_low(k):ind_high(k)));
        max_y(k)=max(Hydata(ind_low(k):ind_high(k)));
    end
    
    min_y(min_y==0)=[];
    max_y(max_y==Inf)=[];
    
    if isempty(min_y); ylim_current=get(h_axes(j),'ylim'); min_y=ylim_current(1); end
    if isempty(max_y); ylim_current=get(h_axes(j),'ylim'); max_y=ylim_current(2); end
        
    min_y_all=min(min_y);
    max_y_all=max(max_y);
    
    scaleType=get(h_axes(j),'YScale');
    
    if strcmpi(scaleType,'log')
        lim_range=log10(max_y_all)-log10(min_y_all);
        Pax=0.1;
        lim = 10.^[log10(min_y_all)-Pax*1*lim_range log10(max_y_all)+Pax*lim_range];
        set(h_axes(j),'ylim',lim);
    elseif strcmpi(scaleType,'linear')
        lim_range=max_y_all-min_y_all;
        Pax=0.1;
        lim = [min_y_all-Pax*lim_range max_y_all+Pax*lim_range];
        if strcmpi(type,'y0'); lim(1)=0; end
        set(h_axes(j),'ylim',lim);
    end


end