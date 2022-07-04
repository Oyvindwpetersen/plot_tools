function ha=deleteaxes(ha,no)

%% Delete axes
%
% Inputs:
% ha: vector with handle to axes
% no: vector numbers to delete
%
% Outputs:
%
%%

delete(ha(no));
ha(no)=[];
