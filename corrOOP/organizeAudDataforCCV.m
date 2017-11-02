function [] = organizeAudDataforCCV()

dbstop if error

doStim = 2; % 1 stim, 2 = spont

figH = figure(100);

doPLot = 0;

switch gethostname
    case 'turtle'
        
        sortedStimDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/StimOrdered/';
        sortedSpontDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontOrdered/';
        saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/';
        
        AudFile = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/Fr-Zscore/FR-Zscore_OnlyAud.mat';
        plotDir = ['/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/Plots/SpikeCCV/'];
        
    case 'deadpool'
        
        sortedStimDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/StimOrdered/';
        sortedSpontDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontOrdered/';
        saveDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/';
        
        AudFile = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/FR-Zscore/FR-Zscore_OnlyAud.mat';
        plotDir = ['/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/SpikeCCV/'];
        
        
end


if exist(saveDir, 'dir') == 0
    mkdir(saveDir);
end

if exist(plotDir, 'dir') == 0
    mkdir(plotDir);
end


if doStim == 1
    StimFiles = dir([sortedStimDir '*.mat']);
    nFiles  = numel(StimFiles);
    allSpikesCntsOrderd_Stim = cell(230, 12); allSpikesOrderd_Stim = cell(230, 12);
    textbeg = 'CCV-Stim-';
elseif doStim  == 2
    SpontFiles = dir([sortedSpontDir '*.mat']);
    nFiles  = numel(SpontFiles);
    allSpikesOrderd_Spont = cell(230, 12); allSpikesCntsOrderd_Spont = cell(230, 12);
    textbeg = 'CCV-Spont-';
end

nCnt = 1;
ntestcnt = 1;

allDataFiles = []; allDataChans = []; allDataSpkInds = [];

a = load(AudFile);
neuronInds = a.AudSorted.allAudInds;
AudNeuronNames = a.AudSorted.allDataChans_Aud;
AudDatFiles = a.AudSorted.allDataFiles_Aud;

for j = 1:nFiles
    
    if doStim == 1
        dStim = load([sortedStimDir StimFiles(j).name]);
        thisData= dStim.Sorted;
        scanrate = dStim.INFO.scanrate;
    elseif doStim == 2
        dSpont = load([sortedSpontDir SpontFiles(j).name]);
        thisData = dSpont.Sorted;
        scanrate = dSpont.INFO.scanrate;
    end
    
    dataFiles = thisData.allrawDataFiles;
    dataChans = thisData.allNeurons;
    dataChanSpkInds = thisData.allSpkInd;
    
    disp([dataFiles{1} ' = ' num2str(j)]);
    nNeurons = numel(dataChans);
    if nNeurons  ==1
        disp('Single neuron, skipping...')
    end
    
    %% This only makes sense to calculate when there are more than 1 neurons
    %so if nNeurons == 1, we should skip
    
    match = [];
    for k = 1:nNeurons
        
        match(k)  = ismember(ntestcnt, neuronInds);
        ntestcnt= ntestcnt +1;
        
    end
    
    if sum(match) > 1 % some of the neurons match
        
        notMatch = ~match;
        dataChans(notMatch) = []; % should do this in case there is a 0 1 1 match
        dataChanSpkInds(notMatch) = [];
        nNeurons = numel(dataChans);
        
        %% First order all the data for the ensembl
         allSpikesOrdered = [];
        
        for k = 1:nNeurons
            
            %% checkthis
            
            allDataFiles{nCnt} = dataFiles{k};
            allDataChans{nCnt} = dataChans(k);
            allDataSpkInds{nCnt} = dataChanSpkInds(k);
            
            Lengths_s_Ordered_Stim = thisData.allLengths_sOrdered(k,:);
            song_set = find(cellfun(@(x) ~isempty(x), Lengths_s_Ordered_Stim));
            nStims = numel(song_set);
            
            for o = 1:nStims
                thisStim = song_set(o);
                
                %allSpikesCntsOrdered{k,thisStim} =  thisData.allSpikesCntsOrdered{k, thisStim};
                %allSpikesOrdered{k,thisStim} = thisData.allSpikesOrdered{k, thisStim};
                allSpikesOrdered{k,thisStim} = thisData.allGaussSmoothOrdered{k, thisStim};
                
            end
            nCnt = nCnt+1;
            
        end
    
        %binSize_samp = round(binSize_ms/1000*scanrate);
    
        chanComparisons_SignalNoise= [];
        chanComparisons_Signal = [];
        
        chanComparisons_SignalNoise_mean = [];
        chanComparisons_Signal_mean = [];
        
        for o = 1:nStims
            
