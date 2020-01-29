function [boxplotHandle] = boxplotArticle(data, varargin)
switch nargin
    case 1
        toLog = false; toFix = false;
    case 2
        toLog = varargin{1}; toFix = false;
    case 3
        toLog = varargin{1}; toFix = varargin{2};
end

% if toFix, data((data(:)==0)) = 10^(floor(log10(min(data((data(:)~=0)))))); end
if toFix, minVal = 10^(floor(log10(min(data((data(:)~=0)))))); data((data(:)==0)) = 1e-100; end
boxplotHandle = boxplot(data, 'width', 0.75);
if toLog,  set(gca, 'yScale', 'log'); end
if toFix, currLim = get(gca,'yLim'); currLim(1) = minVal; set(gca,'yLim', currLim); end

for idx =  1 : 7
    if idx ~= 6, linewdt = 1.5; else, linewdt = 2; end
    if idx ~= 5
        set(boxplotHandle(idx,:),'linewidth',linewdt)
    else
        set(boxplotHandle(idx,:),'linewidth',linewdt, 'color', 'k')
    end
end
set(gca,'linewidth',1,'fontsize',12)
end