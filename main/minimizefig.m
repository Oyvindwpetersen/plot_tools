function minimizefig(fig_handle)

%% Minimize figure
%
% Inputs:
% fig_handle: figure handle(s)
%
% Outputs: none
%
%% 

if nargin<1
	fig_handle=findobj('Type','figure');
end

if isempty(fig_handle)
	fig_handle=findobj('Type','figure');
end


for k=1:length(fig_handle)

	ws=get(fig_handle(k),'WindowState');
	
	if strcmpi(ws,'minimized')
	continue
	else
	set(fig_handle(k),'WindowState','minimized');
	end
	
end