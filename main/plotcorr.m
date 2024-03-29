function varargout=plotcorr(M,varargin)

%% Plot correlation matrix or covariance matrix as heat map
%
% Inputs:
% M: square matrix
%
% Outputs:
% MCorr: normalized correlation matrix
%
%% Default inputs

if nargin<2
    xtick_label='';
end

%%

figure();
colormap('hot');

MCorr=zeros(size(M));

for k=1:size(M,1)
    for l=1:size(M,1)
        
        MCorr(k,l)=M(k,l)/sqrt(M(k,k)*M(l,l));
        
    end
end

if nargout==1
    varargout{1}=MCorr;
end

if any(MCorr>(1+1e-12))
    warning('Correlation bigger than 1');
end

if any(-MCorr>(1+1e-12))
    warning('Correlation smaller than 1');
end


imagesc(MCorr,[-1 1]);
h = colorbar;
% set(h, 'ylim', [-1 1])

t=title('Correlation');
set(t, 'FontSize', 10);


if ~isempty(xtick_label)
    set(gca,'XTick',[1:length(xtick_label)]);
    set(gca,'XTickLabel',xtick_label,'FontSize', 6);
    
    set(gca,'YTick',[1:length(xtick_label)]);
    set(gca,'YTickLabel',xtick_label,'FontSize', 6);
    
    
    set(gca,'TickLabelInterpreter','none')
    h = get(gcf,'Children');
    set(h(2),'XTickLabelRotation',90);
    
end
