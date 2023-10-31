function A=repcell(X,n1,n2)

%% Repeat element X in n1*n2 cell
% 
% Inputs:
% X: element to repeat, numeric or string
% n1: length in dimension 1
% n2: length in dimension 2
%
% Outputs:
% A: cell with repeated elements
%
%%

if issparse(X)
    do_sparse=true;
else
    do_sparse=false;
end

A=cell(n1,n2);
for i=1:n1
    for j=1:n2
        if do_sparse
            A{i,j}=sparse(X);
        else
            A{i,j}=X;
        end
    end
end