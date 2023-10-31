function A=stackHorizontal(varargin)

%% Function to stack matrices horizontally
% Matrix sizes must be equally tall
%
% Inputs:
% cell or repeated arguments
%
% Outputs:
% A: resulting matrix
%
%
% Examples: 
% A=randn(3,3);
% B=randn(3,1);
% C=stackHorizontal(A,B)
%
% D{1}=randn(3,3);
% D{2}=randn(3,1);
% C=stackHorizontal(D)
%
%%

if nargin==1 & isempty(varargin{1})
    A=[]; return
end

if iscell(varargin{1});
    stackCells=varargin{1};
else
    stackCells=varargin;
end

for k=1:length(stackCells)
    [s1(k),s2(k)]=size(stackCells{k});
    s_sparse(k)=issparse(stackCells{k});
end

indEmpty=find(all([s1;s2]==0,1));

stackCells(indEmpty)=[];
s1(indEmpty)=[];
s2(indEmpty)=[];
s_sparse(indEmpty)=[];

if isempty(stackCells)
    A=[]; return
end

if any(s1(1)~=s1)
    error('Matrix size not matching for stacking');
end

if all(s_sparse)
    A=sparse(s1(1),sum(s2));
else
    A=zeros(s1(1),sum(s2));
end

for k=1:length(stackCells)
%     if any(k==indEmpty); continue; end
    range=sum(s2(1:(k-1)))+[1:s2(k)];
    A(:,range)=stackCells{k};
end

% return
%%

% for k=1:length(Bcell)
%     B=Bcell{k};
%     
%     range=stackRange(A,B,'horizontal');
%     A(:,range)=B;
% end
