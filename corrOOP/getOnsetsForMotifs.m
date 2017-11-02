function [] = getOnsetsForMotifs
dbstop if error


switch gethostname
    case 'turtle'
        
        sortedStimDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/StimOrdered/';
        %sortedSpontDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontOrdered/';
        saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/Fr-Zscore/';
        
        
    case 'deadpool'
        
        sortedStimDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/StimOrdered/';
        %sortedSpontDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontOrdered/';
        saveDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/FR-Zscore/';
        
        %AudFile = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/FR-Zscore/FR-Zscore_OnlyAud.mat');
        RSC = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-100ms.mat');
        
end


if exist(saveDir, 'dir') == 0
    mkdir(saveDir);
end

StimFiles = dir([sortedStimDir '*.mat']);

nStimFiles = numel(StimFiles);
nFiles = nStimFiles;

dash = '-';
dot = '.';

nCnt = 1;


allFilesToUse = RSC.RSC.allDatNames;
allSpkInds = RSC.RSC.allDataSpkInds_Aud;

dStim = load([sortedStimDir StimFiles(1).name]);
allDataSorted = dStim.Sorted.AllCriteriaMet_Final;

directoryDelimiter = '/';
mainDataDir = '/home/janie/Data/INI/Quadruplet/';


for j = 1:nFiles-1
    
    thisFILE = allFilesToUse{j}
    theseSpkINDS = allSpkInds{j};
    nchans = numel(theseSpkINDS);
    
    if isempty(thisFILE );
        
        
        
        continue
        
    else
        
        %% Getting the MOtif File
        thisDataSorted = allDataSorted(j);
        
        birdName = thisDataSorted.bird_name;
        
        thisBirdPath = [mainDataDir birdName directoryDelimiter];
        StartstopPath = [thisBirdPath 'Startstop' directoryDelimiter];
        
        matFilesFiles = dir([StartstopPath '*.mat']);
        
        dataFile = thisDataSorted.raw_data_filename;
        
        if strcmpi(dataFile(end-3:end), '.lvd') == 1
            startstopFile = [dataFile(1:end-4)  '-NEW_MOTIF.mat'];    
        else
            startstopFile = [dataFile  '-NEW_MOTIF.mat'];
        end
        
        allNames = []; matches = [];
        for oo = 1:numel(matFilesFiles);
            allNames{oo} = matFilesFiles(oo).name;
            matches(oo) = strcmpi(startstopFile, matFilesFiles(oo).name);
        end
        
        if sum(matches) ==1
            % we have a match
            
            finalMotifOnsetPath = [StartstopPath startstopFile];
            MotifStartStops = load(finalMotifOnsetPath );
            
            scanrate = thisDataSorted.scanrate;
            
            smoothWin_ms = 1;
            smoothWin_samps = round(scanrate/1000*smoothWin_ms);
            w = gausswin(smoothWin_samps);
            
            songSet = [6 8 9]; %leaving out CON for now
            nStims = numel(songSet);
            
            %% Now we get the spikes
            StimOnsets = []; StimOffsets = [];
            AllLengths_samp = [];
            AllLengths_s = [];
            
            allSpikesCnts = [];
            allSpikes = [];
            allGaussSmooth = [];
            
            allNeurons = [];
            allrawDataFiles = [];
            allAreas = [];
            
            allSpikesCntsOrdered = [];
            allSpikesOrdered = [];
            allGaussSmoothOrdered = [];
            
            allLengths_sampOrdered = [];
            allLengths_sOrdered = [];
            
            for o = 1:nStims
                
                switch o
                    
                    case 1
                        
                        theseOnsets = MotifStartStops.rstart;
                        theseOffsets = MotifStartStops.rstop;
                    case 2
                        theseOnsets = MotifStartStops.bstart;
                        theseOffsets = MotifStartStops.bstop;
                        
                    case 3
                        
                        test = isfield(MotifStartStops, 'blstart');
                        
                        if test == 1
                            theseOnsets = MotifStartStops.blstart;
                            theseOffsets = MotifStartStops.blstop;
                        else
                            continue
                        end
                        
                end
                
                StimOnsets{songSet(o)} = theseOnsets;
                StimOffsets{songSet(o)} = theseOffsets;
                
                nUniqueStims = size(theseOnsets,1);
                nUniquereps = size(theseOnsets,2);
                
                reshapedOnsets = reshape(theseOnsets, 1, numel(theseOnsets));
                reshapedOffsets = reshape(theseOffsets, 1, numel(theseOffsets));
                
                nReps = numel(reshapedOnsets);
                
                length_samp = ceil(max(reshapedOffsets - reshapedOnsets));
                length_s = length_samp/scanrate;
                
                
             
                
                for k = 1:nchans
                    thischanInd = theseSpkINDS(k);
                    theseSpikeFiles = cell2mat(thisDataSorted.spikefile_index);
                    
                    FileSpkInd = find(theseSpikeFiles == thischanInd);
                    spks = thisDataSorted.allSpikes{1, FileSpkInd}{:};
                       
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
                    
                    
                    allLengths_samp = reshapedOffsets-reshapedOnsets;
                    allLengths_s = allLengths_samp/scanrate;
                    
                    AllLengths_samp{k, songSet(o)} = allLengths_samp;
                    AllLengths_s{k, songSet(o)} = allLengths_s;
                    
                    allSpikesCnts{k, songSet(o)} = allNSpks;
                    allSpikes{k, songSet(o)} = allSpikesInt;
                    allGaussSmooth{k, songSet(o)} = allGausSmooth;
                    
                    %%
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
                    
                    allNeurons(k) = thischanInd;
                    allrawDataFiles{k} = dataFile;
                    allAreas{k} = thisDataSorted.area(FileSpkInd);
                    
                    allSpikesCntsOrdered{k, songSet(o)} = allNSpksOrdered;
                    allSpikesOrdered{k, songSet(o)} = allSpikesIntOrdered;
                    allGaussSmoothOrdered{k, songSet(o)} = allGausSmoothOrdered;
                    
                    allLengths_sampOrdered{k, songSet(o)} = allL_sampOrdered;
                    allLengths_sOrdered{k, songSet(o)} = allLs_sOrdered;
                    
                    disp('')
                    
                end
            end
            
            INFO.StimOnsets{j} = StimOnsets;
            INFO.StimOffsets{j} = StimOffsets;
            
            INFO.scanrate{j} = scanrate;
            INFO.smoothWin_ms{j} = smoothWin_ms;
            INFO.smoothWin_samps{j} = smoothWin_samps;
            INFO.GausWin{j} = w;
            
            INFO.songSet{j} = songSet;
            INFO.nNeurons{j} = nchans;
            
            Sorted.allNeurons_M{j} = allNeurons;
            Sorted.allrawDataFiles_M{j} = allrawDataFiles;
            Sorted.allAreas_M{j} = allrawDataFiles;
            
            Sorted.allSpikesCntsOrdered_M{j} = allSpikesCntsOrdered;
            Sorted.allSpikesOrdered_M{j} = allSpikesOrdered;
            Sorted.allGaussSmoothOrdered_M{j} = allGaussSmoothOrdered;
            Sorted.allLengths_sampOrdered_M{j} = allLengths_sampOrdered;
            Sorted.allLengths_sOrdered_M{j} = allLengths_sOrdered;
            
        else
            % we have a problem
            disp(['Could not find a statstop filed for' thisFILE]) 
        end
        
    end
    
end

saveDirFinal = [saveDir 'OrderedSpkData-Motifs'];
save(saveDirFinal, 'INFO', 'Sorted', '-v7.3')
disp(saveDirFinal);

disp('')
end

