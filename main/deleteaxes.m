function ha=deleteaxes(ha,no)

%% Delete axes
%
% Inputs:
% ha: vector with handle to axes
% no: vector numbers to delete
%
% Outputs: 
% ha: reduced vector with handle to axes
%
%%

delete(ha(no));
ha(no)=[];
