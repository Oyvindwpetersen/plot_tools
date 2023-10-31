function axesfast(varargin)

%% Fast assignment of current axes for figure
%
% Inputs:
% (handle_axes), figure set as current figure
% (handle_fig,handle_axes)
%
% Outputs:
%
%
%%

if nargin==0
	hfig=gcf;
	hax=gca;
elseif nargin==1
	hfig=gcf;
	hax=varargin{1};
elseif nargin==2
	hfig=varargin{1};
    set(0,'CurrentFigure',hfig);
	hax=varargin{2};
end

hfig.CurrentAxes=hax(1);

