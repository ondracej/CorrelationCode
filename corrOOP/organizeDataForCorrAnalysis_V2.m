function [] = organizeDataForCorrAnalysis_V2()

dbstop if error

doStim = 1;

if doStim ==1
    textstr = 'Stim';
elseif doStim  ==2
    textstr = 'Spont';
end

switch gethostname
    case 'turtle'
        %fileToLoad = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim/SpontStimAllCriteriaMet.mat';
        %         if doStim ==1
        %             saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim/StimOrdered/';
        %         elseif doStim ==2
        %             saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim/SpontOrdered/';
        %         end
        
        
        fileToLoad = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontStimAllCriteriaMet.mat';
        
        if doStim ==1
            saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/StimOrdered/';
        elseif doStim ==2
            saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontOrdered/';
        end
        
        %fileToLoad = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim/SpontStimAllCriteriaNOTMet.mat';
        %         if doStim ==1
        %             saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim/StimOrderedCritNotMet/';
        %         elseif doStim ==2
        %             saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim/SpontOrderedCritNotMet/';
        %         end
        
        
    case 'deadpool'
        
        fileToLoad = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontStimAllCriteriaMet.mat';
        
        if doStim ==1
            saveDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/StimOrdered/';
        elseif doStim ==2
            saveDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontOrdered/';
        end
        
end

if exist(saveDir, 'dir') == 0
    mkdir(saveDir);
end

Sorted = load(fileToLoad);

AllCriteriaMet = Sorted.AllCriteriaMet_Final;
%AllCriteriaMet = Sorted.AllCriteriaNOTMet_Final;
nFiles = size(AllCriteriaMet, 2);

