function [] = plotCloudsOfResponses_2017()


directoryDelimiter = '/';
dbstop if error

%nBinsToCombine = 3; % 15 ms
nBinsToCombine = 5; % 25 ms

selection = 68:69; %r6y1 f003, f008
%selection = 56; %p17r2 01
%selection = 58; %r2y2 01
%selection = 46:48; %g18r2 02
%selection = 20:23; %g18r2 02
%selection = 36:38; %o5r3 02



DprimeRange = 5;
FRRange = 2;
switch gethostname
    case 'turtle'
        
        d = load('/home/janie/Data/INI/CorrPaper2016/Data/AuditoryForebrain-Population/AllPooledData/Motif_77_Neurons-106.mat');
        %PopulationInfoFile = '/home/janie/Data/INI/CorrPaper2016/Data/AuditoryForebrain-Population/PopulationInfo.mat';
        b = load('/home/janie/Data/INI/CorrPaper2016/Data/AuditoryForebrain-Population/AllPooledData/allPooledData.mat');
        metaDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/24-Oct-2016-Motifs-Coef/PairwiseOutput/meta/NewMeta/';
        mainDataDir = '/home/janie/Data/INI/Data/Quadruplet/';
        
        %saveDir = '/home/janie/Dropbox/INI/DataPlots/BinDprimes-15ms/';
        saveDir = '/home/janie/Dropbox/INI/DataPlots/BinDprimes-25ms/';
        
    case 'deadpool'
        
        d = load('/home/janie/Data/CorrPaper2016/AuditoryForebrain-Population/AllPooledData/Motif_77_Neurons-106.mat');
        %PopulationInfoFile = '/home/janie/Data/INI/CorrPaper2016/Data/AuditoryForebrain-Population/PopulationInfo.mat';
        b = load('/home/janie/Data/CorrPaper2016/AuditoryForebrain-Population/AllPooledData/allPooledData.mat');
        metaDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/24-Oct-2016-Motifs-Coef/PairwiseOutput/meta/NewMeta/';
        mainDataDir = '/home/janie/Data/INI/Quadruplet/';
        
        %saveDir = '/home/janie/Data/INI/Data/Quadruplet/BinnedRSC_April2017/';
       
        %saveDir = '/home/janie/Dropbox/INI/DataPlots/BinDprimes-15ms/';
        saveDir = '/home/janie/Dropbox/INI/DataPlots/BinDprimes-25ms/';
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
    
    if thisStim == 6
        stimText = 'REV';
    elseif thisStim ==8
        stimText = 'BOS';
    end
    
    
    %for j = 1:nComparisons
    for j = selection
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
        
        
        %[bla, lags] = xcorr(this_data, this_data, scanrate);
        %% Get the data for the bins
        
        chan1 = thisDATA{1, 1};
        chan2 = thisDATA{1, 2};
        
        nMotifReps = size(chan1, 1);
        n5msBins = size(chan1, 2);
        totalLength_ms = n5msBins*AbsBinSize_ms;
        
        %% This is where we define the number of bins to combine
        
        
        binComboLength_ms = nBinsToCombine * AbsBinSize_ms; % abs dur of combined bins
        binLengthText = num2str(binComboLength_ms);
        
        numCombinedBins = floor(totalLength_ms/binComboLength_ms); % number combined bins we can get from the stim
        
        totalbins = numCombinedBins*binComboLength_ms;
        n5msRemainderBins = (totalLength_ms- totalbins)/AbsBinSize_ms;
        
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
        
        %% cloud
        
        %  figH = figure(100); clf
        %  plot(reshapedSpikeCounts_Chan1, reshapedSpikeCounts_Chan2, 'marker', '.', 'linestyle', 'none')
        
        %% D prime selectivity
        
        allDPrimes = [];
        for oo = 1:2
            
            if oo == 1
                
                thisBinData = reshapedSpikeCounts_Chan1;
            elseif oo == 2
                thisBinData = reshapedSpikeCounts_Chan2;
            end
            
            %% Calc D Primes
            this_d_prime = []; this_d_prime_ForHist = [];
            for p = 1:numCombinedBins
                
                thisBinA = thisBinData(:,p);
                stdA = std(thisBinA);
                meanA  = mean(thisBinA);
                
                for q = 1:numCombinedBins
                    
                    % if q > p
                    %this_d_prime_ForHist(p, q) = nan;
                    %    this_d_prime(p, q) = 2 * (meanA - meanB) / sqrt(stdA^2 + stdB^2);
                    % end
                    thisBinB = thisBinData(:,q);
                    stdB = std(thisBinB);
                    meanB  = mean(thisBinB);
                    
                    %this_d_prime(u,v) = roundn(2 * (mean_this_stim_1 - mean_this_stim_2) / sqrt(this_std_1^2 + this_std_2^2), -2);
                    %this_d_prime_ForHist(p, q) = 2 * (meanA - meanB) / sqrt(stdA^2 + stdB^2);
                    this_d_prime(p, q) = 2 * (meanA - meanB) / sqrt(stdA^2 + stdB^2);
                end
            end
            
            %reshapedDPrime = reshape(this_d_prime_ForHist, 1, numel(this_d_prime));
            reshapedDPrime = reshape(this_d_prime, 1, numel(this_d_prime));
            
            allDPrimes{oo} = this_d_prime;
            
            %% Plotting
            
            figH3 = figure(300+oo); clf
            
            %% Spectrograms
            subplot(2, 2, 1)
            specgram1(double(this_buffered_data)/spec_scale,512,scanrate,400,360);
            
            axis tight
            ylim([0 8000])
            axis off
            title([annotationTitle ' | ' stimTitle ' | ' binLengthText ' ms bin'])
            
            %% Firing Rates
            
            subplot(3, 2, 2)
            
            meanFR = nanmean(thisBinData, 1);
            stdFR = nanstd(thisBinData, 1);
            semFR = stdFR / sqrt(size(thisBinData, 1));
            
            smoothedpart1 = real(meanFR+semFR);
            smoothedpart1a = real(meanFR-semFR);
            
            timepointsX = 1:1:numel(meanFR);
            
            plot(meanFR, 'marker', 'o')
            hold on
            
            axis tight
            %ylim([0 FRRange])
            
            
            jbfill(timepointsX,[smoothedpart1],[smoothedpart1a],[.5,0.5,.5],[.5,0.5,.5],[],.3);
            
            for pp = 1:numel(timepointsX)
                text(timepointsX(pp), meanFR(pp)+.01, [ '  ' num2str(pp)]);
            end
            xticks_s = get(gca, 'xtick');
            xticks_ms = xticks_s*binComboLength_ms;
            
            xlabs = [];
            for q = 1:numel(xticks_ms);
                xlabs{q} = num2str(xticks_ms(q));
            end
            
            %legend(['Neuron ' num2str(theseDataChans(oo))])
            set(gca, 'xticklabels', xlabs)
            
            title(['Mean Firing Rates | Neuron ' num2str(theseDataChans(oo))])
            xlabel('Time [ms]')
            ylabel('FR [Hz]')
            %% Sound amplitude/Energy
            
            subplot(2, 2, 3); cla
            timepoints_ms = ((1:1:numel(this_data))/scanrate)*1000;
            
            %plot(timepoints_ms , this_data)
            %yss = [-2000 2000];
            
            energy = (smooth(this_data.^2, 128));
            hold on
            plot(timepoints_ms, energy, 'linewidth', 2)
            
            %ylim(yss)
            axis tight
            yss = ylim;
            
            % Bin Lines
            allLines_ms = 0:binComboLength_ms:binComboLength_ms*numCombinedBins;
            
            hold on
            
            for ww = 1:numel(allLines_ms)
                line([allLines_ms(ww) allLines_ms(ww)], [yss(1) yss(2)], 'color', [0 0 0], 'linewidth', 1)
                text(allLines_ms(ww), yss(2), [ '  ' num2str(ww)]);
            end
            
            title('Sound Energy')
            xlabel('Time [ms]')
            %%
            %figH = figure(100+oo); clf
            subplot(3, 2, 4)
            clims  = [-DprimeRange  DprimeRange ];
            imagesc(this_d_prime,clims)
            colorbar
            
            if oo == 1
                title(['D Prime | ' uniqueDataName{:} ' | Ch-' num2str(theseDataChans(1)) ' | ' binLengthText ' ms'])
            elseif oo == 2
                title(['D Prime | ' uniqueDataName{:} ' | Ch-' num2str(theseDataChans(2)) ' | ' binLengthText ' ms'])
            end
            
            xlabel('Bin Number')
            ylabel('Bin Number')
            
            %% D Primes Histogram
            subplot(3, 2, 6); cla
            histBinSize = 0.05;
            %bincenters = -2.5:histBinSize:2.5;
            bincenters = -DprimeRange :histBinSize:DprimeRange ;
            hist(reshapedDPrime, bincenters)
            axis tight
            %xlim([0 3])
            xlim([-DprimeRange DprimeRange ])
            %ylim([0 40])
            xlabel('D-Prime')
            title(['Bin D-Prime, bin width = ' num2str(histBinSize)])
            
            %%
            figure(figH3)
            disp('Printing Plot')
            set(0, 'CurrentFigure', figH3)
            FSaveName = [FigSaveName '_' stimText '_BinDprimes_Ch-' num2str(theseDataChans(oo)) '_Bin-' binLengthText];
            export_to = set_export_file_format(4);
            plotpos = [0 0 50 20];
            %print_in_A4(0, FigSaveName, export_to, 0, plotpos);
            print_in_A4(0, FSaveName, export_to, 0, plotpos);
            
            disp('')
            
        end
        
        %% calc corr coeffs
        rs = []; ps = [];
        for k = 1:numCombinedBins
            
            [r pP] = corrcoef(reshapedSpikeCounts_Chan1(:,k), reshapedSpikeCounts_Chan2(:,k));
            rs(k) = r(2, 1);
            ps(k) = pP(2, 1);
        end
        
        %%
        figH2 = figure(200); clf
        
        %% Spectrograms
        subplot(3, 2, 1)
        specgram1(double(this_buffered_data)/spec_scale,512,scanrate,400,360);
        
        axis tight
        ylim([0 8000])
        axis off
        title([annotationTitle ' | ' stimTitle ' | ' binLengthText ' ms bin'])
        
        
        %% Sound amplitude
        subplot(3, 2, 3)
        timepoints_ms = ((1:1:numel(this_data))/scanrate)*1000;
        
        %plot(timepoints_ms , this_data)
        %yss = [-2000 2000];
        %ylim(yss)
        
        energy = (smooth(this_data.^2, 128));
        hold on
        plot(timepoints_ms, energy, 'linewidth', 2)
        
        %ylim(yss)
        axis tight
        yss = ylim;
        
        % Bin Lines
        allLines_ms = 0:binComboLength_ms:binComboLength_ms*numCombinedBins;
        
        hold on
        
        for ww = 1:numel(allLines_ms)
            line([allLines_ms(ww) allLines_ms(ww)], [yss(1) yss(2)], 'color', [0 0 0], 'linewidth', 1)
            text(allLines_ms(ww), yss(2), [ '  ' num2str(ww)]);
        end
        
        title('Sound Energy')
        %% FRs
        subplot(3, 2, 5)
        
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
        for b = 1: numel(rs)
            text(timepointsX(b), meanFR_Chan1(b), [ '  ' num2str(b)]);
        end
        hold on
        plot(meanFR_Chan2, 'marker', 'o')
        for b = 1: numel(rs)
            text(timepointsX(b), meanFR_Chan2(b), [ '  ' num2str(b)]);
        end
        axis tight
        %ylim([0 FRRange])
        
        %jbfill(timepointsX,[smoothedpart1],[smoothedpart1a],[.5,0.5,.5],[.5,0.5,.5],[],.3);
        jbfill(timepointsX,[smoothedpart1],[smoothedpart1a],[0,0.7,1],[0,0.7,1],[],.3);
        %jbfill(timepointsX,[smoothedpart2],[smoothedpart2a],[0,0.7,1],[0,0.7,1],[],.3);
        jbfill(timepointsX,[smoothedpart2],[smoothedpart2a],[1,0.6,0],[1,0.6,0],[],.3);
        
        xticks_s = get(gca, 'xtick');
        xticks_ms = xticks_s*binComboLength_ms;
        
        for q = 1:numel(xticks_ms);
            xlabs{q} = num2str(xticks_ms(q));
        end
        
        legend(['Neuron ' num2str(theseDataChans(1))], ['Neuron ' num2str(theseDataChans(2))])
        set(gca, 'xticklabels', xlabs)
        
        title('Mean Firing Rates')
        xlabel('Time [ms]')
            ylabel('FR [Hz]')
        %% D Primes
        
        subplot(3, 2, 2)
        
        clims  = [-DprimeRange  DprimeRange ];
        imagesc(allDPrimes{1},clims)
        set(gca,'XMinorTick','on')
        set(gca,'YMinorTick','on')
        colorbar
        
        title(['D Prime | ' uniqueDataName{:} ' | Ch-' num2str(theseDataChans(1)) ' | ' binLengthText ' ms'])
        xlabel('Bin Number')
        ylabel('Bin Number')
        
        subplot(3, 2, 4)
        imagesc(allDPrimes{2},clims)
        set(gca,'XMinorTick','on')
        set(gca,'YMinorTick','on')
        colorbar
        
        title(['D Prime | ' uniqueDataName{:} ' | Ch-' num2str(theseDataChans(2)) ' | ' binLengthText ' ms'])
        
        xlabel('Bin Number')
        ylabel('Bin Number')
        
        %% Noise Correlation
        
        subplot(3, 2, 6); cla
        
        plot(timepointsX, smooth(rs), 'linewidth', 1.5, 'color', 'k')
        hold on
        %plot(timepointsX, rs, 'marker', 'o', 'linestyle', 'none')
        plot(timepointsX, rs, 'marker', 'o')
        axis tight
        
        for b = 1: numel(rs)
            text(timepointsX(b), rs(b), [ '  ' num2str(b)]);
        end
        
        xticks_s = get(gca, 'xtick');
        xticks_ms = xticks_s*binComboLength_ms;
        
        for q = 1:numel(xticks_ms);
            xlabs{q} = num2str(xticks_ms(q));
        end
        xss = xlim;
        
        set(gca, 'xticklabels', xlabs)
        title('Noise Correlation')
        xlabel('Time [ms]')
        line([xss(1) xss(2)], [0 0], 'color', 'k'),
        axis tight
        %ylim([-.65 .65])
        
        figure(figH2)
        disp('Printing Plot')
        set(0, 'CurrentFigure', figH2)
        FSaveName = [FigSaveName '_' stimText '_BinDCorrs_CH-' num2str(theseDataChans(1)) '-' num2str(theseDataChans(2)) '_Bin-' binLengthText];
        export_to = set_export_file_format(4);
        plotpos = [0 0 50 20];
        %print_in_A4(0, FigSaveName, export_to, 0, plotpos);
        print_in_A4(0, FSaveName, export_to, 0, plotpos);
        
        disp('')
        
    end
    disp('')
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


