function [figNoNew,figNoTaken]=availableFigNo(figNoDesired,figIncrement)

if nargin==0
    figNoDesired=1;
	figIncrement=100;
elseif nargin==1
	figIncrement=100;
end   

figHandles = findobj('Type', 'figure');
if isempty(figHandles);
    figNoNew=figNoDesired; figNoTaken=[];
    return
end

for k=1:length(figHandles)
	figNoTaken(k)=figHandles(k).Number;
end

figNoNew=figNoDesired;
figNoIsTaken=true;
while figNoIsTaken

	if ~any(figNoNew==figNoTaken);
	figNoIsTaken=false;
	else
	figNoNew=figNoNew+figIncrement;
	end
	
end