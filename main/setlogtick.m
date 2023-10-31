function setlogtick(h_handle,ntick,var)

%% Set number of ticks for axis with exponents 10^ for log axis
%
% Inputs:
% h_handle: handle to axes or figure
% ntick: number of ticks
% var: 'x' or 'y' or 'z'
%
% Outputs: none
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
            scalename='XScale'; limname='xlim'; tickname='XTick';
        elseif strcmpi(var{j},'y')
            scalename='YScale'; limname='ylim'; tickname='YTick';
        elseif strcmpi(var{j},'z')
            scalename='ZScale'; limname='zlim'; tickname='ZTick';
        end
        
        % If axis not log, continue
        if ~strcmpi(get(hax(k),scalename),'log'); continue; end
        
        lim_log=log10(get(hax(k),limname));
        if lim_log(1)==-Inf; lim_log(1)==-10; end
        
        lim_log=[ceil(lim_log(1)) floor(lim_log(2))];
        
        % Orders from lowest to highest
        Nlog=[lim_log(1):lim_log(2)];
        
        if ~isempty(ntick)
            Nlog_plot=[Nlog(1):ceil(length(Nlog)/ntick):Nlog(end)];
        else
            if length(Nlog)<=3
                Nlog_plot=Nlog;
            elseif length(Nlog)<=6
                Nlog_plot=[Nlog(1):2:Nlog(end)];
            else
                ntick=3;
                Nlog_plot=[Nlog(1):ceil(length(Nlog)/ntick):Nlog(end)];
            end
            
        end
        
        % Set manual ticks
        set(hax(k),tickname,10.^Nlog_plot);
        
    end
end
