function axishour(h_handle,dh,angle,xLabel,axislabel)


%%

if nargin==0
    h_handle=gca; dh=1; angle=90; xLabel='Time [h]'; axislabel=[];
elseif nargin==1
    dh=1; angle=90; xLabel='Time [h]'; axislabel=[];
elseif nargin==2
    angle=90; xLabel='Time [h]'; axislabel=[];
elseif nargin==3
	xLabel='Time [h]'; axislabel=[];
elseif nargin==4
	axislabel=[];
end

hax=axisHandle(h_handle);

if isempty(axislabel); 
    axislabel=1:length(hax);
end

for j=1:length(hax)
    c=get(hax(j),'Children');
    
    for k=1:length(c)
       
        if ~any(strcmpi(c(k).Type,{'Line' 'Image'}))
            continue
        end
        
        x_length(k)=length(c(k).XData);
               
    end
    
    [~,i_max]=max(x_length);
    t=c(i_max).XData;
    
    xTick=[0:dh:t(end)/3600]*3600;

    for k=1:length(xTick)
    h_dec=mod(xTick(k)/3600,1);
    h_int=xTick(k)/3600-h_dec;
    xTickLabel{k}=[ num2str(h_int,'%.2d') ':' num2str(round(h_dec*60),'%.2d')];
    end
    set(hax(j),'XTick',xTick,'XTickLabel',xTickLabel,'XTickLabelMode','manual','XTickLabelRotation',angle);
    set(get(hax(j),'XLabel'),'String',xLabel);

	if ~any(axislabel==j);
    set(get(hax(j),'XLabel'),'String','');
    set(hax(j),'XTick',xTick,'XTickLabel',[],'XTickLabelMode','manual','XTickLabelRotation',angle);
    end

end