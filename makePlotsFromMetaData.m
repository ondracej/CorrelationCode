function [] = makePlotsFromMetaData()

dbstop if error

fH100 = figure(100); clf
%mainDataDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/06-Apr-2016-Stims-Coef/PairwiseOutput/meta/NewMeta/';
mainDataDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/22-Aug-2016-Stims-Coef/PairwiseOutput/meta/NewMeta';
setappdata(fH100, 'mainDataDir', mainDataDir);

figSize = fH100.Position;
setappdata(fH100, 'figSize', figSize);


set(fH100, 'Tag', 'fH100', 'NumberTitle', 'off', 'Name', 'Corr Data Viewer');

%uicontrol(fH100, 'Style', 'listbox', 'String', {'Startup ok!'}, 'Position', [figSize(3)*.35 10 550 figSize(4)-20], 'tag', 'loglistbox');

%% We need to find which directories are present in the main data director
allData = dir(fullfile(mainDataDir, '*.mat*'));
n_allData = size(allData, 1);
names_allData = cell(1, n_allData);

% Now we find all the date directory names
for j = 1: n_allData
    names_allData{j} = allData(j).name;
end

%% Now we create a pulldown menu with these date options

uicontrol(fH100,'Style','text','Fontweight', 'bold', 'HorizontalAlignment', 'left', 'BackgroundColor', [.8 .8 .8], 'String','Choose Data','Position',[10 figSize(4)*.9 250 20]);
dataList = uicontrol(fH100,'Style','popupmenu','String', names_allData,'Position',[10 figSize(4)*.85 350 20]);
set(dataList, 'Callback', {@cb_choose_data, fH100})

%% Choose Which Data to Plot // Hide this until ready

plotXCorrH = uicontrol(fH100,'Style','togglebutton','String','[4] Make Plots','Value',0,'Position',[450 figSize(4)*.35 100 40]);
set(plotXCorrH, 'BackgroundColor', [0.456 0.102 0.111], 'ForegroundColor', [1 1 1])
set(plotXCorrH,'Callback',{@cb_makePlots, fH100});


%% Load Meta Data
loadMetaH = uicontrol(fH100,'Style','pushbutton','String', '[1] Load Meta','Position', [400 figSize(4)*.85 100 40]);
set(loadMetaH,'Callback',{@cb_loadMetaData, fH100});

%% Plotting Checklist

plotRawDataH = uicontrol(fH100,'Style','checkbox','String', 'Raw Data','Position', [150 figSize(4)*.55 150 20]);
plotRasterH = uicontrol(fH100,'Style','checkbox','String', 'Raster','Position', [150 figSize(4)*.50 150 20]);

plotDPrimeH = uicontrol(fH100,'Style','checkbox','String', 'DPrime','Position', [250 figSize(4)*.55 150 20]);
plotCorrsH = uicontrol(fH100,'Style','checkbox','String', 'Corrs','Position', [250 figSize(4)*.50 150 20]);

plotAutocorrH = uicontrol(fH100,'Style','checkbox','String', 'Autocorr','Position', [350 figSize(4)*.50 150 20]);
plotFRH = uicontrol(fH100,'Style','checkbox','String', 'Firing Rates','Position', [350 figSize(4)*.55 150 20]);

plotZScoreH = uicontrol(fH100,'Style','checkbox','String', 'Zscore','Position', [450 figSize(4)*.50 150 20]);

setappdata(fH100, 'plotRawDataH', plotRawDataH);
setappdata(fH100, 'plotRasterH', plotRasterH);
setappdata(fH100, 'plotDPrimeH', plotDPrimeH);
setappdata(fH100, 'plotAutocorrH', plotAutocorrH);
setappdata(fH100, 'plotCorrsH', plotCorrsH);
setappdata(fH100, 'plotFRH', plotFRH);
setappdata(fH100, 'plotZScoreH', plotZScoreH);

