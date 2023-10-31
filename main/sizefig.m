function sizefig(size_arg)

%% Resize figure
%
% Inputs:
% size_arg: 'b' 'm' 's' for big, small or medium (default big);
%
% Outputs: none
%
%% Set new size

if nargin==0
    size_arg='big';
elseif isempty(size_arg)
    size_arg='big';
end

if isnumeric(size_arg);
    set(gcf,'Units', 'Normalized', 'OuterPosition', size_arg);
    return
end

if strcmpi(size_arg,'big') | strcmpi(size_arg,'b')
    hy=0.8; hz=0.8;     
    sizemat=[(1-hy)/2 (1-hz)/2 hy hz];
elseif strcmpi(size_arg,'medium') | strcmpi(size_arg,'med') | strcmpi(size_arg,'m')
    hy=0.5; hz=0.5;     
    sizemat=[(1-hy)/2 (1-hz)/2 hy hz];
elseif strcmpi(size_arg,'small') | strcmpi(size_arg,'s')
    hy=0.25; hz=0.25;     
    sizemat=[(1-hy)/2 (1-hz)/2 hy hz];
elseif strcmpi(size_arg,'bl') 
    hy=0.4; hz=0.6;     
    sizemat=[0.05 0.2 hy hz];
elseif strcmpi(size_arg,'br') 
    hy=0.4; hz=0.6;     
    sizemat=[0.05+0.5 0.2 hy hz];
end

if isnumeric(size_arg)
	sizemat=size_arg;
end

set(gcf,'Units', 'Normalized', 'OuterPosition', sizemat);

