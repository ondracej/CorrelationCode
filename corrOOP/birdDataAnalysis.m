classdef birdDataAnalysis < handle
    
    
    properties (Access = public)
        
        dataDir
        
        birdID
        rsc
        birdName
        birdAge
        
        recordingName
        dataFormat
        spikeFile
        scanrate
        
        wavChan
        micChan
        neuronChan
        
        soundFileVersion
        BOUT_startstop
        MOTIF_startstop
        SPONT_startstop
        MOTIF_SYL_startstop
        
        paths
        
        TRIGS
        SPKS
    end
    
    
    methods
        
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% ~~~~~Functions called by constructor
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Get session Info
        function obj=getSessionInfo(obj,rsc)
            
            disp('Getting session info...')
            switch gethostname
                case 'deadpool'
                    dataDir = '/home/janie/Data/INI/Quadruplet/';
                    directoryDelimiter = '/';
                case 'turtle'
                    dataDir = '/home/janie/Data/INI/Data/Quadruplet/';
                    directoryDelimiter = '/';
            end
            
            obj.dataDir = dataDir;
            
            [raw_data_file_db] = correlationDataInfo();
            
            obj.birdID = raw_data_file_db(rsc).birdID;
            obj.rsc = rsc;
            obj.birdName = raw_data_file_db(rsc).bird_name;
            obj.birdAge = raw_data_file_db(rsc).bird_age;
            
            
            obj.recordingName = raw_data_file_db(rsc).raw_file;
            obj.dataFormat = raw_data_file_db(rsc).data_file_format;
            obj.scanrate = raw_data_file_db(rsc).scanrate;
            obj.spikeFile = raw_data_file_db(rsc).spike_file;
            
            obj.wavChan = raw_data_file_db(rsc).wav;
            obj.micChan = raw_data_file_db(rsc).mic;
            obj.neuronChan = raw_data_file_db(rsc).neuron_chans;
            
            obj.paths.birdPath = [obj.dataDir obj.birdName directoryDelimiter];
            obj.paths.dataPath = [obj.paths.birdPath 'Data' directoryDelimiter];
            obj.paths.spikePath = [obj.paths.birdPath 'Spikes' directoryDelimiter];
            obj.paths.spikeFormPath = [obj.paths.birdPath 'Spikeforms' directoryDelimiter];
            obj.paths.stimTrigs = [obj.paths.birdPath 'Startstop' directoryDelimiter];
            % obj.paths.figPath = [obj.paths.birdPath 'Figures' directoryDelimiter];
            
            %% If save to dropbox
            dropboxDir = '/home/janie/Dropbox/INI/DataPlots/forPaper/';
            obj.paths.figPath = [dropboxDir obj.birdName directoryDelimiter 'Figures' directoryDelimiter];
            
        end
        
        %% Get Triggers
        function obj=getTriggerInfo(obj)
            disp('Getting Triggers...')
            [raw_data_file_db] = correlationDataInfo();
            
            obj.soundFileVersion = raw_data_file_db(obj.rsc).soundfile_vers;
            
            %% All Stims
            stimFile = raw_data_file_db(obj.rsc).BOUT_startstop;
            allStimTrigs = load([obj.paths.stimTrigs stimFile]);
            
            motifFile = raw_data_file_db(obj.rsc).NEW_MOTIF_startstop; % We use the new file, which should have cons on it
            
            if isempty(motifFile )
                disp('No "new motif" file found, loading old motif file...')
                disp(['~~*** Recording Session: ' obj.recordingName '***~~'])
                
                motifFile = raw_data_file_db(obj.rsc).MOTIF_startstop;
                
            end
            
            %% MotifSyllable
