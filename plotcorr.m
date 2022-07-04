function varargout=plotcorr(M,varargin)

%% Plot correlation matrix or covariance matrix as heat map
%
% Inputs:
% M: square matrix
%
% Outputs:
%
%% Default inputs

if nargin<2
	xtic_label='';
end

%%

figure();
colormap('hot');

MCorr=zeros(size(M));

for k=1:size(M,1);
for l=1:size(M,1);

MCorr(k,l)=M(k,l)/sqrt(M(k,k)*M(l,l));

end
end

if nargout==1
varargout{1}=MCorr;
end

imagesc(MCorr,[-1 1]); 
h = colorbar;
% set(h, 'ylim', [-1 1])

t=title('Correlation');
set(t, 'FontSize', 10);


if ~isempty(xtic_label)
	set(gca,'XTick',[1:length(xtic_label)]);
	set(gca,'XTickLabel',xtic_label,'FontSize', 6);

	set(gca,'YTick',[1:length(xtic_label)]);
	set(gca,'YTickLabel',xtic_label,'FontSize', 6);


	set(gca,'TickLabelInterpreter','none')
	h = get(gcf,'Children');
	set(h(2),'XTickLabelRotation',90);

end
