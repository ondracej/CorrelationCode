function [] = loadAndBinSpikeTimesForCorrAnalysis()


dbstop if error

CritMet = 1; % 1, criteria met, 2 = criteria not met

dbstop if error
switch gethostname
    
    case 'turtle'
        
        if CritMet == 1
            fileToLoad = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpont-1.5s/SpontAllCriteriaMet.mat';
            Save_Dir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpont-1.5s/SpontCriteriaAnalysis_Sorted/';
            
        elseif CritMet == 2
            
        end
        
        
    case 'deadpool'
        
        if CritMet == 1
            fileToLoad = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpont/SpontAllCriteriaMet.mat';
            Save_Dir  = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpont/SpontCriteriaAnalysis_AC/';
            
        elseif CritMet == 2
            fileToLoad = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpont/SpontAllCriteriaNOTMet.mat';
            Save_Dir  = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpont/SpontCriteriaAnalysis_AC-CritNotMet/';
        end
end


if exist(Save_Dir , 'dir') == 0
    mkdir(Save_Dir );
end

d = load(fileToLoad);

if CritMet == 1
    AllCriteriaMet = d.AllCriteriaMet_Final;
    nFiles = size(AllCriteriaMet, 2);
elseif CritMet == 2
    AllCriteriaNotMet = d.AllCriteriaNOTMet_Final;
    nFiles = size(AllCriteriaNotMet, 2);
end

for j = 1: nFiles
    
    
    thisData = AllCriteriaMet(j);
    %thisData = AllCriteriaNotMet(j);
    
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
    
    nNeurons = numel(thisData.SigTest);
    
    for k = 1:nNeurons
        
        spks = thisData.allSpikes{1,k}{:};
        nStims = numel(songSet);
        
        
        for o = 1:nStims
            
            
            theseOnsets = round(SpontOnsets{songSet(o)});
            theseOffsets = round(SpontOffsets{songSet(o)});
            
            
            nUniqueStims = size(theseOnsets, 1);
            nUniqueReps = size(theseOnsets, 2);
            
            reshapedOnsets = reshape(theseOnsets, 1, numel(theseOnsets));
            reshapedOffsets = reshape(theseOffsets, 1, numel(theseOffsets));
            
            nReps = numel(reshapedOnsets);
            
            length_samp = ceil(max(reshapedOffsets - reshapedOnsets));
            length_s = length_samp/scanrate;
            
            allSpikesInt = []; allNSpks = []; allGausSmooth = []; ACovs = [];
            
            for p =1:nReps
                
                these_spks_on_chan = spks(spks >= reshapedOnsets(p) & spks <= reshapedOffsets(p))-reshapedOnsets(p);
                nSpks = numel(these_spks_on_chan);
                intFR  = zeros(1,length_samp); % we define a vector for integrated FR
                
                % add a 1 to the FR vector for every spike
                for ind = 1 : nSpks
                    if these_spks_on_chan(ind) ~= 0
                        intFR(these_spks_on_chan(ind)) = intFR(these_spks_on_chan(ind)) +1;
                    end
                end
                
                allNSpks(p) = nSpks;
                allSpikesInt(p,:) = intFR;
                allGausSmooth(p,:) = filter(w, 1, intFR);
                %[acov, lags] = xcov(allGausSmooth(p,:), 'coeff');
                
                %ACovs(p,:) = acov;
                
            end
            
            allSpikesCnts{k, songSet(o)} = allNSpks;
            allSpikes{k, songSet(o)} = allSpikesInt;
            allGaussSmooth{k, songSet(o)} = allGausSmooth;
            %allACovs{k, songSet(o)} = ACovs;
            
            
            
            %% Now rearracnge all the data according to repeptitions
            
            cnt = 1;
            
            allNSpks_reshaped = []; allSpikesInt_reshaped = []; allGausSmooth_reshaped = [];
            
            for s = 1:nUniqueReps
                
                for ss = 1:nUniqueStims
                    
                    allNSpks_reshaped(ss, s) = allNSpks(cnt);
                    allSpikesInt_reshaped{ss, s} = allSpikesInt(cnt,:);
                    allGausSmooth_reshaped{ss, s} = allGausSmooth(cnt,:);
                    
                    cnt = cnt +1;
                    
                    disp('')
                end
            end
            
            AllSpkCntsOrdered{k, songSet(o)} = allNSpks_reshaped;
            allSpikesOrdered{k, songSet(o)} = allSpikesInt_reshaped;
            allGaussSmoothOrdered{k, songSet(o)} = allGausSmooth_reshaped;
            
            
        end
    end
    
    CritData.thisData = thisData;
    
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
    
    Sorted.AllSpkCntsOrdered = AllSpkCntsOrdered;
    Sorted.allSpikesOrdered = allSpikesOrdered;
    Sorted.allGaussSmoothOrdered = allGaussSmoothOrdered;
    
    FinalsaveDir = [Save_Dir 'SortedFile-' num2str(j)];
    save(FinalsaveDir, 'CritData', 'INFO', 'Sorted', '-v7.3')
    
    clear('CritData', 'INFO', 'Sorted', 'thisData');
    
end
end