for j = 1: nFiles
    
    
    thisData = AllCriteriaMet(j);
    
    StimOnsets = thisData.allSortedStimOnsets;
    StimOffsets = thisData.allSortedStimOffsets;
    StimLengths = thisData.allSortedStimLengths;
    
    SpontOnsets = thisData.allSortedStimOnsets_spont;
    SpontOffsets = thisData.allSortedStimOffsets_spont;
    SpontLengths = thisData.allSortedStimLengths_spont;
    
    scanrate = thisData.scanrate;
    smoothWin_ms = 1;
    smoothWin_samps = round(scanrate/1000*smoothWin_ms);
    w = gausswin(smoothWin_samps);
    
    songSet = find(cellfun(@(x) ~isempty(x), SpontOnsets));
    
    nNeurons = numel(thisData.spikefile_index);
    
    AllLengths_samp = cell(nNeurons, 12); AllLengths_s = cell(nNeurons, 12);
    allSpikesCnts = cell(nNeurons, 12); allSpikes = cell(nNeurons, 12);
    allGaussSmooth = cell(nNeurons, 12);
    
    allSpikesCntsOrdered = cell(nNeurons, 12); allSpikesOrdered = cell(nNeurons, 12);
    allGaussSmoothOrdered = cell(nNeurons, 12); allLengths_sampOrdered = cell(nNeurons, 12);
    allLengths_sOrdered = cell(nNeurons, 12);
    
    allNeurons = []; allrawDataFiles = []; allAreas = []; allSpkInd = [];
    
    for k = 1:nNeurons
        
        spks = thisData.allSpikes{1,k}{:};
        nStims = numel(songSet);
        
        thisNeuron = thisData.rawDataChan(k);
        thisrawDataFile = thisData.raw_data_filename;
        thisSpkInd = thisData.spikefile_index(k);
        thisArea= thisData.area{k};
        
        %clear('thisData');
        
        for o = 1:nStims
            
            if doStim ==1
                theseOnsets = round(StimOnsets{songSet(o)});
                theseOffsets = round(StimOffsets{songSet(o)});
            elseif doStim ==2
                theseOnsets = round(SpontOnsets{songSet(o)});
                theseOffsets = round(SpontOffsets{songSet(o)});
            end
            
            nUniqueStims = size(theseOnsets,1);
            nUniquereps = size(theseOnsets,2);
            
            allOrderedLengths_samps = theseOffsets - theseOnsets;
            allMaxLengthsUniqueStims = max(allOrderedLengths_samps, [], 2);
            
            %%
            
           
            allNSpksOrdered = []; allSpikesIntOrdered = []; allGausSmoothOrdered = [];
            allL_sampOrdered = []; allLs_sOrdered = [];
            for ss = 1:nUniqueStims
                
                thisMaxLength = allMaxLengthsUniqueStims(ss);
                
                for s = 1:nUniquereps
                
                    these_spks_on_chan = spks(spks >= theseOnsets(ss, s) & spks <= theseOffsets(ss, s))-theseOnsets(ss, s);
                    nSpks = numel(these_spks_on_chan);
                    
                    intFR  = zeros(1,thisMaxLength); % we define a vector for integrated FR
                    
                    % add a 1 to the FR vector for every spike
                    for ind = 1 : nSpks
                        if these_spks_on_chan(ind) ~= 0
                            intFR(these_spks_on_chan(ind)) = intFR(these_spks_on_chan(ind)) +1;
                        end
                    end
                    
                    allNSpksOrdered(ss, s) = nSpks;
                    allSpikesIntOrdered{ss, s} = intFR;
                    allGausSmoothOrdered{ss, s} = filter(w, 1, intFR);
                    
                    allL_sampOrdered(ss, s) = thisMaxLength;
                    allLs_sOrdered(ss, s) = thisMaxLength/scanrate;
                    
                end
            end
            
            allNeurons(k) = thisNeuron{:};
            allrawDataFiles{k} = thisrawDataFile;
            allSpkInd(k) = thisSpkInd{:};
            allAreas{k} = thisArea;
            
            allSpikesCntsOrdered{k, songSet(o)} = allNSpksOrdered;
            allSpikesOrdered{k, songSet(o)} = allSpikesIntOrdered;
            allGaussSmoothOrdered{k, songSet(o)} = allGausSmoothOrdered;
            
            allLengths_sampOrdered{k, songSet(o)} = allL_sampOrdered;
            allLengths_sOrdered{k, songSet(o)} = allLs_sOrdered;
            
            disp('')
            
            
            %%
          %{
            reshapedOnsets = reshape(theseOnsets, 1, numel(theseOnsets));
            reshapedOffsets = reshape(theseOffsets, 1, numel(theseOffsets));
            
            nReps = numel(reshapedOnsets);
            
            length_samp = ceil(max(reshapedOffsets - reshapedOnsets));
            length_s = length_samp/scanrate;
            
            allSpikesInt = []; allNSpks = []; allGausSmooth = [];
            
            for p =1:nReps
                
                these_spks_on_chan = spks(spks >= reshapedOnsets(p) & spks <= reshapedOffsets(p))-reshapedOnsets(p);
                nSpks = numel(these_spks_on_chan);
                
                intFR  = zeros(1,reshapedOffsets(p)-reshapedOnsets(p)); % we define a vector for integrated FR
                
                % add a 1 to the FR vector for every spike
                for ind = 1 : nSpks
                    if these_spks_on_chan(ind) ~= 0
                        intFR(these_spks_on_chan(ind)) = intFR(these_spks_on_chan(ind)) +1;
                    end
                end
                
                allNSpks(p) = nSpks;
                allSpikesInt{p} = intFR;
                allGausSmooth{p} = filter(w, 1, intFR);
                
            end
            
            %integratedMean = sum(allGausSmooth, 1);
            %FRsmoothed = smooth(integratedMean, 300);
            
            allLengths_samp = reshapedOffsets-reshapedOnsets;
            allLengths_s = allLengths_samp/scanrate;
            
            AllLengths_samp{k, songSet(o)} = allLengths_samp;
            AllLengths_s{k, songSet(o)} = allLengths_s;
            
            allSpikesCnts{k, songSet(o)} = allNSpks;
            allSpikes{k, songSet(o)} = allSpikesInt;
            allGaussSmooth{k, songSet(o)} = allGausSmooth;
            
            %% Now reorganize back into the right order
            
            cnt = 1;
            allNSpksOrdered = []; allSpikesIntOrdered = []; allGausSmoothOrdered = [];
            allL_sampOrdered = []; allLs_sOrdered = [];
            for s = 1:nUniquereps
                for ss = 1:nUniqueStims
                    
                    allNSpksOrdered(ss, s) = allNSpks(cnt);
                    allSpikesIntOrdered{ss, s} = allSpikesInt{1, cnt};
                    allGausSmoothOrdered{ss, s} = allGausSmooth{1, cnt};
                    
                    allL_sampOrdered(ss, s) = allLengths_samp(cnt);
                    allLs_sOrdered(ss, s) = allLengths_s(cnt);
                    
                    cnt = cnt +1;
                    
                end
            end
            
            allNeurons(k) = thisNeuron{:};
            allrawDataFiles{k} = thisrawDataFile;
            allAreas{k} = thisArea;
            
            allSpikesCntsOrdered{k, songSet(o)} = allNSpksOrdered;
            allSpikesOrdered{k, songSet(o)} = allSpikesIntOrdered;
            allGaussSmoothOrdered{k, songSet(o)} = allGausSmoothOrdered;
            
            allLengths_sampOrdered{k, songSet(o)} = allL_sampOrdered;
            allLengths_sOrdered{k, songSet(o)} = allLs_sOrdered;
            
            disp('')
          %}  
        end
        
    end
    
    %%
    
    %CritData.thisData = thisData;
    
    INFO.StimOnsets = StimOnsets;
    INFO.StimOffsets = StimOffsets;
    INFO.StimLengths = StimLengths;
    
    INFO.SpontOnsets = SpontOnsets;
    INFO.SpontOffsets = SpontOffsets;
    INFO.SpontLengths = SpontLengths;
    
    INFO.scanrate = scanrate;
    INFO.smoothWin_ms = smoothWin_ms;
    INFO.smoothWin_samps = smoothWin_samps;
    INFO.GausWin = w;
    
    INFO.songSet = songSet;
    INFO.nNeurons = nNeurons;
    
    Sorted.allNeurons = allNeurons;
    Sorted.allrawDataFiles = allrawDataFiles;
    Sorted.allSpkInd = allSpkInd;
    Sorted.allAreas = allAreas;
    
    %Sorted.allSpikesCnts = allSpikesCnts;
    %Sorted.allSpikes = allSpikes;
    %Sorted.allGaussSmooth = allGaussSmooth;
    %Sorted.allLengths_samp = AllLengths_samp;
    %Sorted.allLengths_s = AllLengths_s;
    
    Sorted.allSpikesCntsOrdered = allSpikesCntsOrdered;
    Sorted.allSpikesOrdered = allSpikesOrdered;
    Sorted.allGaussSmoothOrdered = allGaussSmoothOrdered;
    Sorted.allLengths_sampOrdered = allLengths_sampOrdered;
    Sorted.allLengths_sOrdered = allLengths_sOrdered;
    
    textnum = sprintf('%02d', j);
    
    saveDirFinal = [saveDir textstr 'OrderedData-' textnum];
    save(saveDirFinal, 'INFO', 'Sorted', '-v7.3')
    disp(saveDirFinal);
    
    clear('INFO', 'Sorted', 'thisData');
    
end

end

