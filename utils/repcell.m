function A=repcell(X,n1,n2)

%%

A=cell(n1,n2);
for i=1:n1
	for j=1:n2
        if issparse(X)
		A{i,j}=sparse(X);
        else
		A{i,j}=X;
        end
	end
end