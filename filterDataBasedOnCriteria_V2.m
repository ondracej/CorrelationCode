function [] = filterDataBasedOnCriteria_V2(criteria)

runForStimFiles = 1;

dbstop if error
if nargin <1
    
    criteriaDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/Criteria.mat';
    d = load(criteriaDir);
    criteria = d.criteria;
end

%% Unpack Criteria

% Outliers/duplicates
removeOutliers = criteria.removeOutliers;
removeDuplicates = criteria.removeDuplicates;

% Area
sortArea = criteria.sortArea;
selectedAreas = criteria.selectedAreas;
nSelectedAreas = criteria.nSelectedAreas;
AreasSelectedNum = criteria.AreasSelectedNum;

% WN comparison
CompareWN = criteria.CompareWN;
sigLevel = criteria.sigLevel;
WNSel = criteria.WNSel;
WNSel_test = criteria.WNSel_test;

% Stim Set
defStimSet = criteria.defStimSet;
selectedStims = criteria.selectedStims;
nSelectedStims = criteria.nSelectedStims;
selectedStimsNum = criteria.selectedStimsNum;

% D prime
DPrimeRange = criteria.DPrimeRange;
dPrimeStim = criteria.dPrimeStim;
dprimeVal = criteria.dprimeVal;

% DataCutoff
dataCutoff = criteria.dataCutoff;
dataCutoffValue = criteria.dataCutoffValue;

% Data dir
mainDataDir = criteria.mainDataDir;


mainDataDir = criteria.mainDataDir;

[spontDir, stimDir, names_stimMeta, names_spontMeta, num_meta_files]  = findSpontandStimMetaDirs(mainDataDir, runForStimFiles);


  
dbstop if error

%% Directory
today = date;
metaset_save_path = [stimDir today '-Analysis/'];


%%
do_area_selection = sortArea;
areas   = {'-L2a-', 'L2b-', 'L1-', 'L3-', 'HVC-', 'CM-', 'NCM-', 'HCV-Sh-', 'Hipp-'};

%L2b = 2
%L1 = 3
%L3 = 4
%HVC = 5
%CM = 6
%NCM = 7
%HVC-Shelf = 8
%Hippocampus  = 9;

neuron_areas = AreasSelectedNum;
if do_area_selection
    area_text = cell2mat([areas(neuron_areas)]);
    
else
    area_text = '';
end

%% Parameters
do_cutoff = dataCutoff; % Data cutoff
%Cutoff_txt = num2str(data_cutoff);
Cutoff_txt = num2str(dataCutoffValue);
data_cutoff = dataCutoffValue;
kick_out_others = removeOutliers;

%% Parameters to filter the data

BOUT = runForStimFiles;

if BOUT
    stim_type = 'BOUT';
else
    stim_type = 'SPONT';
end

%% compare WNBOF and WNEOF - Decide whether to use the stim-evoked FR or spont FR
compare_WN = CompareWN;

if compare_WN
    WN_set = [1 12];
    stim_or_spont = 1; % (1) stim; (0) spont (2) Both
    fr_or_spk_cnts = 1; % (1) fr; (0) -spk counts
    test_type = 6; %(1)ttest; (2)ranksum; (3)signed rank; (4)anova; (5)kstest2; (6) paired ttest
    sig_level = 0.01;
    
    if stim_or_spont == 1
        sig_text = '-SigStim';
    elseif stim_or_spont == 0
        sig_text = '-SigSpont';
    elseif stim_or_spont == 2
        sig_text = '-SigStimSpont';
    end
    
    if fr_or_spk_cnts ==1
        fr_spks = 'FR';
    else
        fr_spks = 'SpkCnt';
    end
    
else
    sig_text = 'None';
    test_type = 'NaN';
    sig_level = 'NaN';
    fr_spks = 'NaN';
    test_name = 'NoTest';
end

%% Are we running this analysis on COVs or COHs??
COVs_or_COHs = 1;% (1-COVs, 2-COHs)

if COVs_or_COHs == 1
    C_text = 'COV_';
elseif COVs_or_COHs == 2
    C_text = 'COH_';
end

%% Decide whether to sort by z score
sort_by_z = 0;

if sort_by_z
    set_z_max = 15;
    set_z_min = 0;
else
    set_z_max = NaN;
    set_z_min = NaN;
end

%% Stimulus Information

stim_names = {'WNBOF-', 'Pips-', 'Tones-','Stacks-','bla','REV-','CON-','BOS-','qBOS-','bla','bla', 'WNEOF'};
song_set = selectedStimsNum;
song_set_text = cell2mat(stim_names(song_set));

stimset_size = size(song_set, 2);

%% %% Define num of meta files
if exist(metaset_save_path, 'dir') == 0
    mkdir(metaset_save_path);
    disp('Created Meta Data Set Directory.')
end

%meta_file_list = dir(fullfile(metafile_directory, '*.mat'));
%num_meta_files = size(meta_file_list, 1);

%if isempty(num_meta_files)
%    disp('Please check your directory, no metafiles found...')
%end

%% propagate list of metafiles
%for j = 1 : num_meta_files
%    meta_filenames{j} = meta_file_list(j, :).name;
%end

%% zero some variables

scnt = 1;
Comparison_data = [];

abs_id = 0;

habituate = 0;
poking = 0;
keepers = 0;


