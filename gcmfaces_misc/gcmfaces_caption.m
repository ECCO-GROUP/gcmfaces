function [captionHandle]=gcmfaces_caption(myCaption);
% [captionHandle]=GCMFACES_CAPTION(myCaption) adds an editable 
%   caption to the current figure and menu buttons 
%   to show or hide it, or return its handle.
%
%   Notes: 
%   1) the added menu functionalities only support one
%   caption per figure.
%   2) the added menu functionalities operate with two 
%   temporary variables (gfCapTmp, gfCapTmppp) that get 
%   deleted after each callback.

gcmfaces_global;

%the on/off button callback in text form
capOnOff=[...
    'gfCapTmp.h=findall(gcf,''type'',''uipanel'');' ...
    'gfCapTmp.nh=length(gfCapTmp.h);' ...
    'gfCapTmp.captionHandle=[];' ...
    'for gfCapTmppp=1:length(gfCapTmp.h);' ...
    '    gfCapTmp.tag=get(gfCapTmp.h(gfCapTmppp),''Tag'');' ...
    '    if ~isempty(strfind(gfCapTmp.tag,''gfCap''));' ...
    '        gfCapTmp.captionHandle=gfCapTmp.h(gfCapTmppp);' ...
    '    end;' ...
    'end;' ...
    'gfCapTmp.tmp1=get(gfCapTmp.captionHandle,''Visible'');' ...
    'if strcmp(gfCapTmp.tmp1,''on'');' ...
    '    gfCapTmp.tmp1=''off'';' ...
    'else;' ...
    '    gfCapTmp.tmp1=''on''; ' ...
    'end;' ...
    'set(gfCapTmp.captionHandle,''Visible'',gfCapTmp.tmp1);' ...
    'set(get(gfCapTmp.captionHandle,''Children''),''Visible'',gfCapTmp.tmp1);'...
    'clear gfCapTmp gfCapTmppp;' ...
    ];

capHandle=[...
    'gfCapTmp.h=findall(gcf,''type'',''uipanel'');' ...
    'gfCapTmp.nh=length(gfCapTmp.h);' ...
    'captionHandle=[];' ...
    'for gfCapTmppp=1:length(gfCapTmp.h);' ...
    '    gfCapTmp.tag=get(gfCapTmp.h(gfCapTmppp),''Tag'');' ...
    '    if ~isempty(strfind(gfCapTmp.tag,''gfCap''));' ...
    '        captionHandle=gfCapTmp.h(gfCapTmppp);' ...
    '    end;' ...
    'end;' ...
    'clear gfCapTmp gfCapTmppp;' ...
    'evalin(''base'',''captionHandle'');' ...
    ];

%use call back for example:
if isempty(who('myCaption')); 
    myCaption='';
    %use call back for example:
    %myCaption=['example: ' capOnOff]; 
end;

%create and tag panel:
%hp = uipanel('Title','Caption','FontSize',12,...
hp = uipanel('FontSize',12,...
    'BackgroundColor','white',...
    'Position',[.2 0.05 .6 .1]);
set(hp,'Tag','gfCap');

%add the caption text in panel:
txt = uicontrol('Parent',hp,'Style', 'edit',...
  'BackgroundColor','white','FontSize',12,...
  'Max',2,'Min',0, 'String', ['Caption: ' myCaption]);
set(txt,'units','normalized');
set(txt,'Position',[0.05 0.1 0.9 0.8])

%add menu button:
mn=uimenu('Label','Caption');
uimenu(mn,'Label','Hide/Show','Callback',capOnOff);
uimenu(mn,'Label','captionHandle','Callback',capHandle);

%output caption handle:
captionHandle=hp;
