function [data_scaled,a,b]=scalepos(data,range)

%% Scale axis in so that data values falls between positive values A and B
%
% Inputs:
% ha: axes handle
% var: axis, 'x' or 'y' or 'z'
% range: values [lower upper]
%
% Outputs: none
%
%% Default inputs


if nargin<2
    range=[10^0 10^3];
end

range_up=range(2);
range_low=range(1);

data_min=min(data,[],'all');
data_max=max(data,[],'all');

% Scale factors, y_scaled=a*y+b
a=(range_up-range_low)/(data_max-data_min);
b=range_low-a*data_min;

data_scaled=a*data+b;
