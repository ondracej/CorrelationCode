function [] = organizeAudDataforACs()

dbstop if error

doStim = 2; % 1 stim, 2 = spont

switch gethostname
    case 'turtle'
        
        sortedStimDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/StimOrdered/';
        sortedSpontDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontOrdered/';
        saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/';
        
        AudFile = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/Fr-Zscore/FR-Zscore_OnlyAud.mat';
        plotDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/Plots/AC_AudData-notGaus/';
        
    case 'deadpool'
        
        sortedStimDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpont/SpontStimCriteria/StimOrdered/';
        sortedSpontDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpont/SpontStimCriteria/SpontOrdered/';
        saveDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpont/SpontStimCriteria/FR-Zscore/';
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
elseif doStim  == 2
    SpontFiles = dir([sortedSpontDir '*.mat']);
    nFiles  = numel(SpontFiles);
    allSpikesOrderd_Spont = cell(230, 12); allSpikesCntsOrderd_Spont = cell(230, 12);
end

nCnt = 1;

allDataFiles = cell(1, 230); allDataChans = cell(1, 230);


a = load(AudFile);
neuronInds = a.AudSorted.allAudInds;
neuronNames = a.AudSorted.allDataChans_Aud;
DatFiles = a.AudSorted.allDataFiles_Aud;

for j = 1:nFiles
    
    if doStim == 1
        dStim = load([sortedStimDir StimFiles(j).name]);
        thisData= dStim.Sorted;
        
    elseif doStim == 2
        dSpont = load([sortedSpontDir SpontFiles(j).name]);
        thisData = dSpont.Sorted;
        
    end
    
    dataFiles = thisData.allrawDataFiles;
    dataChans = thisData.allNeurons;
    
    disp([dataFiles{1} ' = ' num2str(j)]);
    nNeurons = numel(dataChans);
    
    for k = 1:nNeurons
        
        match = ismember(nCnt, neuronInds);
        
        if ~match
            disp('')
        else
            
            
            %% checkthis
            
            allDataFiles{nCnt} = dataFiles{k};
            allDataChans{nCnt} = dataChans(k);
            
            Lengths_s_Ordered_Stim = thisData.allLengths_sOrdered(k,:);
            song_set = find(cellfun(@(x) ~isempty(x), Lengths_s_Ordered_Stim));
            nStims = numel(song_set);
            
            allStimACs = [];
            for o = 1:nStims
                
                thisStim = song_set(o);
                
                if doStim == 1
                    allSpikesCntsOrderd_Stim =  thisData.allSpikesCntsOrdered{k, thisStim};
                    allSpikesOrderd_Stim = thisData.allSpikesOrdered{k, thisStim};
                    
                elseif doStim == 2
                    
                    
                    nreps = numel(thisData.allSpikesOrdered{k, thisStim});
                    %allSpikesOrderd_Spont = cell2mat(reshape(thisData.allSpikesOrdered{k, thisStim}, 1, nreps)');
                    allSpikesOrderd_Spont = cell2mat(reshape(thisData.allGaussSmoothOrdered{k, thisStim}, 1, nreps)');
                    
                    allACs = [];
                    for qq = 1:nreps;
                        [allACs(qq,:), lags] = xcov(allSpikesOrderd_Spont(qq,:), 'coef');
                    end
                    
                    allStimACs{o} = allACs;
                    
                end
                
            end
            
            %%
            combACs = [];
            for o = 1:nStims
                combACs  = [combACs ; allStimACs{o}];
            end
            
            meanAC = nanmean(combACs);
            medianAC = nanmedian(combACs);
            stdAC = nanstd(combACs);
            semAC = stdAC / (sqrt(size(combACs, 1)));
            
            allMeanACs(nCnt,:) = meanAC;
            allMedianACs(nCnt,:) = medianAC;
            allsemACs(nCnt,:) = semAC;
            
            lags_ms = lags/dSpont.INFO.scanrate*1000;
            
            %%
%             figH = figure(100); clf
%             plot(lags_ms, meanAC, 'k', 'linewidth', 2);
%             hold on
%             plot(lags_ms, meanAC+semAC, 'r');
%             hold on
%             plot(lags_ms, meanAC-semAC, 'r');
%             
%             axis tight
%             %xlim([-25 25]); ylim([-.2 1])
%             xlim([-25 25]); ylim([-.002 .01])
%             set(gca, 'xminortick', 'on')
%             grid minor
% 
%             title([allDataFiles{nCnt} '| AC | N-' num2str(allDataChans{nCnt})])
%             %%
%             figure(figH)
%             plot_filename = [plotDir allDataFiles{nCnt} '_AC_N-' num2str(allDataChans{nCnt})];
%             plotpos = [0 0 10 12];
%             print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
            
        end
        
        nCnt = nCnt+1;
        
    end
    
end
disp('')

AC.allMeanACs_Aud = allMeanACs(neuronInds,:);
AC.allMedianACs_Aud = allMedianACs(neuronInds,:);
AC.allSemsACs_Aud = allsemACs(neuronInds,:);

AC.allDataFiles_Aud = allDataFiles(neuronInds);
AC.allDataChans_Aud = allDataChans(neuronInds);

AC.lags_ms = lags_ms;
AC.scanrate = dSpont.INFO.scanrate;

%%
saveName = [saveDir 'AudACsGauss'];
save(saveName, 'AC', '-v7.3')
disp(saveName)

%%





end


