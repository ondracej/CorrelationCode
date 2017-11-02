function [] = filterBasedOnWNComparison_BothStimSpont()

saveText = 'SpontStim';


dbstop if error
switch gethostname
    
    case 'turtle'
        metaFileDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/22-Aug-2016-Stims-Coef/PairwiseOutput/meta/NewMeta/';
        saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/';
        
    case 'deadpool'
        
        metaFileDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/22-Aug-2016-Stims-Coef/PairwiseOutput/meta/NewMeta/';
        saveDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/';
        
end

if exist(saveDir, 'dir') == 0
    mkdir(saveDir);
end


metaFiles = dir([metaFileDir '*.mat']);
nMetaFiles = numel(metaFiles);

%%
for k = 1:nMetaFiles
    
    d = load([metaFileDir metaFiles(k).name]);
    
    meta = d.meta;
    
    bird_name =  meta.bird_name;
    raw_data_filename = meta.raw_data_filename;
    data_number = meta.data_number;
    
    chanNumbers = meta.channel_numbers;
    num_neruons = meta.num_channels;
    
    
    %% Sort out the stims
    
    
    stims_starts = meta.stim_starts;
    song_set_thisRec = find(cellfun(@(x) ~isempty(x), stims_starts));
    stim_stops = meta.stim_stops;
    unique_stims = meta.unique_stims;
    reps = meta.reps;
    scanrate = meta.scanrate;
    
    allSortedStimOnsets = []; allSortedStimOffsets = []; allSortedStimLengths = [];
    allSortedStimOnsets_spont = []; allSortedStimOffsets_spont = []; allSortedStimLengths_spont = [];
    
    spontLengths_s = 1.5;
    %spontLengths_s = 1.0;
    spontLength_samps = spontLengths_s * scanrate;
    
    spontLenthTotalDur_s = 1.0;
    spontLenthTotalDur_samps = spontLenthTotalDur_s * scanrate;
    
    for o = 1:numel(song_set_thisRec);
        
        thisStimStarts = stims_starts{song_set_thisRec(o)};
        thisStimStops = stim_stops{song_set_thisRec(o)};
        thisUniqueStims = unique_stims{song_set_thisRec(o)};
        thisReps = reps{song_set_thisRec(o)};
        
        sortedOnsets_Stim = []; sortedOffsets_Stim = []; stimLengths = [];
        sortedOnsets_Spont = []; sortedOffsets_Spont = []; stimLengths_Spont = [];
        
        for p = 1:thisUniqueStims
            
            i = p;
            
            for s = 1:thisReps
                
                %% Stim
                start_stim = thisStimStarts(i);
                stop_stim = thisStimStops(i);
                length_this_stim = stop_stim-start_stim +1 ;
                
                sortedOnsets_Stim(p, s) = start_stim;
                sortedOffsets_Stim(p, s) = stop_stim;
                stimLengths(p, s) = length_this_stim;
                
                %% Spont
                start_stim_spont = start_stim - spontLength_samps;
                stop_stim_spont = start_stim_spont + spontLenthTotalDur_samps;
                length_this_spont = stop_stim_spont-start_stim_spont+1;
                
                sortedOnsets_Spont(p, s) = start_stim_spont;
                sortedOffsets_Spont(p, s) = stop_stim_spont;
                stimLengths_Spont(p, s) = length_this_spont;
                
                i = i + thisUniqueStims;
            end
        end
        
        allSortedStimOnsets{song_set_thisRec(o)} = sortedOnsets_Stim;
        allSortedStimOffsets{song_set_thisRec(o)} = sortedOffsets_Stim;
        allSortedStimLengths{song_set_thisRec(o)} = stimLengths;
        
        allSortedStimOnsets_spont{song_set_thisRec(o)} = sortedOnsets_Spont;
        allSortedStimOffsets_spont{song_set_thisRec(o)} = sortedOffsets_Spont;
        allSortedStimLengths_spont{song_set_thisRec(o)} = stimLengths_Spont;
        
        
    end
    
    
    critCnt = 1;
    noCritCnt = 1;
    noStimCnt = 1;
    
    
    for j = 1:num_neruons
        
        thisChan = chanNumbers(j);
        
        song_set_thisChanel = find(cellfun(@(x) ~isempty(x), d.meta.individual_neuron_stats(thisChan,:)));
        nStimsPresent = numel(song_set_thisChanel);
        
        theseStims = [];
        for o = 1:nStimsPresent
            if o ==1
                theseStims = [meta.song_type{song_set_thisChanel(o)}];
            else
                theseStims = [theseStims '  ' meta.song_type{song_set_thisChanel(o)}];
            end
            
        end
        
        rawDataChan = meta.database{thisChan,song_set_thisChanel(o)}.rawDataChan;
        spikefile_index = meta.database{thisChan,song_set_thisChanel(o)}.spikefile_index;
        area = meta.database{thisChan,song_set_thisChanel(o)}.putative_area;
        
        %%
        is_duplicate = meta.database{thisChan,song_set_thisChanel(o)}.is_duplicate;
        same_as_ind = meta.database{thisChan,song_set_thisChanel(o)}.same_as_ind;
        crosstalk_from_channel = meta.database{thisChan,song_set_thisChanel(o)}.crosstalk_from_channel;
        notes = meta.database{thisChan,song_set_thisChanel(o)}.notes;
        
        %% Now some stats..
        
        match_WNS = ismember(1, song_set_thisChanel);
        match_WNE = ismember(12, song_set_thisChanel);
        
        if match_WNS && match_WNE
            
            WNSOnsets_Stim = reshape(allSortedStimOnsets{1}, 1, numel(allSortedStimOnsets{1}));
            WNSOffsets_Stim = reshape(allSortedStimOffsets{1}, 1, numel(allSortedStimOnsets{1}));
            
            WNEOnsets_Stim = reshape(allSortedStimOnsets{12}, 1, numel(allSortedStimOnsets{12}));
            WNEOffsets_Stim = reshape(allSortedStimOffsets{12}, 1, numel(allSortedStimOffsets{12}));
            
            WNSOnsets_Spont = reshape(allSortedStimOnsets_spont{1}, 1, numel(allSortedStimOnsets_spont{1}));
            WNSOffsets_Spont = reshape(allSortedStimOffsets_spont{1}, 1, numel(allSortedStimOffsets_spont{1}));
            
            WNEOnsets_Spont = reshape(allSortedStimOnsets_spont{12}, 1, numel(allSortedStimOnsets_spont{12}));
            WNEOffsets_Spont = reshape(allSortedStimOffsets_spont{12}, 1, numel(allSortedStimOffsets_spont{12}));
            
            if k == 83
                spks = meta.allSpikes{1, 6};
            else
                spks = meta.allSpikes{1, thisChan};
            end
            
            nreps = numel(WNSOnsets_Stim);
            
            
            these_spks_on_chan_WSS = []; these_spks_on_chan_WSE = []; stimLength_s = [];
            these_spks_on_chan_WSS_spont = []; these_spks_on_chan_WSE_spont = []; spontLength_s = [];
            for p  = 1:nreps 
                
              these_spks_on_chan_WSS(p) = numel(spks(spks >= WNSOnsets_Stim(p) & spks <= WNSOffsets_Stim(p))-WNSOffsets_Stim(p));  
              these_spks_on_chan_WSE(p) = numel(spks(spks >= WNEOnsets_Stim(p) & spks <= WNEOffsets_Stim(p))-WNEOffsets_Stim(p));  
            
              stimLength_s(p) = (WNSOffsets_Stim(p) - WNSOnsets_Stim(p)) / scanrate;
              
              these_spks_on_chan_WSS_spont(p) = numel(spks(spks >= WNSOnsets_Spont(p) & spks <= WNSOffsets_Spont(p))-WNSOffsets_Spont(p));  
              these_spks_on_chan_WSE_spont(p) = numel(spks(spks >= WNEOnsets_Spont(p) & spks <= WNEOffsets_Spont(p))-WNEOffsets_Spont(p));  
              
              spontLength_s(p) = (WNSOffsets_Spont(p) - WNSOnsets_Spont(p)) / scanrate;
            
            end
            
            FR_WNS_Stim = these_spks_on_chan_WSS./stimLength_s;
            WNS_mean = nanmean(FR_WNS_Stim);
            
            FR_WNE_Stim = these_spks_on_chan_WSE./stimLength_s;
            WNE_mean = nanmean(FR_WNE_Stim);
            
            FR_WNS_Spont = these_spks_on_chan_WSS_spont./spontLength_s;
            WNS_mean_spont = nanmean(FR_WNS_Spont);
            
            FR_WNE_Spont = these_spks_on_chan_WSE_spont./spontLength_s;
            WNE_mean_spont = nanmean(FR_WNE_Spont);
            
            [pspont, sigLevel_spont] = ttest(FR_WNS_Spont, FR_WNE_Spont);
            [p, sigLevel_stim] = ttest(FR_WNS_Stim, FR_WNE_Stim);
                
            
            %% Thes spont here is 1.5 seconds before the onset of the stim...that is why they are equal
            %% We run the frist pass analysis off this 1.5 s
            
            if sigLevel_stim >= 0.01 || sigLevel_spont >= 0.01 % We keep this neuron as non stationary example
                
                % Get all the spike times
                
                spontSpikeTimes = []; stimSpikeTimes = [];
                for o = 1:nStimsPresent
                    
                    spontSpikeTimes{song_set_thisChanel(o)} = meta.individual_neuron_stats{thisChan, song_set_thisChanel(o)}.allSpkTimes_Spont; % This is for 1.5s
                    stimSpikeTimes{song_set_thisChanel(o)} = meta.individual_neuron_stats{thisChan, song_set_thisChanel(o)}.allSpkTimes_Stim;
                end
                
                AllCriteriaMet(k).scanrate = scanrate;
                AllCriteriaMet(k).bird_name = bird_name;
                AllCriteriaMet(k).raw_data_filename = raw_data_filename;
                AllCriteriaMet(k).data_number = data_number;
                
                AllCriteriaMet(k).allSortedStimOnsets = allSortedStimOnsets;
                AllCriteriaMet(k).allSortedStimOffsets = allSortedStimOffsets;
                AllCriteriaMet(k).allSortedStimLengths = allSortedStimLengths;
                
                AllCriteriaMet(k).allSortedStimOnsets_spont = allSortedStimOnsets_spont;
                AllCriteriaMet(k).allSortedStimOffsets_spont = allSortedStimOffsets_spont;
                AllCriteriaMet(k).allSortedStimLengths_spont = allSortedStimLengths_spont;
                
                AllCriteriaMet(k).sigLevel_spont{critCnt} = sigLevel_spont;
                AllCriteriaMet(k).sigLevel_stim{critCnt} = sigLevel_stim;
                
                AllCriteriaMet(k).WN_mean_spont{critCnt} = [WNS_mean_spont WNE_mean_spont];
                AllCriteriaMet(k).WN_mean_stim{critCnt} = [WNS_mean WNE_mean];
                
                AllCriteriaMet(k).allSpikes{critCnt} = meta.individual_neuron_stats{thisChan, song_set_thisChanel(1)}.all_spks;
                AllCriteriaMet(k).allSpikeShapes{critCnt} = meta.allSpikeShapes{1, thisChan};
                
                AllCriteriaMet(k).rawDataChan{critCnt} = rawDataChan;
                AllCriteriaMet(k).spikefile_index{critCnt} = spikefile_index;
                AllCriteriaMet(k).area{critCnt} = area;
                
                AllCriteriaMet(k).is_duplicate{critCnt} = is_duplicate;
                AllCriteriaMet(k).same_as_ind{critCnt} = same_as_ind;
                
                AllCriteriaMet(k).data_file_format{critCnt} = meta.data_file_format;
                AllCriteriaMet(k).soundfile_vers{critCnt} = meta.soundfile_vers;
                
                critCnt = critCnt+1;
                
                
            else %% These are the neurons that are sig diff between WNS and WNE
                
                spontSpikeTimes = []; stimSpikeTimes = [];
                for o = 1:nStimsPresent
                    
                    spontSpikeTimes{song_set_thisChanel(o)} = meta.individual_neuron_stats{thisChan, song_set_thisChanel(o)}.allSpkTimes_Spont; % This is for 1.5s
                    stimSpikeTimes{song_set_thisChanel(o)} = meta.individual_neuron_stats{thisChan, song_set_thisChanel(o)}.allSpkTimes_Stim;
                end
                
                AllCriteriaNOTMet(k).scanrate = scanrate;
                AllCriteriaNOTMet(k).bird_name = bird_name;
                AllCriteriaNOTMet(k).raw_data_filename = raw_data_filename;
                AllCriteriaNOTMet(k).data_number = data_number;
                
                AllCriteriaNOTMet(k).allSortedStimOnsets = allSortedStimOnsets;
                AllCriteriaNOTMet(k).allSortedStimOffsets = allSortedStimOffsets;
                AllCriteriaNOTMet(k).allSortedStimLengths = allSortedStimLengths;
                
                AllCriteriaNOTMet(k).allSortedStimOnsets_spont = allSortedStimOnsets_spont;
                AllCriteriaNOTMet(k).allSortedStimOffsets_spont = allSortedStimOffsets_spont;
                AllCriteriaNOTMet(k).allSortedStimLengths_spont = allSortedStimLengths_spont;
                
                AllCriteriaNOTMet(k).sigLevel_spont{noCritCnt} = sigLevel_spont;
                AllCriteriaNOTMet(k).sigLevel_stim{noCritCnt} = sigLevel_stim;
                
                AllCriteriaNOTMet(k).WN_mean_spont{noCritCnt} = [WNS_mean_spont WNE_mean_spont];
                AllCriteriaNOTMet(k).WN_mean_stim{noCritCnt} = [WNS_mean WNE_mean];
                
                AllCriteriaNOTMet(k).allSpikes{noCritCnt} = meta.individual_neuron_stats{thisChan, song_set_thisChanel(1)}.all_spks;

                if k == 83
                    AllCriteriaNOTMet(k).allSpikeShapes{noCritCnt} = meta.allSpikeShapes{1, 6};
                else
                    AllCriteriaNOTMet(k).allSpikeShapes{noCritCnt} = meta.allSpikeShapes{1, thisChan};
                end
                
                AllCriteriaNOTMet(k).rawDataChan{noCritCnt} = rawDataChan;
                AllCriteriaNOTMet(k).spikefile_index{noCritCnt} = spikefile_index;
                AllCriteriaNOTMet(k).area{noCritCnt} = area;
                
                AllCriteriaNOTMet(k).is_duplicate{noCritCnt} = is_duplicate;
                AllCriteriaNOTMet(k).same_as_ind{noCritCnt} = same_as_ind;
                
                AllCriteriaNOTMet(k).data_file_format{noCritCnt} = meta.data_file_format;
                AllCriteriaNOTMet(k).soundfile_vers{noCritCnt} = meta.soundfile_vers;
                
                
                noCritCnt = noCritCnt+1;
                
            end
            
        else
            
            %% These are all the neurons that do not have WN-S WN-E
            
            spontSpikeTimes = []; stimSpikeTimes = [];
            for o = 1:nStimsPresent
                
                spontSpikeTimes{song_set_thisChanel(o)} = meta.individual_neuron_stats{thisChan, song_set_thisChanel(o)}.allSpkTimes_Spont; % This is for 1.5s
                stimSpikeTimes{song_set_thisChanel(o)} = meta.individual_neuron_stats{thisChan, song_set_thisChanel(o)}.allSpkTimes_Stim;
            end
            
            AllStimsNOTMet(k).scanrate = scanrate;
            AllStimsNOTMet(k).bird_name = bird_name;
            AllStimsNOTMet(k).raw_data_filename = raw_data_filename;
            AllStimsNOTMet(k).data_number = data_number;
            
            AllStimsNOTMet(k).allSortedStimOnsets = allSortedStimOnsets;
            AllStimsNOTMet(k).allSortedStimOffsets = allSortedStimOffsets;
            AllStimsNOTMet(k).allSortedStimLengths = allSortedStimLengths;
            
            AllStimsNOTMet(k).allSortedStimOnsets_spont = allSortedStimOnsets_spont;
            AllStimsNOTMet(k).allSortedStimOffsets_spont = allSortedStimOffsets_spont;
            AllStimsNOTMet(k).allSortedStimLengths_spont = allSortedStimLengths_spont;
            
            AllStimsNOTMet(k).allSpikes{noStimCnt} = meta.individual_neuron_stats{thisChan, song_set_thisChanel(1)}.all_spks;
            AllStimsNOTMet(k).allSpikeShapes{noStimCnt} = meta.allSpikeShapes{1, thisChan};
            
            AllStimsNOTMet(k).rawDataChan{noStimCnt} = rawDataChan;
            AllStimsNOTMet(k).spikefile_index{noStimCnt} = spikefile_index;
            AllStimsNOTMet(k).area{noStimCnt} = area;
            
            AllStimsNOTMet(k).is_duplicate{noStimCnt} = is_duplicate;
            AllStimsNOTMet(k).same_as_ind{noStimCnt} = same_as_ind;
            
            AllStimsNOTMet(k).data_file_format{noStimCnt} = meta.data_file_format;
            AllStimsNOTMet(k).soundfile_vers{noStimCnt} = meta.soundfile_vers;
                
                
            noStimCnt = noStimCnt+1;
            
            
        end
        
    end
    disp('')