%             if isfield(raw_data_file_db(obj.rsc), 'MOTIF_SYL_startstop')
%                 motifSylFile = raw_data_file_db(obj.rsc).MOTIF_SYL_startstop; % We use the new file, which should have cons on it
%                 allMotifSylTrigs = load([obj.paths.stimTrigs motifSylFile]);
%             end
%             
            
            allMotifTrigs = load([obj.paths.stimTrigs motifFile]);
            
            spontFile = raw_data_file_db(obj.rsc).SPONT_startstop;
            allSpontTrigs = load([obj.paths.stimTrigs spontFile]);
            
            %% Remapping the starstop filedname to the correct stim, this has to be done because I used diff versions of the makesound file
            % from create_stimuli_list.m, remap_stimuli_names.m, clean_out_stops.m, included_stimuli.m,
            
            allStimTrigNames = fieldnames(allStimTrigs);
            nAllStimTrigs = size(allStimTrigNames, 1);
            
            %% included_stimuli.m find out which stimuli are actually included (some will be defined but empty)
            stims_included = nan(1, nAllStimTrigs);
            for i = 1 : nAllStimTrigs
                
                this_field = ['allStimTrigs.' allStimTrigNames(i)];
                this_field = [this_field{:}];
                if ~isempty(eval(this_field))
                    stims_included(i) = i;
                end
            end
            
            nonNanStimInds= stims_included(~isnan(stims_included));
            stimsTrigNames = allStimTrigNames(nonNanStimInds);
            
            %% clean_out_stops.m
            nStimTrigs = numel(stimsTrigNames);
            
            n = 1;
            % we want to get rid of the stop entries, so we just devide the entire list by half.
            cleaned_stims = cell(1, nStimTrigs/2);
            cleaned_stims_ids = zeros(1, nStimTrigs/2);
            for i = 1 : nStimTrigs
                if isempty(findstr(stimsTrigNames{i}, 'start')) == 0
                    cleaned_stims{n} = stimsTrigNames{i};
                    cleaned_stims_ids(n) = i;
                    n = n + 1;
                end
            end
            %% Hardcoded stim list
            defaultStimList = {
                'nstart',   'White Noise (SOF)',            'nstop';...
                'pstart',   'Pips',                         'pstop';...
                'tstart',   'Tones',                        'tstop';...
                'ststart',  'Stacks',                       'ststop';...
                'sstart',   'Subsong',                      'sstop';...
                'rstart',   'Rev BOS',                      'rstop';...
                'cstart',   'Conspecific',                  'cstop';...
                'bstart',   'BOS',                          'bstop';...
                'blstart',  'BOS quiet',                    'blstop';...
                'calstart', 'Call',                         'calstop';...
                'disstart', 'BOS + Call',                   'disstop';
                'n2start',  'White Noise (EOF)',            'n2stop';...
                };
            
            %% %% rempastimuli names
            nStimsTotal = numel(cleaned_stims);
            stim_names = cell(1, nStimsTotal);
            stim_ids = nan(1, nStimsTotal);
            
            B = defaultStimList(:, 1);
            
            for i = 1 : nStimsTotal
                this_string = cleaned_stims{i};
                this_match = cellfun(@(x) strmatch(this_string,x), B, 'UniformOutput', false);
                A = cellfun('isempty', this_match);
                stim_ids(i) = find(A == 0);
                stim_names{i} = defaultStimList{stim_ids(i), 2};
                
            end
            
            %% From mapStimsToCorrectInds
            
            if size(stim_names,2) < 5
                stim_selected_by_user = stim_ids;
                stim_names_selected = stim_names;
            else
                
                switch obj.soundFileVersion
                    case {1, 7}
                        stim_selected_by_user = [1 3 4 6 7 8 9 12];
                        stim_names_selected  = {stim_names{[1 2 3 4 5 6 7 8]}};
                        %stim_selected_by_user = stim_ids;
                        %stim_names_selected  = stim_names;
                        
                    case 2
                        
                        stim_selected_by_user = [1 4 6 7 8 9 12];
                        stim_names_selected  = {stim_names{[1 2 3 4 5 6 7]}};
                        
                    case 3
                        
                        stim_selected_by_user = [1 6 7 8 12];
                        stim_names_selected  = {stim_names{[1 2 3 4 5]}};
                        %stim_selected_by_user = stim_ids;
                        %stim_names_selected = stim_names;
                        
                    case 4
                        
                        stim_selected_by_user = [1 4 6 7 8 9 12];
                        stim_names_selected  = {stim_names{[1 2 3 4 5 6 7]}};
                        
                    case 5
                        
                        stim_selected_by_user = [1 4 6 8 9 12];
                        stim_names_selected  = {stim_names{[1 2 3 4 5 6]}};
                        
                    case 6
                        stim_selected_by_user = [1 4 6 7 8 9 12];
                        stim_names_selected  = {stim_names{[1 2 3 4 5 6 7]}};
                        
                end
            end
            
            %% Get info about the stim reps
            
            obj.TRIGS.INFO.allStims = stim_selected_by_user;
            obj.TRIGS.INFO.nStims = numel(stim_selected_by_user);
            obj.TRIGS.INFO.allStimsNames = stim_names_selected;
            
            for j = stim_selected_by_user
                [stimRepInfo{j}] = uniqueReps_Stims(j, obj.soundFileVersion);
            end
            
            %%
            stimTRIGS = [];
            motifConTRIGS = [];
            for q = 1:numel(stimRepInfo)
                
                thisStimRepInfo = stimRepInfo{q};
                
                if ~isempty(thisStimRepInfo)
                    
                    %% For Stims
                    [stim_start, stim_stop, song_type] = cc_choose_stim(q, allStimTrigs);
                    
                    if isempty(stim_start)
                        continue
                    end
                    
                    unique_stims = thisStimRepInfo.unique_stims;
                    reps_stims = thisStimRepInfo.stim_reps;
                    
                    allStartTrigs = []; allStopTrigs = []; allLengths = [];
                    for p = 1 : unique_stims
                        i = p;
                        
                        start_stim = []; stop_stim = []; length_this_stim = [];
                        for s = 1 : reps_stims
                            start_stim(s) =  stim_start(i);
                            stop_stim(s) =  stim_stop(i);
                            length_this_stim(s) = stop_stim(s)-start_stim(s);
                            
                            i = i + unique_stims;
                            
                        end
                        allStartTrigs(p,:) = start_stim;
                        allStopTrigs(p,:) = stop_stim;
                        allLengths(p,:) = length_this_stim;
                    end
                    
                    stimTRIGS{q}.start = allStartTrigs;
                    stimTRIGS{q}.stop = allStopTrigs;
                    stimTRIGS{q}.length_samp = allLengths;
                    stimTRIGS{q}.name = song_type;
                    stimTRIGS{q}.uniqueStims = unique_stims;
                    stimTRIGS{q}.stimReps = reps_stims;
                    
                    %% For Sponts
                    [stim_start, stim_stop, song_type] = cc_choose_stim(q, allSpontTrigs);
                    
                    unique_stims = thisStimRepInfo.spont_versions;
                    reps_stims = thisStimRepInfo.spont_reps;
                    
                    allStartTrigs = []; allStopTrigs = []; allLengths = [];
                    for p = 1 : unique_stims
                        i = p;
                        
                        start_stim = []; stop_stim = []; length_this_stim = [];
                        for s = 1 : reps_stims
                            start_stim(s) =  stim_start(i);
                            stop_stim(s) =  stim_stop(i);
                            length_this_stim(s) = stop_stim(s)-start_stim(s);
                            
                            i = i + unique_stims;
                            
                        end
                        allStartTrigs(p,:) = start_stim;
                        allStopTrigs(p,:) = stop_stim;
                        allLengths(p,:) = length_this_stim;
                    end
                    
                    spontTRIGS{q}.start = allStartTrigs;
                    spontTRIGS{q}.stop = allStopTrigs;
                    spontTRIGS{q}.length_samp = allLengths;
                    spontTRIGS{q}.name = song_type;
                    spontTRIGS{q}.uniqueStims = unique_stims;
                    spontTRIGS{q}.stimReps = reps_stims;
                    
                    %% For Motifs
                    motifSet = [6, 8, 9];
                    if ismember (q, motifSet)
                        
                        [stim_start, stim_stop, song_type] = cc_choose_stim(q, allMotifTrigs);
                        [motif_info] = uniqueReps_Motifs(q, allMotifTrigs);
                        
                        unique_stims = motif_info.unique_bouts;
                        reps_stims = motif_info.bout_reps;
                        
                        allStartTrigs = []; allStopTrigs = []; allLengths = [];
                        for p = 1 : unique_stims
                            i = p;
                            
                            start_stim = []; stop_stim = []; length_this_stim = [];
                            for s = 1 : reps_stims
                                start_stim(s) =  stim_start(i);
                                stop_stim(s) =  stim_stop(i);
                                length_this_stim(s) = stop_stim(s)-start_stim(s);
                                
                                i = i + unique_stims;
                                
                            end
                            allStartTrigs(p,:) = start_stim;
                            allStopTrigs(p,:) = stop_stim;
                            allLengths(p,:) = length_this_stim;
                        end
                        
                        
                        motifTRIGS{q}.start = allStartTrigs;
                        motifTRIGS{q}.stop = allStopTrigs;
                        motifTRIGS{q}.length_samp = allLengths;
                        motifTRIGS{q}.name = song_type;
                        motifTRIGS{q}.uniqueStims = unique_stims;
                        motifTRIGS{q}.stimReps = reps_stims;
                        
                        %% Motif Syllables
                        %{
                        [stim_start, stim_stop, song_type] = cc_choose_stim(q, allMotifSylTrigs);
                        [motif_info] = uniqueReps_Motifs(q, allMotifSylTrigs);
                        
                        allStartTrigs = []; allStopTrigs = []; allLengths = [];
                        for p = 1 : unique_stims
                            i = p;
                            
                            %start_stim = []; stop_stim = []; length_this_stim = [];
                            for s = 1 : reps_stims
                                
                                if isfield(stim_start, 's1')
                                    start_stim_s1(s) =  stim_start.s1(i);
                                    stop_stim_s1(s) =  stim_stop.s1(i);
                                    length_this_stim_s1(s) = stop_stim_s1(s)-start_stim_s1(s);
                                end
                                
                                if isfield(stim_start, 's2')
                                    start_stim_s2(s) =  stim_start.s2(i);
                                    stop_stim_s2(s) =  stim_stop.s2(i);
                                    length_this_stim_s2(s) = stop_stim_s2(s)-start_stim_s2(s);
                                end
                                
                                if isfield(stim_start, 's3')
                                    start_stim_s3(s) =  stim_start.s3(i);
                                    stop_stim_s3(s) =  stim_stop.s3(i);
                                    length_this_stim_s3(s) = stop_stim_s3(s)-start_stim_s3(s);
                                end
                                
                                if isfield(stim_start, 's4')
                                    start_stim_s4(s) =  stim_start.s4(i);
                                    stop_stim_s4(s) =  stim_stop.s4(i);
                                    length_this_stim_s4(s) = stop_stim_s4(s)-start_stim_s4(s);
                                end
                                
                                if isfield(stim_start, 's5')
                                    start_stim_s5(s) =  stim_start.s5(i);
                                    stop_stim_s5(s) =  stim_stop.s5(i);
                                    length_this_stim_s5(s) = stop_stim_s5(s)-start_stim_s5(s);
                                end
                                
                                i = i + unique_stims;
                                
                            end
                            
                            fieldNames = fieldnames(stim_start);
                            nFieldNames = numel(fieldNames);
                            
                            for qq = 1:nFieldNames
                                
                                thisInd = num2str(qq);
                                
                                eval(['allStartTrigs.s' thisInd '(p,:) = start_stim_s' thisInd ';']);
                                eval(['allStopTrigs.s' thisInd '(p,:) = stop_stim_s' thisInd ';']);
                                eval(['allLengths.s' thisInd '(p,:) = length_this_stim_s' thisInd ';']);
                                
                            end
                            
                        end
                        
                        
                        motifTRIGS_SYL{q}.start = allStartTrigs;
                        motifTRIGS_SYL{q}.stop = allStopTrigs;
                        motifTRIGS_SYL{q}.length_samp = allLengths;
                        motifTRIGS_SYL{q}.name = song_type;
                        motifTRIGS_SYL{q}.uniqueStims = unique_stims;
                        motifTRIGS_SYL{q}.stimReps = reps_stims;
                        
                        disp('')
                        %}
                    end
                    
                    if q == 7 % CON motifs
                        
                        [stim_start, stim_stop, song_type] = cc_choose_stim(q, allMotifTrigs);
                        if ~isempty(stim_start)
                            [motif_info] = uniqueReps_Motifs(q, allMotifTrigs);
                            
                            unique_stims = motif_info.unique_bouts;
                            reps_stims = motif_info.bout_reps;
                            
                            for p = 1 : unique_stims
                                
                                thisStimStart = stim_start{p};
                                thisStimStop = stim_stop{p};
                                length_this_stim = thisStimStop-thisStimStart;
                                
                                allStartTrigs_CONMotif{p} = thisStimStart;
                                allStopTrigs_CONMotif{p} = thisStimStop;
                                allLengths_CONMotif{p} = length_this_stim;
                            end
                            
                            motifConTRIGS{q}.start = allStartTrigs_CONMotif;
                            motifConTRIGS{q}.stop = allStopTrigs_CONMotif;
                            motifConTRIGS{q}.length_samp = allLengths_CONMotif;
                            motifConTRIGS{q}.name = song_type;
                            motifConTRIGS{q}.uniqueStims = unique_stims;
                            motifConTRIGS{q}.stimReps = reps_stims;
                        else
                            motifConTRIGS = [];
                        end
                    end
                    
                end
            end
            
            obj.TRIGS.stimTRIGS = stimTRIGS;
            obj.TRIGS.spontTRIGS = spontTRIGS;
            obj.TRIGS.motifTRIGS = motifTRIGS;
            obj.TRIGS.motifConTRIGS = motifConTRIGS;
            %obj.TRIGS.motifSylTRIGS = motifTRIGS_SYL;
            
            disp('')
        end
        
        %% Get Spike Times
        function obj = getSpikesTimes(obj)
            disp('Getting spikes...')
            
            spkINFO = load([obj.paths.spikePath obj.spikeFile]);
            spks = spkINFO.spks;
            
            chwSpks = cellfun(@(x) ~isempty(x), spks);
            
            chans = find(chwSpks == 1);
            nchans = numel(chans);
            
            obj.SPKS.spks = spks;
            obj.SPKS.chans = chans;
            obj.SPKS.nchans = nchans;
            
            
            %% Determine which stimuli are present for each channel
            
            allStims = obj.TRIGS.INFO.allStims;
            stimTRIGS = obj.TRIGS.stimTRIGS;
            
            spkStimInfo = []; spkRateInfo =[];
            for j = chans
                
                chSpks = spks{j};
                
                chanStims = [];
                for k = 1:numel(allStims)
                    stim =  allStims(k);
                    
                    thisStim = stimTRIGS{stim};
                    
                    firstStart = thisStim.start(1);
                    lastEnd = thisStim.stop(end);
                    stimLengthTotal_s = (lastEnd-firstStart)/obj.scanrate;
                    
                    %chanSpksDuringStim = numel(spks{chan}(spks{chan} >= OnOff_params.Bout_stim_start(1) & spks{chan} <= OnOff_params.BOUT_stim_stop(end)));
                    chanSpksDuringStim = numel(chSpks(chSpks >= firstStart & chSpks <= lastEnd));
                    spkRate = chanSpksDuringStim/stimLengthTotal_s;
                    
                    if spkRate> 0.05
                        chanStims(k) = stim;
                        allSpkRates(k) = spkRate;
                    else
                        chanStims(k) = nan;
                        allSpkRates(k) = spkRate;
                    end
                end
                
                % Remove nans
                spkStimInfo{j} = chanStims;
                spkRateInfo(j,:) = allSpkRates;
                
            end
            
            obj.SPKS.spkStimInfo = spkStimInfo;
            obj.SPKS.spkRateInfo = spkRateInfo;
            
        end
        
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% ~~~~~Secondary Functions
        %% Getting Data
        function audData = loadSpectralData(obj)
            
            useWavData  = 1;
            
            recordingSessionPath = [obj.paths.dataPath obj.recordingName];
            
            if obj.dataFormat ~= 8 % file format 8 needs to be loaded with the chronic file loader
                [data, data_scanrate]= load_labview_acute(recordingSessionPath, 0);
                disp('Loading raw data file..');
            else
                [data, data_scanrate] = load_labview_chronic(recordingSessionPath, 0);
                disp('Loading raw data file..');
            end
            
            if useWavData
                if ~isempty(obj.wavChan)
                    audData = data(obj.wavChan,:);
                else
                    if ~isempty(obj.micChan)
                        audData = data(obj.micChan,:);
                    end
                end
                
            else
                if ~isempty(obj.micChan)
                    audData = data(obj.micChan,:);
                end
            end
        end
        
        %% Plotting Rasters
        function plotRastersForMotifs(obj, audData, chans)
            
            if nargin <3
                % we use all the chans by default
                chans = obj.SPKS.chans;
            end
            
            FigSavePath = [obj.paths.figPath 'MotifRasters/'];
            
            if exist(FigSavePath, 'dir') == 0
                mkdir(FigSavePath);
            end
            
            stimSet = [6 8 9];
            stimTRIGS = obj.TRIGS.motifTRIGS;
            
            spec_scale = 2000; % for changing the intesity of the spectrogram
            buffer_ms = 20;
            buffer_samp = round(buffer_ms/1000*obj.scanrate);
            
            spk_size_y = 0.005;
            y_offset_between_repetitions = 0.001;
            
            for j = 1: numel(chans)
                
                thisChan = chans(j);
                spkStimInfo_chan = obj.SPKS.spkStimInfo{thisChan};
                spks = obj.SPKS.spks{thisChan};
                
                for k = 1: numel(stimSet)
                    
                    % check to see if this stim exists for this chan
                    if ismember(stimSet(k), spkStimInfo_chan)
                        
                        thisStim = stimTRIGS{stimSet(k)};
                        stimStarts = thisStim.start;
                        stimStops = thisStim.stop;
                        stimLengBuff = thisStim.length_samp(1)+2*buffer_samp;
                        
                        stimAudData = audData(stimStarts(1)-buffer_samp:stimStops(1)+buffer_samp);
                        
                        
                        figSaveName = [FigSavePath obj.recordingName '_' thisStim.name '_Ch-'  num2str(thisChan) '_motifRaster'];
                        
                        %%
                        figH = figure(100); clf
                        %% Spectrogram
                        subplot(4, 1, 1)
                        specgram1(double(stimAudData)/spec_scale,512,obj.scanrate,400,360);
                        ylim([0 10000])
                        set(gca, 'xtick', []);
                        title([obj.recordingName ' | ' thisStim.name ' | Ch-'  num2str(thisChan) ])
                        %% Spikes
                        intFR  = zeros(1,stimLengBuff); % we define a vector for integrated FR
                        subplot(4, 1, [2 3])
                        for s = 1 : numel(stimStarts)
                            start_stim = stimStarts(s)-buffer_samp;
                            stop_stim = stimStops(s)+buffer_samp;
                            
                            %must subtract start_stim to arrange spikes relative to onset
                            theseSpks= spks(spks >= start_stim & spks <= stop_stim)-start_stim;
                            
                            y_low =  (s * spk_size_y - spk_size_y);
                            y_high = (s * spk_size_y - y_offset_between_repetitions);
                            
                            spk_vct = repmat(theseSpks, 2, 1); % this draws a straight vertical line
                            this_run_spks = size(spk_vct, 2);
                            ln_vct = repmat([y_high; y_low], 1, this_run_spks); % this defines the line height
                            
                            line(spk_vct, ln_vct, 'LineWidth', 0.5, 'Color', 'k');
                            
                            nspks = size(theseSpks, 2);
                            
                            % add a 1 to the FR vector for every spike
                            for ind = 1 : nspks
                                if theseSpks(ind) ~= 0
                                    intFR(theseSpks(ind)) = intFR(theseSpks(ind)) +1;
                                end
                            end
                            
                        end
                        
                        axis tight
                        xlim([0 stimLengBuff])
                        set(gca, 'xtick', []);
                        set(gca, 'ytick', []);
                        
                        %% Firing Rate
                        subplot(4, 1, 4)
                        
                        smoothiWin = round(obj.scanrate*.01);% 5 ms
                        
                        FRsmoothed = smooth(intFR, smoothiWin)/numel(stimStarts);
                        timepoints = 1:1:numel(FRsmoothed);
                        timepoints_ms = timepoints/obj.scanrate*1000;
                        
                        plot(timepoints_ms, FRsmoothed, 'color', 'k', 'LineWidth', 1)
                        
                        axis tight
                        %ylim([0 0.005])
                        xlabel('Time [ms]')
                        
                        %% Print
                        figure(figH)
                        
                        disp('Printing Plot')
                        set(0, 'CurrentFigure', figH)
                        
                        export_to = set_export_file_format(4); % 4 (jpeg)
                        export_to = set_export_file_format(1); % 4 (jpeg)
                        plotpos = [0 0 10 12];
                        print_in_A4(0, figSaveName, export_to, 0, plotpos);
                        
                        disp('')
                    end
                end
            end
        end
        
        %% Syllables
        
        %% Plotting Rasters
        function plotRastersForMotifSyllables(obj, audData, chans)
            
            if nargin <3
                % we use all the chans by default
                chans = obj.SPKS.chans;
            end
            
            FigSavePath = [obj.paths.figPath 'MotifSyllableRasters/'];
            
            if exist(FigSavePath, 'dir') == 0
                mkdir(FigSavePath);
            end
            
            stimSet = [6 8 9];
            stimTRIGS = obj.TRIGS.motifSylTRIGS;
            
            spec_scale = 2000; % for changing the intesity of the spectrogram
            buffer_ms = 10;
            buffer_samp = round(buffer_ms/1000*obj.scanrate);
            
            spk_size_y = 0.005;
            y_offset_between_repetitions = 0.001;
            
            for j = 1: numel(chans)
                
                thisChan = chans(j);
                spkStimInfo_chan = obj.SPKS.spkStimInfo{thisChan};
                spks = obj.SPKS.spks{thisChan};
                
                for k = 1: numel(stimSet)
                    
                    % check to see if this stim exists for this chan
                    if ismember(stimSet(k), spkStimInfo_chan)
                        
                        thisStim = stimTRIGS{stimSet(k)};
                        
                        fieldNames = fieldnames(thisStim.start);
                        nFieldNames = numel(fieldNames);
                        
                        for q = 1:nFieldNames
                            
                            thisSyl = num2str(q);
                            stimStarts = []; stimStops  = []; stimLengBuff = [];
                            
                            eval(['stimStarts = thisStim.start.s' thisSyl ';']);
                            eval(['stimStops = thisStim.stop.s' thisSyl ';']);
                            eval(['stimLengBuff = thisStim.length_samp.s' thisSyl '(1)+2*buffer_samp;']);
                            
                            stimLengBuff = round(stimLengBuff);
                            %stimStarts = thisStim.start;
                            %stimStops = thisStim.stop;
                            %stimLengBuff = thisStim.length_samp(1)+2*buffer_samp;
                            
                            stimAudData = audData(stimStarts(1)-buffer_samp:stimStops(1)+buffer_samp);
                            
                            %figSaveName = [FigSavePath obj.recordingName '_' thisStim.name '_Ch-'  num2str(thisChan) '_motifRaster'];
                            eval(['figSaveName = [FigSavePath obj.recordingName ''_'' thisStim.name ''_Ch-'' num2str(thisChan) ''-MotifAlignment_s'' thisSyl ];' ]);
                            
                            %%
                            figH = figure(100); clf
                            %% Spectrogram
                            subplot(4, 1, 1)
                            specgram1(double(stimAudData)/spec_scale,512,obj.scanrate,400,360);
                            ylim([0 10000])
                            set(gca, 'xtick', []);
                            
                            eval(['title([obj.recordingName '' | '' thisStim.name  '' | Ch- '' num2str(thisChan) '' Motif Syllable -s'' thisSyl ])']);
                            %title([obj.recordingName ' | ' thisStim.name ' | Ch-'  num2str(thisChan) ])
                            %% Spikes
                            intFR  = zeros(1,stimLengBuff); % we define a vector for integrated FR
                            subplot(4, 1, [2 3])
                            for s = 1 : numel(stimStarts)
                                start_stim = stimStarts(s)-buffer_samp;
                                stop_stim = stimStops(s)+buffer_samp;
                                
                                %must subtract start_stim to arrange spikes relative to onset
                                theseSpks= spks(spks >= start_stim & spks <= stop_stim)-start_stim;
                                
                                y_low =  (s * spk_size_y - spk_size_y);
                                y_high = (s * spk_size_y - y_offset_between_repetitions);
                                
                                spk_vct = repmat(theseSpks, 2, 1); % this draws a straight vertical line
                                this_run_spks = size(spk_vct, 2);
                                ln_vct = repmat([y_high; y_low], 1, this_run_spks); % this defines the line height
                                
                                line(spk_vct, ln_vct, 'LineWidth', 0.5, 'Color', 'k');
                                
                                nspks = size(theseSpks, 2);
                                
                                % add a 1 to the FR vector for every spike
                                for ind = 1 : nspks
                                    if theseSpks(ind) ~= 0 && theseSpks(ind) <= length(intFR)
                                        intFR(theseSpks(ind)) = intFR(theseSpks(ind)) +1;
                                    end
                                end
                                
                            end
                            
                            axis tight
                            xlim([0 stimLengBuff])
                            set(gca, 'xtick', []);
                            set(gca, 'ytick', []);
                            
                            %% Firing Rate
                            subplot(4, 1, 4)
                            
                            smoothiWin = round(obj.scanrate*.005);% 5 ms
                            
                            FRsmoothed = smooth(intFR, smoothiWin)/numel(stimStarts);
                            timepoints = 1:1:numel(FRsmoothed);
                            timepoints_ms = timepoints/obj.scanrate*1000;
                            
                            plot(timepoints_ms, FRsmoothed, 'color', 'k', 'LineWidth', 1)
                            
                            axis tight
                            ylim([0 0.005])
                            xlabel('Time [ms]')
                            
                            %% Print
                            figure(figH)
                            
                            disp('Printing Plot')
                            set(0, 'CurrentFigure', figH)
                            
                            export_to = set_export_file_format(4); % 4 (jpeg)
                            plotpos = [0 0 10 15];
                            print_in_A4(0, figSaveName, export_to, 0, plotpos);
                            
                            disp('')
                        end
                        
                    end
                end
            end
        end
        
        
        
        %%
        
        function plotRastersForStim(obj, audData, stim, chans)
            
            if nargin <4
                % we use all the chans by default
                chans = obj.SPKS.chans;
            end
            
            FigSavePath = [obj.paths.figPath 'StimRasters/'];
            
            if exist(FigSavePath, 'dir') == 0
                mkdir(FigSavePath);
            end
            
            stimSet = stim;
            stimTRIGS = obj.TRIGS.stimTRIGS;
            
            spec_scale = 2000; % for changing the intesity of the spectrogram
            buffer_ms = 500;
            buffer_samp = round(buffer_ms/1000*obj.scanrate);
            
            spk_size_y = 0.005;
            y_offset_between_repetitions = 0.001;
            
            for j = 1: numel(chans)
                
                thisChan = chans(j);
                spkStimInfo_chan = obj.SPKS.spkStimInfo{thisChan};
                spks = obj.SPKS.spks{thisChan};
                
                for k = 1: numel(stimSet)
                    
                    % check to see if this stim exists for this chan
                    if ismember(stimSet(k), spkStimInfo_chan)
                        
                        thisStim = stimTRIGS{stimSet(k)};
                        stimStarts = thisStim.start;
                        stimStops = thisStim.stop;
                        stimLengBuff = max(max(thisStim.length_samp))+2*buffer_samp;
                        
                        stimAudData = audData(stimStarts(6,1)-buffer_samp:stimStops(6,1)+buffer_samp);
                        
                        
                        figSaveName = [FigSavePath obj.recordingName '_' thisStim.name '_Ch-'  num2str(thisChan) '_Raster'];
                        
                        %%
                        figH = figure(100); clf
                        %% Spectrogram
                        subplot(4, 1, 1)
                        specgram1(double(stimAudData)/spec_scale,512,obj.scanrate,400,360);
                        ylim([0 10000])
                        set(gca, 'xtick', []);
                        title([obj.recordingName ' | ' thisStim.name ' | Ch-'  num2str(thisChan) ])
                        %% Spikes
                        intFR  = zeros(1,stimLengBuff); % we define a vector for integrated FR
                        subplot(4, 1, [2 3])
                        cnt  = 1;
                        for ss = 1: size(stimStarts, 1)
                         
                            for s = 1 : size(stimStarts, 2)
                                
                                start_stim = stimStarts(ss, s)-buffer_samp;
                                stop_stim = stimStops(ss, s)+buffer_samp;
                                
                                %must subtract start_stim to arrange spikes relative to onset
                                theseSpks= spks(spks >= start_stim & spks <= stop_stim)-start_stim;
                                
                                y_low =  (cnt * spk_size_y - spk_size_y);
                                y_high = (cnt * spk_size_y - y_offset_between_repetitions);
                                
                                
                                cnt = cnt+1;
                                spk_vct = repmat(theseSpks, 2, 1); % this draws a straight vertical line
                                this_run_spks = size(spk_vct, 2);
                                ln_vct = repmat([y_high; y_low], 1, this_run_spks); % this defines the line height
                                
                                line(spk_vct, ln_vct, 'LineWidth', 0.5, 'Color', 'k');
                                
                                nspks = size(theseSpks, 2);
                                
                                % add a 1 to the FR vector for every spike
                                for ind = 1 : nspks
                                    if theseSpks(ind) ~= 0
                                        intFR(theseSpks(ind)) = intFR(theseSpks(ind)) +1;
                                    end
                                end
                           
                            end
                                hold on
                             line([0, stimLengBuff], [y_high, y_high], 'color', 'b') 
                        end
                        
                        axis tight
                        xlim([0 stimLengBuff])
                        set(gca, 'xtick', []);
                        set(gca, 'ytick', []);
                        
                        %% Firing Rate
                        subplot(4, 1, 4)
                        
                        smoothiWin = round(obj.scanrate*.005);% 5 ms
                        
                        FRsmoothed = smooth(intFR, smoothiWin)/numel(stimStarts);
                        timepoints = 1:1:numel(FRsmoothed);
                        timepoints_ms = timepoints/obj.scanrate*1000;
                        
                        plot(timepoints_ms, FRsmoothed, 'color', 'k', 'LineWidth', 1)
                        
                        axis tight
                        ylim([0 0.01])
                        xlabel('Time [ms]')
                        
                        %% Print
                        figure(figH)
                        
                        disp('Printing Plot')
                        set(0, 'CurrentFigure', figH)
                        
                        export_to = set_export_file_format(4); % 4 (jpeg)
                        plotpos = [0 0 15 12];
                        print_in_A4(0, figSaveName, export_to, 0, plotpos);
                        print_in_A4(0, figSaveName, '-depsc', 0, plotpos);
                        
                        disp('')
                    end
                end
            end
        end
        
        
        
        function plotRastersForSpont(obj, audData, chans)
            if nargin <3
                % we use all the chans by default
                chans = obj.SPKS.chans;
            end
            
            FigSavePath = [obj.paths.figPath 'SpontRasters/'];
            
            if exist(FigSavePath, 'dir') == 0
                mkdir(FigSavePath);
            end
            
            stimSet = obj.TRIGS.INFO.allStims;
            stimTRIGS = obj.TRIGS.spontTRIGS;
            
            spec_scale = 2000; % for changing the intesity of the spectrogram
            buffer_ms = 1000;
            buffer_samp = round(buffer_ms/1000*obj.scanrate);
            
            spk_size_y = 0.005;
            y_offset_between_repetitions = 0.001;
            
            for j = 1: numel(chans)
                
                thisChan = chans(j);
                spkStimInfo_chan = obj.SPKS.spkStimInfo{thisChan};
                spks = obj.SPKS.spks{thisChan};
                
                allStimStarts = []; allStimStops = [];
                for k = 1: numel(stimSet)
                    
                    % check to see if this stim exists for this chan
                    if ismember(stimSet(k), spkStimInfo_chan)
                        
                        thisStim = stimTRIGS{stimSet(k)};
                        stimStarts = thisStim.start;
                        stimStops = thisStim.stop;
                        
                        allStimStarts = [allStimStarts stimStarts];
                        allStimStops = [allStimStops stimStops];
                        nStims(k) = numel(stimStarts);
                    end
                end
                
                stimLengBuff = thisStim.length_samp(1)+2*buffer_samp;
                
                stimAudData = audData(stimStarts(1)-buffer_samp:stimStops(1)+buffer_samp);
                
                figSaveName = [FigSavePath obj.recordingName '_AllStims_Ch-'  num2str(thisChan) '_spontRaster'];
                
                nStimsCSum = cumsum(nStims);
                %%
                figH = figure(100); clf
                %% Spectrogram
                subplot(4, 1, 1)
                specgram1(double(stimAudData)/spec_scale,512,obj.scanrate,400,360);
                ylim([0 10000])
                set(gca, 'xtick', []);
                title([obj.recordingName ' | Spont. | Ch-'  num2str(thisChan) ])
                %% Spikes
                intFR  = zeros(1,stimLengBuff); % we define a vector for integrated FR
                subplot(4, 1, [2 3])
                for s = 1 : numel(allStimStarts)
                    start_stim = allStimStarts(s)-buffer_samp;
                    stop_stim = allStimStops(s)+buffer_samp;
                    
                    %must subtract start_stim to arrange spikes relative to onset
                    theseSpks= spks(spks >= start_stim & spks <= stop_stim)-start_stim;
                    
                    y_low =  (s * spk_size_y - spk_size_y);
                    y_high = (s * spk_size_y - y_offset_between_repetitions);
                    
                    spk_vct = repmat(theseSpks, 2, 1); % this draws a straight vertical line
                    this_run_spks = size(spk_vct, 2);
                    ln_vct = repmat([y_high; y_low], 1, this_run_spks); % this defines the line height
                    
                    line(spk_vct, ln_vct, 'LineWidth', 0.5, 'Color', 'k');
                    
                    if ismember(s, nStimsCSum)
                        line([0, stimLengBuff], [y_high, y_high], 'color', 'b')
                    end
                    
                    nspks = size(theseSpks, 2);
                    % add a 1 to the FR vector for every spike
                    for ind = 1 : nspks
                        if theseSpks(ind) ~= 0
                            intFR(theseSpks(ind)) = intFR(theseSpks(ind)) +1;
                        end
                    end
                    
                end
                
                axis tight
                xlim([0 stimLengBuff])
                set(gca, 'xtick', []);
                set(gca, 'ytick', []);
                
                %% Firing Rate
                subplot(4, 1, 4)
                
                smoothiWin = round(obj.scanrate*.005);% 5 ms
                
                FRsmoothed = smooth(intFR, smoothiWin)/numel(allStimStarts);
                timepoints = 1:1:numel(FRsmoothed);
                timepoints_ms = timepoints/obj.scanrate*1000;
                
                plot(timepoints_ms, FRsmoothed, 'color', 'k', 'LineWidth', 1)
                
                axis tight
                ylim([0 0.005])
                hold on
                line([1000 1000], [0 0.005], 'color', 'k' )
                line([2000 2000], [0 0.005], 'color', 'k' )
                
                
                xlabel('Time [ms]')
                
                %% Print
                figure(figH)
                
                disp('Printing Plot')
                set(0, 'CurrentFigure', figH)
                
                export_to = set_export_file_format(4); % 4 (jpeg)
                plotpos = [0 0 10 12];
                print_in_A4(0, figSaveName, export_to, 0, plotpos);
                print_in_A4(0, figSaveName, '-depsc', 0, plotpos);
                disp('')
            end
        end
        %%
        
        function plotRastersForSpontSingleStim(obj, audData, stim, chans)
            if nargin <4
                % we use all the chans by default
                chans = obj.SPKS.chans;
            end
            
            FigSavePath = [obj.paths.figPath 'SpontRasters/'];
            
            if exist(FigSavePath, 'dir') == 0
                mkdir(FigSavePath);
            end
            
            stimSet = obj.TRIGS.INFO.allStims;
            stimTRIGS = obj.TRIGS.spontTRIGS;
            
            spec_scale = 2000; % for changing the intesity of the spectrogram
            buffer_ms = 1000;
            buffer_samp = round(buffer_ms/1000*obj.scanrate);
            
            spk_size_y = 0.005;
            y_offset_between_repetitions = 0.001;
            
            for j = 1: numel(chans)
                
                thisChan = chans(j);
                spkStimInfo_chan = obj.SPKS.spkStimInfo{thisChan};
                spks = obj.SPKS.spks{thisChan};
                
                allStimStarts = []; allStimStops = [];
                for k = stim
                    
                    % check to see if this stim exists for this chan
                    if ismember(stim, spkStimInfo_chan)
                        
                        thisStim = stimTRIGS{stimSet(k)};
                        stimStarts = thisStim.start;
                        stimStops = thisStim.stop;
                        
                        allStimStarts = [allStimStarts stimStarts];
                        allStimStops = [allStimStops stimStops];
                        nStims(k) = numel(stimStarts);
                    end
                end
                
                stimLengBuff = thisStim.length_samp(1)+2*buffer_samp;
                
                stimAudData = audData(stimStarts(1)-buffer_samp:stimStops(1)+buffer_samp);
                
                figSaveName = [FigSavePath obj.recordingName thisStim.name '_Ch-'  num2str(thisChan) '_spontRaster'];
                
                nStimsCSum = cumsum(nStims);
                %%
                figH = figure(100); clf
                %% Spectrogram
                subplot(4, 1, 1)
                specgram1(double(stimAudData)/spec_scale,512,obj.scanrate,400,360);
                ylim([0 10000])
                set(gca, 'xtick', []);
                title([obj.recordingName ' | Spont. | Ch-'  num2str(thisChan) ])
                %% Spikes
                intFR  = zeros(1,stimLengBuff); % we define a vector for integrated FR
                subplot(4, 1, [2 3])
                for s = 1 : numel(allStimStarts)
                    start_stim = allStimStarts(s)-buffer_samp;
                    stop_stim = allStimStops(s)+buffer_samp;
                    
                    %must subtract start_stim to arrange spikes relative to onset
                    theseSpks= spks(spks >= start_stim & spks <= stop_stim)-start_stim;
                    
                    y_low =  (s * spk_size_y - spk_size_y);
                    y_high = (s * spk_size_y - y_offset_between_repetitions);
                    
                    spk_vct = repmat(theseSpks, 2, 1); % this draws a straight vertical line
                    this_run_spks = size(spk_vct, 2);
                    ln_vct = repmat([y_high; y_low], 1, this_run_spks); % this defines the line height
                    
                    line(spk_vct, ln_vct, 'LineWidth', 0.5, 'Color', 'k');
                    
