function makebig(varargin)

%%

warning('Obsolete, use sizefig instead');

sizefig(varargin);

% if nargin==0;
% 	sizefig='big';
% end
% 
% if isnumeric(sizefig);
%     set(gcf,'Units', 'Normalized', 'OuterPosition', sizefig);
%     return
% end
% 
% if strcmpi(sizefig,'big')
%     hy=0.8; hz=0.8;     
%     sizemat=[(1-hy)/2 (1-hz)/2 hy hz];
% elseif strcmpi(sizefig,'medium') | strcmpi(sizefig,'med') | strcmpi(sizefig,'m')
%     hy=0.5; hz=0.5;     
%     sizemat=[(1-hy)/2 (1-hz)/2 hy hz];
% elseif strcmpi(sizefig,'small') | strcmpi(sizefig,'s')
%     hy=0.25; hz=0.25;     
%     sizemat=[(1-hy)/2 (1-hz)/2 hy hz];
% elseif strcmpi(sizefig,'mu') 
%     hy=0.5; hz=0.3;     
%     sizemat=[(1-hy)/2 0.5 hy hz];
% end
% 
% set(gcf,'Units', 'Normalized', 'OuterPosition', sizemat);
