function []  = calculateRSCForMotifBins_2017()


directoryDelimiter = '/';
dbstop if error
nBinsToCombine = 5; % number of 5 ms bins to combine

switch gethostname
    case 'turtle'

        d = load('/home/janie/Data/INI/CorrPaper2016/Data/AuditoryForebrain-Population/AllPooledData/Motif_77_Neurons-106.mat');
        %PopulationInfoFile = '/home/janie/Data/INI/CorrPaper2016/Data/AuditoryForebrain-Population/PopulationInfo.mat';
        b = load('/home/janie/Data/INI/CorrPaper2016/Data/AuditoryForebrain-Population/AllPooledData/allPooledData.mat');
        metaDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/24-Oct-2016-Motifs-Coef/PairwiseOutput/meta/NewMeta/';
        mainDataDir = '/home/janie/Data/INI/Data/Quadruplet/';
        
        %saveDir = '/home/janie/Data/INI/Data/Quadruplet/BinnedRSC_April2017/';
        saveDir = '/home/janie/Dropbox/INI/DataPlots/';
        
    case 'deadpool'
        
        d = load('/home/janie/Data/CorrPaper2016/AuditoryForebrain-Population/AllPooledData/Motif_77_Neurons-106.mat');
        %PopulationInfoFile = '/home/janie/Data/INI/CorrPaper2016/Data/AuditoryForebrain-Population/PopulationInfo.mat';
        b = load('/home/janie/Data/CorrPaper2016/AuditoryForebrain-Population/AllPooledData/allPooledData.mat');
        metaDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/24-Oct-2016-Motifs-Coef/PairwiseOutput/meta/NewMeta/';
        mainDataDir = '/home/janie/Data/INI/Quadruplet/';
        
        %saveDir = '/home/janie/Data/INI/Data/Quadruplet/BinnedRSC_April2017/';
        saveDir = '/home/janie/Dropbox/INI/DataPlots/';
end

if exist(saveDir, 'dir') == 0
    mkdir(saveDir);
end

INFO = b.INFO;
clear('b')
nComparisons = numel(INFO.PairwiseComparisons_FileNames);

%%
StimSet = [6, 8];
AbsBinSize_ms = 5;

%% Propagate meta files

