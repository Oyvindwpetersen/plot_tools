function ylabel=labelgrid(n1,n2,letter,prefix,postfix)
%% Labels for rectangular grid
%
% |H_{ij}(omega)|
%
% Example:
% y_3d=[y11 y12 y13
%      y21 y22 y23
%      y31 y32 y33]
%
%
% ylabel={y11_label
%       y12_label
%       y13_label
%       y21_label
%       y22_label
%       y23_label
%       y31_label
%       y32_label
%       y33_label}
%
% Note ylabel is row-by-row of y_3d, same as plotting order
%
% Inputs:
% n1: size of y in dim1 or cell with labels
% n2: size of y in dim2 or cell with labels
% letter: letter, e.g. 'H'
% prefix: character before letter
% postfix: character after ij
%
% Outputs:
% ylabel: cell labels
%
%% Default inputs

if nargin<5
    postfix='';
end

if nargin<4
    prefix='';
end

if nargin<3
    letter='H';
end

if isempty(letter)
    underscore='';
else
    underscore='_';
end

%% Generate labels

if isnumeric(n1) & isnumeric(n2)

    n1_tmp=[1:n1];
    n1={};
    for k1=1:length(n1_tmp)
        n1{k1}=num2str(n1_tmp(k1));
    end

    n2_tmp=[1:n2];
    n2={};
    for k2=1:length(n2_tmp)
        n2{k2}=num2str(n2_tmp(k2));
    end

elseif iscell(n1) | iscell(n2)
    
    if ischar(n1)
        n1={n1};
    end

    if ischar(n2)
        n2={n2};
    end

end

ylabel={};
for k1=1:length(n1)
        for k2=1:length(n2)
            ylabel{k1,k2}=['$' prefix letter underscore '{' n1{k1}  n2{k2} '}' postfix '$'];
        end
    end
    ylabel=permute(ylabel,[2 1]); ylabel=ylabel(:);

end

