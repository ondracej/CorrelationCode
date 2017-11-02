function [] = browse_Corr_MetaData()

dbstop if error

switch gethostname
    case 'm-01237'
        mainDataDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/';
    case 'd-01096'
        mainDataDir = '/storage/laur/Personal/OndracekJanie/INI/Projects/Extracellular/Quadruplet/Analysis/5ms/';
    case 'deadpool'
         mainDataDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/';
    otherwise
        
        
        disp('Please defined directory')
end

dirD = '/';

%% Figure
fH100 = figure(100); clf
figSize = fH100.Position;

setappdata(fH100, 'figSize', figSize); %###
setappdata(fH100, 'mainDataDir', mainDataDir); %###
set(fH100, 'Tag', 'fH100', 'NumberTitle', 'off', 'Name', 'Corr Data Viewer');

%%

%% Plotting Checklist

%Define Area Selection
sortAreaH = uicontrol(fH100,'Style','checkbox','String', 'SelectArea','Position', [10 figSize(4)*.95 150 20]);
set(sortAreaH, 'Callback', {@cb_makeAreaSelection, fH100})

% Define WN Comparison
CompareWNH = uicontrol(fH100,'Style','checkbox','String', 'CompareWN','Position', [150 figSize(4)*.95 150 20]);
set(CompareWNH, 'Callback', {@cb_propWNComparisonOptions, fH100})

%Define Stimulus Set
defStimSetH = uicontrol(fH100,'Style','checkbox','String', 'SelectStims','Position', [270 figSize(4)*.95 150 20]);
set(defStimSetH, 'Callback', {@cb_makeStimSelection, fH100})

% Outliers/Duplicates
removeOutliersH = uicontrol(fH100,'Style','checkbox','String', 'removeOutliers','Position', [10 figSize(4)*.2 150 20]);
removeDuplicatesH = uicontrol(fH100,'Style','checkbox','String', 'removeDuplicates','Position', [10 figSize(4)*.10 150 20]);

% Dprime Range
DPrimeRangeH = uicontrol(fH100,'Style','checkbox','String', 'DPrimeRange','Position', [400 figSize(4)*.95 150 20]);
set(DPrimeRangeH, 'Callback', {@cb_setDPrimeRange, fH100})

SaveStringH = uicontrol(fH100,'Style','edit','Position',[420 figSize(4)*.42 120 25]);
set(SaveStringH, 'Callback', {@cb_enterSaveString, fH100})

% go button
startMetaSelectionH = uicontrol(fH100,'Style','pushbutton','String','Sort Meta Data','Position',[420 figSize(4)*.10  120 120]);
set(startMetaSelectionH, 'BackgroundColor', [0.204 0.702 0.494], 'ForegroundColor', [1 1 1])
set(startMetaSelectionH, 'Callback', {@cb_finalizeMetaSelection, fH100})

dataCutoffH = uicontrol(fH100,'Style','checkbox','String', 'Min Data Cutoff','Position', [200 figSize(4)*.2 150 20]);
minDataRespCutoffH = uicontrol(fH100,'Style','edit','Position',[220 figSize(4)*.13 80 25]);
set(minDataRespCutoffH, 'Callback', {@cb_enterDataCutoffVal, fH100})


%%
setappdata(fH100, 'removeOutliersH', removeOutliersH);
setappdata(fH100, 'removeDuplicatesH', removeDuplicatesH);
setappdata(fH100, 'sortAreaH', sortAreaH);
setappdata(fH100, 'CompareWNH', CompareWNH);
setappdata(fH100, 'defStimSetH', defStimSetH);
setappdata(fH100, 'DPrimeRangeH', DPrimeRangeH);
setappdata(fH100, 'dataCutoffH', dataCutoffH);
setappdata(fH100, 'SaveStringH', SaveStringH);

end

function [] = cb_makeAreaSelection(src, event, fH100)

figSize  = getappdata(fH100, 'figSize'); %###

areaList   = {'L2a', 'L2b', 'L1', 'L3', 'HVC', 'CM', 'NCM', 'HCV-Sh', 'Hipp'};

areaListH = uicontrol(fH100,'Style','listbox', 'max', 10, 'min', 1, 'String', areaList,'Position',[25 figSize(4)*.55  80 150]);
setappdata(fH100, 'areasList', areaList);
setappdata(fH100, 'areaListH', areaListH);

makeAreaSelectionH = uicontrol(fH100,'Style','pushbutton','String','Select','Position',[15 figSize(4)*.47  120 20]);
set(makeAreaSelectionH, 'Callback', {@cb_finalizeAreaSelection, fH100})

end

function [] = cb_finalizeAreaSelection(src, event, fH100)

areaListH = getappdata(fH100, 'areaListH');
areasSelected = areaListH.Value;
areaList = getappdata(fH100, 'areasList');

selectedAreas = areaList(areasSelected);
nSelectedAreas = numel(selectedAreas);

setappdata(fH100, 'selectedAreas', selectedAreas);
setappdata(fH100, 'nSelectedAreas', nSelectedAreas);
setappdata(fH100, 'AreasSelectedNum', areasSelected);