[tagNames, namesMetaFilesSorted] = propagagteMetaFileNames(metaDir);
%%
allDataNames = d.INFO.IndividualNeurons_FileNames;
allSingleNeuronData = d.singleNeuronData;
allChannelNames = d.INFO.IndividualNeurons_Channels;
clear('d')
for s = 1:numel(StimSet)
    
    thisStim = StimSet(s);
    thisData = allSingleNeuronData{1, thisStim}.allBinnedSpkCnts_Stims_forXCOV; % this is in 5 ms bins
    
    for j = 1:nComparisons
        thisInd = j;
        
        %% Find which inds match this pairing
        
        [AllIndividualInds] = lookupIndNeurons(thisInd, INFO);
        % we are looking at binned data
        DataNames = allDataNames(AllIndividualInds);
        theseDataChans = allChannelNames(AllIndividualInds);
        uniqueDataName = unique(DataNames); % should be just one name
        [thisDATA] = getDataFromInds(thisData, AllIndividualInds);
        
        %% figure out the meta to load
        [FigSaveName, annotationTitle, this_data, spec_scale, scanrate, this_buffered_data, stimTitle] = loadSpectrogramData(thisStim, uniqueDataName, tagNames, namesMetaFilesSorted, metaDir, mainDataDir, directoryDelimiter, saveDir);
        
        %% Get the data for the bins
        
        chan1 = thisDATA{1, 1};
        chan2 = thisDATA{1, 2};
        
        nMotifReps = size(chan1, 1);
        n5msBins = size(chan1, 2);
        totalLenght_ms = n5msBins*AbsBinSize_ms;
        
        %% This is where we define the number of bins to combine
        
        
        binComboLenght_ms = nBinsToCombine * AbsBinSize_ms; % abs dur of combined bins
        binLenghtText = num2str(binComboLenght_ms);
        
        numCombinedBins = floor(totalLenght_ms/binComboLenght_ms); % number combined bins we can get from the stim
        
        totalbins = numCombinedBins*binComboLenght_ms;
        n5msRemainderBins = (totalLenght_ms- totalbins)/AbsBinSize_ms;
        
        reshapedSpikeCounts_Chan1 = []; reshapedSpikeCounts_Chan2 = [];

        for o = 1:nMotifReps
            thisChan1Rep = chan1(o, 1:end-n5msRemainderBins); % we include only the bins that even break into the bin count
            thisChan2Rep = chan2(o, 1:end-n5msRemainderBins); % we include only the bins that even break into the bin count
            
            chan1_reshape = reshape(thisChan1Rep, [nBinsToCombine, numCombinedBins]);
            chan2_reshape = reshape(thisChan2Rep, [nBinsToCombine, numCombinedBins]);
            
            chan1BinSums = sum(chan1_reshape, 1);
            chan2BinSums = sum(chan2_reshape, 1);
            
            reshapedSpikeCounts_Chan1(o,:) = chan1BinSums;
            reshapedSpikeCounts_Chan2(o,:) = chan2BinSums;
            
        end
        
        %% calc corr coeffs
        
        for k = 1:numCombinedBins
            
            [r h] = corrcoef(reshapedSpikeCounts_Chan1(:,k), reshapedSpikeCounts_Chan2(:,k));
            rs(k) = r(2, 1);
            
        end
        
        figH2 = figure(200); clf
        %% Spectrogram
        subplot(5, 1, 1)
        specgram1(double(this_buffered_data)/spec_scale,512,scanrate,400,360);
        
        axis tight
        ylim([0 8000])
        axis off
        title([annotationTitle ' | ' stimTitle ' | Ch-' num2str(theseDataChans(1)) '&' num2str(theseDataChans(2)) ' | ' binLenghtText ' ms bin'])
        
        %% Sound amplitude
        subplot(5, 1, 2)
        timepoints_ms = ((1:1:numel(this_data))/scanrate)*1000;
        plot(timepoints_ms , this_data)
        yss = [-2000 2000];
        ylim(yss)
        axis tight
        
        % Bin Lines
        allLines_ms = 0:binComboLenght_ms:binComboLenght_ms*numCombinedBins;
        
        hold on
        
        for oo = 1:numel(allLines_ms)
            line([allLines_ms(oo) allLines_ms(oo)], [yss(1) yss(2)], 'color', [0 0 0], 'linewidth', 1)
            text(allLines_ms(oo), yss(2), [ '  ' num2str(oo)]);
        end
        
        %% Firing Rates
        
        subplot(5, 1, 3)
        
        meanFR_Chan1 = nanmean(reshapedSpikeCounts_Chan1, 1);
        stdFR_chan1 = nanstd(reshapedSpikeCounts_Chan1, 1);
        semFR_chan1 = stdFR_chan1 / sqrt(size(reshapedSpikeCounts_Chan1, 1));
        
        meanFR_Chan2 = nanmean(reshapedSpikeCounts_Chan2, 1);
        stdFR_chan2 = nanstd(reshapedSpikeCounts_Chan2, 1);
        semFR_chan2 = stdFR_chan2 / sqrt(size(reshapedSpikeCounts_Chan2, 1));
        
        smoothedpart1 = real(meanFR_Chan1+semFR_chan1);
        smoothedpart1a = real(meanFR_Chan1-semFR_chan1);
        
        smoothedpart2 = real(meanFR_Chan2+semFR_chan2);
        smoothedpart2a = real(meanFR_Chan2-semFR_chan2);
        
        timepointsX = 1:1:numel(meanFR_Chan1);
        
        plot(meanFR_Chan1, 'marker', 'o')
        hold on
        plot(meanFR_Chan2, 'marker', 'o')
        axis tight
        
        %jbfill(timepointsX,[smoothedpart1],[smoothedpart1a],[.5,0.5,.5],[.5,0.5,.5],[],.3);
        jbfill(timepointsX,[smoothedpart1],[smoothedpart1a],[0,0.7,1],[0,0.7,1],[],.3);
        %jbfill(timepointsX,[smoothedpart2],[smoothedpart2a],[0,0.7,1],[0,0.7,1],[],.3);
        jbfill(timepointsX,[smoothedpart2],[smoothedpart2a],[1,0.6,0],[1,0.6,0],[],.3);
        
        xticks_s = get(gca, 'xtick');
        xticks_ms = xticks_s*binComboLenght_ms;
        
        for q = 1:numel(xticks_ms);
            xlabs{q} = num2str(xticks_ms(q));
        end
        
        legend(['Neuron ' num2str(theseDataChans(1))], ['Neuron ' num2str(theseDataChans(2))])
        set(gca, 'xticklabels', xlabs)
        
        title('Mean Firing Rates')
        %% Noise Correlation
        
        subplot(5, 1, 4)
        
        plot(rs, 'marker', 'o')
        axis tight
        
        xticks_s = get(gca, 'xtick');
        xticks_ms = xticks_s*binComboLenght_ms;
        
        for q = 1:numel(xticks_ms);
            xlabs{q} = num2str(xticks_ms(q));
        end
        xss = xlim;
        
        set(gca, 'xticklabels', xlabs)
        title('Noise Correlation')
        xlabel('Time [ms]')
        line([xss(1) xss(2)], [0 0]),
        
        ylim([-.4 .4])
        %%
        
        subplot(5, 1, 5)
        
        bincenters = -1:.02:1;
        hist(rs, bincenters)
        
        
        disp('')
        
        
        figure(figH2)
        disp('Printing Plot')
        set(0, 'CurrentFigure', figH2)
        FSaveName = [FigSaveName 'Stim' num2str(thisStim) '_CorrFRDists_CH-' num2str(theseDataChans(1)) '-' num2str(theseDataChans(2)) '_Bin-' binLenghtText];
        export_to = set_export_file_format(4);
        plotpos = [0 0 25 20];
        %print_in_A4(0, FigSaveName, export_to, 0, plotpos);
        print_in_A4(0, FSaveName, export_to, 0, plotpos);
        
        disp('')
        
        
    end
