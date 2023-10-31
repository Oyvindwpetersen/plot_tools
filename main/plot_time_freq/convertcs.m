function out=convertcs(in)
%% Convert cell to struct (or vice versa)
%
% Example struct;
% s.field_a=value_a
% s.field_b=value_b
%
% or
%
% example cell:
% c={'field_a' , value_a , 'field_b' , value_b}
%
% Inputs:
% in: cell or struct on the form shown above
%
% Outputs:
% out: cell or struct on the form shown above
%
%% Cell to struct

if iscell(in)
   
   n=length(in);
   
   % Must be even number of things
   if mod(n,2)~=0
       n
       error('Cell must be even length');
   end

   out_struct=struct();
   
   for k=1:n/2
       
       if ~ischar(in{2*k-1})
           k
           in{2*k-1}
            error('Field name must be a string');
       end
       
       out_struct=setfield(out_struct,in{2*k-1},in{2*k});
   end
   
   out=out_struct;
   
end


%% Struct to cell

if isstruct(in)
   
   allnames=fieldnames(in);
   n=length(allnames);

   out_cell=cell(1,2*n);
   
   for k=1:n
       out_cell{2*k-1}=allnames{k};
       out_cell{2*k}=getfield(in,allnames{k});
   end
   
   out=out_cell;
   
end




