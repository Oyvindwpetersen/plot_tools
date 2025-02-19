function ha=plottzf(varargin)

%%

args_in=varargin;

if isstruct(args_in{end})

    plotopt=args_in{end};

    if isfield(plotopt,'xlim2')
        xlim2=plotopt.xlim2;
        plotopt=rmfield(plotopt,'xlim2');
    end

    if isfield(plotopt,'t_zoom')
        t_zoom=plotopt.t_zoom;
        plotopt=rmfield(plotopt,'t_zoom');
    end

    if isfield(plotopt,'log')
        log_=plotopt.log;
        plotopt=rmfield(plotopt,'log');
    end

    if isfield(plotopt,'weight')
        weight=plotopt.weight;
        plotopt=rmfield(plotopt,'weight');
    end

    if isfield(plotopt,'unit')
        unit=plotopt.unit;
        plotopt=rmfield(plotopt,'unit');
    end

end

plotopt_td=plotopt;
plotopt_fd=plotopt;

plotopt_td.t_zoom=t_zoom;
plotopt_td.ylabel=labelgrid(plotopt.ylabel,'(t)','');

plotopt_fd.xlim=xlim2;
plotopt_fd.log=log_;
plotopt_fd.unit=unit;

if strcmpi(plotopt_fd.unit,'hz')
    f='(f)';
elseif strcmpi(plotopt_fd.unit,'rad/s')
    f='(\omega)';
end

for idx=1:length(plotopt.ylabel)
    plotopt_fd.ylabel{idx}= ['$|' plotopt.ylabel{idx} f '|$' ];
end

args_in_td=args_in;
args_in_td{end}=plotopt_td;

args_in_fd=args_in;
args_in_fd{end}=plotopt_fd;

%%

ha_td=plottimezoom(args_in_td{:});

[~,pos]=tight_subplot(length(ha_td)/2,3,plotopt_fd.gap,...
    plotopt_fd.marg_h,plotopt_fd.marg_w,[],weight,[],true);

idx=-1;
for k=1:3:length(pos)
    idx=idx+2;
    set(ha_td(idx),'Position',pos{k}); % Set pos time series
    set(ha_td(idx+1),'Position',pos{k+1}); % Set pos zoom
end

clear ha
ha(1:3:length(pos))=ha_td(1:2:end);
ha(2:3:length(pos))=ha_td(2:2:end);

for k=3:3:length(pos)
    ha(k)=axes('Units','normalized','Position',pos{k});
end

ha_fd=plotfreq(args_in_fd{:});

copyaxescontent(ha_fd,ha(3:3:end),true,false);

if strcmpi(plotopt_fd.unit,'hz')
    label_f='$f$ [Hz]';
elseif strcmpi(plotopt_fd.unit,'rad/s')
    label_f='$\omega$ [rad/s]';
end

axislabelmulti(gcf,{'$t$ [s]' '$t$ [s]' label_f},'bottom');