end

%% Stimulus Selection Callbacks
function [] = cb_makeStimSelection(src, event, fH100)

figSize  = getappdata(fH100, 'figSize'); %###


stim_namesList = {'WNBOF-', 'Pips-', 'Tones-','Stacks-','-','REV-','CON-','BOS-','qBOS-','-','-', 'WNEOF'};


%song_set_text = cell2mat(stim_names(song_set));


%stimset_size = size(song_set, 2);



stimListH = uicontrol(fH100,'Style','listbox', 'max', 10, 'min', 1, 'String', stim_namesList,'Position',[290 figSize(4)*.55  80 150]);
setappdata(fH100, 'stim_namesList', stim_namesList);
setappdata(fH100, 'stimListH', stimListH);

makeStimSelectionH = uicontrol(fH100,'Style','pushbutton','String','Select','Position',[290 figSize(4)*.47  120 20]);
set(makeStimSelectionH, 'Callback', {@cb_finalizeStimSelection, fH100})

end

function [] = cb_finalizeStimSelection(src, event, fH100)

stimListH = getappdata(fH100, 'stimListH');
stimsSelected = stimListH.Value;
stim_namesList = getappdata(fH100, 'stim_namesList');

selectedStims = stim_namesList(stimsSelected);
nSelectedStims = numel(selectedStims);

setappdata(fH100, 'selectedStims', selectedStims);
setappdata(fH100, 'nSelectedStims', nSelectedStims);
setappdata(fH100, 'selectedStimsNum', stimsSelected);

end


%% White Noise Comparison Callbacks

function [] = cb_propWNComparisonOptions(src, event, fH100)

figSize  = getappdata(fH100, 'figSize'); %###

% For stim and spont selection
bg = uibuttongroup('Visible','on',...
    'Position',[.27 .69 .2 .2],...
    'SelectionChangedFcn',{@cb_bselection, fH100});

% Create three radio buttons in the button group.
r1 = uicontrol(bg,'Style',...
    'radiobutton',...
    'String','Spont',...
    'Position',[10 20 70 30],...
    'HandleVisibility','on');

r2 = uicontrol(bg,'Style','radiobutton',...
    'String','Stim',...
    'Position',[10 50 70 30],...
    'HandleVisibility','on');


%%
% For kind of ttest selction
bg2 = uibuttongroup('Visible','on',...
    'Position',[.27 .40 .22 .3],...
    'SelectionChangedFcn',{@cb_bselection2, fH100});

% Create three radio buttons in the button group.
rr1 = uicontrol(bg2,'Style',...
    'radiobutton',...
    'String','SignedRanks',...
    'Position',[10 20 120 30],...
    'HandleVisibility','on');

rr2 = uicontrol(bg2,'Style','radiobutton',...
    'String','RankSum',...
    'Position',[10 50 120 30],...
    'HandleVisibility','on');

rr3 = uicontrol(bg2,'Style','radiobutton',...
    'String','pairedTTest',...
    'Position',[10 80 120 30],...
    'HandleVisibility','on');

%%

sigH = uicontrol(fH100,'Style','popupmenu', 'String', {'0.05', '0.01'},'Position',[160 figSize(4)*.32 50 20]);
setappdata(fH100, 'sigH', sigH);

end


function [] = cb_bselection(src, event, fH100)

switch event.NewValue.String
    
    case 'Stim'
        WNSel = 1;
        
    case 'Spont'
        WNSel = 2;
end

setappdata(fH100, 'WNSel', WNSel);

end


function [] = cb_bselection2(src, event, fH100)

switch event.NewValue.String
    
    case 'pairedTTest'
        WNSel_test = 1;
        
    case 'RankSum'
        WNSel_test = 2;
        
    case 'SignedRanks'
        WNSel_test = 3;
        
end

setappdata(fH100, 'WNSel_test', WNSel_test);

end

%% D Prime Filtering Callbacks

function [] = cb_setDPrimeRange(src, event, fH100)

figSize  = getappdata(fH100, 'figSize'); %###


bg3 = uibuttongroup('Visible','on',...
    'Position',[.77 .60 .15 .35],...
    'SelectionChangedFcn',{@cb_bselection3, fH100});

% Create three radio buttons in the button group.
r1 = uicontrol(bg3,'Style',...
    'radiobutton',...
    'String','WN-S',...
    'Position',[10 20 120 30],...
    'HandleVisibility','on');

r2 = uicontrol(bg3,'Style','radiobutton',...
    'String','REV',...
    'Position',[10 50 120 30],...
    'HandleVisibility','on');

r3 = uicontrol(bg3,'Style','radiobutton',...
    'String','BOS',...
    'Position',[10 80 120 30],...
    'HandleVisibility','on');

r4 = uicontrol(bg3,'Style','radiobutton',...
    'String','CON',...
    'Position',[10 110 120 30],...
    'HandleVisibility','on');


dprimeSettingH = uicontrol(fH100,'Style','edit','Position',[430 figSize(4)*.47 80 25]);
set(dprimeSettingH, 'Callback', {@cb_enterDprimeValue, fH100})

