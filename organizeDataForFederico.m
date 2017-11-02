function [] = organizeDataForFederico()

dbstop if error

metaFileDir = '/storage/laur/Personal/OndracekJanie/INI/Projects/Extracellular/Quadruplet/Analysis/5ms/31-May-2015-Stims-Coef/PairwiseOutput/Meta/';
newSaveDir = [metaFileDir 'forFederico2/'];
dataPath = '/storage/laur/Personal/OndracekJanie/INI/Projects/Extracellular/Quadruplet/';


stimSet = [7 8];

if exist(newSaveDir, 'dir') == 0
    mkdir(newSaveDir);
    disp('Created new meta directory.')
end

metaFiles = dir([metaFileDir '*.mat']);

nMetaFiles = numel(metaFiles);

neuronCnt = 0;

for k = 1:nMetaFiles
    
    d = load([metaFileDir metaFiles(k).name]);
    
    %%  Basic Info
    birdName = d.meta.bird_name;
    rawDataFilename = d.meta.raw_data_filename;
    
    chanNumbers = d.meta.channel_numbers;
    num_neruons = d.meta.num_channels;
    wavChan = d.meta.wav_chan;
    
    if isempty(wavChan)
        wavChan = d.meta.mic_chan;
    end
    
    thisRecordingSessionPath = [dataPath birdName '/Data/' rawDataFilename];
    
    %% Load the data filed to extract the voltage stims  - we only need to do this 1x per meta file
    data_file_format = d.meta.data_file_format;
    
    if data_file_format ~= 8 % file format 8 needs to be loaded with the chronic file loader
        [data data_scanrate]= load_labview_acute(thisRecordingSessionPath, 0);
        disp(['Loading raw data file..' rawDataFilename ]);
    else
        [data data_scanrate] = load_labview_chronic(thisRecordingSessionPath, 0);
        disp(['Loading raw data file..' rawDataFilename ]);
    end
    
    %% Go through neurons in meta file
    for j = 1:num_neruons
        
        thisChan = chanNumbers(j);
        
        song_set_thisChanel = find(cellfun(@(x) ~isempty(x), d.meta.individual_neuron_stats(thisChan,:)));
        
        %% Check to see that all stims are present
        if sum(ismember(stimSet, song_set_thisChanel)) == numel(stimSet) % all of the stims are present for this channel
            
            allNeuronInfo = d.meta.individual_neuron_stats(thisChan, stimSet);
            zscores = [];
            for p = 1:numel(allNeuronInfo )
                zscores(p) = allNeuronInfo{1,p}.zscore;
            end
            
            meanZscore = mean(abs(zscores));
            
            if meanZscore < 2
                disp(['Mean z score not high enough: ' rawDataFilename 'ch-' num2str(thisChan)])
            else
                neuronCnt = neuronCnt+1;
                
                %% If so, go through the stims
                for k = 1:numel(stimSet)
                    
                    thisStim = stimSet(k);
                    
                    spikeTimes = d.meta.individual_neuron_stats{thisChan, thisStim}.allSpkTimes_Stim;
                    
                    STIM.stimID = d.meta.song_type{1, thisStim};
                    STIM.uniqueStims = size(spikeTimes, 1);
                    STIM.stimsReps = size(spikeTimes, 2);
                    
                    INFO.rawDataFilename = rawDataFilename;
                    INFO.data_scanrate = data_scanrate;
                    INFO.neuronChan = thisChan;
                    INFO.crosstalk_from_channel = d.meta.database{thisChan, thisStim}.crosstalk_from_channel;
                    INFO.is_duplicate = d.meta.database{thisChan, thisStim}.is_duplicate;
                    INFO.duplicate_ind = d.meta.database{thisChan, thisStim}.same_as_ind;
                    INFO.rawDataChan = d.meta.database{thisChan, thisStim}.rawDataChan;
                    INFO.notes = d.meta.database{thisChan, thisStim}.notes;
                    stimStarts = d.meta.stim_starts{1, thisStim};
                    stimStops = d.meta.stim_stops{1, thisStim};
                    
                    cnt = 1;
                    stimSignal = cell(STIM.uniqueStims, STIM.stimsReps);
                    spikeSignal = cell(STIM.uniqueStims, STIM.stimsReps);
                    
                    for a = 1:STIM.stimsReps
                        for b = 1:STIM.uniqueStims
                            
                            
                            thisStimStart = stimStarts(cnt);
                            thisStimStop = stimStops(cnt);
                            
                            wavData = data(wavChan,:);
                            chanData = data(INFO.rawDataChan,:);
                            thisStimSnippet = wavData(thisStimStart:thisStimStop);
                            thisDataSnippet = chanData(thisStimStart:thisStimStop);
                            
                            %{
                 figure(100)
                 subplot(2, 1, 2)
                 plot(thisStimSnippet)
                 subplot(2, 1, 2)
                 specgram1(double(thisStimSnippet)/2000,512,data_scanrate,400,360);
                            %}
                            
                            stimSignal{b, a} = thisStimSnippet;
                            spikeSignal{b, a} = thisDataSnippet;
                            cnt = cnt +1;
                        end
                    end
                    
                    %% Save stim related info for this neuron
                    
                    DATA{neuronCnt, k}.INFO = INFO;
                    DATA{neuronCnt, k}.STIM = STIM;
                    DATA{neuronCnt, k}.spikeTimes = spikeTimes;
                    DATA{neuronCnt, k}.dataSignal = spikeSignal;
                    DATA{neuronCnt, k}.stimSignal = stimSignal;
                    
                end
            end
            
            disp('')
        end
        
    end
    
    disp('')
    
    tic
    saveName = [newSaveDir rawDataFilename '-Data'];
    save(saveName, 'DATA', '-v7.3')
    toc
    
end


end
