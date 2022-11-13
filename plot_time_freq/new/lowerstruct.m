function struct_out=lowerstruct(struct_in)
%% Set all field names in struct to lowercase
%
% Inputs:
% struct_in: struct
%
% Outputs:
% struct_out: same as struct_in, but all fields lowercase
%
%%

names_all=fieldnames(struct_in);

struct_out=struct();
for k=1:length(names_all)
	struct_out=setfield(struct_out,lower(names_all{k}),getfield(struct_in,names_all{k}));
end
