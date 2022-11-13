function struct_out=mergestruct(struct_slave,struct_master)
%% Merge two structs together
% If two field names are shared (case insensitive), the field from struct_master is kept
% 
% Inputs:
% struct_slave: struct
% struct_master: struct
%
% Outputs:
% struct_out: merged struct
%
%%

% casesens=false;

names_slave=fieldnames(struct_slave);
names_master=fieldnames(struct_master);

names_slave_lower=cell(size(names_slave));
for k=1:length(names_slave)
    names_slave_lower{k}=lower(names_slave{k});
end

names_master_lower=cell(size(names_master));
for k=1:length(names_master)
    names_master_lower{k}=lower(names_master{k});
end

struct_out=struct_slave;

% Add master fields
for k=1:length(names_master)
    
    % Check if already exist in slave (case insensitive)
    [logic_exist,index]=ismember(names_master_lower{k},names_slave_lower);
    
    % If exist, then remove
    if logic_exist
        struct_out=rmfield(struct_out,names_slave{index});
    end
    
    % Add from master
    struct_out=setfield(struct_out,names_master{k},getfield(struct_master,names_master{k}));
    
end