%plotFRH = uicontrol(fH100,'Style','checkbox','String', 'Firing Rates','Position', [200 figSize(4)*.25 150 20]);

end

function [] = cb_choose_data(src, event, fH100)


index_selected = get(src, 'Value');
list = get(src, 'String');
chosenData = list{index_selected};

%% We define the data date directory
mainDataDir = getappdata(fH100, 'mainDataDir');
setappdata(fH100, 'currDataDir', [mainDataDir '/' chosenData]);


end

function [] = cb_loadMetaData(src, event, fH100)


currDataDir = getappdata(fH100, 'currDataDir');

d = load(currDataDir);
meta = d.meta;

figSize = getappdata(fH100, 'figSize');
setappdata(fH100, 'currMeta', meta);

%% Song Info
song_type = meta.song_type;

%spk_channels = cellfun(@(x) ~isempty(x), spks);

existingSongTypes  = find(cellfun(@(x) ~isempty(x), song_type));
songNames = song_type(existingSongTypes);
setappdata(fH100, 'songNames', songNames);
setappdata(fH100, 'existingSongTypes', existingSongTypes);

%% Stims in meta file

SongListH = uicontrol(fH100,'Style','listbox', 'max', 10, 'min', 1, 'String', songNames,'Position',[10 figSize(4)*.35  80 150]);
setappdata(fH100, 'SongListH', SongListH);
uicontrol(fH100,'Style','text','Fontweight', 'bold', 'HorizontalAlignment', 'left', 'BackgroundColor', [.8 .8 .8], 'String','Stims','Position',[10 figSize(4)*.72 80 20]);




%% Neuron chans in list

totalChanNumber = meta.totalChanNumber;

for p = 1:numel(totalChanNumber )
    chanList{p} = num2str(totalChanNumber(p));
end

ChanListH = uicontrol(fH100,'Style','listbox', 'max', 10, 'min', 1, 'String', chanList,'Position',[100 figSize(4)*.35  20 100]);
uicontrol(fH100,'Style','text','Fontweight', 'bold', 'HorizontalAlignment', 'left', 'BackgroundColor', [.8 .8 .8], 'String','Chs','Position',[100 figSize(4)*.60 30 20]);
setappdata(fH100, 'ChanListH', ChanListH);
setappdata(fH100, 'chanList', chanList);

end



function [] = cb_makePlots(src, event, fH100)

%% Retrieving Plots selected

plotRawDataH = getappdata(fH100, 'plotRawDataH');
plotRasterH = getappdata(fH100, 'plotRasterH');
plotDPrimeH = getappdata(fH100, 'plotDPrimeH');
plotAutocorrH = getappdata(fH100, 'plotAutocorrH');
plotCorrsH = getappdata(fH100, 'plotCorrsH');
plotFRH = getappdata(fH100, 'plotFRH');
plotZScoreH = getappdata(fH100, 'plotZScoreH');

plotRawData_val = plotRawDataH.Value;
plotRaster_val = plotRasterH.Value;
plotDPrime_val = plotDPrimeH.Value;
plotAutocorr_val = plotAutocorrH.Value;
plotCorrs_val = plotCorrsH.Value;
plotFR_val = plotFRH.Value;
plotZScore_val = plotZScoreH.Value;


%% Retrieving Stims Selected

SongListH = getappdata(fH100, 'SongListH');
selection = SongListH.Value;

songNames = getappdata(fH100, 'songNames');
existingSongTypes = getappdata(fH100, 'existingSongTypes');

songsSelected = songNames(selection);
songSelectedInds = existingSongTypes(selection);
nSongs = numel(songsSelected);

setappdata(fH100, 'songsSelected', songsSelected);
setappdata(fH100, 'songSelectedInds', songSelectedInds);
setappdata(fH100, 'nSongs', nSongs);

%% Retrieivng Chans


ChanListH = getappdata(fH100, 'ChanListH');
selection = ChanListH.Value;

chanList = getappdata(fH100, 'chanList');

chansSelected = chanList(selection);
nChansSelected = numel(chansSelected);

