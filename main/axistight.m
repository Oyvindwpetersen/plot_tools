function axistight(H, P, varargin)

%% axistight adjusts axis limits tight but not too tight
%
% Examples:
% axistight(gca,[0 0.05],'x','y'); % tight on x-axis, small gap on y-axis
% axistight(gca,[0.1 0.1 0.1],'x','y','z'); % ten percent gap on all axis limits
%
%
% 'x': x-axis
% 'y': y-axis
% 'z': z-axis
% '+x': positive part of x-axis
% '+y': positive part of y-axis
% '+z': positive part of z-axis
% '-x': negative part of x-axis
% '-y': negative part of y-axis
% '-z': negative part of z-axis
% 'xlog': log x-axis
% 'ylog': log y-axis
% 'zlog': log z-axis
% 'ylog2': log y-axis, y-data within current x-range
% 'x0': x-axis, keep lower limit zero
% 'y0': y-axis, keep lower limit zero

% Inputs:
% H: axis handle
% P: vector with ratios for axis
% [varargin]: strings with axis labels
%
% Outputs: none
%
% Based on the script by (Copyright (c) 2010 Will Robertson, wspr 81 at gmail dot com)
% Modified by OWP
%
%%

args_in=varargin;

% Default values
if nargin < 1, H = gca; end
if nargin < 2, P = 0.05; end
if nargin < 3, args_in = {'y'}; end


if ~isnumeric(P)
    error('P must be numeric, e.g. [0 0.05]');
end

if isempty(args_in), args_in = {'y'}; end

% if H is a figure, run for all axes in figure
if strcmpi(get(H,'Type'),'figure')
    hax=findall(H,'type','axes');
    for k=1:length(hax)
        axistight(hax(k),P,args_in{:});
    end
    return
end

% if H is multiple handles, run for all
if length(H)>1
    for k=1:length(H)
        axistight(H(k),P,args_in{:});
    end
    return
end

% Case ylog2 and the x-range to adjust to is specified as the last argument
for ii = 1:length(args_in)
    if strcmpi(args_in{ii},'ylog2') | strcmpi(args_in{ii},'+ylog2') | strcmpi(args_in{ii},'-ylog2') 
        if length(args_in)==(ii+1)
            x_range=args_in{ii+1};
            args_in=args_in(1:ii);
            xlim_current=get(H,'xlim');
            break
        else
            x_range=get(H,'xlim');
        end
    end
end

for ii = 1:length(args_in)
    switch args_in{ii}
        case 'keepx'; xlim_current=get(H,'xlim');
        case 'keepy'; ylim_current=get(H,'ylim');
        case 'keepz'; zlim_current=get(H,'zlim');
    end
end

axis(H,'tight');

for ii = 1:length(args_in)
    if P(ii)==0 & ~strcmpi(args_in{ii},'x0') & ~strcmpi(args_in{ii},'y0')
        continue; end

    switch args_in{ii}
        case 'x'
            set_tight_axis('xlim',P(ii));
        case 'y'
            set_tight_axis('ylim',P(ii));
        case 'z'
            Pz=P(3);
            set_tight_axis('zlim',P(ii));
        case '+x'
            set_tight_positive('xlim',P(ii));
        case '+y'
            set_tight_positive('ylim',P(ii));
        case '+z'
            set_tight_positive('zlim',P(ii));
        case '-x'
            set_tight_negative('xlim',P(ii));
        case '-y'
            set_tight_negative('ylim',P(ii));
        case '-z'
            set_tight_negative('zlim',P(ii));
        case 'xlog'
            set_tight_xlog('xlog',P(ii));
        case 'ylog'
            set_tight_ylog('ylog',P(ii));
        case 'zlog'
            set_tight_zlog('zlog',P(ii));
     	case 'ylog2'
            set_tight_ylog_range(x_range,P(ii));
        case '+ylog2'
            set_tight_ylog_range(x_range,[0 P(ii)]);
        case '-ylog2'
            set_tight_ylog_range(x_range,[P(ii) 0]);
    	case 'x0'
            set_tight_x0('xlim',P(ii));
     	case 'y0'
            set_tight_y0('ylim',P(ii));
     	case 'yfixed'
            set_tight_yfixed('ylim',P(ii));
            %     otherwise
            %       error('Only ''x'' or ''y'' or ''z'' axes allowed.')
    end
end

