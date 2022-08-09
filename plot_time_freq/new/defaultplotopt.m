function defaultplotopt(


%%



if isempty(LineWidth)
    LineWidth=0.5*ones(1,nSources);
end

if isempty(Color)
    Color=GenColor(nSources);
end

if ~isempty(alpha)
    if size(alpha,1)<size(alpha,2); alpha=alpha.'; end
    Color=[Color alpha];
end

if isempty(LineStyle)
    LineStyle=repcell('-',1,30);
end

if isempty(Marker)
    Marker=repcell('none',1,30);  
end

if isempty(Displayname)
	Displayname=strseq('',[1:nSources]);
end

if ischar(x_labels)
    x_labels={x_labels};
end

if isempty(y_labels)
	x_labels=strseq('X ',[1:nSignals]);
end

if ischar(y_labels)
    y_labels={y_labels};
end

if isempty(y_labels)
	y_labels=strseq('Y ',[1:nSignals]);
end
