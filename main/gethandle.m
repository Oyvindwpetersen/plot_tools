function hax=gethandle(h_handle)

%% Get axes handle
%
% Inputs:
% h_handle: handle to figure(s) or axes, or figure number
%
% Outputs:
% hax: handle to figure or axes
%
%%

if ishandle(h_handle)
    if strcmpi(get(h_handle,'type'),'figure')
        hax=getsortedaxes(h_handle);
    elseif strcmpi(get(h_handle,'type'),'axes')
        hax=h_handle;
    end
elseif isnumeric(h_handle)

	hax_temp={};
	for j=1:length(h_handle);
        hax_temp{1,end+1}=getsortedaxes(figure(h_handle(j)));
    end
	
    hax=stackHorizontal(hax);
	
end

