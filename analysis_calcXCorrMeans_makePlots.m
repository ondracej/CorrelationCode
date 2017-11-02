function[metaINFO] = analysis_calcXCorrMeans_makePlots(COV_or_COH, binSpkCnts_RSC, FR_meta, COV_sorted_C_matrix, Lags, allDirPaths, OnOff_params, raw_data_info, RSC, z_score_stats, AnovaStats, autoCOV, print_params, stim_selected_by_user, Plot_other_figs, BinInfo)

%[meta_info, ALL_DIFFS, ALL_TL_TS_CPlot_Corrs] =  analysis_calcXCorrMeans_makePlots(COV_or_COH, Binned_Spike_Count_CCs, FR_meta, sorted_C_matrix, C_Matrix_whole_spiketrain, Lags, cor_paths, cor_start_stop_params, raw_data_info, stim_analysis_type, stats, stim_cor_cofs, z_score_stats,AnovaStats, autoCOV, autoCOH, print_params, stim_selected_by_user, BIN_size_text, really_plot, BIN_size_ms)

dbstop if error
if OnOff_params.stim_analysis_type ==5
song_type = OnOff_params.BOUT_song_type;
else
    song_type = OnOff_params.song_type;
end
%% These are the functions calculated from each individual repetition
sorted_C_matrix_TL = COV_sorted_C_matrix.TL;
sorted_C_matrix_TS = COV_sorted_C_matrix.TS_all;
sorted_C_matrix_TS_np1 = COV_sorted_C_matrix.TS_np1;

%% Check to make sure pairwise comparisons are present
% These cases really shouldnt happen..
comparisons_present = cellfun(@(x) ~isempty(x), sorted_C_matrix_TL);

if comparisons_present == 0
    disp('There are not enough data on any of the channels to make comparisons. Quitting.')
    keyboard
    metaINFO = [];
    return
end

%
if sum(sum(cellfun(@(x) isempty(x), sorted_C_matrix_TL))) == numel(sorted_C_matrix_TL)
    
    metaINFO = [];
    disp('<<< There is no data here, quitting... >>>')
    keyboard
else
    
    %% These are the functions calculated from all of the repetitions stitched together into one binned vector
    switch COV_or_COH
        case 1
            bird_corr_dir = allDirPaths.corr_COV_dir;
            calc_type_save_name = 'COV';
            
        case 2
            bird_corr_dir = allDirPaths.corr_COH_dir;
            calc_type_save_name = 'COH';
    end
    
    %% Unpacking variables
    
    channel_numbers = FR_meta.channel_numbers;
    num_channels = FR_meta.num_channels;
    
    %% stimulus info
    
    unique_stims = OnOff_params.unique_stims;
    
    analysis_type = OnOff_params.analysis_type;
    
    %% Lags
    max_lag_bins = Lags.max_lag_bins;
    
    x_time = -max_lag_bins:max_lag_bins;
    
    %% saving info
    print_format = print_params.print_format;
    export_to = set_export_file_format(print_format);
    recording_session = raw_data_info.recording_session;
    
    %% Define the channel comparison and get channel-specific stats
    
    for n = 1 : num_channels
        this_chan1 = channel_numbers(n);
        
        if this_chan1 > size(sorted_C_matrix_TL, 1) % how does this happen?
            continue
        end
        
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% First we extract some statistics on the individual channels
        
        [chan1_stats] = analysis_extractIndividualChanStats(this_chan1, z_score_stats, AnovaStats, autoCOV, stim_selected_by_user);
        
        for m = 1 :num_channels
            
            if n >= m % We don't need to look at identical channels
                continue
            end
            
            this_chan2 = channel_numbers(m);
            
            if this_chan2 > size(sorted_C_matrix_TL, 2)
                continue
            end
            
            [chan2_stats] = analysis_extractIndividualChanStats(this_chan2, z_score_stats, AnovaStats, autoCOV, stim_selected_by_user);
            
            %% File name
            
            save_name = [bird_corr_dir recording_session '_' calc_type_save_name '_' song_type '_Ch-' chan1_stats.chan_txt '-' chan2_stats.chan_txt '_' analysis_type '_' calc_type_save_name];
            title_name = [recording_session ' | ' calc_type_save_name  ' Calculation | Ch-' chan1_stats.chan_txt ' & Ch-' chan2_stats.chan_txt ' | '  song_type];
            
            %% get info about the channel pair
            
            %% check if it exists
            
            test = sorted_C_matrix_TL{this_chan1, this_chan2};
            
            if isempty(test)
                continue
            end
            
            if OnOff_params.stim_analysis_type == 5  && OnOff_params.stim_selected ~=7 % BOS, REV Motifs