for ii = 1:length(args_in)
    switch args_in{ii}
        case 'keepx'; set(H,'xlim',xlim_current);
        case 'keepy'; set(H,'ylim',ylim_current);
        case 'keepz'; set(H,'zlim',zlim_current);
    end
end

%%

    function set_tight_axis(limname,Pax)

        lim = get(H,limname);
        lim_range = lim(2)-lim(1);
        lim = [lim(1)-Pax*lim_range lim(2)+Pax*lim_range];
        set(H,limname,lim);

    end

    function set_tight_positive(limname,Pax)

        lim = get(H,limname);
        lim_range = lim(2)-lim(1);
        lim = [lim(1) (lim(2)+Pax*lim_range)];
        set(H,limname,lim);

    end

    function set_tight_negative(limname,Pax)

        lim = get(H,limname);
        lim_range = lim(2)-lim(1);
        lim = [(lim(1)-Pax*lim_range) lim(2)];
        set(H,limname,lim);

    end

    function set_tight_xlog(limname,Pax)
        limname='xlim';
        lim = log10(get(H,limname));
        lim_range = lim(2)-lim(1);
        lim = 10.^[lim(1)-Pax*lim_range lim(2)+Pax*lim_range];
        set(H,limname,lim);

    end

    function set_tight_x0(limname,Pax)
        lim = get(H,limname);
        lim_range = lim(2)-lim(1);
        lim = [0 (lim(2)+Pax*lim_range)];
        set(H,limname,lim);
    end

    function set_tight_y0(limname,Pax)
        lim = get(H,limname);
        lim_range = lim(2)-lim(1);
        lim = [0 (lim(2)+Pax*lim_range)];

        if lim(1)<lim(2)
            set(H,limname,lim);
        else
            warning('axistight y0 probably has negative number, ignoring');
        end
    end

    function set_tight_ylog(limname,Pax)
        limname='ylim';
        lim = log10(get(H,limname));
        if imag(lim(1))>0;  lim(1)=real(lim(1)); end
        if lim(1)>lim(2); return; end
        lim_range = lim(2)-lim(1);
        lim = 10.^[lim(1)-Pax*lim_range lim(2)+Pax*lim_range];
        set(H,limname,lim);

    end

    function set_tight_zlog(limname,Pax)
        limname='zlim';
        lim = log10(get(H,limname));
        if imag(lim(1))>0;  lim(1)=real(lim(1)); end
        if lim(1)>lim(2); return; end
        lim_range = lim(2)-lim(1);
        lim = 10.^[lim(1)-Pax*lim_range lim(2)+Pax*lim_range];
        set(H,limname,lim);

    end

    function set_tight_yfixed(limname,Pax)
    	limname='ylim';
        lim = get(H,limname);
        lim_range = lim(2)-lim(1);
        lim = mean(lim)+[-Pax Pax]/2;
        set(H,limname,lim);
    end

    function set_tight_ylog_range(x_range,Pax)

    	if length(Pax)==1; Pax=Pax*[1 1]; end

    	hc=get(H,'Children');

        for k=1:size(hc,1)

            htype=get(hc(k),'type');

            if ~strcmpi(htype,'line')
                min_y(k)=NaN; max_y(k)=NaN;
                continue
            end

            xdata=hc(k).XData;
            ydata=hc(k).YData;

            ydata(isinf(ydata))=NaN;
            ydata(ydata==0)=NaN;

            [~,ind_low(k)]=min(abs(x_range(1)-xdata));
            [~,ind_high(k)]=min(abs(x_range(2)-xdata));

            min_y(k)=min(ydata(ind_low(k):ind_high(k)));
            max_y(k)=max(ydata(ind_low(k):ind_high(k)));
        end

        min_y(min_y==0)=[];
        max_y(max_y==Inf)=[];

        if isempty(min_y); ylim_curr=get(H,'ylim'); min_y=ylim_curr(1); end
        if isempty(max_y); ylim_curr=get(H,'ylim'); max_y=ylim_curr(2); end

        min_y_all=min(min_y);
        max_y_all=max(max_y);

        lim_range=log10(max_y_all)-log10(min_y_all);

        if lim_range==0; lim_range=min_y_all*0.05; end

        lim = 10.^[log10(min_y_all)-Pax(1)*lim_range log10(max_y_all)+Pax(2)*lim_range];

        set(H,'xlim',x_range);

        if isinf(lim(2)) | any(isnan(lim)) | abs(diff(lim))<eps
        else
            set(H,'ylim',lim);
        end

    end

end