i_cnt = 1;
cnnt = 0;
%% Start for loop for loading data and extracting info from each meta file therein
for s = 1: num_meta_files
    
    %[file] = cc_loading_order(s);
    [file] = names_stimMeta{s}; 
    
    disp('*******************************************************************************************************************')
    disp('*******************************************************************************************************************')
    
    this_metafile = [stimDir file];
    this_meta = load(this_metafile);
    
    num_files_for_this_bird = size(this_meta.meta, 2);
    
    
    %% First go through the data and get rid of all channel info that does not include data for all the necessary stims..
    potential_chans = [];
    for a = 1:num_files_for_this_bird
        this_data = [];
        how_many_neurons = [];
        
        this_data = this_meta.meta(a);
        how_many_neurons = cellfun(@(x) ~isempty(x), this_data.individual_neuron_stats);
        channel_numbers = [];
        
        if size(how_many_neurons, 2) < song_set(end)
            
            continue
        else
            
            for b = 1: size(how_many_neurons, 1)
                this_chan = b;
                
                
                this_chan_stimset = how_many_neurons(this_chan, :);
                
                if sum(this_chan_stimset) == 0
                    continue
                end
                
                if sum(this_chan_stimset(song_set)) < stimset_size
                    
                    disp([this_data.raw_data_filename '-Chan ' num2str(this_chan) ' does not have data for the stimset selection..'])
                    %this_data.overall_neuron_stats(this_chan,:) = [];
                    %this_data.individual_neuron_stats(this_chan,:) = [];
                    
                else
                    channel_numbers = [channel_numbers this_chan];
                end
                
            end
        end
        %% 'potential_chans' is a cell array that contains the available channels for each of the data files that are present for this bird
        %% We do it like this so that we can easily search for duplicate channels across bird-specific data files
        
        potential_chans{a} = channel_numbers;
        
    end
    
    
    if do_area_selection
        potential_chans_loc  = [];
        this_data = [];
        
        for a = 1:size(potential_chans, 2)
            this_data = this_meta.meta(a);
            these_pot_chans = potential_chans{a};
            checked_channel_numbers = [];
            
            this_overall_neuron_stats = this_data.overall_neuron_stats;
            
            for b = 1:size(these_pot_chans, 2)
                this_chan = these_pot_chans(b);
                
                this_chan_location = this_overall_neuron_stats{this_chan, song_set(1)}.putative_area_num;
                %% check if this neurons area belongs to the eligable neuron areas
                
                if ismember(this_chan_location, neuron_areas)
                    
                    checked_channel_numbers = [checked_channel_numbers this_chan];
                else
                    disp(['This ' this_data.raw_data_filename ' Chan ' num2str(this_chan) ' ' this_overall_neuron_stats{this_chan, song_set(1)}.putative_area ' neuron was deleted..'])
                    
                end
                
            end
            potential_chans_loc{a} = checked_channel_numbers;
        end
        
    else
        
        potential_chans_loc = potential_chans;
    end
    
    
    %% Now we look over all this data and kick out data in which the WN stims are not matched..
    
    this_data = [];
    this_chan = [];
    potential_chans2 = [];
    
    if compare_WN
        
        for a = 1:size(potential_chans, 2)
            this_data = this_meta.meta(a);
            these_pot_chans = potential_chans_loc{a};
            checked_channel_numbers = [];
            
            for b = 1:size(these_pot_chans, 2)
                this_chan = these_pot_chans(b);
                
                if compare_WN && sum(ismember(song_set, WN_set)) ==2
                    
                 
                    if stim_or_spont == 1 % Stim-evoked
                        % We check WNBOF {1} and CON {7} to see if the z score is high enough
                        WNBOF_FRs = this_data.individual_neuron_stats{this_chan,1}.allChans_FR_vec_Stims;
                        WNEOF_FRs = this_data.individual_neuron_stats{this_chan,12}.allChans_FR_vec_Stims;
                        
                        %Means
                        WNBOF_meanFRs = this_data.individual_neuron_stats{this_chan,1}.meanFR_Stim;
                        WNEOF_meanFRs = this_data.individual_neuron_stats{this_chan,12}.meanFR_Stim;
                        
                        %spkcnts
                        %WNBOF_mean_spkcnts = this_data.individual_neuron_stats{this_chan,1}.stim_spike_counts;
                        %WNEOF_mean_spkcnts = this_data.individual_neuron_stats{this_chan,12}.stim_spike_counts;
                        
                    elseif  stim_or_spont == 0 % Spontaneous
                        WNBOF_FRs = this_data.individual_neuron_stats{this_chan,1}.allChans_FR_vec_Spont;
                        WNEOF_FRs= this_data.individual_neuron_stats{this_chan,12}.allChans_FR_vec_Spont;
                        
                        %Means
                        WNBOF_meanFRs = this_data.individual_neuron_stats{this_chan,1}.meanFR_Spont;
                        WNEOF_meanFRs = this_data.individual_neuron_stats{this_chan,12}.meanFR_Spont;
                        
                        %spkcnts
                        %WNBOF_mean_spkcnts = this_data.individual_neuron_stats{this_chan,1}.spont_spike_counts;
                        %WNEOF_mean_spkcnts = this_data.individual_neuron_stats{this_chan,12}.spont_spike_counts;
                        
                    elseif stim_or_spont == 2
                        
                        WNBOF_FRsA = this_data.individual_neuron_stats{this_chan,1}.allChans_FR_vec_Stims;
                        WNEOF_FRsA = this_data.individual_neuron_stats{this_chan,12}.allChans_FR_vec_Stims;
                        
                        WNBOF_FRsB = this_data.individual_neuron_stats{this_chan,1}.allChans_FR_vec_Spont;
                        WNEOF_FRsB = this_data.individual_neuron_stats{this_chan,12}.allChans_FR_vec_Spont;
                        
                        WNBOF_FRs = [WNBOF_FRsA WNBOF_FRsB];
                        WNEOF_FRs = [WNEOF_FRsA WNEOF_FRsB];
                        
                        %Means
                        WNBOF_meanFRs = this_data.individual_neuron_stats{this_chan,1}.meanFR_Spont;
                        WNEOF_meanFRs = this_data.individual_neuron_stats{this_chan,12}.meanFR_Spont;
                        
                        %spkcnts
                        %WNBOF_mean_spkcnts = this_data.individual_neuron_stats{this_chan,1}.spont_spike_counts;
                        %WNEOF_mean_spkcnts = this_data.individual_neuron_stats{this_chan,12}.spont_spike_counts;
                        
                        
                    end
                    
                    if fr_or_spk_cnts
                        WNBOF_FRs = reshape(WNBOF_FRs, numel(WNBOF_FRs), 1);
                        WNEOF_FRs = reshape(WNEOF_FRs, numel(WNEOF_FRs), 1);    
                    else
                        WNBOF_FRs = reshape(WNBOF_mean_spkcnts, numel(WNBOF_mean_spkcnts), 1);
                        WNEOF_FRs = reshape(WNEOF_mean_spkcnts, numel(WNEOF_mean_spkcnts), 1);
                    end
                    
                    %WNBOF_FRs = reshape(WNBOF_FRs, 1, numel(WNBOF_FRs));
                    %WNEOF_FRs = reshape(WNEOF_FRs, 1, numel(WNEOF_FRs));
                    
                    %when h = 0; the FR are not sig different
                    switch test_type
                        case 1
                            [h,p] = ttest2(WNBOF_FRs, WNEOF_FRs);
                            test_name = '-Ttest';
                        case 2
                            [p, h] = ranksum(WNBOF_FRs, WNEOF_FRs);
                            test_name = '-RankS';
                        case 3
                            [p, h] = signrank(WNBOF_FRs, WNEOF_FRs);%when h = 0; the FR are not sig different
                            test_name = '-SignR';
                        case 4
                            anova_test = [WNBOF_FRs WNEOF_FRs];
                            p = anova1(anova_test);
                            test_name = '-Anova';
                        case 5
                            [h, p] = kstest2(WNBOF_FRs, WNEOF_FRs);
                            test_name = '-KStest';
                            
                        case 6
                            [h,p] = ttest(WNBOF_FRs, WNEOF_FRs);
                            test_name = '-PairedTtest';
                            
                    end
                    
                    %%
                    if p >= sig_level
                        checked_channel_numbers = [checked_channel_numbers this_chan];
                        keepers = keepers +1;
                    else
                        if WNBOF_meanFRs > WNEOF_meanFRs
                            habituate = habituate + 1;
                        elseif WNBOF_meanFRs < WNEOF_meanFRs
                            poking = poking + 1;
                        end
                        
                        disp([this_data.raw_data_filename '-CHAN: ' num2str(this_chan) ' **WNBOF and WNEOF firing rates are significantly different: p = ' num2str(p)])
                    end
                    
                elseif compare_WN && sum(ismember(song_set, WN_set)) < 2
                    disp('You have selected to sort based on WN firing rates, but either WNBOF or WNEOF is not part of your stim set')
                    
                end
            end
            potential_chans2{a} =  checked_channel_numbers;
        end
        
    else
        potential_chans2 = potential_chans_loc;
        habituate = [];
        poking = [];
        keepers = [];
    end
    
    %% Sorting by z score
    
    if sort_by_z
        
        this_data = [];
        this_chan = [];
        potential_chans3 = [];
        
        for a = 1: size(potential_chans2, 2)
            this_data = this_meta.meta(a);
            these_pot_chans = potential_chans2{a};
            checked_channel_numbers = [];
            
            for b = 1:size(these_pot_chans, 2)
                this_chan = these_pot_chans(b);
                
                WNBOF_Z = this_data.individual_neuron_stats{this_chan,1}.zscore;
                CON_Z = this_data.individual_neuron_stats{this_chan,7}.zscore;
                
                % We check WNBOF {1} and CON {7} to see if the z score is high enough
                if  WNBOF_Z >= set_z_min &&  WNBOF_Z <= set_z_max || CON_Z >= set_z_min &&  CON_Z <= set_z_max
                    checked_channel_numbers = [checked_channel_numbers this_chan];
                    
                else
                    disp([this_data.raw_data_filename '-CHAN: ' num2str(this_chan) '-zscore WNBOF: ' num2str(WNBOF_Z) ' & zscore CON: ' num2str(CON_Z) ' **Eliminated..**'])
                    
                end
            end
            potential_chans3{a} = checked_channel_numbers;
        end
        
    else
        potential_chans3 = potential_chans2;
        
    end
    
    %% Check for duplicates
    
    
    
    potential_chans4 = [];
    all_duplicate_channels = [];
    all_duplicate_channels_inds = [];
    duplicate_chans_inds = [];
    
    for a = 1:size(potential_chans3, 2)
        this_data = [];
        these_pot_chans = [];
        checked_channel_numbers = [];
        duplicate_chans = [];
        
        these_pot_chans = potential_chans3{a};
        this_data = this_meta.meta(a);
        
        for b = 1:size(these_pot_chans, 2)
            this_chan = [];
            this_chan = these_pot_chans(b);
            meta_info_this_chan = [];
            is_this_chan_a_duplicate = [];
            
            meta_info_this_chan = this_data.overall_neuron_stats{this_chan, song_set(1)};
            is_this_chan_a_duplicate = meta_info_this_chan.is_duplicate;
            
            if is_this_chan_a_duplicate == 0
                
                checked_channel_numbers = [checked_channel_numbers this_chan];
            else
                same_as_inds = [];
                same_as_chan = [];
                curr_index = [];
                
                % Find which indices it might share.
                % is the data recorded on channel 'this_chan' from
                % dataset id 'curr_index' (see below, but independent of
                % loop variable 'b'), found in a different data set
                % (from the same bird)? the relative data set id might be
                % 1:num_files_for_this_bird, and the channel might be
                % different from 'this_chan'.
                
                %% This info is for the datafiles that might be the same as this current data file
                % find in the database entry, which dataset id
                % corresponds to 'curr_index'
                curr_index = this_data.data_number;
                same_as_inds = sort(meta_info_this_chan.same_as_ind(:,:));
                % find the channel number of 'same_as_inds'
                same_as_chan = meta_info_this_chan.same_as_spike_chan;
                
                %% THis is information about the current data file
                % absolute data set number, as defined in
                % 'cc_database_individual_neurons_11'
                
                
                % We have to map back the data index with the number of data files we have already loaded
                ind_differences = [];
                duplicate_inds_in_this_birdfile = [];
                
                % loop over all potential datasets that might contain this
                for x = 1:size(same_as_inds, 1)
                    % difference of absolute indices (for data sets)
                    ind_differences(x) = same_as_inds(x) - curr_index;
                    % relative difference of index numbers - relative to
                    % current, which is defined by 'a'
                    duplicate_inds_in_this_birdfile(x) = a + ind_differences(x);
                end
                
                
                %% So from 'duplicate_inds_in_this_birdfile', we know that 'this_chan' is the same neuron for all these different data files
                %% check whether the duplicate neuron has already been eliminated though one of the previous filters
                this_duplicate_entry = [];
                these_chans_from_pot_duplicate_data = [];
                
                for y = 1: size(duplicate_inds_in_this_birdfile, 2)
                    this_duplicate_ind = duplicate_inds_in_this_birdfile(y);
                    these_chans_from_pot_duplicate_data = potential_chans3{:}(this_duplicate_ind);
                    
                    if ismember(same_as_chan, these_chans_from_pot_duplicate_data)
                        
                        this_duplicate_entry = duplicate_chans_inds{this_duplicate_ind};
                        
                        if isempty(this_duplicate_entry)
                            duplicate_chans_inds{this_duplicate_ind} = this_chan;
                            
                        else
                            duplicate_chans_inds{this_duplicate_ind} = [this_duplicate_entry this_chan];
                        end
                        
                    end
                    
                    
                end
                
                checked_channel_numbers = [checked_channel_numbers this_chan];
                
            end
            
        end
        
        potential_chans4{a} = checked_channel_numbers;
        
    end
    
    all_duplicate_channels = cellfun(@(x) unique(x), duplicate_chans_inds, 'UniformOutput', false);
    
    
    %% Now lets go through the data and collect the calculations
    Final_available_channels = [];
    Final_all_duplicate_channels = [];
    
    for a = 1:size(potential_chans4, 2)
        this_data = this_meta.meta(a);
        these_available_chans = potential_chans4{a};
        
        if size(these_available_chans, 2) <=1
            disp(['There are fewer than 2 pairs left for this data file: ' this_data.raw_data_filename ])
            continue
        end
        
        these_duplicate_chans = all_duplicate_channels{a};
        
        
        for j = 1:size(these_available_chans, 2)
            chan1 = these_available_chans(j);
            
            for k = 1:size(these_available_chans, 2)
                
                if j >= k
                    continue
                end
                
                chan2 = these_available_chans(k);
                
                if do_cutoff
                    
                    WN_comp_stats = eval(['this_data.' C_text 'comparison_stats{1,1};']);
                    CON_comp_stats = eval(['this_data.' C_text 'comparison_stats{1,7};']);
                    
                    %WN_TL_n = eval(['WN_comp_stats.' C_text 'TL_n{chan1,
                    %chan2};']); 
                    %WN_TL_n_Max = eval(['WN_comp_stats.' C_text 'TL_n_max{chan1, chan2};']);
                    
                    WN_TL_n = WN_comp_stats.TL_n{chan1, chan2};
                    WN_TL_n_Max = WN_comp_stats.TL_n_max{chan1, chan2};
                    
                    WN_ratio = WN_TL_n/WN_TL_n_Max;
                    
                    if ~isempty(CON_comp_stats)
                        
                        %CON_TL_n = eval(['CON_comp_stats.' C_text 'TL_n{chan1, chan2};']);
                        %CON_TL_n_Max = eval(['CON_comp_stats.' C_text 'TL_n_max{chan1, chan2};']);
                        CON_TL_n = CON_comp_stats.TL_n{chan1, chan2};
                        CON_TL_n_Max = CON_comp_stats.TL_n_max{chan1, chan2};
                        
                        CON_ratio = CON_TL_n/CON_TL_n_Max;
                        
                    else
                        CON_comp_stats = eval(['this_data.' C_text 'comparison_stats{1,8};']); % Use the BOS instead of CON
                        disp('used BOS for TL/TS ratio')
                        
                        %CON_TL_n = eval(['CON_comp_stats.' C_text 'TL_n{chan1, chan2};']);
                        %CON_TL_n_Max = eval(['CON_comp_stats.' C_text 'TL_n_max{chan1, chan2};']);
                        CON_TL_n = CON_comp_stats.TL_n{chan1, chan2};
                        CON_TL_n_Max = CON_comp_stats.TL_n_max{chan1, chan2};
                        
                        CON_ratio = CON_TL_n/CON_TL_n_Max;
                        
                    end
                    
                    if isempty(WN_ratio)
                        WN_ratio = 0;
                    end
                    
                    if isempty(CON_ratio)
                        CON_ratio = 0;
                    end
                    
                    if WN_ratio < data_cutoff && CON_ratio < data_cutoff
                        disp([this_data.raw_data_filename ': Current Data Cutoff = ' num2str(data_cutoff) ', WN data ratio: ' num2str(WN_ratio) '; CON data ratio: ' num2str(CON_ratio)])
                        data_exclusion = data_exclusion + 1;
                        potential_chans4{a} = [];
                        all_duplicate_channels{a} = [];
                        continue
                    else
                        Final_available_channels{a} = potential_chans4{a};
                        Final_all_duplicate_channels{a} = all_duplicate_channels{a};
                    end
                else
                    Final_available_channels{a} = potential_chans4{a};
                    Final_all_duplicate_channels{a} = all_duplicate_channels{a};
                    
                end
            end
        end
        
    end
    
    
    %% Find all possible neuron pair comparisons
    pairwise_comparisons = [];
    these_pairwise_comparison = [];
    
    for c = 1:size(Final_available_channels, 2)
        these_available_chans = [];
        num_channels = [];
        
        these_available_chans = Final_available_channels{c};
        num_channels = size(these_available_chans, 2);
        
        if num_channels <=1
            %continue
        elseif num_channels == 2
            pairwise_comparisons{c} = these_available_chans;
        elseif num_channels > 2
            cnt = 1;
            
            chan1 = [];
            chan2 = [];
            these_pairwise_comparison = [];
            
            for jj = 1:num_channels
                chan1 = these_available_chans(jj);
                
                for kk = 1:num_channels
                    
                    
                    if jj >= kk
                        continue
                    end
                    chan2 = these_available_chans(kk);
                    
                    these_pairwise_comparison(cnt,:) = [chan1 chan2];
                    
                    cnt = cnt+1;
                end
            end
            
            pairwise_comparisons{c} = these_pairwise_comparison;
            
        end
    end
    
    %% Now do the same thing for the duplicates
    duplicate_comparisons = [];
    these_duplicate_pairwise_comparison = [];
    
    for d = 1:size(Final_all_duplicate_channels, 2)
        
        these_duplicate_chans = Final_all_duplicate_channels{d};
        num_duplicate_channels = size(these_duplicate_chans, 2);
        
        if num_duplicate_channels <= 1
            continue
            
        elseif num_duplicate_channels == 2
            duplicate_comparisons{d} = these_duplicate_chans;
            
        elseif num_duplicate_channels > 2
            cnt = 1;
            
            for jj = 1:num_duplicate_channels
                chan1_dup = these_duplicate_chans(jj);
                
                for kk = 1:num_duplicate_channels
                    
                    if jj >= kk
                        continue
                    end
                    chan2_dup = these_duplicate_chans(kk);
                    
                    these_duplicate_pairwise_comparison(cnt,:) = [chan1_dup chan2_dup];
                    
                    cnt = cnt+1;
                end
            end
            
            duplicate_comparisons{d} = these_duplicate_pairwise_comparison;
            
        end
    end
    
    %% Fixing all the duplicate pairs
    
    new_duplicate_comparisons = pairwise_comparisons;
    all_bird_specific_valid_channel_comparisons = [];
    
    for b = 1: size(duplicate_comparisons, 2)
        
        this_raw_data_file_name = this_meta.meta(b).raw_data_filename;
        % For the b-specific data file, we look and see if the neuron pair
        % 'test_cases_duplicate_pair' exists in another data file
        
        test_cases_duplicate_pair = duplicate_comparisons{b};
        
        if isempty(test_cases_duplicate_pair)
            continue
        else
            
            for q = 1 : size(test_cases_duplicate_pair, 1)
                
                this_test_case = test_cases_duplicate_pair(q, :);
                
                
                matching_indeces = cellfun(@(x) sum(ismember(this_test_case, x)), duplicate_comparisons);
                dupl_inds = find(matching_indeces ==2);
                
                
                
                if size(dupl_inds, 2) > 1
                    
                    bla = find(dupl_inds ~= b);
                    
                    for h = 1:size(bla, 2)
                        thisone = dupl_inds(bla(h));
                        
                        if thisone > b
                            
                            if size(new_duplicate_comparisons{thisone}, 1) == 1
                                disp(['duplicate pair eliminated (it shows up on a different file): ' this_raw_data_file_name ' Pair ' num2str(new_duplicate_comparisons{thisone})]);
                                new_duplicate_comparisons{thisone} = [];
                                
                                break
                                %double_check_duplicate_chans{thisone} =  this_test_case;
                                
                            elseif size(new_duplicate_comparisons{thisone}, 1) > 1
                                
                                this_problem = new_duplicate_comparisons{thisone};
                                
                                for p = 1: size(this_problem, 1)
                                    
                                    thispart = this_problem(p,:);
                                    
                                    if sum(thispart == this_test_case) == 2
                                        this_problem(p,:) = [];
                                        disp(['duplicate pair eliminated (it shows up on a different file): ' this_raw_data_file_name ' Pair ' num2str(thispart)]);
                                        % we break because there should only be one
                                        % match for the test case
                                        break
                                        
                                    end
                                    
                                end
                                
                                new_duplicate_comparisons{thisone} = this_problem;
                                
                            end
                        end
                    end
                end
                
            end
        end
    end
    
    all_bird_specific_valid_channel_comparisons = new_duplicate_comparisons;
    
    
    %% This first part goes through the data files and finds channels that contain all the necessary stims and high enough z scores
    
    
    for q = 1:size(all_bird_specific_valid_channel_comparisons, 2)
        this_data = [];
        these_valid_channel_comparisons = [];
        
        this_data = this_meta.meta(q);
        these_valid_channel_comparisons = all_bird_specific_valid_channel_comparisons{q};
        
        %%  %% Here we kick out specific outlier pairs, weird neurons (eg, k18r2, ch 5 & 7)
        if kick_out_others;
            if s == 5 && this_data.data_number == 17 || this_data.data_number == 18
                
                for ff = 1:size(these_valid_channel_comparisons, 1)
                    
                    this_comparison = these_valid_channel_comparisons(ff,:);
                    
                    if ismember(5, this_comparison) && ismember(7, this_comparison)
                        these_valid_channel_comparisons(ff,:) = [];
                        all_bird_specific_valid_channel_comparisons{q} = [];
                        
                        disp(['** Eliminated problematic pair: ' this_data.raw_data_filename ', chan ' num2str(this_comparison(1)) ' & chan ' num2str(this_comparison(2)) '**' ]);
                        continue
                    end
                end
            end
        end
        
        
        for w = 1: size(these_valid_channel_comparisons, 1)
            
            chan1 = [];
            chan2 = [];
            
            if w > size(these_valid_channel_comparisons, 1)
                this_chan_comparison = these_valid_channel_comparisons(w-1, :);
            else
                this_chan_comparison = these_valid_channel_comparisons(w, :);
            end
            
            %% check to make sure this comparison really exists
            
            chan1 = this_chan_comparison(1);
            chan2 = this_chan_comparison(2);
            
            %% check to make sure this comparison really exists
            
            if isempty(this_data.COV_comparison_stats{1, song_set(1)}.TL_n{chan1,chan2})
                
                disp('There are no TL reps for this comparison, skipping')
                these_valid_channel_comparisons(w, :) = [];
                
                all_bird_specific_valid_channel_comparisons{q} = these_valid_channel_comparisons;
                
                continue
            end
            
            
            
            
            %% Here is where it really starts
            cnnt = cnnt +1;
            
            all_comparisons(cnnt,:) = this_chan_comparison;
            which_raw_data_file{cnnt,:} = this_data.raw_data_filename;
            
            disp('')
            for a = 1: stimset_size
                f = song_set(a);
                All_comp_stats = [];
                
                switch f
                    case 1
                        song = 1;
                        song_name = 'WN BOF';
                        
                    case 4
                        song = 4;
                        song_name = 'Stacks';
                        
                    case 6
                        song = 6;
                        song_name = 'REV';
                        
                    case 7
                        song = 7;
                        song_name = 'CON';
                        
                    case 8
                        song = 8;
                        song_name = 'BOS';
                        
                    case 9
                        song = 9;
                        song_name = 'qBOS';
                        
                    case 12
                        song = 12;
                        song_name = 'WN EOF';
                        
                end
                
                %%
                comp_stats = [];
                comp_stats = eval(['this_data.' C_text 'comparison_stats{1,song};']);
                RSC_comparison_stats = this_data.RSC_comparison_stats{1,song};
                
                if isempty(comp_stats)
                    continue
                end
                
                %% Scalar Values
                %% Spike count correlations - Whole Stims
                
                Comparison_data{1,song}.RSC_rSC(cnnt) = RSC_comparison_stats.RSC_rSC{chan1,chan2};
                Comparison_data{1,song}.RSC_pSC(cnnt) = RSC_comparison_stats.RSC_pSC{chan1,chan2};
             
                %% Ns of TLs,TSs
                
                Comparison_data{1,song}.TL_n(cnnt) =  comp_stats.TL_n{chan1,chan2};
                Comparison_data{1,song}.TL_n_max(cnnt) =  comp_stats.TL_n_max{chan1,chan2};
               
                Comparison_data{1,song}.TS_all_n(cnnt) =  comp_stats.TS_all_n{chan1,chan2};
                Comparison_data{1,song}.TS_all_max(cnnt) =  comp_stats.TS_all_max{chan1,chan2};
               
                Comparison_data{1,song}.TS_np1_n(cnnt) =  comp_stats.TS_np1_n{chan1,chan2};
                Comparison_data{1,song}.TS_np1_max(cnnt) =  comp_stats.TS_np1_max{chan1,chan2};
               
                %% Vectors
                %% TL Means and Medians
               
                Comparison_data{1,song}.TL_means(cnnt,:) = comp_stats.TL_means{chan1,chan2};
                Comparison_data{1,song}.TL_medians(cnnt,:) = comp_stats.TL_medians{chan1,chan2};
                Comparison_data{1,song}.TL_sems(cnnt,:) = comp_stats.TL_sems{chan1,chan2};
                
                Comparison_data{1,song}.TS_all_means(cnnt,:) = comp_stats.TS_all_means{chan1,chan2};
                Comparison_data{1,song}.TS_all_medians(cnnt,:) = comp_stats.TS_all_medians{chan1,chan2};
                Comparison_data{1,song}.TS_all_sems(cnnt,:) = comp_stats.TS_all_sems{chan1,chan2};

                Comparison_data{1,song}.TS_np1_means(cnnt,:) = comp_stats.TS_np1_means{chan1,chan2};
                Comparison_data{1,song}.TS_np1_medians(cnnt,:) = comp_stats.TS_np1_medians{chan1,chan2};
                Comparison_data{1,song}.TS_np1_sems(cnnt,:) = comp_stats.TS_np1_sems{chan1,chan2};
                
                Comparison_data{1,song}.Diff_TL_TS_np1_pairdiff_mean(cnnt,:) = comp_stats.Diff_TL_TS_np1_pairdiff_mean{chan1,chan2};
                    Comparison_data{1,song}.Diff_TL_TS_np1_pairdiff_median(cnnt,:) = comp_stats.Diff_TL_TS_np1_pairdiff_median{chan1,chan2};
                    Comparison_data{1,song}.Diff_TL_TS_np1_pairdiff_sem(cnnt,:) = comp_stats.Diff_TL_TS_np1_pairdiff_sem{chan1,chan2};
                    
            
                %% All reps
                %{
                    All_REPS{1,song}.COV_all_TL_reps{cnnt, 1} = comp_stats.COV_all_TL_reps{chan1,chan2};
                    All_REPS{1,song}.COV_all_TS_reps{cnnt, 1} = comp_stats.COV_all_TS_reps{chan1,chan2};
                    All_REPS{1,song}.COV_all_TS_np1_reps{cnnt, 1} = comp_stats.COV_all_TS_np1_reps{chan1,chan2};
                %}
                
                All_REPS{1,song}.TL_reps{cnnt, 1} = comp_stats.TL_reps{chan1,chan2};
                All_REPS{1,song}.TS_all_reps{cnnt, 1} = comp_stats.TS_all_reps{chan1,chan2};
                All_REPS{1,song}.TS_np1_reps{cnnt, 1} = comp_stats.TS_np1_reps{chan1,chan2};
                All_REPS{1,song}.Diff_TL_TS_np1_pairdiff_reps{cnnt, 1} = comp_stats.Diff_TL_TS_np1_pairdiff_reps{chan1,chan2};
              
                %% Data Plotted in CalcCorr figures
              
                %{
                %% Diffs
                if bout_or_spont == 1 && song ~= 7 || bout_or_spont == 0
                
                  
                   
                else
                 
                    
                    %% Mean and Median differences
                    
                    eval(['Comparison_data{1,song}.' C_text 'Diff_meanTL_minus_meanTS(cnnt,:) = NaN;']);
                    eval(['Comparison_data{1,song}.' C_text 'Diff_meanTL_minus_meanTS_np1(cnnt,:) = NaN;']);
                    
                    eval(['Comparison_data{1,song}.' C_text 'Diff_medianTL_minus_medianTS(cnnt,:) = NaN;']);
                    eval(['Comparison_data{1,song}.' C_text 'Diff_medianTL_minus_medianTS_np1(cnnt,:) = NaN;']);
                    
                    %% Mean and median differences - plotted data
                    
                    eval(['Comparison_data{1,song}.' C_text 'Diff_meanTL_minus_meanTS_plotted_data(cnnt,:) = NaN;']);
                    eval(['Comparison_data{1,song}.' C_text 'Diff_medianTL_minus_medianTS_plotted_data(cnnt,:) = NaN;']);
                    
                    %% Differences calculated by subtracting all TS n+1 from all TL repetitions
                    
                    % all reps
                    eval(['Comparison_data{1,song}.' C_text 'Diff_all_TL_minus_TS_np1_diffs{cnnt, 1} = NaN;']);
                    eval(['Comparison_data{1,song}.' C_text 'Diff_SEM_all_TL_minus_TS_np1_diffs{cnnt, 1} = NaN;']);
                    
                    % Means & medians
                    eval(['Comparison_data{1,song}.' C_text 'Diff_all_TL_minus_all_TS_np1_mean(cnnt,:) = NaN;']);
                    eval(['Comparison_data{1,song}.' C_text 'Diff_all_TL_minus_all_TS_np1_median(cnnt,:) = NaN;']);
                    
                    %% Mean and median differences - plotted data
                    
                    eval(['Comparison_data{1,song}.' C_text 'Diff_all_TL_minus_all_TS_np1_plotted_data_mean(cnnt,:) = NaN;']);
                    eval(['Comparison_data{1,song}.' C_text 'Diff_all_TL_minus_all_TS_np1_plotted_data_median(cnnt,:) = NaN;']);
                    
                end
           %}
            end
        end
    end
    
    Final_all_unique_neuron_chans = [];
    all_unique_neuron_chans = [];
    
    %% propagate the list of all unique neurons  - including duplicates
    for q = 1:size(all_bird_specific_valid_channel_comparisons, 2)
        these_valid_channel_comparisons = all_bird_specific_valid_channel_comparisons{q};
        all_unique_neuron_chans{q} = unique(these_valid_channel_comparisons);
    end
    
    Final_all_unique_neuron_chans = all_unique_neuron_chans;
    
    for q = 1:size(all_bird_specific_valid_channel_comparisons, 2)
        duplicate_chans_on_this_file = Final_all_duplicate_channels{q};
        
        if ~isempty(duplicate_chans_on_this_file)
            
            this_data = this_meta.meta(q);
            overall_neuron_stats = this_data.overall_neuron_stats;
            current_data_index = this_data.data_number;
            
            for v = 1: size(duplicate_chans_on_this_file, 2)
                
                duplicate_neuron_chan = duplicate_chans_on_this_file(v);
                duplicate_neuron_info = overall_neuron_stats{duplicate_neuron_chan, song_set(1)};
                
                other_duplicate_inds = duplicate_neuron_info.same_as_ind;
                
                for h = 1: size(other_duplicate_inds, 1)
                    this_index = other_duplicate_inds(h);
                    
                    if this_index < current_data_index
                        disp('keeping this first duplicate')
                        continue
                    end
                    
                    relative_indeces = other_duplicate_inds - current_data_index + q;
                    
                    
                    %relative_indeces = find([this_meta.meta.data_number] == other_duplicate_inds);
                    
                    if size(Final_all_unique_neuron_chans, 2) < relative_indeces
                        continue
                    else
                        
                        for g = 1: size(relative_indeces, 2)
                            
                            this_relative_index = relative_indeces(g);
                            
                            if this_relative_index < current_data_index
                                disp('keeping this first duplicate')
                                continue
                            end
                            
                            
                            data_channels_to_check = Final_all_unique_neuron_chans{this_relative_index};
                            
                            if ismember(duplicate_neuron_chan, data_channels_to_check)
                                ind_to_delete = find(data_channels_to_check == duplicate_neuron_chan);
                                
                                disp(['duplicate neuron eliminated (included in a previous file): '  this_meta.meta(this_relative_index).raw_data_filename ' chan ' num2str(data_channels_to_check(ind_to_delete)) ]);
                                data_channels_to_check(ind_to_delete) = [];
                                
                                
                                Final_all_unique_neuron_chans{this_relative_index} = data_channels_to_check;
                                disp('')
                            end
                        end
                    end
                end
            end
        end
    end
    
    
    these_raw_data_files = [];
    
    %% Individual data
    for o = 1: size(Final_all_unique_neuron_chans, 2)
        this_data = this_meta.meta(o);
        this_overall_data = this_data.overall_neuron_stats;
        this_individual_data = this_data.individual_neuron_stats;
        
        these_valid_chans = Final_all_unique_neuron_chans{o};
        these_raw_data_files{o} = this_data.raw_data_filename;
        
        if size(these_valid_chans, 1) > 1
        these_valid_chans = these_valid_chans';
        end
        
        
        
        for e = 1:size(these_valid_chans, 2)
            
            Individual_data(i_cnt,:) = this_individual_data(these_valid_chans(e), 1:song_set(end));
            Overall_data(i_cnt,:) = this_overall_data(these_valid_chans(e),song_set(1));
            
            Individual_chans_cnt(i_cnt,:) = these_valid_chans(e);
            Individual_chans_raw_data_file_cnt{i_cnt,:} = this_data.raw_data_filename;
            
            i_cnt = i_cnt +1;
            
        end
        
    end
    
    SongSet_stats.all_valid_chan_comparisons{s} = all_bird_specific_valid_channel_comparisons;
    SongSet_stats.all_unique_neurons{s} = Final_all_unique_neuron_chans;
    SongSet_stats.bird_name{s} = this_meta.meta(1,1).bird_name;
    SongSet_stats.bird_age{s} = this_meta.meta(1,1).bird_age;
    SongSet_stats.raw_data_files{s} = these_raw_data_files;
    
    
    
end
SongSet_stats.all_comparisons_cnnt = all_comparisons;
SongSet_stats.all_raw_data_files_comparison_cnnt = which_raw_data_file;
SongSet_stats.Individual_chans_cnt = Individual_chans_cnt;
SongSet_stats.Individual_chans_raw_data_file_cnt = Individual_chans_raw_data_file_cnt;

SongSet_stats.number_of_pairs = eval(['size(Comparison_data{1, song_set(1)}.' C_text 'TL_means, 1);']);
SongSet_stats.number_of_neurons = size(Individual_data, 1);
SongSet_stats.bin_size = this_meta.meta(1,1).BIN_size;

disp('******************************')
disp(['Total number of cells: ' num2str(SongSet_stats.number_of_neurons)]);
disp(['Total number of pairs: ' num2str(SongSet_stats.number_of_pairs)]);
disp('******************************')

disp('')

SongSet_stats.song_set = song_set;
SongSet_stats.song_set_text = song_set_text;
SongSet_stats.zscore_max = set_z_max;
SongSet_stats.zscore_min = set_z_min;
SongSet_stats.habituate = habituate;
SongSet_stats.poking = poking;
SongSet_stats.keepers = keepers;
SongSet_stats.area_text = area_text;
SongSet_stats.neuron_areas = neuron_areas;

%%
data_name = [C_text stim_type '--Pairs-' num2str(SongSet_stats.number_of_pairs) '-Neurons---' num2str(SongSet_stats.number_of_neurons) fr_spks test_name sig_text 'sig-' num2str(sig_level) '- ' song_set_text '--Zsort-' num2str(set_z_min) 'to' num2str(set_z_max) '--DataCutoff-' Cutoff_txt '--BinSize-' num2str(SongSet_stats.bin_size) area_text];

%%
short_filename = [metaset_save_path data_name '.mat'];
disp('starting to save...')
save(short_filename, 'SongSet_stats', 'Comparison_data', 'Individual_data', 'Overall_data', 'All_REPS', '-v7.3')
disp(['saved file: ' short_filename])
    end


function [spontMetaDir, stimMetaDir, names_stimMetaSorted, names_spontMetaSorted, n_stimMeta]  = findSpontandStimMetaDirs(mainDataDir, runForStimFiles)
dirD = '/';

if runForStimFiles
    
    stimDirSearch = dir(fullfile(mainDataDir, '*Stims*'));
    stimDir =  [mainDataDir stimDirSearch.name dirD];
    stimMetaDir = [stimDir '/PairwiseOutput/meta/NewMeta/']; % we calculate d prime scores, hence the 'newmeta' dir
    stimMetaFiles = dir(fullfile(stimMetaDir, '*.mat*'));
    
    n_stimMeta = numel(stimMetaFiles);
    % Now we find all the date directory names
    for j = 1: n_stimMeta
        names_stimMeta{j} = stimMetaFiles(j).name;
    end
    
    [names_stimMetaSorted,~] = sort(names_stimMeta);
    
    spontMetaDir = [];
    names_spontMetaSorted = [];
else
    
    spontDirSearch = dir(fullfile(mainDataDir, '*Spont*'));
    spontDir =  [mainDataDir spontDirSearch.name dirD];
    
    %% Find n meta files in each dir
    
    
    spontMetaDir = [spontDir '/PairwiseOutput/meta/']; % no dprime scores calculated, all data in 'meta'
    spontMetaFiles = dir(fullfile(spontMetaDir, '*.mat*'));
    
    if numel(stimMetaFiles) ~= numel(spontMetaFiles)
        disp('*********************************************************')
        disp('Unequal numbers of spont and stim meta files, quitting...')
        disp('*********************************************************')
        keyboard
    end
    
    n_spontMeta = numel(spontMetaFiles);
    
    % Now we find all the date directory names
    for j = 1: n_spontMeta
        names_spontMeta{j} = spontMetaFiles(j).name;
    end
    
    [names_spontMetaSorted,~] = sort(names_spontMeta);
end



end