end

function [] = cb_bselection3(src, event, fH100)

switch event.NewValue.String
    
    case 'CON'
        dPrimeStim = 1;
        
    case 'BOS'
        dPrimeStim = 2;
        
    case 'REV'
        dPrimeStim = 3;
        
    case 'WN-S'
        dPrimeStim = 4;
        
end

setappdata(fH100, 'dPrimeStim', dPrimeStim);

end


function [] = cb_enterDprimeValue(src, event, fH100)

dprimeVal = str2num(src.String);
setappdata(fH100, 'dprimeVal', dprimeVal);

end

function [] = cb_enterDataCutoffVal(src, event, fH100)

dataCutoffVal = str2num(src.String);
setappdata(fH100, 'dataCutoffVal', dataCutoffVal);

end

function [] = cb_enterSaveString(src, event, fH100)

saveStr = src.String;
setappdata(fH100, 'saveStr', saveStr);

end


function [] = cb_finalizeMetaSelection(src, event, fH100)



%% Get Info From the buttons

removeOutliersH = getappdata(fH100, 'removeOutliersH');
removeDuplicatesH = getappdata(fH100, 'removeDuplicatesH');
sortAreaH = getappdata(fH100, 'sortAreaH');
CompareWNH = getappdata(fH100, 'CompareWNH');
defStimSetH = getappdata(fH100, 'defStimSetH');
DPrimeRangeH = getappdata(fH100, 'DPrimeRangeH');
dataCutoffVal = getappdata(fH100, 'dataCutoffVal');
dataCutoffH = getappdata(fH100, 'dataCutoffH');
saveStr  = getappdata(fH100, 'saveStr'); 

removeOutliers = removeOutliersH.Value;
removeDuplicates = removeDuplicatesH.Value;
sortArea = sortAreaH.Value;
CompareWN = CompareWNH.Value;
defStimSet = defStimSetH.Value;
DPrimeRange = DPrimeRangeH.Value;
dataCutoff = dataCutoffH.Value;
dataCutoffValue = dataCutoffVal;

%% Propagate info
criteria.saveStr = saveStr;

criteria.removeOutliers = removeOutliers;
criteria.removeDuplicates = removeDuplicates;

%% Area
if sortArea
    % get area info
    selectedAreas = getappdata(fH100, 'selectedAreas');
    nSelectedAreas = getappdata(fH100, 'nSelectedAreas');
    AreasSelectedNum = getappdata(fH100, 'AreasSelectedNum');
    
else
    selectedAreas  = [];
    nSelectedAreas = [];
    AreasSelectedNum = [];
end

criteria.sortArea = sortArea;
criteria.selectedAreas = selectedAreas;
criteria.nSelectedAreas = nSelectedAreas;
criteria.AreasSelectedNum = AreasSelectedNum;

%% WN Comparison

if CompareWN
    
    sigH  = getappdata(fH100, 'sigH');
    
    sigHval = sigH.Value;
    sigHstring = sigH.String;
    
    sigLevel = str2num(sigHstring{sigHval});
    
    WNSel = getappdata(fH100, 'WNSel'); % Stim  = 1, Spont = 2
    WNSel_test = getappdata(fH100, 'WNSel_test'); % 1 = paired ttest, 2 = ranksum, 3 = signed rank
    
else
    
    sigLevel = [];
    
    WNSel = [];
    WNSel_test = [];
    
end

criteria.CompareWN = CompareWN;
criteria.sigLevel = sigLevel;
criteria.WNSel = WNSel;
criteria.WNSel_test = WNSel_test;

%% Define Stim set
if defStimSet
    
    selectedStims = getappdata(fH100, 'selectedStims');
    nSelectedStims = getappdata(fH100, 'nSelectedStims');
    selectedStimsNum = getappdata(fH100, 'selectedStimsNum');
else
    
    selectedStims = [];
    nSelectedStims= [];
    selectedStimsNum = [];
end

criteria.defStimSet = defStimSet;
criteria.selectedStims = selectedStims;
criteria.nSelectedStims = nSelectedStims;
criteria.selectedStimsNum = selectedStimsNum;

%% Dprime Selection
if DPrimeRange
    dPrimeStim = getappdata(fH100, 'dPrimeStim'); %1=Con, 2=BOS, 3=REV, 4=WN-S
    dprimeVal = getappdata(fH100, 'dprimeVal');
    
else
    
    dPrimeStim = [];
    dprimeVal = [];
end

criteria.DPrimeRange = DPrimeRange;
criteria.dPrimeStim = dPrimeStim;
criteria.dprimeVal = dprimeVal;

%% Data cutoff

criteria.dataCutoff = dataCutoff;
criteria.dataCutoffValue = dataCutoffValue;

%%
mainDataDir = getappdata(fH100, 'mainDataDir'); %###
criteria.mainDataDir = mainDataDir;

criteriaSaveDir = [mainDataDir saveStr '-Criteria.mat'];
save(criteriaSaveDir, 'criteria');

%%
filterDataBasedOnCriteria_V3(criteria)

end

