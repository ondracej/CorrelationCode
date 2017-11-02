function[] = appendMetaINFO(binSpkCnts_RSC, this_data_info, spks, quad_metafile_name, stim_selected_by_user, z_score_stats, COV_metaINFO, FR_meta, autoCOV, OnOff_params, AnovaStats, RSC, COV_sorted_C_matrix, spikeShapes, BinInfo, COV_or_COH)
%appendMetaINFO(binSpkCnts_RSC, this_data_info, spks, quad_metafile_name, stim_selected_by_user, z_score_stats, COV_metaINFO, FR_meta, autoCOV, OnOff_params, AnovaStats, RSC, COV_sorted_C_matrix, spikeShapes, BinInfo, 1)
%appendMetaINFO(SpikeCounts, this_data_info, stats, spks, quad_metafile_name, neuron_name, stim_selected_by_user, z_score_stats, COV_meta_info, FR_meta, autoCOV, autoCOH, cor_start_stop_params, AnovaStats, SCCs, Binned_Spike_Count_CCs, COV_sorted_C_matrix, C_Matrix_whole_spiketrain, COV_ALL_DIFFS, spikeform_dir, BIN_size, COV_TL_TS_CPlot_Corrs, autoCOV_single)

%% Define some File Info
data_number = this_data_info.data_number;
quad_metafile_name = [quad_metafile_name(1:end-4) '-' this_data_info.raw_file '.mat'];

%% Chekc if a previous file exists, and if so, load it
if exist(quad_metafile_name, 'file') ~= 0
    load(quad_metafile_name)
    prev_entries = find([meta.data_number] == data_number);
    
    if isempty(prev_entries)
        entry_nbr = size(meta, 2) + 1;
    else
        entry_nbr = prev_entries;
    end
else
    entry_nbr = 1;
    disp('Could not a find a previous metafile, making a new one..');
end

%% Check to see if there is data to append
if isempty(COV_metaINFO)
    disp('<<< No meta calculated for this data file - quitting***');