end

%% Remove all empty cells

k = {AllCriteriaMet.scanrate};
k1 = cellfun(@(x)x(:).',k,'un',0);
ii = cellfun(@isempty,k1);
notii = ~ii;
idx = find(notii);    % (2)

AllCriteriaMet_Final = AllCriteriaMet(idx);

%%
k = {AllCriteriaNOTMet.scanrate};
k1 = cellfun(@(x)x(:).',k,'un',0);
ii = cellfun(@isempty,k1);
notii = ~ii;
idx = find(notii);    % (2)

AllCriteriaNOTMet_Final = AllCriteriaNOTMet(idx);

%%

k = {AllStimsNOTMet.scanrate};
k1 = cellfun(@(x)x(:).',k,'un',0);
ii = cellfun(@isempty,k1);
notii = ~ii;
idx = find(notii);    % (2)

AllStimsNOTMet_Final = AllStimsNOTMet(idx);

%%

saveNameBase = [saveDir saveText];

save([saveNameBase 'AllCriteriaMet'], 'AllCriteriaMet_Final');
save([saveNameBase 'AllCriteriaNOTMet'], 'AllCriteriaNOTMet_Final');
save([saveNameBase 'AllStimNOTMet'], 'AllStimsNOTMet_Final');


disp('')

end

