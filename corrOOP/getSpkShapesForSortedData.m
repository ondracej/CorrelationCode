function [] = getSpkShapesForSortedData()


dbstop if error

switch gethostname
    case 'turtle'
        
        fileToLoad = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontStimAllCriteriaMet.mat';
        saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpkShape/';
        
    case 'deadpool'
        
        fileToLoad = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontStimAllCriteriaMet.mat';
        saveDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpkShape/';
        
end

if exist(saveDir, 'dir') == 0
    mkdir(saveDir);
end

Sorted = load(fileToLoad);

AllCriteriaMet = Sorted.AllCriteriaMet_Final;
nFiles = size(AllCriteriaMet, 2);

directoryDelimiter = '/';
mainDataDir = '/home/janie/Data/INI/Quadruplet/';

spikeWin_ms = 2;
spikeWin_s = spikeWin_ms/1000;

for j = 1: nFiles
    
    
    thisData = AllCriteriaMet(j);
    
    thisBirdPath = [mainDataDir thisData.bird_name directoryDelimiter];
    thisRawDataPath = [thisBirdPath 'Data' directoryDelimiter];
    thisRecordingSessionPath = [thisRawDataPath thisData.raw_data_filename];
    
    allSpikes = thisData.allSpikes;
    rawChans = thisData.rawDataChan;
    nChans = numel(rawChans);
    
    
    data_file_format = thisData.data_file_format{1};
    
    if data_file_format ~= 8 % file format 8 needs to be loaded with the chronic file loader
        [data data_scanrate]= load_labview_acute(thisRecordingSessionPath, 0);
        disp('Loading raw data file..');
    else
        [data data_scanrate] = load_labview_chronic(thisRecordingSessionPath, 0);
        disp('Loading raw data file..');
    end
    
    winSamp = round(spikeWin_s*data_scanrate);
    
    timepoints_samp = -winSamp:1:winSamp;
    timepoints_ms = timepoints_samp/data_scanrate*1000;
    
    meanSpks = []; medianSpks = []; stdSpks = []; allShapes = [];
    for k = 1:nChans
        
        thisChan = rawChans{k};
        thisChanSpks = allSpikes{k}{:};
        
        thisDataChan = data(thisChan,:);
        chanSpks = [];
        for o = 2:numel(thisChanSpks)-1
            chanSpks(o,:) = thisDataChan(thisChanSpks(o)-winSamp:thisChanSpks(o)+winSamp);
        end
        
        
        meanSpks(k,:) = mean(chanSpks);
        medianSpks(k,:) = median(chanSpks);
        stdSpks(k,:) = nanstd(chanSpks);
        
        allShapes{k} = chanSpks;
    end
    
    %figure; plot(timepoints_ms, meanSpks(1,:))
    %%
    
    SPKINFO.allShapes = allShapes;
    SPKINFO.allSpikes = allSpikes;
    SPKINFO.meanSpks = meanSpks;
    SPKINFO.medianSpks = medianSpks;
    SPKINFO.stdSpks = stdSpks;
    SPKINFO.spikeWin_ms = spikeWin_ms;
    
    SPKINFO.rawChans = rawChans;
    SPKINFO.rawDataFile = thisData.raw_data_filename;
    SPKINFO.allAreas = thisData.area;
    SPKINFO.scanrate = data_scanrate;
    
    %%
    textnum = sprintf('%02d', j);
    
    saveDirFinal = [saveDir 'SpkShape-' textnum];
    save(saveDirFinal, 'SPKINFO', '-v7.3')
    disp(saveDirFinal);
    
    clear('INFO', 'Sorted', 'thisData');
    
end


end