%                     if ismember(s, nStimsCSum)
%                         line([0, stimLengBuff], [y_high, y_high], 'color', 'b')
%                     end
%                     
                    nspks = size(theseSpks, 2);
                    % add a 1 to the FR vector for every spike
                    for ind = 1 : nspks
                        if theseSpks(ind) ~= 0
                            intFR(theseSpks(ind)) = intFR(theseSpks(ind)) +1;
                        end
                    end
                    
                end
                
                axis tight
                xlim([0 stimLengBuff])
                set(gca, 'xtick', []);
                set(gca, 'ytick', []);
                
                %% Firing Rate
                subplot(4, 1, 4)
                
                smoothiWin = round(obj.scanrate*.005);% 5 ms
                
                FRsmoothed = smooth(intFR, smoothiWin)/numel(allStimStarts);
                timepoints = 1:1:numel(FRsmoothed);
                timepoints_ms = timepoints/obj.scanrate*1000;
                
                plot(timepoints_ms, FRsmoothed, 'color', 'k', 'LineWidth', 1)
                
                axis tight
                ylim([0 0.01])
                hold on
                line([1000 1000], [0 0.005], 'color', 'k' )
                line([2000 2000], [0 0.005], 'color', 'k' )
                
                
                xlabel('Time [ms]')
                
                %% Print
                figure(figH)
                
                disp('Printing Plot')
                set(0, 'CurrentFigure', figH)
                
                export_to = set_export_file_format(4); % 4 (jpeg)
                plotpos = [0 0 10 12];
                print_in_A4(0, figSaveName, export_to, 0, plotpos);
                print_in_A4(0, figSaveName, '-depsc', 0, plotpos);
                
                
                disp('')
            end
        end
        
        
        %% plot Motif Jitter
        
        function plotMotifSpectrogramsAndRawData(obj, audData, stims)
            
            FigSavePath = [obj.paths.figPath 'MotifSpecData/'];
            doRandSel = 0;
            
            if exist(FigSavePath, 'dir') == 0
                mkdir(FigSavePath);
            end
            
            stimSet = [6 8 9];
            stimTRIGS = obj.TRIGS.motifTRIGS;
            
            
            spec_scale = 2000; % for changing the intesity of the spectrogram
            buffer_ms = 20;
            buffer_samp = round(buffer_ms/1000*obj.scanrate);
            
            plotOffsetL = 0.05;
            
            plotOffsetB = 0.1;
            plotWidth = 0.9;
            
            
            for j =1: numel(stims)
                
                thisStim = stimTRIGS{stims(j)};
                stimStarts = thisStim.start;
                stimStops = thisStim.stop;
                
                figH = figure(100); clf
                
                stimid = 1;
                
                this_databuff = audData(stimStarts(stimid)-buffer_samp:stimStops(stimid));
                
                figure(figH)
                
                subplot(2, 1, 1)
                %axes('position',pos);
                specgram1(double(this_databuff)/spec_scale,512,obj.scanrate,400,360);
                
                xes_samp = 1:1:size(this_databuff,2);
                xes_ms = (xes_samp ./ obj.scanrate)*1000;
                
                axis tight
                ylim([0 8000])
                %axis off
                set(gca, 'ytick', []);
                xticks_s = get(gca, 'xtick');
                xticks_ms = xticks_s*1000;
                
                for q = 1:numel(xticks_ms);
                    xlabs{q} = num2str(xticks_ms(q));
                end
                
                set(gca, 'xticklabels', xlabs)
                set(gca, 'XColor', [ 0 0 0]);
                
                subplot(2, 1, 2)
                plot(xes_ms, this_databuff, 'k')
                axis tight
                %xlim([ 0 500])
                
                
                figure(figH)
                title([obj.recordingName ' | ' thisStim.name ' Motifs'])
                figSaveNameH = [FigSavePath obj.recordingName '_' thisStim.name '-MotifAlignment'];
                
                disp('Printing Plot')
                set(0, 'CurrentFigure', figH)
                
                export_to = set_export_file_format(1); % 4 (jpeg)
                plotpos = [0 0 10 10];
                print_in_A4(0, figSaveNameH, export_to, 3, plotpos);
                
                
            end
            
        end
        
        
        
        
        %% plot Motif Jitter
        
        function plotMotifSpectrograms(obj, audData)
            
            FigSavePath = [obj.paths.figPath 'MotifAlignment/'];
            doRandSel = 0;
            
            if exist(FigSavePath, 'dir') == 0
                mkdir(FigSavePath);
            end
            
            stimSet = [6 8 9];
            stimTRIGS = obj.TRIGS.motifTRIGS;
            
            
            spec_scale = 2000; % for changing the intesity of the spectrogram
            buffer_ms = 20;
            buffer_samp = round(buffer_ms/1000*obj.scanrate);
            
            plotOffsetL = 0.05;
            
            plotOffsetB = 0.1;
            plotWidth = 0.9;
            
            
            for j =1: numel(stimSet)
                
                thisStim = stimTRIGS{stimSet(j)};
                stimStarts = thisStim.start;
                stimStops = thisStim.stop;
                nStimStarts = numel(stimStarts);
                
                figH = figure(100); clf
                figHH = figure(101); clf
                
                if doRandSel
                    nMotifReps = 30;
                    randSel = randperm(nStimStarts);
                else
                    %nMotifReps = numel(stimStarts);
                    nMotifReps = 30;
                    randSel = 1:1:nMotifReps;
                end
                
                plotHeight = (.90-plotOffsetB)/nMotifReps;
                
                for k = 1:nMotifReps
                    
                    thisInd = randSel(k);
                    
                    this_data = audData(stimStarts(thisInd)-buffer_samp:stimStops(thisInd)+buffer_samp);
                    if k == 1
                        [pos] = [plotOffsetL plotOffsetB plotWidth plotHeight];
                    else
                        [pos] = [plotOffsetL plotOffsetB+plotHeight*(k-1) plotWidth plotHeight];
                    end
                    
                    figure(figH)
                    axes('position',pos);
                    specgram1(double(this_data)/spec_scale,512,obj.scanrate,400,360);
                    
                    axis tight
                    ylim([0 8000])
                    %axis off
                    set(gca, 'ytick', []);
                    xticks_s = get(gca, 'xtick');
                    xticks_ms = xticks_s*1000;
                    
                    for q = 1:numel(xticks_ms);
                        xlabs{q} = num2str(xticks_ms(q));
                    end
                    
                    set(gca, 'xticklabels', xlabs)
                    set(gca, 'XColor', [1 1 1]);
                    
                    if k == 1
                        xlabel('Time [ms]')
                        set(gca,'XMinorTick','on')
                    end
                    
                    
                    %% Calc Energy
                    %ydata = ( smooth(roi.^2, effective) * getappdata(saH.h1200, 'energy_multiplier') );
                    ydata = ( smooth(this_data.^2, 128));
                    
                    figure(figHH)
                    axes('position',pos);
                    %xdata = (1 : length(roi)) / base_rate;
                    timepoints = (1:numel(ydata))/obj.scanrate;
                    plot(timepoints*1000, ydata, 'linewidth', 2, 'color', 'k')
                    axis tight
                    
                end
                
                %%
                
                figure(figH)
                title([obj.recordingName ' | ' thisStim.name ' Motifs'])
                figSaveNameH = [FigSavePath obj.recordingName '_' thisStim.name '-MotifAlignment'];
                
                disp('Printing Plot')
                set(0, 'CurrentFigure', figH)
                
                export_to = set_export_file_format(4); % 4 (jpeg)
                plotpos = [0 0 20 15];
                print_in_A4(0, figSaveNameH, export_to, 3, plotpos);
                %%
                figure(figHH)
                
                title([obj.recordingName ' | ' thisStim.name ' Motifs | Energy'])
                figSaveNameHH = [FigSavePath  obj.recordingName '_' thisStim.name '-MotifEnergyAlignment'];
                xlabel(['Time [ms]'])
                
                disp('Printing Plot')
                set(0, 'CurrentFigure', figHH)
                
                export_to = set_export_file_format(4); % 4 (jpeg)
                plotpos = [0 0 20 15];
                print_in_A4(0, figSaveNameHH, export_to, 0, plotpos);
                
            end
        end
        
        %%
        
        function plotMotifSylSpectrograms(obj, audData)
            
            FigSavePath = [obj.paths.figPath 'MotifSylAlignment/'];
            doRandSel = 0;
            
            if exist(FigSavePath, 'dir') == 0
                mkdir(FigSavePath);
            end
            
            stimSet = [6 8 9];
            stimTRIGS = obj.TRIGS.motifSylTRIGS;
            
            
            spec_scale = 2000; % for changing the intesity of the spectrogram
            buffer_ms = 10;
            buffer_samp = round(buffer_ms/1000*obj.scanrate);
            
            plotOffsetL = 0.05;
            
            plotOffsetB = 0.1;
            plotWidth = 0.9;
            
            
            for j =1: numel(stimSet)
                
                thisStim = stimTRIGS{stimSet(j)};
                stimStarts = thisStim.start;
                stimStops = thisStim.stop;
                
                
                fieldNames = fieldnames(stimStarts);
                nFieldNames = numel(fieldNames);
                
                for q = 1:nFieldNames;
                    
                    thisIndtxt = num2str(q);
                    
                    eval(['Syl_stimStarts = stimStarts.s' thisIndtxt ';']);
                    eval(['Syl_stimStops = stimStops.s' thisIndtxt ';']);
                    
                    
                    nStimStarts = numel(Syl_stimStarts);
                    
                    figH = figure(100); clf
                    figHH = figure(101); clf
                    
                    nMotifReps = 30;
                    
                    plotHeight = (.90-plotOffsetB)/nMotifReps;
                    
                    for k = 1:nMotifReps
                        
                        
                        
                        this_data = audData(Syl_stimStarts(k)-buffer_samp:Syl_stimStops(k)+buffer_samp);
                        if k == 1
                            [pos] = [plotOffsetL plotOffsetB plotWidth plotHeight];
                        else
                            [pos] = [plotOffsetL plotOffsetB+plotHeight*(k-1) plotWidth plotHeight];
                        end
                        
                        figure(figH)
                        axes('position',pos);
                        specgram1(double(this_data)/spec_scale,512,obj.scanrate,400,360);
                        
                        axis tight
                        ylim([0 8000])
                        %axis off
                        set(gca, 'ytick', []);
                        xticks_s = get(gca, 'xtick');
                        xticks_ms = xticks_s*1000;
                        
                        for q = 1:numel(xticks_ms);
                            xlabs{q} = num2str(xticks_ms(q));
                        end
                        
                        set(gca, 'xticklabels', xlabs)
                        set(gca, 'XColor', [1 1 1]);
                        
                        if k == 1
                            xlabel('Time [ms]')
                            set(gca,'XMinorTick','on')
                        end
                        
                        
                        %% Calc Energy
                        %ydata = ( smooth(roi.^2, effective) * getappdata(saH.h1200, 'energy_multiplier') );
                        ydata = ( smooth(this_data.^2, 128));
                        
                        figure(figHH)
                        axes('position',pos);
                        %xdata = (1 : length(roi)) / base_rate;
                        timepoints = (1:numel(ydata))/obj.scanrate;
                        plot(timepoints*1000, ydata, 'linewidth', 2, 'color', 'k')
                        axis tight
                        
                    end
                    
                    %%
                    
                    figure(figH)
                    
                    eval(['title([obj.recordingName '' | '' thisStim.name  ''Motifs Syllable -s'' thisIndtxt ])']);
                    eval(['figSaveNameH = [FigSavePath obj.recordingName ''_'' thisStim.name ''-MotifAlignment_s'' thisIndtxt ];' ]);
                    %figSaveNameH = [FigSavePath obj.recordingName '_' thisStim.name '-MotifAlignment'];
                    
                    disp('Printing Plot')
                    set(0, 'CurrentFigure', figH)
                    
                    export_to = set_export_file_format(4); % 4 (jpeg)
                    plotpos = [0 0 10 15];
                    print_in_A4(0, figSaveNameH, export_to, 3, plotpos);
                    %%
                    figure(figHH)
                    
                    eval(['title([obj.recordingName '' | '' thisStim.name  ''Motifs Syllable Energy -s'' thisIndtxt ])']);
                    eval(['figSaveNameHH = [FigSavePath obj.recordingName ''_'' thisStim.name ''-MotifEnergyAlignment_s'' thisIndtxt ];']);
                    
                    %title([obj.recordingName ' | ' thisStim.name ' Motifs | Energy'])
                    %5figSaveNameHH = [FigSavePath  obj.recordingName '_' thisStim.name '-MotifEnergyAlignment'];
                    xlabel(['Time [ms]'])
                    
                    disp('Printing Plot')
                    set(0, 'CurrentFigure', figHH)
                    
                    export_to = set_export_file_format(4); % 4 (jpeg)
                    plotpos = [0 0 10 15];
                    print_in_A4(0, figSaveNameHH, export_to, 0, plotpos);
                end
            end
        end
        
        
        function plotMotifSpectrogramsTimeWarping(obj, audData)
            
            FigSavePath = [obj.paths.figPath 'TimeWarp/'];
            
            if exist(FigSavePath, 'dir') == 0
                mkdir(FigSavePath);
            end
            
            stimSet = [6 8 9];
            stimTRIGS = obj.TRIGS.motifTRIGS;
            
            spec_scale = 2000; % for changing the intesity of the spectrogram
            buffer_ms = 0;
            buffer_samp = round(buffer_ms/1000*obj.scanrate);
            
            plotOffsetL = 0.05;
            
            plotOffsetB = 0.1;
            plotWidth = 0.9;
            
            
            for j =1: numel(stimSet)
                
                thisStim = stimTRIGS{stimSet(j)};
                stimStarts = thisStim.start;
                stimStops = thisStim.stop;
                nStimStarts = numel(stimStarts);
                
                %figH = figure(100); clf
                %figHH = figure(101); clf
                
                nMotifReps = 30;
                randSel = 1:1:nMotifReps;
                %                 if doRandSel
                %                     nMotifReps = 30;
                %                     randSel = randperm(nStimStarts);
                %                 else
                %                     %nMotifReps = numel(stimStarts);
                %                     nMotifReps = 30;
                %
                %                 end
                
                plotHeight = (.90-plotOffsetB)/nMotifReps;
                
                for k = 1:nMotifReps
                    
                    
                    thisInd = randSel(k);
                    
                    this_data(k,:) = audData(stimStarts(thisInd)-buffer_samp:stimStops(thisInd)+buffer_samp);
                    
                end
                
                [B] = specgram1(double(this_data(1,:))/spec_scale,512,obj.scanrate,400,360);
                
                if k == 1
                    [pos] = [plotOffsetL plotOffsetB plotWidth plotHeight];
                else
                    [pos] = [plotOffsetL plotOffsetB+plotHeight*(k-1) plotWidth plotHeight];
                end
                
                figure(figH)
                
                
                
                M=1-double(spec0')*double(specs{i})/norm(double(spec0))/norm(double(specs{i}));
                [p,q,D] = dp_rich(M);   % The warping is done by using dynamic programming to find a min-cost path through matrix M. state sequence in p,q returned
                
                
                axes('position',pos);
                [B,F,T] = SPECGRAM(A,NFFT,Fs,WINDOW,NOVERLAP)
                specgram1(double(this_data)/spec_scale,512,obj.scanrate,400,360);
                
                axis tight
                ylim([0 8000])
                %axis off
                set(gca, 'ytick', []);
                xticks_s = get(gca, 'xtick');
                xticks_ms = xticks_s*1000;
                
                for q = 1:numel(xticks_ms);
                    xlabs{q} = num2str(xticks_ms(q));
                end
                
                set(gca, 'xticklabels', xlabs)
                set(gca, 'XColor', [1 1 1]);
                
                if k == 1
                    xlabel('Time [ms]')
                    set(gca,'XMinorTick','on')
                end
                
                
                %% Calc Energy
                %ydata = ( smooth(roi.^2, effective) * getappdata(saH.h1200, 'energy_multiplier') );
                ydata = ( smooth(this_data.^2, 128));
                
                figure(figHH)
                axes('position',pos);
                %xdata = (1 : length(roi)) / base_rate;
                timepoints = (1:numel(ydata))/obj.scanrate;
                plot(timepoints*1000, ydata, 'linewidth', 2, 'color', 'k')
                axis tight
                
            end
            
            %%
            
            figure(figH)
            title([obj.recordingName ' | ' thisStim.name ' Motifs'])
            figSaveNameH = [FigSavePath obj.recordingName '_' thisStim.name '-MotifAlignment'];
            
            disp('Printing Plot')
            set(0, 'CurrentFigure', figH)
            
            export_to = set_export_file_format(4); % 4 (jpeg)
            plotpos = [0 0 20 15];
            print_in_A4(0, figSaveNameH, export_to, 3, plotpos);
            %%
            figure(figHH)
            
            title([obj.recordingName ' | ' thisStim.name ' Motifs | Energy'])
            figSaveNameHH = [FigSavePath  obj.recordingName '_' thisStim.name '-MotifEnergyAlignment'];
            xlabel(['Time [ms]'])
            
            disp('Printing Plot')
            set(0, 'CurrentFigure', figHH)
            
            export_to = set_export_file_format(4); % 4 (jpeg)
            plotpos = [0 0 20 15];
            print_in_A4(0, figSaveNameHH, export_to, 0, plotpos);
            
        end
        
        
        
        function plotCONMotifSpectrograms(obj, audData)
            
            FigSavePath = [obj.paths.figPath 'CON_MotifAlignment/'];
            doRandSel = 0;
            
            if exist(FigSavePath, 'dir') == 0
                mkdir(FigSavePath);
            end
            
            
            stimTRIGS = obj.TRIGS.motifConTRIGS;
            stimSet = [7];
            
            thisStim = stimTRIGS{stimSet};
            
            nUniqueCONs = numel(thisStim.start);
            
            spec_scale = 2000; % for changing the intesity of the spectrogram
            buffer_ms = 20;
            buffer_samp = round(buffer_ms/1000*obj.scanrate);
            
            plotOffsetL = 0.05;
            
            plotOffsetB = 0.1;
            plotWidth = 0.9;
            
            for j =1: nUniqueCONs
                
                stimStarts = thisStim.start{j};
                stimStops = thisStim.stop{j};
                nStimStarts = numel(stimStarts);
                
                figH = figure(100); clf
                figHH = figure(101); clf
                
                nMotifReps = nStimStarts;
                randSel = 1:1:nMotifReps;
                
                plotHeight = (.90-plotOffsetB)/nMotifReps;
                
                for k = 1:nMotifReps
                    
                    thisInd = randSel(k);
                    
                    this_data = audData(stimStarts(thisInd)-buffer_samp:stimStops(thisInd)+buffer_samp);
                    if k == 1
                        [pos] = [plotOffsetL plotOffsetB plotWidth plotHeight];
                    else
                        [pos] = [plotOffsetL plotOffsetB+plotHeight*(k-1) plotWidth plotHeight];
                    end
                    
                    figure(figH)
                    axes('position',pos);
                    specgram1(double(this_data)/spec_scale,512,obj.scanrate,400,360);
                    
                    axis tight
                    ylim([0 8000])
                    %axis off
                    set(gca, 'ytick', []);
                    xticks_s = get(gca, 'xtick');
                    xticks_ms = xticks_s*1000;
                    
                    for q = 1:numel(xticks_ms);
                        xlabs{q} = num2str(xticks_ms(q));
                    end
                    
                    set(gca, 'xticklabels', xlabs)
                    set(gca, 'XColor', [1 1 1]);
                    
                    if k == 1
                        xlabel('Time [ms]')
                        set(gca,'XMinorTick','on')
                    end
                    
                    
                    %% Calc Energy
                    %ydata = ( smooth(roi.^2, effective) * getappdata(saH.h1200, 'energy_multiplier') );
                    ydata = ( smooth(this_data.^2, 128));
                    
                    figure(figHH)
                    axes('position',pos);
                    %xdata = (1 : length(roi)) / base_rate;
                    timepoints = (1:numel(ydata))/obj.scanrate;
                    plot(timepoints*1000, ydata, 'linewidth', 2, 'color', 'k')
                    axis tight
                    
                end
                
                %%
                
                figure(figH)
                title([obj.recordingName ' | ' thisStim.name ' Motifs-' num2str(j) ])
                figSaveNameH = [FigSavePath obj.recordingName '_' thisStim.name '-MotifAlignment-' num2str(j)];
                
                disp('Printing Plot')
                set(0, 'CurrentFigure', figH)
                
                export_to = set_export_file_format(4); % 4 (jpeg)
                plotpos = [0 0 20 15];
                print_in_A4(0, figSaveNameH, export_to, 3, plotpos);
                %%
                figure(figHH)
                
                title([obj.recordingName ' | ' thisStim.name ' Motifs-' num2str(j) ' | Energy'])
                figSaveNameHH = [FigSavePath  obj.recordingName '_' thisStim.name '-MotifEnergyAlignment-' num2str(j)];
                xlabel(['Time [ms]'])
                
                disp('Printing Plot')
                set(0, 'CurrentFigure', figHH)
                
                export_to = set_export_file_format(4); % 4 (jpeg)
                plotpos = [0 0 20 15];
                print_in_A4(0, figSaveNameHH, export_to, 0, plotpos);
                
            end
        end
        
        
        %% Analysis
        %% Binning Data
        function BinnedData = binSpikesForStimulus(obj, binSize_ms, stimSet)
            
            if nargin <3
                stimSet = obj.TRIGS.INFO.allStims;
            end
            
            stimTRIGS = obj.TRIGS.stimTRIGS;
            
            binSize_samp = floor(binSize_ms/1000*obj.scanrate);
            chans = obj.SPKS.chans;
            
            for j = 1: numel(chans)
                
                thisChan = chans(j);
                
                spkStimInfo_chan = obj.SPKS.spkStimInfo{thisChan};
                spks = obj.SPKS.spks{thisChan};
                
                for k = 1: numel(stimSet)
                    stim = stimSet(k);
                    
                    if ismember(stim, spkStimInfo_chan)
                        stimStarts = stimTRIGS{stim}.start;
                        stimStops = stimTRIGS{stim}.stop;
                        
                        uniqueStims = stimTRIGS{stim}.uniqueStims;
                        stimReps = stimTRIGS{stim}.stimReps;
                        
                        spksCnts_Bins_StimVers = [];
                        spksTimes_InBin_rel_samp_StimVers = [];
                        spksTimes_InBin_abs_samp_StimVers = [];
                        binDur_samp_StimVers = [];
                        
                        for p = 1:uniqueStims
                            
                            spksCnts_Bins = [];
                            spksTimes_InBin_rel_samp = [];
                            spksTimes_InBin_abs_samp = [];
                            binDur_samp = [];
                            
                            for b = 1:stimReps
                                
                                start_stim =  stimStarts(p, b);
                                stop_stim =  stimStops(p, b);
                                stimDur_samp = stop_stim -start_stim; % needs to be defined for each new unique stim
                                nBins = ceil(stimDur_samp/binSize_samp);
                                [~, indices_in_same_bin] = histc(1:stimDur_samp, [1:binSize_samp:stimDur_samp+binSize_samp]);
                                
                                cum_spikes = 0;
                                for o = 1: nBins
                                    
                                    %% Define stimulus onset offset
                                    
                                    % Map indices in stimulus to time points in stimulus
                                    this_data_range = start_stim:stop_stim-1;
                                    
                                    samples_this_bin = this_data_range(indices_in_same_bin == o);
                                    
                                    bin_start_samp = samples_this_bin(1);
                                    bin_stop_samp = samples_this_bin(end);
                                    
                                    length_this_bin = bin_stop_samp - bin_start_samp +1; % check to make sure bin length is correct
                                    
                                    spkTimesInBin_rel = spks(spks >= bin_start_samp & spks <= bin_stop_samp)-bin_start_samp;
                                    spkTimesInBin_abs = spks(spks >= bin_start_samp & spks <= bin_stop_samp);
                                    
                                    %% Binned Spike count used in COV calculations
                                    if ~isempty(spkTimesInBin_abs)
                                        spkCnt_Bin = numel(spkTimesInBin_abs);
                                    else
                                        spkCnt_Bin = 0;
                                    end
                                    
                                    % Test to make sure the binned spike counts match the unbinned spike counts
                                    cum_spikes = cum_spikes + spkCnt_Bin;
                                    
                                    % Binned Firing rate statistics
                                    spksCnts_Bins(b,o) = spkCnt_Bin;
                                    spksTimes_InBin_rel_samp{b,o} = spkTimesInBin_rel;
                                    spksTimes_InBin_abs_samp{b,o} = spkTimesInBin_abs;
                                    binDur_samp(b, o) = length_this_bin;
                                    
                                end
                            end
                            spksCnts_Bins_StimVers{p} = spksCnts_Bins;
                            spksTimes_InBin_rel_samp_StimVers{p} = spksTimes_InBin_rel_samp;
                            spksTimes_InBin_abs_samp_StimVers{p} = spksTimes_InBin_abs_samp;
                            binDur_samp_StimVers{p} = binDur_samp;
                        end
                        all_SpksCnts_Bins{thisChan, stim} = spksCnts_Bins_StimVers;
                        all_spksTimes_InBin_rel_samp_StimVers{thisChan, stim} = spksTimes_InBin_rel_samp_StimVers;
                        all_spksTimes_InBin_abs_samp_StimVers{thisChan, stim} = spksTimes_InBin_abs_samp_StimVers;
                        all_binDur_samp_StimVers{thisChan, stim} = binDur_samp_StimVers;
                        
                    else
                        all_SpksCnts_Bins{thisChan, stim} = [];
                        all_spksTimes_InBin_rel_samp_StimVers{thisChan, stim} = [];
                        all_spksTimes_InBin_abs_samp_StimVers{thisChan, stim} = [];
                        all_binDur_samp_StimVers{thisChan, stim} = [];
                    end
                end
            end
            BinnedData.all_SpksCnts_Bins = all_SpksCnts_Bins;
            BinnedData.all_spksTimes_InBin_rel_samp_StimVers = all_spksTimes_InBin_rel_samp_StimVers;
            BinnedData.all_spksTimes_InBin_abs_samp_StimVers = all_spksTimes_InBin_abs_samp_StimVers;
            BinnedData.all_binDur_samp_StimVers = all_binDur_samp_StimVers;
            BinnedData.stimSet = stimSet;
            BinnedData.allStimsNames = obj.TRIGS.INFO.allStimsNames;
            BinnedData.binSize_ms = binSize_ms;
            BinnedData.binSize_samp = binSize_samp;
            BinnedData.scanrate = obj.scanrate;
            disp('')
        end
        
        function BinnedData = binSpikesForMotifs(obj, binSize_ms, stimSet)
            
            if nargin <3
                stimSet = [6, 8, 9];
            end
            
            stimTRIGS = obj.TRIGS.motifTRIGS;
            
            binSize_samp = floor(binSize_ms/1000*obj.scanrate);
            chans = obj.SPKS.chans;
            
            for j = 1: numel(chans)
                
                thisChan = chans(j);
                
                spkStimInfo_chan = obj.SPKS.spkStimInfo{thisChan};
                spks = obj.SPKS.spks{thisChan};
                
                for k = 1: numel(stimSet)
                    stim = stimSet(k);
                    
                    if ismember(stim, spkStimInfo_chan)
                        stimStarts = stimTRIGS{stim}.start;
                        stimStops = stimTRIGS{stim}.stop;
                        
                        uniqueStims = stimTRIGS{stim}.uniqueStims;
                        stimReps = stimTRIGS{stim}.stimReps;
                        
                        spksCnts_Bins_StimVers = [];
                        spksTimes_InBin_rel_samp_StimVers = [];
                        spksTimes_InBin_abs_samp_StimVers = [];
                        binDur_samp_StimVers = [];
                        
                        allnames{stim} = stimTRIGS{stim}.name;
                        for p = 1:uniqueStims
                            
                            spksCnts_Bins = [];
                            spksTimes_InBin_rel_samp = [];
                            spksTimes_InBin_abs_samp = [];
                            binDur_samp = [];
                            
                            for b = 1:stimReps
                                
                                start_stim =  stimStarts(p, b);
                                stop_stim =  stimStops(p, b);
                                stimDur_samp = stop_stim -start_stim; % needs to be defined for each new unique stim
                                nBins = ceil(stimDur_samp/binSize_samp);
                                [~, indices_in_same_bin] = histc(1:stimDur_samp, [1:binSize_samp:stimDur_samp+binSize_samp]);
                                
                                cum_spikes = 0;
                                for o = 1: nBins
                                    
                                    %% Define stimulus onset offset
                                    
                                    % Map indices in stimulus to time points in stimulus
                                    this_data_range = start_stim:stop_stim-1;
                                    
                                    samples_this_bin = this_data_range(indices_in_same_bin == o);
                                    
                                    bin_start_samp = samples_this_bin(1);
                                    bin_stop_samp = samples_this_bin(end);
                                    
                                    length_this_bin = bin_stop_samp - bin_start_samp +1; % check to make sure bin length is correct
                                    
                                    spkTimesInBin_rel = spks(spks >= bin_start_samp & spks <= bin_stop_samp)-bin_start_samp;
                                    spkTimesInBin_abs = spks(spks >= bin_start_samp & spks <= bin_stop_samp);
                                    
                                    %% Binned Spike count used in COV calculations
                                    if ~isempty(spkTimesInBin_abs)
                                        spkCnt_Bin = numel(spkTimesInBin_abs);
                                    else
                                        spkCnt_Bin = 0;
                                    end
                                    
                                    % Test to make sure the binned spike counts match the unbinned spike counts
                                    cum_spikes = cum_spikes + spkCnt_Bin;
                                    
                                    % Binned Firing rate statistics
                                    spksCnts_Bins(b,o) = spkCnt_Bin;
                                    spksTimes_InBin_rel_samp{b,o} = spkTimesInBin_rel;
                                    spksTimes_InBin_abs_samp{b,o} = spkTimesInBin_abs;
                                    binDur_samp(b, o) = length_this_bin;
                                    
                                    
                                end
                                
                            end
                            spksCnts_Bins_StimVers{p} = spksCnts_Bins;
                            spksTimes_InBin_rel_samp_StimVers{p} = spksTimes_InBin_rel_samp;
                            spksTimes_InBin_abs_samp_StimVers{p} = spksTimes_InBin_abs_samp;
                            binDur_samp_StimVers{p} = binDur_samp;
                        end
                        
                        
                        all_SpksCnts_Bins{thisChan, stim} = spksCnts_Bins_StimVers;
                        all_spksTimes_InBin_rel_samp_StimVers{thisChan, stim} = spksTimes_InBin_rel_samp_StimVers;
                        all_spksTimes_InBin_abs_samp_StimVers{thisChan, stim} = spksTimes_InBin_abs_samp_StimVers;
                        all_binDur_samp_StimVers{thisChan, stim} = binDur_samp_StimVers;
                        
                    else
                        all_SpksCnts_Bins{thisChan, stim} = [];
                        all_spksTimes_InBin_rel_samp_StimVers{thisChan, stim} = [];
                        all_spksTimes_InBin_abs_samp_StimVers{thisChan, stim} = [];
                        all_binDur_samp_StimVers{thisChan, stim} = [];
                        
                    end
                    
                    
                end
            end
            BinnedData.all_SpksCnts_Bins = all_SpksCnts_Bins;
            BinnedData.all_spksTimes_InBin_rel_samp_StimVers = all_spksTimes_InBin_rel_samp_StimVers;
            BinnedData.all_spksTimes_InBin_abs_samp_StimVers = all_spksTimes_InBin_abs_samp_StimVers;
            BinnedData.all_binDur_samp_StimVers = all_binDur_samp_StimVers;
            BinnedData.stimSet = stimSet;
            BinnedData.allStimsNames = allnames;
            BinnedData.binSize_ms = binSize_ms;
            BinnedData.binSize_samp = binSize_samp;
            BinnedData.scanrate = obj.scanrate;
            disp('')
        end
        function BinnedData = binSpikesForSpont(obj, binSize_ms, stimSet)
            
            if nargin <3
                stimSet = obj.TRIGS.INFO.allStims;
            end
            
            stimTRIGS = obj.TRIGS.spontTRIGS;
            
            binSize_samp = floor(binSize_ms/1000*obj.scanrate);
            chans = obj.SPKS.chans;
            
            for j = 1: numel(chans)
                
                thisChan = chans(j);
                
                spkStimInfo_chan = obj.SPKS.spkStimInfo{thisChan};
                spks = obj.SPKS.spks{thisChan};
                
                allStimStarts = []; allStimStops = []; nStimReps = [];
                
                for k = 1: numel(stimSet)
                    stim = stimSet(k);
                    
                    if ismember(stim, spkStimInfo_chan)
                        allStimStarts = [allStimStarts stimTRIGS{stim}.start];
                        allStimStops = [allStimStops stimTRIGS{stim}.stop];
                        nStimReps(k) = numel(stimTRIGS{stim}.start);
                    end
                end
                
                uniqueStims = stimTRIGS{stim}.uniqueStims;
                stimReps = numel(allStimStarts);
                
                spksCnts_Bins_StimVers = [];
                spksTimes_InBin_rel_samp_StimVers = [];
                spksTimes_InBin_abs_samp_StimVers = [];
                binDur_samp_StimVers = [];
                
                for p = 1:uniqueStims
                    
                    spksCnts_Bins = [];
                    spksTimes_InBin_rel_samp = [];
                    spksTimes_InBin_abs_samp = [];
                    binDur_samp = [];
                    
                    for b = 1:stimReps
                        
                        start_stim =  allStimStarts(p, b);
                        stop_stim =  allStimStops(p, b);
                        stimDur_samp = stop_stim -start_stim; % needs to be defined for each new unique stim
                        nBins = ceil(stimDur_samp/binSize_samp);
                        [~, indices_in_same_bin] = histc(1:stimDur_samp, [1:binSize_samp:stimDur_samp+binSize_samp]);
                        
                        cum_spikes = 0;
                        for o = 1: nBins
                            
                            %% Define stimulus onset offset
                            
                            % Map indices in stimulus to time points in stimulus
                            this_data_range = start_stim:stop_stim-1;
                            
                            samples_this_bin = this_data_range(indices_in_same_bin == o);
                            
                            bin_start_samp = samples_this_bin(1);
                            bin_stop_samp = samples_this_bin(end);
                            
                            length_this_bin = bin_stop_samp - bin_start_samp +1; % check to make sure bin length is correct
                            
                            spkTimesInBin_rel = spks(spks >= bin_start_samp & spks <= bin_stop_samp)-bin_start_samp;
                            spkTimesInBin_abs = spks(spks >= bin_start_samp & spks <= bin_stop_samp);
                            
                            %% Binned Spike count used in COV calculations
                            if ~isempty(spkTimesInBin_abs)
                                spkCnt_Bin = numel(spkTimesInBin_abs);
                            else
                                spkCnt_Bin = 0;
                            end
                            
                            % Test to make sure the binned spike counts match the unbinned spike counts
                            cum_spikes = cum_spikes + spkCnt_Bin;
                            
                            % Binned Firing rate statistics
                            spksCnts_Bins(b,o) = spkCnt_Bin;
                            spksTimes_InBin_rel_samp{b,o} = spkTimesInBin_rel;
                            spksTimes_InBin_abs_samp{b,o} = spkTimesInBin_abs;
                            binDur_samp(b, o) = length_this_bin;
                            
                            
                            %chan_BinDuration_s(o, b) = length_this_bin/scanrate_labview;
                            %chan_FiringRatesBins(o, b) = this_spike_count_bin /  chan_BinDuration_s(o, s);
                            
                            %% Used for xCOV calculation
                            %all_spike_count_bins(s, b) = this_spike_count_bin;
                            
                        end
                        
                    end
                    spksCnts_Bins_StimVers{p} = spksCnts_Bins;
                    spksTimes_InBin_rel_samp_StimVers{p} = spksTimes_InBin_rel_samp;
                    spksTimes_InBin_abs_samp_StimVers{p} = spksTimes_InBin_abs_samp;
                    binDur_samp_StimVers{p} = binDur_samp;
                end
                
                all_SpksCnts_Bins{thisChan, 1} = spksCnts_Bins_StimVers;
                all_spksTimes_InBin_rel_samp_StimVers{thisChan, 1} = spksTimes_InBin_rel_samp_StimVers;
                all_spksTimes_InBin_abs_samp_StimVers{thisChan, 1} = spksTimes_InBin_abs_samp_StimVers;
                all_binDur_samp_StimVers{thisChan, 1} = binDur_samp_StimVers;
                
            end
            BinnedData.all_SpksCnts_Bins = all_SpksCnts_Bins;
            BinnedData.all_spksTimes_InBin_rel_samp_StimVers = all_spksTimes_InBin_rel_samp_StimVers;
            BinnedData.all_spksTimes_InBin_abs_samp_StimVers = all_spksTimes_InBin_abs_samp_StimVers;
            BinnedData.all_binDur_samp_StimVers = all_binDur_samp_StimVers;
            BinnedData.stimSet = stimSet;
            BinnedData.allStimsNames = obj.TRIGS.INFO.allStimsNames;
            BinnedData.binSize_ms = binSize_ms;
            BinnedData.binSize_samp = binSize_samp;
            BinnedData.scanrate = obj.scanrate;
        end
        
        function FR = calcFROnBins(obj, BinnedData, stimType, stimSet)
            %2 = spont, 3 = motifs,
            
            %DprimeRange = 3;
            DprimeRange = 5;
            switch stimType
                case 2
                    FigSavePath = [obj.paths.figPath 'Spont-Dprime/'];
                case 3
                    FigSavePath = [obj.paths.figPath 'Motif-Dprime/'];
            end
            
            if exist(FigSavePath, 'dir') == 0
                mkdir(FigSavePath);
            end
            
            all_SpksCnts_Bins = BinnedData.all_SpksCnts_Bins;
            all_binDur_samp_StimVers = BinnedData.all_binDur_samp_StimVers;
            
            binSize_ms = BinnedData.binSize_ms;
            binSize_samp = BinnedData.binSize_samp;
            
            nChansAll = size(all_SpksCnts_Bins, 1);
            
            for j = 1:nChansAll
                thisChan = all_SpksCnts_Bins(j,:);
                thisChan_BinDurations_samp = all_binDur_samp_StimVers(j,:);
                
                % find whch stims are present
                stimsPresent = find(cellfun(@(x) ~isempty(x), thisChan));
                
                if isempty(stimsPresent)
                    continue
                elseif nargin ==4
                    stimsPresent = stimSet;
                end
                
                for k = 1:numel(stimsPresent)
                    thisStimInd = stimsPresent(k);
                    thisStim = thisChan{thisStimInd}{:};
                    thisStim_BinDurations_samp = thisChan_BinDurations_samp{thisStimInd}{:};
                    
                    %Check to make sure last bin is correct length
                    if thisStim_BinDurations_samp(end) ~= binSize_samp
                        nBins = size(thisStim_BinDurations_samp, 2) - 1; % last bin is not complete
                    else
                        nBins = size(thisStim_BinDurations_samp, 2);% last bin is not complete
                    end
                    
                    this_d_prime = [];
                    for p = 1:nBins
                        
                        thisBinA = thisStim(:,p);
                        stdA = std(thisBinA);
                        meanA  = mean(thisBinA);
                        
                        for q = 1:nBins
                            
                            thisBinB = thisStim(:,q);
                            stdB = std(thisBinB);
                            meanB  = mean(thisBinB);
                            this_d_prime(p, q) = 2 * (meanA - meanB) / sqrt(stdA^2 + stdB^2);
                        end
                    end
                    
                    reshapedDPrime = reshape(this_d_prime, 1, numel(this_d_prime));
                    
                    figH = figure(100); clf
                    
                    subplot(2, 1, 1)
                    clims  = [-DprimeRange  DprimeRange ];
                    imagesc(this_d_prime,clims)
                    set(gca,'XMinorTick','on')
                    set(gca,'YMinorTick','on')
                    xlabel('Bin Number')
                    ylabel('Bin Number')
                    colorbar
                    
                    if  stimType == 3
                        title([obj.recordingName ' | ' BinnedData.allStimsNames{thisStimInd} ' | Ch-'  num2str(j) ' | Bin = ' num2str(binSize_ms) 'ms | D-Prime'])
                        figSaveName = [FigSavePath obj.recordingName '_' BinnedData.allStimsNames{thisStimInd} '_Ch-'  num2str(j) '_bin-' num2str(binSize_ms) 'ms_DPrime'];
                    elseif stimType == 2
                        title([obj.recordingName ' | Spont. | Ch-'  num2str(j) ' | Bin = ' num2str(binSize_ms) 'ms | D-Prime'])
                        figSaveName = [FigSavePath obj.recordingName '_Spont_Ch-'  num2str(j) '_bin-' num2str(binSize_ms) 'ms_DPrime'];
                    end
                    
                    %%
                    subplot(2, 1, 2)
                    histBinSize = 0.05;
                    bincenters = -DprimeRange:histBinSize:DprimeRange ;
                    hist(reshapedDPrime, bincenters)
                    axis tight
                    xlim([-DprimeRange DprimeRange ])
                    xlabel('D-Prime')
                    title(['Bin D-Prime, bin width = ' num2str(histBinSize)])
                    kosis = kurtosis(reshapedDPrime);
                    legtxt = ['k = ' num2str(kosis)];
                    legend(legtxt)
                    %% Print
                    figure(figH)
                    
                    disp('Printing Plot')
                    set(0, 'CurrentFigure', figH)
                    
                    export_to = set_export_file_format(4); % 4 (jpeg)
                    plotpos = [0 0 15 12];
                    print_in_A4(0, figSaveName, export_to, 0, plotpos);
                    
                    allReshapedDPrime{thisStimInd, j} = reshapedDPrime;
                    allDPrimes{thisStimInd, j} = this_d_prime;
                    
                end
            end
            
            DPrimes.reshapedDPrime = reshapedDPrime;
            DPrimes.allDPrimes = allDPrimes;
        end
        
        
        %% D Prime
        function DPrimes = calcDPRimesOnBins(obj, BinnedData, stimType, stimSet)
            %2 = spont, 3 = motifs,
            
            %DprimeRange = 3;
            DprimeRange = 5;
            switch stimType
                case 2
                    FigSavePath = [obj.paths.figPath 'Spont-Dprime/'];
                case 3
                    FigSavePath = [obj.paths.figPath 'Motif-Dprime/'];
            end
            
            if exist(FigSavePath, 'dir') == 0
                mkdir(FigSavePath);
            end
            
            all_SpksCnts_Bins = BinnedData.all_SpksCnts_Bins;
            all_binDur_samp_StimVers = BinnedData.all_binDur_samp_StimVers;
            
            binSize_ms = BinnedData.binSize_ms;
            binSize_samp = BinnedData.binSize_samp;
            
            nChansAll = size(all_SpksCnts_Bins, 1);
            
            for j = 1:nChansAll
                thisChan = all_SpksCnts_Bins(j,:);
                thisChan_BinDurations_samp = all_binDur_samp_StimVers(j,:);
                
                % find whch stims are present
                stimsPresent = find(cellfun(@(x) ~isempty(x), thisChan));
                
                if isempty(stimsPresent)
                    continue
                elseif nargin ==4
                    stimsPresent = stimSet;
                end
                
                for k = 1:numel(stimsPresent)
                    thisStimInd = stimsPresent(k);
                    thisStim = thisChan{thisStimInd}{:};
                    thisStim_BinDurations_samp = thisChan_BinDurations_samp{thisStimInd}{:};
                    
                    %Check to make sure last bin is correct length
                    if thisStim_BinDurations_samp(end) ~= binSize_samp
                        nBins = size(thisStim_BinDurations_samp, 2) - 1; % last bin is not complete
                    else
                        nBins = size(thisStim_BinDurations_samp, 2);% last bin is not complete
                    end
                    
                    this_FR = nanmean(thisStim, 2)
                    
                    
                    for p = 1:nBins
                        
                        thisBinA = thisStim(:,p);
                        stdA = std(thisBinA);
                        meanA  = mean(thisBinA);
                        
                        for q = 1:nBins
                            
                            thisBinB = thisStim(:,q);
                            stdB = std(thisBinB);
                            meanB  = mean(thisBinB);
                            this_d_prime(p, q) = 2 * (meanA - meanB) / sqrt(stdA^2 + stdB^2);
                        end
                    end
                    
                    reshapedDPrime = reshape(this_d_prime, 1, numel(this_d_prime));
                    
                    figH = figure(100); clf
                    
                    subplot(2, 1, 1)
                    clims  = [-DprimeRange  DprimeRange ];
                    imagesc(this_d_prime,clims)
                    set(gca,'XMinorTick','on')
                    set(gca,'YMinorTick','on')
                    xlabel('Bin Number')
                    ylabel('Bin Number')
                    colorbar
                    
                    if  stimType == 3
                        title([obj.recordingName ' | ' BinnedData.allStimsNames{thisStimInd} ' | Ch-'  num2str(j) ' | Bin = ' num2str(binSize_ms) 'ms | D-Prime'])
                        figSaveName = [FigSavePath obj.recordingName '_' BinnedData.allStimsNames{thisStimInd} '_Ch-'  num2str(j) '_bin-' num2str(binSize_ms) 'ms_DPrime'];
                    elseif stimType == 2
                        title([obj.recordingName ' | Spont. | Ch-'  num2str(j) ' | Bin = ' num2str(binSize_ms) 'ms | D-Prime'])
                        figSaveName = [FigSavePath obj.recordingName '_Spont_Ch-'  num2str(j) '_bin-' num2str(binSize_ms) 'ms_DPrime'];
                    end
                    
                    %%
                    subplot(2, 1, 2)
                    histBinSize = 0.05;
                    bincenters = -DprimeRange:histBinSize:DprimeRange ;
                    hist(reshapedDPrime, bincenters)
                    axis tight
                    xlim([-DprimeRange DprimeRange ])
                    xlabel('D-Prime')
                    title(['Bin D-Prime, bin width = ' num2str(histBinSize)])
                    kosis = kurtosis(reshapedDPrime);
                    legtxt = ['k = ' num2str(kosis)];
                    legend(legtxt)
                    %% Print
                    figure(figH)
                    
                    disp('Printing Plot')
                    set(0, 'CurrentFigure', figH)
                    
                    export_to = set_export_file_format(4); % 4 (jpeg)
                    plotpos = [0 0 15 12];
                    print_in_A4(0, figSaveName, export_to, 0, plotpos);
                    
                    allReshapedDPrime{thisStimInd, j} = reshapedDPrime;
                    allDPrimes{thisStimInd, j} = this_d_prime;
                    
                end
            end
            
            DPrimes.reshapedDPrime = reshapedDPrime;
            DPrimes.allDPrimes = allDPrimes;
        end
        
        %% function
        
        function CC = calcCCOnBins(obj, BinnedData, stimType, stimSet)
            %2 = spont, 3 = motifs,
            
            if nargin <4
                stimSet = obj.TRIGS.INFO.allStims;
            end
            
            switch stimType
                case 1
                    FigSavePath = [obj.paths.figPath 'Stim-CC/'];
                case 2
                    FigSavePath = [obj.paths.figPath 'Spont-CC/'];
                    stimSet = 1;
                case 3
                    FigSavePath = [obj.paths.figPath 'Motif-CC/'];
            end
            
            if exist(FigSavePath, 'dir') == 0
                mkdir(FigSavePath);
            end
            
            %%
            for s = 1:numel(stimSet)
                if s > numel(BinnedData.stimSet)
                    break
                end
                
                thisStimInd = BinnedData.stimSet(s);
                
                if thisStimInd  == 7 % no CONS
                    continue
                end
                
                
                all_SpksCnts_Bins = BinnedData.all_SpksCnts_Bins;
                all_binDur_samp_StimVers = BinnedData.all_binDur_samp_StimVers;
                
                binSize_ms = BinnedData.binSize_ms;
                binSize_samp = BinnedData.binSize_samp;
                
                nChansAll = size(all_SpksCnts_Bins, 1);
                
                thisChanA_allSpks = []; thisChanA_allSpks_thisStim = [];
                for j = 1:nChansAll
                    thisChanA_allSpks = all_SpksCnts_Bins(j,:);
                    thisChanA_BinDurations_samp = all_binDur_samp_StimVers(j,:);
                    chanA_Name = ['Neuron ' num2str(j)];
                    
                    % find whch stims are present
                    stimsPresentA = find(cellfun(@(x) ~isempty(x), thisChanA_allSpks));
                    
                    if isempty(stimsPresentA)
                        continue
                    elseif nargin ==4
                        stimsPresentA = stimSet;
                    end
                    
                    if ~ismember(thisStimInd, stimsPresentA)
                        continue
                    else
                        
                        thisChanA_allSpks_thisStim = thisChanA_allSpks{thisStimInd}{:};
                        
                        %% Check the number of bins
                        thisStim_BinDurations_samp = thisChanA_BinDurations_samp{thisStimInd}{:};
                        if thisStim_BinDurations_samp(end) ~= binSize_samp
                            nBins = size(thisStim_BinDurations_samp, 2) - 1; % last bin is not complete
                        else
                            nBins = size(thisStim_BinDurations_samp, 2);% last bin is not complete
                        end
                        
                        %% Next channel
                        
                        thisChanB_allSpks = []; thisChanB_allSpks_thisStim = [];
                        for k = 1:nChansAll
                            
                            if j>=k
                                continue
                            end
                            
                            thisChanB_allSpks = all_SpksCnts_Bins(k,:);
                            %thisChanB_BinDurations_samp = all_binDur_samp_StimVers(k,:);
                            %chanB_Name = ['Neuron ' num2str(k)];
                            
                            % find whch stims are present
                            stimsPresentB = find(cellfun(@(x) ~isempty(x), thisChanB_allSpks));
                            
                            if isempty(stimsPresentB)
                                disp('')
                                continue
                            elseif nargin ==4
                                stimsPresentB = stimSet;
                            end
                            
                            if ~ismember(thisStimInd, stimsPresentB)
                                continue
                            else
                                
                                thisChanB_allSpks_thisStim = thisChanB_allSpks{thisStimInd}{:};
                                
                                % check to make sure same num of reps are present
                                
                                if numel(thisChanA_allSpks_thisStim) ~= numel(thisChanB_allSpks_thisStim)
                                    AllRs{j, k} = [];
                                    AllPs{j, k} = [];
                                    continue
                                else
                                    %% Noise Corr Per bin
                                    Rs = [];Ps = [];
                                    for o = 1:nBins
                                        
                                        thisBinA = thisChanA_allSpks_thisStim(:,o);
                                        %stdA = std(thisBinA);
                                        %meanA  = mean(thisBinA);
                                        
                                        thisBinB = thisChanB_allSpks_thisStim(:,o);
                                        %stdB = std(thisBinB);
                                        %meanB  = mean(thisBinB);
                                        
                                        
                                        [R, P] = corrcoef(thisBinA, thisBinB);
                                        
                                        Rs(o) = R(1, 2);
                                        Ps(o) = P(1, 2);
                                    end
                                    %% Print
                                    figH = figure(100); clf
                                    
                                    subplot(2, 1, 1)
                                    timepoints = 1:1:nBins;
                                    
                                    plot(timepoints, smooth(Rs), 'linewidth', 1.5, 'color', 'k')
                                    hold on
                                    %plot(timepointsX, rs, 'marker', 'o', 'linestyle', 'none')
                                    plot(timepoints, Rs, 'marker', 'o')
                                    axis tight
                                    ylim([-1 1])
                                    
                                    set(gca,'XMinorTick','on')
                                    set(gca,'YMinorTick','on')
                                    xlabel('Bin Number')
                                    ylabel('Corr Coef')
                                    
                                    
                                    if  stimType == 3 || stimType == 1
                                        title([obj.recordingName ' | ' BinnedData.allStimsNames{thisStimInd} ' | Ch-'  num2str(j) ' & Ch- ' num2str(num2str(k)) ' | Bin = ' num2str(binSize_ms) 'ms | CorrCoef'])
                                        figSaveName = [FigSavePath obj.recordingName '_' BinnedData.allStimsNames{thisStimInd} '_Ch-'  num2str(j) 'Ch- ' num2str(num2str(k)) ' _bin-' num2str(binSize_ms) 'ms_CC'];
                                    elseif stimType == 2
                                        title([obj.recordingName ' | Spont. | Ch-'  num2str(j) ' & Ch- ' num2str(num2str(k)) ' | Bin = ' num2str(binSize_ms) 'ms | CorrCoef'])
                                        figSaveName = [FigSavePath obj.recordingName '_Spont_Ch-'  num2str(j) 'Ch- ' num2str(num2str(k)) ' _bin-' num2str(binSize_ms) 'ms_CC'];
                                    end
                                    
                                    %%
                                    subplot(2, 1, 2)
                                    histBinSize = 0.02;
                                    bincenters = -1:histBinSize:1 ;
                                    hist(Rs, bincenters)
                                    axis tight
                                    xlim([-1 1 ])
                                    xlabel('Corr Coef')
                                    title(['Corr Coeff, bin width = ' num2str(histBinSize)])
                                    %kosis = kurtosis(reshapedDPrime);
                                    %legtxt = ['k = ' num2str(kosis)];
                                    %legend(legtxt)
                                    %% Print
                                    figure(figH)
                                    
                                    disp('Printing Plot')
                                    set(0, 'CurrentFigure', figH)
                                    
                                    export_to = set_export_file_format(4); % 4 (jpeg)
                                    plotpos = [0 0 15 12];
                                    print_in_A4(0, figSaveName, export_to, 0, plotpos);
                                    disp('')
                                    %%
                                    AllRs{j, k} = Rs;
                                    AllPs{j, k} = Ps;
                                end
                                
                            end
                        end
                    end
                end
                
                allRs_Stims{thisStimInd} = AllRs;
                allPs_Stims{thisStimInd} = AllPs;
            end
            disp('')
            CC.allRs_Stims = allRs_Stims;
            CC.allPs_Stims = allPs_Stims;
        end
        
    end
    
    %%
    methods (Hidden)
        %class constructor
        function obj = birdDataAnalysis(rsc)
            
            if nargin==0
                rsc=[];
            elseif nargin>1
                disp('Object was not constructed since too many parameters were given at construction');
                return;
            end
            
            obj = obj.getSessionInfo(rsc);
            obj = getTriggerInfo(obj);
            obj = getSpikesTimes(obj);
        end
    end
    
    
    
end
