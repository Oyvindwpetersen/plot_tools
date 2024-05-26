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

end


plotopt_td=plotopt;
plotopt_fd=plotopt;

plotopt_td.t_zoom=t_zoom;
plotopt_td.ylabel=labelgrid(plotopt.ylabel,'(t)','');

plotopt_fd.xlim=xlim2;
plotopt_fd.log=log_;

plotopt_fd.unit='rad/s';
plotopt_fd.ylabel=labelgrid(plotopt.ylabel,'(\omega)','');

args_in_td=args_in;
args_in_td{end}=plotopt_td;

args_in_fd=args_in;
args_in_fd{end}=plotopt_fd;


%%

ha=plottimezoom(args_in_td{:});

[~,pos]=tight_subplot(length(ha)/2,3,plotopt_fd.gap,...
    plotopt_fd.marg_h,plotopt_fd.marg_w,[],weight,[],true);

idx=-1;
for k=1:3:length(pos)
    idx=idx+2;
    set(ha(idx),'Position',pos{k});
    set(ha(idx+1),'Position',pos{k+1});
end

idx=0;
for k=3:3:length(pos)
    idx=idx+1;
    ha_new(idx)=axes('Units','normalized','Position',pos{k});
end

% args_in_fd{1}=args_in_fd{1}*2*pi;
ha_tmp=plotfreq(args_in_fd{:});

copyaxescontent(ha_tmp,ha_new,true,false);

axislabelmulti(gcf,{'$t$ [s]' '$t$ [s]' '$\omega$ [rad/s]'},'bottom');