else
    
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% General Bird and File related info
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if entry_nbr == 1 % We only save this info once for the first entry
        
        %% Bird Info
        disp('>> General Info...');
        
        meta(entry_nbr).bird_name = this_data_info.bird_name;
        meta(entry_nbr).birdID = this_data_info.birdID;
        meta(entry_nbr).bird_age = this_data_info.bird_age;
        
        %% Raw Data Info - General
        
        meta(entry_nbr).data_number = data_number;
        meta(entry_nbr).raw_data_filename = this_data_info.raw_file;
        meta(entry_nbr).scanrate = this_data_info.scanrate;
        meta(entry_nbr).data_file_format= this_data_info.data_file_format;
        
        %% Raw Data Info  - Specific
        
        meta(entry_nbr).analysis_type =  OnOff_params.analysis_type;
        
        % Chan Info
        meta(entry_nbr).totalChanNumber =  this_data_info.neuron_chans;
        
        % Spike Info
        meta(entry_nbr).BIN_size_ms = BinInfo.BIN_size_ms;
        meta(entry_nbr).sorted_spk_file = this_data_info.spike_file;
        meta(entry_nbr).allSpikeShapes = spikeShapes.spkforms_this_chan;
        meta(entry_nbr).allSpikes = spikeShapes.spks_on_chan;
        
        % Sound Chan info
        meta(entry_nbr).mic_chan = this_data_info.mic;
        meta(entry_nbr).wav_chan = this_data_info.wav;
        
        % Stim Alignement files
        meta(entry_nbr).bout_startstop_file = this_data_info.BOUT_startstop;
        meta(entry_nbr).motif_startstop_file = this_data_info.MOTIF_startstop;
        meta(entry_nbr).new_motif_startstop_file = this_data_info.NEW_MOTIF_startstop;
        meta(entry_nbr).spont_startstop_file = this_data_info.SPONT_startstop;
        meta(entry_nbr).soundfile_vers = this_data_info.soundfile_vers;
        
        
        
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% overall_neuron_stats
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        disp('>> General Neuron Info...');
        for k = 1:size(this_data_info.chan_info,2)
            this_entry = this_data_info.chan_info(1,k);
            this_chan = this_entry.spikefile_index;
            
            meta(entry_nbr).overall_neuron_stats{this_chan, stim_selected_by_user}.spikefile_index = this_entry.spikefile_index;
            meta(entry_nbr).overall_neuron_stats{this_chan, stim_selected_by_user}.is_duplicate = this_entry.is_duplicate;
            meta(entry_nbr).overall_neuron_stats{this_chan, stim_selected_by_user}.same_as_ind = this_entry.same_as_ind;
            meta(entry_nbr).overall_neuron_stats{this_chan, stim_selected_by_user}.same_as_spike_chan = this_entry.same_as_spike_chan;
            meta(entry_nbr).overall_neuron_stats{this_chan, stim_selected_by_user}.SN_ratio_raw = this_entry.SN_ratio_raw;
            meta(entry_nbr).overall_neuron_stats{this_chan, stim_selected_by_user}.SN_ratio_fil = this_entry.SN_ratio_fil;
            %% Coordinates
            meta(entry_nbr).overall_neuron_stats{this_chan, stim_selected_by_user}.manipulator = this_entry.manipulator;
            meta(entry_nbr).overall_neuron_stats{this_chan, stim_selected_by_user}.ap = this_entry.ap;
            meta(entry_nbr).overall_neuron_stats{this_chan, stim_selected_by_user}.ml = this_entry.ml;
            meta(entry_nbr).overall_neuron_stats{this_chan, stim_selected_by_user}.dv = this_entry.dv;
            
            meta(entry_nbr).overall_neuron_stats{this_chan, stim_selected_by_user}.putative_area = this_entry.putative_area;
            meta(entry_nbr).overall_neuron_stats{this_chan, stim_selected_by_user}.putative_area_num = this_entry.putative_area_num;
        end
        
        
    end
    
    
    %% Now for Stim-specific info
    disp('>> Stim-Specific Info...');
    
    % Chan specific info for this stim
    meta(entry_nbr).channel_numbers =  FR_meta.channel_numbers;
    meta(entry_nbr).num_channels =  FR_meta.num_channels;
    
    % This Stim Onsets and Offsets
    meta(entry_nbr).stim_type{1, stim_selected_by_user} =  OnOff_params.stim_selected;
    if OnOff_params.stim_analysis_type ==5
    meta(entry_nbr).song_type{1, stim_selected_by_user} = OnOff_params.BOUT_song_type;
    else
    meta(entry_nbr).song_type{1, stim_selected_by_user} = OnOff_params.song_type;
    end
    
    meta(entry_nbr).stim_starts{1, stim_selected_by_user} = OnOff_params.stim_start;
    meta(entry_nbr).stim_stops{1, stim_selected_by_user} = OnOff_params.stim_stop;
    
    meta(entry_nbr).unique_stims{1, stim_selected_by_user} = OnOff_params.unique_stims;
    meta(entry_nbr).reps{1, stim_selected_by_user} = OnOff_params.reps;
    
    % Num of chans w spikes for this stim
    channel_numbers = FR_meta.channel_numbers;
    num_channels = FR_meta.num_channels;
    meta(entry_nbr).neuron_chans{1, stim_selected_by_user} = channel_numbers;
    
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% individual_neuron_stats
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    disp('>> Chan Info...');
    for j = 1: size(channel_numbers, 2);
        chan = channel_numbers(j);
        
        %% Firing rates, spike counts, organized spikes
        
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.all_spks = spks(1, chan);
        
        %Stim Evoked
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allChans_FR_vec_Stims = FR_meta.allChans_FR_vec_Stims{1, chan};
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allChans_FR_vec_Stims_reps = FR_meta.allChans_FR_vec_Stims_reps{1, chan};
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allBinnedFiringRates_Stims = FR_meta.allBinnedFiringRates_Stims{1, chan};
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allFiringRates_Stim = FR_meta.allFiringRates_Stim{1, chan};
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allSpkCnts_Stim = FR_meta.allSpkCnts_Stim{1, chan};
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allSpkTimes_Stim = FR_meta.allSpkTimes_Stim{1, chan};
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allBinnedSpkCnts_Stims_forXCOV = FR_meta.allBinnedSpkCnts_Stims_forXCOV{1, chan};
        
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.meanFR_Stim = z_score_stats.meanFR_Stim(1, chan);
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.stdFR_Stim = z_score_stats.stdFR_Stim(1, chan);
    
        if OnOff_params.stim_analysis_type ==5
            % Motifs
            meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allFiringRates_Stim_MOTIF =  FR_meta.allFiringRates_Stim_MOTIF;
            meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allDurations_s_Stim_MOTIF =  FR_meta.allDurations_s_Stim_MOTIF;
            meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allSpkCnts_Stim_MOTIF =  FR_meta.allSpkCnts_Stim_MOTIF;
            meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allSpkTimes_Stim_MOTIF =  FR_meta.allSpkTimes_Stim_MOTIF;
             meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allChans_FR_vec_Stims_MOTIFS =  FR_meta.allChans_FR_vec_Stims_MOTIFS;
        end
        
        % Spont
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allChans_FR_vec_Spont = FR_meta.allChans_FR_vec_Spont{1, chan};
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allChans_FR_vec_Spont_reps = FR_meta.allChans_FR_vec_Spont_reps{1, chan};
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allFiringRates_Spont = FR_meta.allFiringRates_Spont{1, chan};
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allSpkCnts_Spont = FR_meta.allSpkCnts_Spont{1, chan};
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allSpkTimes_Spont = FR_meta.allSpkTimes_Spont{1, chan};
        
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.meanFR_Spont = z_score_stats.meanFR_Spont(1, chan);
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.stdFR_Spont = z_score_stats.stdFR_Spont(1, chan);
        
        %% Z scores, ttests, ranksums to test for FR sig different from baseline
        
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.zscore = z_score_stats.z_score_cov(1, chan);
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.FR_ttest_p = z_score_stats.FR_ttest_p(1, chan);
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.FR_ranksum_p = z_score_stats.FR_RS_p(1, chan);
        
        %% autocovariance
        
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.AutoCov_Y_allReps = autoCOV.Y_allReps{1, chan};
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allReps_mean = autoCOV.allReps_mean(1, chan);
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allReps_median = autoCOV.allReps_median(1, chan);
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.allReps_std = autoCOV.allReps_std(1, chan);
        
        %% Anova test stats
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.Anova_SS = AnovaStats.ss{1, chan};
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.Anova_dfs = AnovaStats.df{1, chan};
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.Anova_MSs = AnovaStats.ms{1, chan};
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.Anova_F_val = AnovaStats.f{1, chan};
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.Anova_P = AnovaStats.P{1, chan};
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.Anova_meanFval = AnovaStats.mean_f(1, chan);
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.Anova_meanP = AnovaStats.mean_P(1, chan);
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.Anova_meanSS = AnovaStats.mean_ss(1, chan);
        
        %% RSC Spikes
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.RSC_Win_s = binSpkCnts_RSC.spikeWindow_RSC_s;
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.RSC_Win_samps = binSpkCnts_RSC.spikeWindow_RSC_samps;
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.RSC_SpkTimes = binSpkCnts_RSC.SpkTimes{chan};
        meta(entry_nbr).individual_neuron_stats{chan, stim_selected_by_user}.RSC_SpkCnt = binSpkCnts_RSC.SpkCnt{chan};
        
        %% Other Database Info
         
        thisChanInfoInd = find([this_data_info.chan_info.spikefile_index] == chan); % need to concatenate to search
        thisChanInfo = this_data_info.chan_info(thisChanInfoInd);
        
        meta(entry_nbr).database{chan, stim_selected_by_user}.rawDataChan = thisChanInfo.channel;
        meta(entry_nbr).database{chan, stim_selected_by_user}.spikefile_index = thisChanInfo.spikefile_index;
        meta(entry_nbr).database{chan, stim_selected_by_user}.is_duplicate = thisChanInfo.is_duplicate;
        meta(entry_nbr).database{chan, stim_selected_by_user}.same_as_ind = thisChanInfo.same_as_ind;
        meta(entry_nbr).database{chan, stim_selected_by_user}.same_as_spike_chan = thisChanInfo.same_as_spike_chan;
        meta(entry_nbr).database{chan, stim_selected_by_user}.crosstalk_from_channel = thisChanInfo.crosstalk_from_channel;
        meta(entry_nbr).database{chan, stim_selected_by_user}.SN_ratio_raw = thisChanInfo.SN_ratio_raw;
        meta(entry_nbr).database{chan, stim_selected_by_user}.SN_ratio_fil = thisChanInfo.SN_ratio_fil;
        meta(entry_nbr).database{chan, stim_selected_by_user}.putative_area = thisChanInfo.putative_area;
        meta(entry_nbr).database{chan, stim_selected_by_user}.putative_area_num = thisChanInfo.putative_area_num;
        meta(entry_nbr).database{chan, stim_selected_by_user}.notes = thisChanInfo.notes;
        
        
    end
    
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Pairwise Comparison Stats
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    % This creates a cell array inside the column which indicates the stimulus
    % number, where each array is a ~ 6x6 cell array, where the rows and
    % column indicate the channel comparison.
    
    disp('>> Pairwise Info...');
    if num_channels <= 1 || isstruct(COV_metaINFO) ~=1
        disp('>>> no pairwise comparisons | only 1 channel, quitting...')
    else
        
        for k = 1: num_channels
            this_chan_1 = channel_numbers(k);
            
            for o = 1 : num_channels
                
                if k >=o
                    continue
                end
                
                this_chan_2 = channel_numbers(o);
                
                if this_chan_1 > size(COV_metaINFO.TL_means, 1) || this_chan_2 > size(COV_metaINFO.TL_means, 2)
                    disp(['>>> this channel combination does not exist | ch-' num2str(this_chan_1) '&' num2str(this_chan_2)])
                    continue
                    
                end
                
                %% RSC - Noise Correlations
                
                if this_chan_2 > size(RSC.rSC, 2) || this_chan_1 > size(RSC.rSC, 1)
                    meta(entry_nbr).RSC_comparison_stats{1, stim_selected_by_user}.RSC_rSC{this_chan_1,this_chan_2} = NaN;
                    meta(entry_nbr).RSC_comparison_stats{1, stim_selected_by_user}.RSC_pSC{this_chan_1,this_chan_2} = NaN;
                else
                    meta(entry_nbr).RSC_comparison_stats{1, stim_selected_by_user}.RSC_rSC{this_chan_1,this_chan_2} = RSC.rSC(this_chan_1, this_chan_2);
                    meta(entry_nbr).RSC_comparison_stats{1, stim_selected_by_user}.RSC_pSC{this_chan_1,this_chan_2} = RSC.pSC(this_chan_1, this_chan_2);
                end
                
                %%
                
                if COV_or_COH == 1
                    calcType  = 'xCOV';
                    
                elseif COV_or_COH == 2
                    calcType  = 'xCOH';
                end
                
                %% xCOV/xCOH calculations
                
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.XCorCalcType = calcType;
                
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TL_reps{this_chan_1,this_chan_2} = COV_sorted_C_matrix.TL{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TS_all_reps{this_chan_1,this_chan_2} = COV_sorted_C_matrix.TS_all{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TS_np1_reps{this_chan_1,this_chan_2} = COV_sorted_C_matrix.TS_np1{this_chan_1, this_chan_2};
                
                %% Means and Medians of reps
                
                %% TL (Signal+Noise)
                
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TL_means{this_chan_1,this_chan_2} = COV_metaINFO.TL_means{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TL_medians{this_chan_1,this_chan_2} = COV_metaINFO.TL_medians{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TL_sems{this_chan_1,this_chan_2} = COV_metaINFO.TL_sems{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TL_stds{this_chan_1,this_chan_2} = COV_metaINFO.TL_stds{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TL_n{this_chan_1,this_chan_2} = COV_metaINFO.n_TL{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TL_n_max{this_chan_1,this_chan_2} = COV_metaINFO.n_TL_max{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TL_reps{this_chan_1,this_chan_2} = COV_metaINFO.all_TL_reps{this_chan_1, this_chan_2};
                
                
                %% TS_all (Signal)
                
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TS_all_means{this_chan_1,this_chan_2} = COV_metaINFO.TS_means{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TS_all_medians{this_chan_1,this_chan_2} = COV_metaINFO.TS_medians{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TS_all_sems{this_chan_1,this_chan_2} = COV_metaINFO.TS_sems{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TS_all_stds{this_chan_1,this_chan_2} = COV_metaINFO.TS_stds{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TS_all_n{this_chan_1,this_chan_2} = COV_metaINFO.n_TS{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TS_all_max{this_chan_1,this_chan_2} = COV_metaINFO.n_TS_max{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TS_all_reps{this_chan_1,this_chan_2} = COV_metaINFO.all_TS_reps{this_chan_1, this_chan_2};
                
                
                %% TS_np (Signal)
                
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TS_np1_means{this_chan_1,this_chan_2} = COV_metaINFO.TS_np1_means{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TS_np1_medians{this_chan_1,this_chan_2} = COV_metaINFO.TS_np1_medians{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TS_np1_sems{this_chan_1,this_chan_2} = COV_metaINFO.TS_np1_sems{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TS_np1_stds{this_chan_1,this_chan_2} = COV_metaINFO.TS_np1_stds{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TS_np1_n{this_chan_1,this_chan_2} = COV_metaINFO.n_TS_np1{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TS_np1_max{this_chan_1,this_chan_2} = COV_metaINFO.n_TS_np1_max{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.TS_np1_reps{this_chan_1,this_chan_2} = COV_metaINFO.all_TS_np1_reps{this_chan_1, this_chan_2};
                
                
                %% Diffs (Noise)
                
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.Diff_TL_TS_all_diff_mean{this_chan_1,this_chan_2} = COV_metaINFO.mean_TL_TS_all_diff{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.Diff_TL_TS_all_diff_median{this_chan_1,this_chan_2} = COV_metaINFO.median_TL_TS_all_diff{this_chan_1, this_chan_2};
                
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.Diff_TL_TS_np1_diff_mean{this_chan_1,this_chan_2} = COV_metaINFO.mean_TL_TS_np1_diff{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.Diff_TL_TS_np1_diff_median{this_chan_1,this_chan_2} = COV_metaINFO.median_TL_TS_np1_diff{this_chan_1, this_chan_2};
                
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.Diff_TL_TS_np1_pairdiff_mean{this_chan_1,this_chan_2} = COV_metaINFO.mean_TL_TSnp1_pairs_diff{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.Diff_TL_TS_np1_pairdiff_median{this_chan_1,this_chan_2} = COV_metaINFO.median_TL_TSnp1_pairs_diff{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.Diff_TL_TS_np1_pairdiff_std{this_chan_1,this_chan_2} = COV_metaINFO.TL_TSnp1_pairs_diff_std{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.Diff_TL_TS_np1_pairdiff_sem{this_chan_1,this_chan_2} = COV_metaINFO.TL_TSnp1_pairs_diff_sem{this_chan_1, this_chan_2};
                meta(entry_nbr).COV_comparison_stats{1, stim_selected_by_user}.Diff_TL_TS_np1_pairdiff_reps{this_chan_1,this_chan_2} = COV_metaINFO.all_DIFFs_TL_TSnp1_pairs{this_chan_1, this_chan_2};
                
            end
        end
        
        save(quad_metafile_name, 'meta', '-v7.3')
        disp('<<< updated metafile');
    end
    
end