%                 chans_TL = sorted_C_matrix_TL{this_chan1, this_chan2}{:,:};
%                 chans_TS_all = sorted_C_matrix_TS{this_chan1, this_chan2}{:,:};
%                 chans_TS_np1 = sorted_C_matrix_TS_np1{this_chan1, this_chan2}{:,:};
%                 
                
                  chans_TL = sorted_C_matrix_TL{this_chan1, this_chan2};
                chans_TS_all = sorted_C_matrix_TS{this_chan1, this_chan2};
                chans_TS_np1 = sorted_C_matrix_TS_np1{this_chan1, this_chan2};
            else % Full stims
                chans_TL = sorted_C_matrix_TL{this_chan1, this_chan2};
                chans_TS_all = sorted_C_matrix_TS{this_chan1, this_chan2};
                chans_TS_np1 = sorted_C_matrix_TS_np1{this_chan1, this_chan2};
            end
            
%             if OnOff_params.stim_analysis_type == 5 % BOS, REV Motifs
%                 if sum(cellfun(@(x) isempty(x), chans_TL)) == numel(chans_TL)
%                     continue
%                 end
%             else
%                 if isempty(chans_TL)
%                     continue
%                 end
%                 
%             end
            
            %% Mean and Median COV/COH Calculations per channel pair
            
            if OnOff_params.stim_analysis_type == 5 && OnOff_params.stim_selected ==7 % CON Motifs
                [TL_Calcs, TS_all_Calcs, TS_np1_Calcs, Diff_Calcs] = cc_do_calculations_motifs(unique_stims, chans_TL, chans_TS_all, chans_TS_np1, stim_selected_by_user, OnOff_params);
                
            else %Full Stims
                % analysis_organizeRepsCalcMeanMedianXcorrs
                %[TL_Calcs, TS_Calcs, TS_np1_Calcs, Diff_Calcs] = cc_do_calculations(unique_stims, chans_TL, chans_TS, chans_TS_np1, stim_selected_by_user, cor_start_stop_params);
                [TL_Calcs, TS_all_Calcs, TS_np1_Calcs, Diff_Calcs] = analysis_organizeRepsCalcMeanMedianXcorrs(chans_TL, chans_TS_all, chans_TS_np1, stim_selected_by_user, OnOff_params);
            end
            
            %% Save for meta Data
            
            %% TL
            TL_means{this_chan1, this_chan2} = TL_Calcs.mean_TL;
            TL_medians{this_chan1, this_chan2} = TL_Calcs.median_TL;
            TL_sems{this_chan1,this_chan2} = TL_Calcs.sem_TL;
            TL_stds{this_chan1,this_chan2} = TL_Calcs.std_TL;
            n_TL{this_chan1,this_chan2} = TL_Calcs.n_TL;
            n_TL_max{this_chan1,this_chan2} = TL_Calcs.n_TL_max;
            
            %% ALL TS
            TS_means{this_chan1, this_chan2} = TS_all_Calcs.mean_TS;
            TS_medians{this_chan1, this_chan2} = TS_all_Calcs.median_TS;
            TS_sems{this_chan1,this_chan2} = TS_all_Calcs.sem_TS;
            TS_stds{this_chan1,this_chan2} = TS_all_Calcs.std_TS;
            n_TS{this_chan1,this_chan2} = TS_all_Calcs.n_TS;
            n_TS_max{this_chan1,this_chan2} = TS_all_Calcs.n_TS_max;
            
            %% TS n+1
            TS_np1_means{this_chan1, this_chan2} = TS_np1_Calcs.mean_TS;
            TS_np1_medians{this_chan1, this_chan2} = TS_np1_Calcs.median_TS;
            TS_np1_sems{this_chan1,this_chan2} = TS_np1_Calcs.sem_TS;
            TS_np1_stds{this_chan1,this_chan2} = TS_np1_Calcs.std_TS;
            n_TS_np1{this_chan1,this_chan2} = TS_np1_Calcs.n_TS_np1;
            n_TS_np1_max{this_chan1,this_chan2} = TS_np1_Calcs.n_TS_np1_max;
            
            %% All Reps
            all_TL_reps{this_chan1,this_chan2} = TL_Calcs.TL_Reps_thisChanComparion;
            all_TS_reps{this_chan1,this_chan2} = TS_all_Calcs.TS_all_Reps_thisChanComparion;
            all_TS_np1_reps{this_chan1,this_chan2} = TS_np1_Calcs.TS_np1_Reps_thisChanComparion;
            all_DIFFs_TL_TSnp1_pairs{this_chan1,this_chan2} = Diff_Calcs.all_DIFFs_TL_TSnp1_pairs;
            
            
            %% Diffs (Signal Corrs)
            
            mean_TL_TS_all_diff{this_chan1, this_chan2} = Diff_Calcs.mean_DIFF_TSall;
            median_TL_TS_all_diff{this_chan1, this_chan2} = Diff_Calcs.median_DIFF_TSall;
            
            mean_TL_TS_np1_diff{this_chan1, this_chan2} = Diff_Calcs.mean_DIFF_TSnp1;
            median_TL_TS_np1_diff{this_chan1, this_chan2} = Diff_Calcs.median_DIFF_TSnp1;
            
            mean_TL_TSnp1_pairs_diff{this_chan1, this_chan2} = Diff_Calcs.all_DIFFs_TL_TSnp1_pairs_mean;
            median_TL_TSnp1_pairs_diff{this_chan1, this_chan2} = Diff_Calcs.all_DIFFs_TL_TSnp1_pairs_median;
            TL_TSnp1_pairs_diff_std{this_chan1, this_chan2} = Diff_Calcs.all_DIFFs_TL_TSnp1_pairs_std;
            TL_TSnp1_pairs_diff_sem{this_chan1, this_chan2} = Diff_Calcs.all_DIFFs_TL_TSnp1_pairs_sem;
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Plot Figure For the Reps of Each Bout %%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            if TL_Calcs.n_TL == 0 || sum(sum(cellfun(@(x) isempty(x), chans_TL))) == sum(sum(numel(chans_TL)))
                disp('>>> No TL or TS reps, skipping..')
                
            else
                
                if Plot_other_figs
                    pos = [2.5 2.5 25 15];
                    
                    %% Plots of the means medians (-1000 ms to +1000 ms) means (0) and medians(1)
                    plot_XCOV_or_XCOH(COV_or_COH, binSpkCnts_RSC, title_name, RSC, x_time, TL_Calcs, TS_all_Calcs, TS_np1_Calcs, Diff_Calcs, chan1_stats, chan2_stats, save_name, export_to, pos, BinInfo, 0, 0);
                    plot_XCOV_or_XCOH(COV_or_COH, binSpkCnts_RSC, title_name, RSC, x_time, TL_Calcs, TS_all_Calcs, TS_np1_Calcs, Diff_Calcs, chan1_stats, chan2_stats, save_name, export_to, pos, BinInfo, 1, 0);
                    
                    %% Zoomed in versions (-200 ms to +200 ms)
                    plot_XCOV_or_XCOH(COV_or_COH, binSpkCnts_RSC, title_name, RSC, x_time, TL_Calcs, TS_all_Calcs, TS_np1_Calcs, Diff_Calcs, chan1_stats, chan2_stats, save_name, export_to, pos, BinInfo, 0, 1);
                    plot_XCOV_or_XCOH(COV_or_COH, binSpkCnts_RSC, title_name, RSC, x_time, TL_Calcs, TS_all_Calcs, TS_np1_Calcs, Diff_Calcs, chan1_stats, chan2_stats, save_name, export_to, pos, BinInfo, 1, 1);
                end
                
            end
            
        end
    end
    
    metaINFO = [];
    
    
    metaINFO.TL_means = TL_means;
    metaINFO.TL_medians = TL_medians;
    metaINFO.TL_sems = TL_sems;
    metaINFO.TL_stds = TL_stds;
    metaINFO.n_TL = n_TL;
    metaINFO.n_TL_max = n_TL_max;
    
    %% ALL TS
    metaINFO.TS_means = TS_means;
    metaINFO.TS_medians = TS_medians;
    metaINFO.TS_sems = TS_sems;
    metaINFO.TS_stds = TS_stds;
    metaINFO.n_TS = n_TS;
    metaINFO.n_TS_max = n_TS_max;
    
    %% TS n+1
    metaINFO.TS_np1_means = TS_np1_means;
    metaINFO.TS_np1_medians = TS_np1_medians;
    metaINFO.TS_np1_sems = TS_np1_sems;
    metaINFO.TS_np1_stds = TS_np1_stds;
    metaINFO.n_TS_np1 = n_TS_np1;
    metaINFO.n_TS_np1_max = n_TS_np1_max;
    
    %% All Reps
    metaINFO.all_TL_reps = all_TL_reps;
    metaINFO.all_TS_reps = all_TS_reps;
    metaINFO.all_TS_np1_reps = all_TS_np1_reps;
    metaINFO.all_DIFFs_TL_TSnp1_pairs = all_DIFFs_TL_TSnp1_pairs;
    
    %% Diffs (Signal Corrs)
    
    metaINFO.mean_TL_TS_all_diff = mean_TL_TS_all_diff;
    metaINFO.median_TL_TS_all_diff = median_TL_TS_all_diff;
    
    metaINFO.mean_TL_TS_np1_diff = mean_TL_TS_np1_diff;
    metaINFO.median_TL_TS_np1_diff = median_TL_TS_np1_diff;
    
    metaINFO.mean_TL_TSnp1_pairs_diff = mean_TL_TSnp1_pairs_diff;
    metaINFO.median_TL_TSnp1_pairs_diff = median_TL_TSnp1_pairs_diff;
    metaINFO.TL_TSnp1_pairs_diff_std = TL_TSnp1_pairs_diff_std;
    metaINFO.TL_TSnp1_pairs_diff_sem = TL_TSnp1_pairs_diff_sem;
    
    metaINFO.stim_type = song_type;
    
end