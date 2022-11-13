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
% n1: size of y in dim1
% n2: size of y in dim2
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


%% Genenrate labels

n=0;
ylabel={};
for k1=1:n1
    for k2=1:n2
        n=n+1;
        ylabel{k1,k2}=['$' prefix letter '_{' num2str(k1) num2str(k2) '}' postfix '$'];
    end
end
ylabel=permute(ylabel,[2 1]); ylabel=ylabel(:);

