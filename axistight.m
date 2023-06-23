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


% Default values
if nargin < 1, H = gca; end
if nargin < 2, P = 0.05; end
if nargin < 3, varargin = {'y'}; end

if isempty(varargin), varargin = {'y'}; end

% if H is a figure, run for all axes in figure
if strcmpi(get(H,'Type'),'figure')
    hax=findall(H,'type','axes');
    for k=1:length(hax)
        axistight(hax(k),P,varargin{:});
    end
    return
end

% if H is multiple handles, run for all
if length(H)>1
    for k=1:length(H)
        axistight(H(k),P,varargin{:});
    end
    return
end

for ii = 1:length(varargin)
    switch varargin{ii}
        case 'ylog2'; xlim_current=get(H,'xlim');
        case '+ylog2'; xlim_current=get(H,'xlim');
        case '-ylog2'; xlim_current=get(H,'xlim');
        case 'keepx'; xlim_current=get(H,'xlim');
        case 'keepy'; ylim_current=get(H,'ylim');
        case 'keepz'; zlim_current=get(H,'zlim');
    end
end

axis(H,'tight');

for ii = 1:length(varargin)
    if P(ii)==0 & ~strcmpi(varargin{ii},'x0') & ~strcmpi(varargin{ii},'y0')
        continue; end

    switch varargin{ii}
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
            set_tight_ylog_range(xlim_current,P(ii));
        case '+ylog2'
            set_tight_ylog_range(xlim_current,[0 P(ii)]);
        case '-ylog2'
            set_tight_ylog_range(xlim_current,[P(ii) 0]);
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

for ii = 1:length(varargin)
    switch varargin{ii}
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
        set(H,limname,lim);
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

    	HgetChildren=get(H,'Children');

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