%             chanComparisons_P = [];
%             chanComparisons_R = [];
%             
%             chanComparisons_R_matrix = [];
%             
%             posCorrs = [];
%             negCorrs = [];
            
            thisStim = song_set(o);
            
            for i = 1:nNeurons
                
                thisChan1 = dataChanSpkInds(i);
                n1Data = allSpikesOrdered{i,thisStim};
                
                for ii = 1:nNeurons
                    
                    thisChan2 = dataChanSpkInds(ii);
                    n2Data = allSpikesOrdered{ii,thisStim};
                    
                    
                    if i >= ii || isempty(n1Data)
                        continue
                    else
                        
                        %% Reorganize all the data:
                        
                        titletxt = [dataFiles{1} ' | ' textbeg num2str(thisStim) ' | N-' num2str(dataChanSpkInds(i)) ' & N-' num2str(dataChanSpkInds(ii)) ' | CCV '];
                        savetxt = [dataFiles{1} textbeg '-' num2str(thisStim) '_N-' num2str(dataChanSpkInds(i)) '-N-' num2str(dataChanSpkInds(ii)) '_CCV'];
                        
                        nReps = size(n1Data, 2);
                        nUnique = size(n1Data, 1);
                        
                        %P_UniqueStims = []; R_UniqueStims = []; buffLength_bins = [];
                        
                        cnt = 1;
                        allCovs_SignalNoise = [];
                        %% Signal+Noise
                        for U = 1:nUnique
                            
                            for R = 1:nReps
                                
                                thisData1 = n1Data{U, R};
                                thisData2 = n2Data{U, R};
                                
                                [COVS_Noise, lags] = xcov(thisData1, thisData2, scanrate, 'coef');
                                
                                allCovs_SignalNoise(cnt,:) = COVS_Noise;
                                cnt = cnt+1;
                                
                            end
                        end
                        
                        lags_ms = lags/scanrate*1000;
                        
                        smoothWin_ms = 5;
                        smoothWin_s  = smoothWin_ms/1000;
                        smoothWin_samp = round(smoothWin_s* scanrate);
                        
                        meanCovSignalNoise = nanmean(allCovs_SignalNoise);
                        smoothCovSignalNoise = smooth(meanCovSignalNoise, smoothWin_samp);
                        
                        %% Signal
                        
                        cnt = 1;
                        allCovs_Signal = [];
                        for U = 1:nUnique
                            
                            for R = 1:nReps
                                
                                RR = R+1;
                                
                                if R == nReps
                                    RR = 1;
                                end
                                
                                thisData1 = n1Data{U, R};
                                thisData2 = n2Data{U, RR};
                                
                                [COVS_Signal, lags] = xcov(thisData1, thisData2, scanrate, 'coef');
                                
                                allCovs_Signal(cnt,:) = COVS_Signal;
                                cnt = cnt+1;
                                
                            end
                        end
                        
                        meanCovSignal = nanmean(allCovs_Signal);
                        smoothCovSignal = smooth(meanCovSignal, smoothWin_samp);
                        
                        if doPLot
                            figure(figH);clf;
                            plot(lags_ms, smoothCovSignalNoise, 'k')
                            hold on
                            plot(lags_ms, smoothCovSignal, 'b')
                            axis tight
                            yss = ylim;
                            line([0 0], [yss(1) yss(2)], 'color', 'r')
                            line([-200 200], [0 0], 'color', 'r')
                            
                            xlim([-200 200])
                            legend('Signal+Noise', 'Signal')
                            legend('boxoff')
                            title(titletxt)
                            
                            figure(figH)
                            plot_filename = [plotDir savetxt];
                            plotpos = [0 0 15 12];
                            %print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
                            print_in_A4(0, plot_filename, '-depsc', 0, plotpos);
                            disp(plot_filename)
                            
                        end
                        
                        %chanComparisons_SignalNoise{thisChan1, thisChan2} = allCovs_SignalNoise;
                        %chanComparisons_Signal{thisChan1, thisChan2} = allCovs_Signal;
                        
                        chanComparisons_SignalNoise_mean{thisChan1, thisChan2} = meanCovSignalNoise;
                        chanComparisons_Signal_mean{thisChan1, thisChan2} = meanCovSignal;
                        
                    end
                    
                end
            end
            
            %SignalNoiseCov_OverStims{j, thisStim} = chanComparisons_SignalNoise;
            %SignalCov_OverStims{j, thisStim} = chanComparisons_Signal;
            
            SignalNoiseCov_mean_OverStims{j, thisStim} = chanComparisons_SignalNoise_mean;
            SignalCov_mean_OverStims{j, thisStim} = chanComparisons_Signal_mean;
            
            
        end
        
    end
    disp('')
end


disp('')

%CCV.SignalNoiseCov_OverStims = SignalNoiseCov_OverStims;
%CCV.SignalCov_OverStims = SignalCov_OverStims;

CCV.SignalNoiseCov_mean_OverStims = SignalNoiseCov_mean_OverStims;
CCV.SignalCov_mean_OverStims = SignalCov_mean_OverStims;

CCV.allDataFiles_Aud = allDataFiles;
CCV.allDataChans_Aud = allDataChans;
CCV.allDataSpkInds_Aud = allDataSpkInds;

CCV.AudNeuronNames = AudNeuronNames;
CCV.AudDatFiles = AudDatFiles;

CCV.scanrate = scanrate;
CCV.lags_ms = lags_ms;


%%
saveName = [saveDir textbeg '-CCV'];
save(saveName, 'CCV', '-v7.3')
disp(saveName)

%%


figH = figure(101);

%PosCovSignalNoise = CCV.SignalNoiseCov_mean_OverStims{27,8}{3,4};
%PosCovSignal = CCV.SignalCov_mean_OverStims{27,8}{3,4};

PosCovSignalNoise = CCV.SignalNoiseCov_mean_OverStims{27,6}{4,6};
PosCovSignal = CCV.SignalCov_mean_OverStims{27,6}{4,6};

scanrate = CCV.scanrate;

smoothWin_ms = 5;
smoothWin_s  = smoothWin_ms/1000;
smoothWin_samp = round(smoothWin_s* scanrate);


PosSmoothCovSignalNoise = smooth(PosCovSignalNoise, smoothWin_samp);
PosSmoothCovSignal = smooth(PosCovSignal, smoothWin_samp);


lags_samp = -scanrate:1:scanrate;
lags_ms  = lags_samp/scanrate*1000;

figure(figH);clf;
plot(lags_ms, PosSmoothCovSignalNoise, 'k')
hold on
plot(lags_ms, PosSmoothCovSignal, 'b')
axis tight
yss = ylim;
line([0 0], [yss(1) yss(2)], 'color', 'r')
line([-200 200], [0 0], 'color', 'r')

xlim([-200 200])
legend('Signal+Noise', 'Signal')
legend('boxoff')



end


