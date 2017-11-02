function [] = analyzePopCCVResponses()

doStim = 1; % 1 stim, 2 = spont

figH = figure(100);

doPLot = 0;

switch gethostname
    case 'turtle'
        
        saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/';
        plotDir = ['/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/Plots/SpikeCCV/'];
        
    case 'deadpool'
        
        saveDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/';        
        plotDir = ['/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/SpikeCCV/'];
        
end


if exist(saveDir, 'dir') == 0
    mkdir(saveDir);
end

if exist(plotDir, 'dir') == 0
    mkdir(plotDir);
end


if doStim == 1
    d = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/CCV/CCV-Stim--CCV.mat');
    textbeg = 'CCV-Stim-';
elseif doStim  == 2
    d = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/CCV/CCV-Spont--CCV.mat');
    textbeg = 'RSC-Spont-';
end

stimSet = [1 4 6 7 8 9 12];
nStims = numel(stimSet );

signalCCVs = d.CCV.SignalCov_mean_OverStims;
signalNoiseCCVs = d.CCV.SignalNoiseCov_mean_OverStims;

cols = {'k', 'r', 'b', 'g', 'm', [0.5 0.5 0.5], [0.3 0.5 0.8]};
nComparisons = size(signalCCVs, 1);

scanrate = d.CCV.scanrate;
lags_samp = -scanrate:1:scanrate;
lags_ms = lags_samp/scanrate*1000;
    
    
allCCV_Signal_Stims = []; allCCV_SignalNoise_Stims = []; allpairs = []; allnPairs = [];
for j = 1:nStims
    thisStim = stimSet(j);
    
    cnt = 1;
    
    allCCV_Signal = []; allCCV_SignalNoise = []; nPairs = [];
    for k = 1:nComparisons    
        thisCCV_Signal = signalCCVs{k, thisStim};
        thisCCV_SignalNoise = signalNoiseCCVs{k, thisStim};
        
        if ~isempty(thisCCV_Signal)
            pairInds = find(cellfun(@(x) ~isempty(x), thisCCV_Signal));
            nPairs(k) = numel(pairInds);
            figure(100); clf
            for o = 1:numel(pairInds)
                allCCV_Signal{cnt} = thisCCV_Signal{pairInds(o)};
                allCCV_SignalNoise{cnt} = thisCCV_SignalNoise{pairInds(o)};
                
                
                subplot(nPairs, 1, o)
                plot(lags_ms, allCCV_Signal{cnt}, 'color', 'b')
                hold on
                plot(lags_ms, allCCV_SignalNoise{cnt}, 'color', 'k')
                axis tight
                xlim([-200 200])
                %ylim([-.0005 .004])
                
                
                cnt = cnt+1;
            end
        end
        
        
    end
    
    allCCV_Signal_Stims{thisStim} = allCCV_Signal;
    allCCV_SignalNoise_Stims{thisStim} = allCCV_SignalNoise;

    allpairs{thisStim} = sum(nPairs);
    allnPairs{thisStim} = nPairs;

end
allSums = [];
for  j = [1 3 6 10]
    
    allSums{j} = numel(find(allnPairs{1} ==j));
    
end

%%

close all
allSymSignalCVVs = []; allSymSignalNoiseCVVs = [];
for j = 1:nStims
    thisStim = stimSet(j);
    
    thisStim_SignalCCV = cell2mat(allCCV_Signal_Stims{thisStim}');
    thisStim_SignalNoiseCCV = cell2mat(allCCV_SignalNoise_Stims{thisStim}');
    
    mean_thisStim_SignalCCV = nanmean(thisStim_SignalCCV);
    mean_thisStim_SignalNoiseCCV = nanmean(thisStim_SignalNoiseCCV);
    
    Sym_mean_thisStim_SignalCCV = (mean_thisStim_SignalCCV + fliplr(mean_thisStim_SignalCCV))/2;
    Sym_mean_thisStim_SignalNoiseCCV = (mean_thisStim_SignalNoiseCCV + fliplr(mean_thisStim_SignalNoiseCCV))/2;
    
    
    
    %%
    figure(100+j); clf;
    plot(lags_ms, Sym_mean_thisStim_SignalCCV, 'b')
    hold on
    plot(lags_ms, Sym_mean_thisStim_SignalNoiseCCV, 'k')
    xlim([-200 200])
    ylim([-.0005 .004])
    
    title(['Stim' num2str(thisStim)])
    allSymSignalCVVs{thisStim} = Sym_mean_thisStim_SignalCCV;
    allSymSignalNoiseCVVs{thisStim} = Sym_mean_thisStim_SignalNoiseCCV;
end

%%







end