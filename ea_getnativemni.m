function nativemni = ea_getnativemni
% Returns 1 for "MNI space" or 2 for "Native Space" handle in main LEAD GUI
% __________________________________________________________________________________
% Copyright (C) 2017 University of Pittsburgh (UPMC), Brain Modulation Lab
% Ari Kappel

nativemnistr = [];

openFigs = findall(0,'Type','Figure');
openNames = {openFigs(:).Name};
idx = ~cellfun(@isempty,strfind(openNames,'Lead-DBS'));
appdata = getappdata(openFigs(idx));
vizspacevalue = appdata.UsedByGUIData_m.vizspacepopup.Value;

nativemnistr = char(appdata.UsedByGUIData_m.vizspacepopup.String(vizspacevalue));
nativemnistr = strsplit(nativemnistr); 
nativemnistr = nativemnistr{1};

if isempty(nativemnistr)
    ea_error('Main Lead-DBS GUI must be open to use ea_getnativemni')
elseif strcmp(nativemnistr,'MNI')
    nativemni=1;
elseif strcmp(nativemnistr,'Native')
    nativemni=2;
end