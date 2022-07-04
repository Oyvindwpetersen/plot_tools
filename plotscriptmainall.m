function plotscriptmainall(varargin)

%plotscriptmainall('h',8,'w',12,'name','testall','titlesize',8,'labelsize',6,'ticksize',6,'path','desktop','open','yes');

p=inputParser;
addParameter(p,'h',8,@isnumeric)
addParameter(p,'w',12,@isnumeric)
addParameter(p,'titlesize',10,@isnumeric)
addParameter(p,'labelsize',8,@isnumeric)
addParameter(p,'ticksize',8,@isnumeric)
addParameter(p,'path','C:\Work',@ischar)
addParameter(p,'format','pdf',@ischar)
addParameter(p,'name','plot',@ischar)
addParameter(p,'savefig','no',@ischar)
addParameter(p,'open','yes',@ischar)

parse(p,varargin{:});

height = p.Results.h;
width = p.Results.w;
titlesize = p.Results.titlesize;
labelsize = p.Results.labelsize;
ticksize = p.Results.ticksize;
fpat = p.Results.path;
format = p.Results.format;
fname = p.Results.name;
savefigure = p.Results.savefig;
openfile = p.Results.open;


%path
if strcmpi(fpat,'work');
fpat='C:\Work';
elseif strcmpi(fpat,'desktop');
fpat='C:\Users\oyvinpet\Desktop';
end

if ~strcmp(fpat(end),'\')
fpat=[fpat '\'];
end

%format
if strcmpi(format,'pdf')
	format='-dpdf';
elseif strcmpi(format,'eps')
	format='-depsc';
end

%get all figs
h_fig=get(0,'children'); nfig=length(h_fig);

if nfig==0
disp('Error: no figures open');
return
end

for k=1:nfig
   h_fig_number(k)=h_fig(k).Number; 
end
[~,b]=sort(h_fig_number);
h_fig=h_fig(b);

%temp plotting
for k=1:nfig;

figure(h_fig(k))
fnamek = [fname '_' num2str(k)];
fpat_temp='C:\Temp\';
input_list{k}=strcat( char(fpat_temp), char(fnamek), '.pdf' );
	if strcmpi(savefigure,'yes')
	savefig(gcf,[fpat fnamek]);
	end
plotscriptmain('h',height,'w',width,'name',fnamek,'titlesize',titlesize,'labelsize',labelsize,'ticksize',ticksize,'path',fpat_temp,'open','no');
end


fullname=[fpat fname '.' format(3:end)];

fileAlreadyExist=exist(fullname, 'file');
if fileAlreadyExist==2;
	disp(['file  ', fname,' in ' fpat ' in ' format ' already exist'])
	delete(fullname); %Delete if existing 
	disp(['deleting pdf  ',fname,' in ' fpat ' in ' format])
end

append_pdfs(fullname, input_list{:})
for k=1:nfig
	delete(input_list{k}); %Delete temp files
end

disp(['printing appended pdf  ', fname ,' to ' fpat ' in ' format])

if strcmpi(openfile,'yes')
pause(0.5)
	try
		winopen(fullname);
	catch
		disp('Error: unable to open file')
	end
end



%saveas(gcf,'-dpdf','-r1200', strtok(h.FileName, '.'))
%print(gcf,'-dpdf','-r1200', strtok(h.FileName, '.'))
