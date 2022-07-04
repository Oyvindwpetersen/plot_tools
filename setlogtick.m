function setlogtick(h_handle,ntick,var)

%% Add cursor with information
%
% Inputs:
% h_handle: handle to axes or figure
% ntick: number of ticks
% var: 'x' or 'y' or 'z'
%
% Outputs:
%
%% 

if isfigure(h_handle)
hax=getsortedaxes(h_handle);
else
hax=h_handle;
end

if ~iscell(var)
var={var};
end

%%

for j=1:length(var)

for k=1:length(hax)

if strcmpi(var{j},'x')
scaleName='XScale'; limName='xlim'; tickName='XTick';
end

if strcmpi(var{j},'y')
scaleName='YScale'; limName='ylim'; tickName='YTick';
end

if strcmpi(var{j},'z')
scaleName='ZScale'; limName='zlim'; tickName='ZTick';
end

if ~strcmpi(get(hax(k),scaleName),'log'); continue; end

lim_log=log10(get(hax(k),limName));

if lim_log(1)==-Inf; lim_log(1)==-10; end
	
lim_log=[ceil(lim_log(1)) floor(lim_log(2))];
Nlog=[lim_log(1):lim_log(2)];

if ~isempty(ntick)
Nlog_plot=[Nlog(1):ceil(length(Nlog)/ntick):Nlog(end)];
set(hax(k),tickName,10.^Nlog_plot);
else

if length(Nlog)<=3
	Nlog_plot=Nlog;
	set(hax(k),tickName,10.^Nlog_plot);
elseif length(Nlog)<=6
	Nlog_plot=[Nlog(1):2:Nlog(end)];
	set(hax(k),tickName,10.^Nlog_plot);
else
	Nlog_plot=[Nlog(1):ceil(length(Nlog)/3):Nlog(end)];
	set(hax(k),tickName,10.^Nlog_plot);
end

end

end
end
