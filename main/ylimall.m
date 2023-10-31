function ylimall(varargin)

%% Set ylimit to multiple axes
%
% Inputs:
% hfig: figure handleor figure number
% ylimit: [lower, upper] limit
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

limall('y',var_limit,hfig);