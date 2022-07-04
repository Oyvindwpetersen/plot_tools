function [ind dist]=indexClose(x,x_val)


%%

warning('Obsolete, use indexargmin instead');

[ind dist]=indexargmin(x,x_val);