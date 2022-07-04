function axislabelmulti(h_handle,label_cell,axislabel_number,delete_ticks,x_or_y,interpreter)

%% Add axis label to multiple subfigures
%
% Inputs:
% h_handle: handle to figure or axes
% label_cell: e.g. 'Time [s]' or {'Time 1' 'Time 2' 'Time 3'}
% axislabel_number: axes number or string, 'bottom' or 'bottom2' etc
% delete_ticks: true/false, delete ticks of axes without labels
% x_or_y: 'x' or 'y'
% interpreter: interpreter for label, e.g. 'latex'
%
% Outputs:
%
%
%% Default inputs

if nargin<6
interpreter='';
end

if nargin<5 | isempty(x_or_y)
x_or_y='x';
end

if nargin<4
delete_ticks=false;
end

%% 

if isempty(h_handle)
	hax=gethandle(gcf);
else
	hax=gethandle(h_handle);
end

if ischar(axislabel_number)
    if strcmpi(axislabel_number,'bottom')
        axislabel_number=length(hax);
    elseif strcmpi(axislabel_number,'bottom2')
        axislabel_number=length(hax)+[-1 0];
	elseif strcmpi(axislabel_number,'bottom3')
        axislabel_number=length(hax)+[-2 -1 0];
	elseif strcmpi(axislabel_number,'bottom4')
        axislabel_number=length(hax)+[-3 -2 -1 0];
    end
end

if isempty(axislabel_number)
	axislabel_number=1:length(hax);
end

if ~iscell(label_cell)
    label_cell={label_cell};
end

if length(label_cell)==1
	label_cell=repcell(label_cell,1,length(hax));
elseif length(label_cell)==length(axislabel_number)
    xLabel0=label_cell;
    label_cell=repcell('',1,length(h_handle));
    
    no=0;
    for k=axislabel_number
        no=no+1;
        label_cell{k}=xLabel0{no};
    end
end

% hax=gethandle(h_handle);

if strcmpi(x_or_y,'x')

	for j=1:length(hax)

		if ~any(j==axislabel_number)
			set(get(hax(j),'XLabel'),'String','');
			if delete_ticks
				currentXticks=get(hax(j),'XTick');
				set(hax(j),'XTickLabel',repcell('',1,length(currentXticks)));
			end
		else
			set(get(hax(j),'XLabel'),'String',label_cell{j});
			
			if ~isempty(interpreter);
			set(get(hax(j),'XLabel'),'Interpreter',interpreter);
			end
			
		end

	end

elseif strcmpi(x_or_y,'y')

    for j=1:length(hax)

	if ~any(j==axislabel_number)
	    set(get(hax(j),'YLabel'),'String','');
		if delete_ticks
			currentXticks=get(hax(j),'YTick');
			set(hax(j),'YTickLabel',repcell('',1,length(currentXticks)));
		end
	else
		set(get(hax(j),'YLabel'),'String',label_cell{j});
        
        if ~isempty(interpreter);
		set(get(hax(j),'YLabel'),'Interpreter',interpreter);
        end
	end

    end

end
    
    