chansSelectedInds = [];
for o = 1:nChansSelected
    chansSelectedInds(o) = chansSelected{1, o}; % something is effed up here
end

setappdata(fH100, 'chansSelectedInds', chansSelectedInds);

%%

meta = getappdata(fH100, 'currMeta');



if plotRawData_val
    disp('')
    
end

if plotFR_val
    
    
    gui_plot_FR(meta, songSelectedInds, chansSelected)
    
    
    
    
    
end

if plotRaster_val
    
end

if plotDPrime_val
    
end

if plotAutocorr_val
    
end

if plotZScore_val
    
end


if plotCorrs_val
    
end





disp('')

end


function [] = gui_plot_FR(meta, songSelectedInds, chansSelected)

nChans = numel(chansSelected);
nStims = numel(songSelectedInds);

FR_spont_mean = nan(nChans, nStims);
FR_spont_std = nan(nChans, nStims);
FR_stim_mean = nan(nChans, nStims);
FR_stim_std = nan(nChans, nStims);
theseChans = nan(1, nChans);
theseStims = cell(1, nStims);
spikeCnts_Stim = cell(nChans, nStims);
spikeCnts_Spont = cell(nChans, nStims);

% columns are the stims, and rows are each channel
for k = 1:nStims
    thisStim = songSelectedInds(k);
    
    for j = 1:nChans
        
        thisChan = str2num(chansSelected{j});
        
        FR_spont_mean(j, k) = meta.individual_neuron_stats{thisChan, thisStim}.meanFR_Spont;
        FR_spont_std(j, k) = meta.individual_neuron_stats{thisChan, thisStim}.stdFR_Spont;
        
        FR_stim_mean(j, k) = meta.individual_neuron_stats{thisChan, thisStim}.meanFR_Stim;
        FR_stim_std(j, k) = meta.individual_neuron_stats{thisChan, thisStim}.stdFR_Stim;
        
        spikeCnts_Stim{j, k} = meta.individual_neuron_stats{thisChan, thisStim}.allSpkCnts_Stim(:);
        spikeCnts_Spont{j, k} = meta.individual_neuron_stats{thisChan, thisStim}.allSpkCnts_Spont(:);
        
        theseChans(j) =  thisChan;
        
    end
    theseStims{k} = meta.song_type{thisStim};
end

%% make an individual plot for each channel of the FRs per stimulus

%handles = barweb(barvalues, errors, width, groupnames, bw_title, bw_xlabel, bw_ylabel, bw_colormap, gridstatus, bw_legend)
for j = 1:nChans
    figure
    barweb([FR_spont_mean(j,:)' FR_stim_mean(j,:)'], [FR_spont_std(j,:)'  FR_stim_std(j,:)'], .8, theseStims, [], [], [], 'copper')
    %ylim([-10 10])
    legend('Spont.', 'Stim.')
    title(['Firing rates | Channel: ' num2str(theseChans(j))])
    ylabel('Firing Rate [Hz]')
end


%% make a plot for all the spikecounts

disp('')
figure

for j = 1:nChans
    figure
    for k = 1:nStims
        
        theseCounts_Stim = spikeCnts_Stim{j,k};
        theseCounts_Spont = spikeCnts_Spont{j,k};
        xpnts = ones(1, numel(theseCounts_Stim))*k;
        
        plot(xpnts - .05, theseCounts_Spont, 'k.')
        hold on
        plot(xpnts + .05, theseCounts_Stim, 'r.')
    end
    legend('Spont.', 'Stim.')
    title(['Spike counts | Channel: ' num2str(theseChans(j))])
    ylabel('Spike count [spks]')
    set(gca, 'xtick', 1:1:nStims)
    set(gca, 'xticklabel', theseStims)
    
end

%boxplot(thisGoodData, 'whisker', 0, 'symbol', 'k*', 'outliersize', 4,  'jitter', 0.3, 'colors', [0 0 0])


end



