function [] = calc_FRs_zscores_forSortedData()

dbstop if error


switch gethostname
    case 'turtle'
        
        sortedStimDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/StimOrdered/';
        sortedSpontDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontOrdered/';
        saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/Fr-Zscore/';
        
        
        %         sortedStimDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim/StimOrdered/';
        %         sortedSpontDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim/SpontOrdered/';
        %         saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim/Fr-Zscore/';
        
        %         sortedStimDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim/StimOrderedCritNotMet/';
        %         sortedSpontDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim/SpontOrderedCritNotMet/';
        %         saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim/Fr-Zscore_CritNotMet/';
        %
        
    case 'deadpool'
        
        sortedStimDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/StimOrdered/';
        sortedSpontDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontOrdered/';
        saveDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/FR-Zscore/';
end


if exist(saveDir, 'dir') == 0
    mkdir(saveDir);
end


StimFiles = dir([sortedStimDir '*.mat']);
SpontFiles = dir([sortedSpontDir '*.mat']);

nStimFiles = numel(StimFiles);
nSpontFiles = numel(SpontFiles);

if nStimFiles ~= nSpontFiles
    keyboard
else
    nFiles = nStimFiles;
end


dash = '-';
dot = '.';

nCnt = 1;

for j = 1:nFiles
    
    %% Check to make sure the files match
    dashInd = find(StimFiles(j).name == dash);
    dotInd = find(StimFiles(j).name == dot);
    
    stimFiletxt = StimFiles(j).name(dashInd+1:dotInd-1);
    
    dashInd = find(SpontFiles(j).name == dash);
    dotInd = find(SpontFiles(j).name == dot);
    
    spontFiletxt = SpontFiles(j).name(dashInd+1:dotInd-1);
    
    txtMatch = strcmpi(stimFiletxt, spontFiletxt);
    
    if txtMatch ~= 1
        keyboard
    end
    
    tic
    dStim = load([sortedStimDir StimFiles(j).name]);
    dSpont = load([sortedSpontDir SpontFiles(j).name]);
    toc
    
    StimData = dStim.Sorted;
    SpontData = dSpont.Sorted;
    
    dataFiles = StimData.allrawDataFiles;
    dataChans = StimData.allNeurons;
    dataChansSpkInds = StimData.allSpkInd;
    
    disp(dataFiles{1});
    
    nNeurons = numel(dataChans);
    
    for k = 1:nNeurons
        
        allDataFiles{nCnt} = dataFiles{k};
        allDataChans{nCnt} = dataChans(k);
        allDataChansSpkInds{nCnt} = dataChansSpkInds(k);
        
        thisRecAllLengths_s_Stim = StimData.allLengths_sOrdered(k,:);
        thisRecAllLengths_s_Spont = SpontData.allLengths_sOrdered(k,:);
        
        thisNeuronAllSpkCnts_Stim = StimData.allSpikesCntsOrdered(k,:);
        thisNeuronAllSpkCnts_Spont = SpontData.allSpikesCntsOrdered(k,:);
        
        song_set = find(cellfun(@(x) ~isempty(x), thisNeuronAllSpkCnts_Stim));
        nStims = numel(song_set);
        
        for o = 1:nStims
            
            thisStim = song_set(o);
            
            spkCnts_Stim = thisNeuronAllSpkCnts_Stim{thisStim};
            length_s_Stim = thisRecAllLengths_s_Stim{thisStim};
            
            spkCnts_Spont = thisNeuronAllSpkCnts_Spont{thisStim};
            length_s_Spont = thisRecAllLengths_s_Spont{thisStim};
            
            %% FR
            FR_Stim = spkCnts_Stim./length_s_Stim;
            FR_Spont = spkCnts_Spont./length_s_Spont;
            
            %zeroSpkCntReps = numel(find(spkCnts_Stim ==0));
            %             if zeroSpkCntReps  > 0.5*numel(spkCnts_Stim);
            %               %  keyboard
            %             end
            
            %% Z score
            
            meanStim = nanmean(reshape(FR_Stim, 1, numel(FR_Stim)));
            meanSpont = nanmean(reshape(FR_Spont, 1, numel(FR_Spont)));
            
            medianStim = nanmedian(reshape(FR_Stim, 1, numel(FR_Stim)));
            medianSpont = nanmedian(reshape(FR_Spont, 1, numel(FR_Spont)));
            
            stdStim = nanstd(reshape(FR_Stim, 1, numel(FR_Stim)));
            stdSpont = nanstd(reshape(FR_Spont, 1, numel(FR_Spont)));
            
            semStim = stdStim / (sqrt(numel(FR_Stim)));
            semSpont = stdSpont / (sqrt(numel(FR_Spont)));
            
            covar = cov(reshape(FR_Stim, 1, numel(FR_Stim)), reshape(FR_Spont, 1, numel(FR_Spont)));
            z_score_cov = (meanStim - meanSpont) / sqrt((stdStim^2 + stdSpont^2) - 2*covar(1, 2));
            
            
            allFR_Stim{nCnt, thisStim} = FR_Stim;
            allFR_Spont{nCnt, thisStim} = FR_Spont;
            allmean_Stim{nCnt, thisStim} = meanStim;
            allmean_Spont{nCnt, thisStim} = meanSpont;
            allmedian_Stim{nCnt, thisStim} = medianStim;
            allmedian_Spont{nCnt, thisStim} = medianSpont;
            allsem_Stim{nCnt, thisStim} = semStim;
            allsem_Spont{nCnt, thisStim} = semSpont;
            
            allZScore{nCnt, thisStim}= z_score_cov;
            
        end
        
        nCnt = nCnt+1;
        
    end
    
    clear('dStim','dSpont');
    
end

nStats.allDataFiles = allDataFiles;
nStats.allDataChans = allDataChans;
nStats.allDataChansSpkInds = allDataChansSpkInds;

nStats.allFR_Stim = allFR_Stim;
nStats.allFR_Spont = allFR_Spont;
nStats.allmean_Stim = allmean_Stim;
nStats.allmean_Spont = allmean_Spont;
nStats.allmedian_Stim = allmedian_Stim;
nStats.allmedian_Spont = allmedian_Spont;
nStats.allsem_Stim = allsem_Stim;
nStats.allsem_Spont = allsem_Spont;
nStats.allZScore = allZScore;

disp('')

saveName = [saveDir 'FR-Zscore'];
save(saveName, 'nStats', '-v7.3')

end

