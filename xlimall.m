function xlimall(varargin)

%% Set xlimit to multiple axes
%
% Inputs:
% hfig: figure handleor figure number
% xlimit: [lower, upper] limit
%
% Outputs: none
%
%%

if nargin==1
    hfig=gcf;
    var_limit=varargin{1};
end

if nargin==2
    hfig=varargin{1};
    var_limit=varargin{2};
end

limall('x',var_limit,hfig);