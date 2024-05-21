function [y_out,parameter_struct]=data_3d_to_2d(y,parameter_struct)
%% Convert 3d matrix to 2d matrix for plotting
%
% Example:
% y_3d=[S11(w) S12(w) S13(w)
%      S21(w) S22(w) S23(w)
%      S31(w) S32(w) S33(w)]
%
% y_2d=[S11(w)
%       S12(w) 
%       S13(w) 
%       S21(w) 
%       S22(w) 
%       S23(w) 
%       S31(w)
%       S32(w)
%        S33(w)]
%
% Note y_2d is row-by-row of y_3d, same as plotting order
%
% Inputs:
% y: cell with 3d y-data
% parameter_struct: struct with plotting parameters
%
% Outputs:
% y_out: cell with 2d y-data
% parameter_struct: updated struct with plotting parameters
%
%% Desired plotting layout when auto elements are plotted

matrix_nSignal_nh_nw=[
    1 1 1 ;
    2 1 2 ;
    3 1 3 ;
    4 2 2 ;
    5 2 3 ;
    6 2 3 ;
    7 2 4 ;
    8 2 4 ;
    9 3 3 ;
    10 2 5];

%% Only diagonal elements

if strcmpi(parameter_struct.type,'auto')
    
    if size(y{1},1)~=size(y{1},2)
        error('Matrix be square for auto option');
    end
    
    for k=1:length(y)
        y_out{k}=diag3d(y{k});
    end
        
    if isfield(parameter_struct,'comp')
         [~,y_out,~]=compcut([],y_out,parameter_struct.comp,[]);
         parameter_struct.comp=[];
    end
    
    nSignals=size(y_out{1},1);
    nSources=length(y_out);
    
	if ~isfield(parameter_struct,'nh')
        if nSignals<=10; parameter_struct.nh=matrix_nSignal_nh_nw(nSignals,2); parameter_struct.nw=matrix_nSignal_nh_nw(nSignals,3); 
        else; parameter_struct.nh=ceil(sqrt(nSignals)); parameter_struct.nw=ceil(nSignals/parameter_struct.nh);
        end
    end
    
    parameter_struct.complexdata=false;
    for k=1:length(y)
        for j=1:size(y_out{k},1)
            
            ratio=norm(imag(y_out{k}(j,:)),'fro')./norm(real(y_out{k}(j,:)),'fro');
            
            if ratio>1e-12
                k
                j
                ratio
                warning('Ratio of imag to real part exceed 1e-12. Only real part kept in plot.');
            end
            
            y_out{k}(j,:)=real(y_out{k}(j,:));

        end
            
    end
    
end

%% All elements

if strcmpi(parameter_struct.type,'all')
    
    if isfield(parameter_struct,'comp')
         [~,y,~]=compcut([],y,parameter_struct.comp,[]);
         parameter_struct.comp=[];
    end
    
    for k=1:length(y)
       y_out{k}=reshape(permute(y{k},[2 1 3]),size(y{k},1)*size(y{k},2),[]);
    end

    nSignals=size(y_out{1},1);
    nSources=length(y_out);
    
	if ~isfield(parameter_struct,'nh')
        parameter_struct.nh=size(y{k},1);
    end
    
	if ~isfield(parameter_struct,'nw')
        parameter_struct.nw=size(y{k},2);
    end
    
    % If all are real then complexdata is turned off
    for k=1:length(y)
        y_isreal(k)=isreal(y_out{k});
    end
    
    if all(y_isreal)
        parameter_struct.complexdata=false;
    else
        parameter_struct.complexdata=true;
    end
    
end
    