end

end

function [tagNames, namesMetaFilesSorted] = propagagteMetaFileNames(metaDir)
metaFiles = dir(fullfile(metaDir, '*.mat*'));

nMetaFiles = numel(metaFiles);
% Now we find all the date directory names
for j = 1: nMetaFiles
    namesMetaFiles{j} = metaFiles(j).name;
end

[namesMetaFilesSorted,~] = sort(namesMetaFiles);

dash = '-';
dot = '.';
for q = 1: nMetaFiles
    dashes2 = find(namesMetaFilesSorted{q} == dash);
    dots2 = find(namesMetaFilesSorted{q} == dot);
    
    if numel(dots2) > 1
        dots2 = dots2(end);
    else
        dots2 = dots2(1);
        disp('')
    end
    
    if numel(dashes2) > 4
        dashes2 = dashes2(4);
    else
        dashes2 = dashes2(end);
        disp('')
    end
    
    
    str2 = namesMetaFilesSorted{q}(dashes2+1:dots2-1);
    
    tagNames{q} = str2;
    
end

end

function [FigSaveName, annotationTitle, this_data, spec_scale, scanrate, this_buffered_data, stimTitle] = loadSpectrogramData(thisStim, uniqueDataName, tagNames, namesMetaFilesSorted, metaDir, mainDataDir, directoryDelimiter, saveDir)

fileMatchInd = find(cell2mat(cellfun(@(x) strcmpi(x, uniqueDataName), tagNames, 'uniformoutput', 0)));
namesMetaFilesSorted{fileMatchInd}
this_metafile = [metaDir namesMetaFilesSorted{fileMatchInd}];
this_meta = load(this_metafile);
m = this_meta.meta;

bird_name = m.bird_name;
data_name = m.raw_data_filename;
mic_channel = m.wav_chan;
spec_scale = 2000; % for changing the intesity of the spectrogram

if isempty(mic_channel)
    mic_channel = m.mic_chan(1);
    spec_scale = 1000; % for changing the intesity of the spectrogram
    
end

thisBirdPath = [mainDataDir bird_name directoryDelimiter];
thisRawDataPath = [thisBirdPath 'Data' directoryDelimiter];
thisRecordingSessionPath = [thisRawDataPath data_name];

FigSaveName = [saveDir data_name ];
annotationTitle = [bird_name ' | ' data_name ];
data_file_format = m.data_file_format;

if thisStim == 6
    stimTitle = 'REV Motif';
elseif thisStim == 8
    stimTitle = 'BOS motif' ;
end

stim_start = m.stim_starts{1,thisStim};
stim_stop = m.stim_stops{1,thisStim};
reps = 1;

for p  = 1:reps
    
    roiOn_samps = stim_start(p);
    roiOff_samps = stim_stop(p);
end

clear('m')

if data_file_format ~= 8 % file format 8 needs to be loaded with the chronic file loader
    [data scanrate]= load_labview_acute(thisRecordingSessionPath, 0);
    disp('Loading raw data file..');
else
    [data scanrate] = load_labview_chronic(thisRecordingSessionPath, 0);
    disp('Loading raw data file..');
end

%buffer_sampls = floor((buffer/1000)*scanrate);
%this_data = data(mic_channel,roiOn_samps-buffer_sampls:roiOff_samps+1*buffer_sampls);
this_data = data(mic_channel,roiOn_samps:roiOff_samps+1);

spectrogramBuffer = floor((10/1000)*scanrate); % 10 ms
this_buffered_data = data(mic_channel,roiOn_samps-spectrogramBuffer:roiOff_samps+1*spectrogramBuffer);

end


