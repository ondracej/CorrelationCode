function [FR_meta, AnovaStats] = analysis_calcFR_binSpikes_Motifs(BIN_size, OnOff_params, spks, raw_data_info, allDirPaths, stim_selected_by_user, doplot)

%% Unpack raw data information

dbstop if error

save_dir = [allDirPaths.bird_rast_dir 'BinnedRasters/'];

if exist(save_dir, 'dir') == 0
    mkdir(save_dir);
    disp('Created binned rasterplot directory.')
end

%% Unpack onset offset information

AnovaStats = [];

unique_stims = OnOff_params.unique_stims;
reps_stims = OnOff_params.reps;

scanrate_labview = raw_data_info.scanrate_labview;

%% Bin length

bin_size = BIN_size; % in s
bin_size_samps = ceil(bin_size*scanrate_labview);

%%
if isempty(OnOff_params.BOUT_stim_start) || isempty(OnOff_params.BOUT_stim_stop)
    disp(['There are not start stop times defined for this stimulus: ' OnOff_params.song_type])
    FR_meta = [];
    AnovaStats = [];
    
else
    
    %% Find out which channels have spikes on them
    spk_channels = cellfun(@(x) ~isempty(x), spks);
    channel_numbers = find(spk_channels == 1);
    num_channels = sum(spk_channels);
    
    maxChanNumber = max(channel_numbers);
    channel_numbers_w_spks = channel_numbers ;
    num_channels_w_spks = numel(channel_numbers_w_spks);
     
    %% Preallocate variables
    allBinnedFiringRates_Stims = cell(1, maxChanNumber);
    allBinnedSpkCnts_Stims = cell(1, maxChanNumber);
    
    allBinnedSpkCnts_Stims_forXCOV = cell(1, maxChanNumber);
    
    allFiringRates_Spont = cell(1, maxChanNumber);
    allDurations_s_Spont = cell(1, maxChanNumber);
    allSpkCnts_Spont = cell(1, maxChanNumber);
    allSpkTimes_Spont = cell(1, maxChanNumber);
    
    allFiringRates_Stim = cell(1, maxChanNumber);
    allDurations_s_Stim = cell(1, maxChanNumber);
    allSpkCnts_Stim = cell(1, maxChanNumber);
    allSpkTimes_Stim = cell(1, maxChanNumber);
    
    for m = 1 : num_channels
        chan = channel_numbers(m);
        
        %% First check to see whether there are spikes on this channel for this stim
        
        chanSpksDuringStim = numel(spks{chan}(spks{chan} >= OnOff_params.stim_start(1) & spks{chan} <= OnOff_params.stim_stop(end)));
        
        if chanSpksDuringStim > 0
            
             %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Start for loop the Stimulus-evoked spikes (MOTIFS)
            %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            chan_SpkTimesFullStims = cell(unique_stims, reps_stims);
            chan_SpksCntsFullStims = nan(unique_stims, reps_stims);
            chan_StimDurations_samp = nan(unique_stims, reps_stims);
            chan_StimDurations_s = nan(unique_stims, reps_stims);
            chan_FiringRatesFullStims = nan(unique_stims, reps_stims);
            
            for p = 1 : unique_stims
                i = p;
                
                for s = 1 : reps_stims
                    
                    %% Define stimulus onset offset
                    start_stim =  OnOff_params.stim_start(i);
                    stop_stim =  OnOff_params.stim_stop(i);
                    
                    length_this_stim = stop_stim-start_stim +1 ; % add a 1 because of data offset
                    
                    %% Find spikes present between onset offset timpoints
                    % must subtract start_stim to arrange spikes relative to onset of that stimululs
                    these_spks_on_chan = spks{chan}(spks{chan} >= start_stim & spks{chan} <= stop_stim)-start_stim;
                    this_spike_count = numel(these_spks_on_chan);
                    
                    
                    %all_spks{p, s} = these_spks_on_chan;
                    chan_SpkTimesFullStims{p, s} = these_spks_on_chan;
                    chan_SpksCntsFullStims(p, s) = this_spike_count;
                    chan_StimDurations_samp(p, s) = length_this_stim;
                    chan_StimDurations_s(p, s) = length_this_stim/scanrate_labview;
                    
                    chan_FiringRatesFullStims(p, s) = this_spike_count /  chan_StimDurations_s(p, s);
                    
                    %% Increment Stims identical stimuli are organized together
                    i = i + unique_stims;
                    
                end
            end
            
            if sum(sum(cellfun(@isempty, chan_SpkTimesFullStims))) == numel(chan_SpkTimesFullStims)
                disp(['There are no evoked spike for chan ' num2str(chan)])
            end
            
            allFiringRates_Stim_MOTIF{1, chan} = chan_FiringRatesFullStims;
            allDurations_s_Stim_MOTIF{1, chan} = chan_StimDurations_s;
            allDurations_samps_Stim_MOTIF{1, chan} = chan_StimDurations_samp;
            allSpkCnts_Stim_MOTIF{1, chan} = chan_SpksCntsFullStims;
            allSpkTimes_Stim_MOTIF{1, chan} = chan_SpkTimesFullStims;
             
            
            
            %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Start for loop the Stimulus-evoked spikes (Full Stim)
            %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            chan_SpkTimesFullStims = cell(OnOff_params.bout_unique_stims, OnOff_params.bout_reps);
            chan_SpksCntsFullStims = nan(OnOff_params.bout_unique_stims, OnOff_params.bout_reps);
            chan_StimDurations_samp = nan(OnOff_params.bout_unique_stims, OnOff_params.bout_reps);
            chan_StimDurations_s = nan(OnOff_params.bout_unique_stims, OnOff_params.bout_reps);
            chan_FiringRatesFullStims = nan(OnOff_params.bout_unique_stims, OnOff_params.bout_reps);
            
            for p = 1 : OnOff_params.bout_unique_stims
                i = p;
                
                for s = 1 : OnOff_params.bout_reps
                    
                    %% Define stimulus onset offset
                    start_stim =  OnOff_params.stim_start(i);
                    stop_stim =  OnOff_params.stim_stop(i);
                    
                    length_this_stim = stop_stim-start_stim +1 ; % add a 1 because of data offset
                    
                    %% Find spikes present between onset offset timpoints
                    % must subtract start_stim to arrange spikes relative to onset of that stimululs
                    these_spks_on_chan = spks{chan}(spks{chan} >= start_stim & spks{chan} <= stop_stim)-start_stim;
                    this_spike_count = numel(these_spks_on_chan);
                    
                    
                    %all_spks{p, s} = these_spks_on_chan;
                    chan_SpkTimesFullStims{p, s} = these_spks_on_chan;
                    chan_SpksCntsFullStims(p, s) = this_spike_count;
                    chan_StimDurations_samp(p, s) = length_this_stim;
                    chan_StimDurations_s(p, s) = length_this_stim/scanrate_labview;
                    
                    chan_FiringRatesFullStims(p, s) = this_spike_count /  chan_StimDurations_s(p, s);
                    
                    %% Increment Stims identical stimuli are organized together
                    i = i + unique_stims;
                    
                end
            end
            
            if sum(sum(cellfun(@isempty, chan_SpkTimesFullStims))) == numel(chan_SpkTimesFullStims)
                disp(['There are no evoked spike for chan ' num2str(chan)])
            end
            
            allFiringRates_Stim{1, chan} = chan_FiringRatesFullStims;
            allDurations_s_Stim{1, chan} = chan_StimDurations_s;
            allSpkCnts_Stim{1, chan} = chan_SpksCntsFullStims;
            allSpkTimes_Stim{1, chan} = chan_SpkTimesFullStims;
            
            
            
            %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Start for loop the SPONTANEOUS spikes
            %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            % For motifs, we use the spont interval before the bout onset
            chan_SpkTimes_Spont = cell(OnOff_params.bout_unique_stims, OnOff_params.bout_reps);
            chan_SpksCnts_Spont = nan(OnOff_params.bout_unique_stims, OnOff_params.bout_reps);
            chan_SpontDurations_samp = nan(OnOff_params.bout_unique_stims, OnOff_params.bout_reps);
            chan_SpontDurations_s = nan(OnOff_params.bout_unique_stims, OnOff_params.bout_reps);
            chan_FiringRatesSpont = nan(OnOff_params.bout_unique_stims, OnOff_params.bout_reps);
            
            
            %% For firing rate comparisons, it makes sense to compare stimulus evoked responses to a previous baseline period
            % Therefore, we use the stim-evoked onset and use 1.5 s of spont spikes
            
            spontInterval_s  = 1.5;
            spontInterval_samps = spontInterval_s * scanrate_labview;
            
            for p = 1 : OnOff_params.bout_unique_stims % We use the bout reps/unique stims
                
                i = p;
                
                for s = 1 : OnOff_params.bout_reps
                    
                    start_stim = OnOff_params.BOUT_stim_start(i) - spontInterval_samps ; % We compare this to the bout start/stop
                    stop_stim = OnOff_params.BOUT_stim_start(i);
                    length_this_stim = stop_stim-start_stim +1 ;
                    
                    %must subtract start_stim to arrange spikes relative to onset
                    these_spks_on_chan = spks{chan}(spks{chan} >= start_stim & spks{chan} <= stop_stim)-start_stim;
                    this_spike_count = numel(these_spks_on_chan);
                    
                    
                    %all_spks{p, s} = these_spks_on_chan;
                    chan_SpkTimes_Spont{p, s} = these_spks_on_chan;
                    chan_SpksCnts_Spont(p, s) = this_spike_count;
                    chan_SpontDurations_samp(p, s) = length_this_stim;
                    chan_SpontDurations_s(p, s) = length_this_stim/scanrate_labview;
                    
                    chan_FiringRatesSpont(p, s) = this_spike_count /  chan_SpontDurations_s(p, s);
                    
                    %% Increment
                    i = i + unique_stims;
                    
                end
            end
            
            if sum(sum(cellfun(@isempty, chan_SpkTimes_Spont))) == numel(chan_SpkTimes_Spont)
                disp(['There are no spontaneous spike for chan ' num2str(chan)])
            end
            
            allFiringRates_Spont{1, chan} = chan_FiringRatesSpont;
            allDurations_s_Spont{1, chan} = chan_SpontDurations_s;
            allSpkCnts_Spont{1, chan} = chan_SpksCnts_Spont;
            allSpkTimes_Spont{1, chan} = chan_SpkTimes_Spont;
            
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Start for loop binning the stimulus evoked spikes - MOTIFS
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            chan_FiringRates_UniqueStims_AllBins = cell(1, unique_stims);
            chan_SpkCnts_UniqueStims_AllBins = cell(1, unique_stims);
            chan_SpkCnts_UniqueStims_AllBins_forXCOV = cell(unique_stims, 1);
            
            for p = 1 : unique_stims
                i = p;
                
                %cannot preallocate variables
                % chan_SpksCntsBins = nan(nBins, reps_stims);
                % chan_BinDuration_samp = nan(nBins, reps_stims);
                % chan_BinDuration_s = nan(nBins, reps_stims);
                % chan_FiringRatesBins = nan(nBins, reps_stims);
                % all_spike_count_bins = nan(reps_stims, nBins);
                all_spike_count_bins = [];
                for s = 1 : reps_stims
                    length_this_stim = allDurations_samps_Stim_MOTIF{1, chan}(p, s);
                    nBins = ceil(length_this_stim/bin_size_samps);
                    
                    binSize_rounded = round(bin_size_samps);
                    
                    %% First try the binning with the exact bin length
                    [~, indices_in_same_bin] = histc(1:length_this_stim, [1:bin_size_samps:length_this_stim+bin_size_samps]);
                    
                    if indices_in_same_bin(end) ~= nBins
                        disp('Problems with the binning, trying the rounded bin size now...');
                        [~, indices_in_same_bin] = histc(1:length_this_stim, [1:binSize_rounded:length_this_stim+roundbins]);
                    end
                    
                    if indices_in_same_bin(end) ~= nBins
                        disp('There are still problems with the binning...');
                        keyboard
                    end
                    
                    
                    %% Now find all spikes that belong to ordered bin indices
                    cum_spikes = 0; % running binned spike count
                    
                    for o = 1: nBins
                        
                        %% Define stimulus onset offset
                        start_stim =  OnOff_params.stim_start(i);
                        stop_stim =  OnOff_params.stim_stop(i);
                        
                        % Map indices in stimulus to time points in stimulus
                        this_data_range = start_stim:stop_stim;
                        samples_this_bin = this_data_range(indices_in_same_bin == o);
                        
                        bin_start_samp = samples_this_bin(1);
                        bin_stop_samp = samples_this_bin(end);
                        length_this_bin = bin_stop_samp - bin_start_samp +1;
                        
                        these_spks_on_chan_bin = spks{chan}(spks{chan} >= bin_start_samp & spks{chan} <= bin_stop_samp)-bin_start_samp;
                        
                        %% Binned Spike count used in COV calculations
                        if ~isempty(these_spks_on_chan_bin)
                            this_spike_count_bin = numel(these_spks_on_chan_bin);
                        else
                            this_spike_count_bin = 0;
                        end
                        
                        % Test to make sure the binned spike counts match the unbinned spike counts
                        cum_spikes = cum_spikes + this_spike_count_bin;
                        
                        % Binned Firing rate statistics
                        chan_SpksCntsBins(o, s) = this_spike_count_bin;
                        chan_BinDuration_samp(o, s) = length_this_bin;
                        chan_BinDuration_s(o, s) = length_this_bin/scanrate_labview;
                        
                        chan_FiringRatesBins(o, s) = this_spike_count_bin /  chan_BinDuration_s(o, s);
                        
                        %% Used for xCOV calculation
                        all_spike_count_bins(s, o) = this_spike_count_bin;
                        
                    end
                    
                   % if chan_SpksCntsFullStims(p,s) ~= cum_spikes
                   %     disp(['<<< Error | Binned spike count does not match the spike count for this stimulus rep: p=' num2str(p) ', s=' num2str(s)])
                   %     keyboard
                   % end
                    
                    i = i + unique_stims;
                    
                end
                
                chan_FiringRates_UniqueStims_AllBins{p} = chan_FiringRatesBins;
                chan_SpkCnts_UniqueStims_AllBins{p} = chan_SpksCntsBins;
                chan_SpkCnts_UniqueStims_AllBins_forXCOV{p,1} = all_spike_count_bins;
                
            end
            
            allBinnedFiringRates_Stims{1, chan} = chan_FiringRates_UniqueStims_AllBins;
            allBinnedSpkCnts_Stims{1, chan} = chan_SpkCnts_UniqueStims_AllBins;
            allBinnedSpkCnts_Stims_forXCOV{1, chan} = chan_SpkCnts_UniqueStims_AllBins_forXCOV;
            
            %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Anova statistics
            %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            for a = 1:unique_stims
                
                %% anova
                anova_Chan_SpkCnt = chan_SpkCnts_UniqueStims_AllBins_forXCOV{a,1}';
                [pp,table,stats] = anova1(anova_Chan_SpkCnt, [], 'off');
                
                %% The standard ANOVA table has six columns:
                % The source of the variability.
                % The sum of squares (SS) due to each source.
                % The degrees of freedom (df) associated with each source.
                % The mean squares (MS) for each source, which is the ratio SS/df.
                % The F-statistic, which is the ratio of the mean squares.
                % The p value, which is derived from the cdf of F.
                
                ss(a, 1) = table{2, 2};
                df(a,1) = table{2, 3};
                ms(a,1) = table{2, 4};
                f(a,1) = table{2, 5};
                P(a,1) = pp;
                
            end
            
            %% Saving Anova stats per channel
            AnovaStats.ss{1, chan} = ss;
            AnovaStats.df{1, chan} = df;
            AnovaStats.ms{1, chan} = ms;
            AnovaStats.f{1, chan} = f;
            AnovaStats.P{1, chan} = P;
            
            AnovaStats.mean_f(1, chan) = mean(f);
            AnovaStats.mean_P(1, chan) = mean(P);
            AnovaStats.mean_ss(1, chan) = mean(ss);
            
            disp(['Finished calculating firing rates and Anovas for ch ' num2str(chan)])
            
            %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %% Rasterplot of binned spikes
            %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % We do not do this for CON (stim_selected_by_user = 7) and motifs (stim_analysis_type = 4)
            
            if stim_selected_by_user ~=7 && doplot == 1 || OnOff_params.stim_analysis_type == 4 && doplot == 1;
                this_fig = figure(105); clf;
                for a = 1:unique_stims
                    % for case with > 6 unique stim (WN), we only plot the first 8 unique stims
                    if unique_stims > 6
                        if a <= 8
                            subplot(8, 1, a) % we do a max of 8 plots for many unique stims
                            %{
                        for b = 1:reps
                        
                            figure
                            
                            %xpoints = repmat(b, 1, numel(chan_SpkCnts_UniqueStims_AllBins_forXCOV{a}(b,:)));
                            ypoints = chan_SpkCnts_UniqueStims_AllBins_forXCOV{a}(b,:);
                            ypoints_nan_ind = find(ypoints == 0);
                            ypoints(ypoints_nan_ind) = nan;
                            
                            xpoints = 1:numel(chan_SpkCnts_UniqueStims_AllBins_forXCOV{a}(b,:));
                            
                            figure(100)
                            hold on
                            plot(xpoints, b*ypoints, 'k*')
                        end
                            %}
                            imagesc(chan_SpkCnts_UniqueStims_AllBins_forXCOV{a,1})
                            title([OnOff_params.song_type ' V.' num2str(a) ', F: ' num2str(roundn(f(a), -2))])
                        end
                    else
                        subplot(unique_stims, 1, a)
                        imagesc(chan_SpkCnts_UniqueStims_AllBins_forXCOV{a,1})
                        title([OnOff_params.BOUT_song_type ' V.' num2str(a) ', F: ' num2str(roundn(f(a), -2))])
                    end
                    
                    colormap(gray)
                    ylabel('reps')
                end
            end
            
            %% If the stim is a CON or motifs, we dont plot/save anything
            if stim_selected_by_user ~=7 && doplot == 1 || OnOff_params.stim_analysis_type == 4 && doplot == 1;
                this_title = {['Binned Rasterplot, Chan-' num2str(chan) ': ' OnOff_params.BOUT_song_type ', f mean: ' num2str(roundn(nanmean(f), -2))]};
                annotation(this_fig,'textbox',[0.29 0.97 0.470 0.03],'String',this_title,'HorizontalAlignment','center', 'Fontsize', 14, 'FitBoxToText','on','LineStyle','none');
                this_save_name = [save_dir raw_data_info.recording_session '-' OnOff_params.BOUT_song_type '-Chan-' num2str(chan) '.eps'];
                
                pos = [2.5 2.5 25 15];
                
                figure(this_fig);
                print_in_A4(0, this_save_name, '-depsc', 0, pos);
            end
            
            
            %% No spikes are present during this stim, set variables for this channel to empty
        else % the case where no spikes were found, set everything to empty
            
            %% Anova
            AnovaStats.ss{1, chan} = [];
            AnovaStats.df{1, chan} = [];
            AnovaStats.ms{1, chan} = [];
            AnovaStats.f{1, chan} = [];
            AnovaStats.P{1, chan} = [];
            
            AnovaStats.mean_f(1, chan) = nan;
            AnovaStats.mean_P(1, chan) = nan;
            AnovaStats.mean_ss(1, chan) = nan;
            
            allBinnedFiringRates_Stims{1, chan} = [];
            
            allFiringRates_Spont{1, chan} = [];
            allDurations_s_Spont{1, chan} = [];
            allSpkCnts_Spont{1, chan} = [];
            allSpkTimes_Spont{1, chan} = [];
            
            allFiringRates_Stim{1, chan} = [];
            allDurations_s_Stim{1, chan} = [];
            allSpkCnts_Stim{1, chan} = [];
            allSpkTimes_Stim{1, chan} = [];
            
              allFiringRates_Stim_MOTIF{1, chan} = [];
            allDurations_s_Stim_MOTIF{1, chan} = [];
            allSpkCnts_Stim_MOTIF{1, chan} = [];
            allSpkTimes_Stim_MOTIF{1, chan} = [];
            
            %% We update the channel number information here if there is a channel with no spikes for this stimulus block
           
            channel_numbers_w_spks(m) = NaN; % try setting the bad chan to a NaN
            
            
        end
    end
    
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Organize evoked and spontaneous FRs into vectors for easier analysis
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    allChans_FR_vec_Stims = cell(1, maxChanNumber);
    allChans_FR_vec_Spont = cell(1, maxChanNumber);
    
    for q = 1 : num_channels
        
        this_chan = channel_numbers(q);
        
        %% Check if channel actually had spikes
        if isempty(allFiringRates_Stim{this_chan})
            
            disp(['<<< FRs not present for this channel: ' num2str(this_chan)])
            allChans_FR_vec_Stims{1, this_chan} = [];
            allChans_FR_vec_Spont{1, this_chan} = [];
        else
            
            if this_chan > numel(allFiringRates_Stim)
                % this is a case where the chan number is larger than the vector?
                
                keyboard
                continue
            else
                
                FR_stims = allFiringRates_Stim{1, this_chan};
                FR_stims_MOTIFS = allFiringRates_Stim_MOTIF{1, this_chan};
                
                if isempty(FR_stims)
                    disp(['<<< FRs not present for this channel: ' num2str(this_chan)])
                    keyboard
                    continue
                    
                else
                    
                    FR_stims = allFiringRates_Stim{1, this_chan};
                    FR_spont  = allFiringRates_Spont{1, this_chan};
                    FR_MOTIF = allFiringRates_Stim_MOTIF{1, this_chan};
                    
                    % reshape reads it down the columns, so unique stim
                    % reps are not consecutive
                    allChans_FR_vec_Stims{1, this_chan} = reshape(FR_stims, 1, numel(FR_stims));
                    allChans_FR_vec_Spont{1, this_chan} = reshape(FR_spont, 1, numel(FR_spont));
                    allChans_FR_vec_Stims_MOTIF{1, this_chan} = reshape(FR_MOTIF, 1, numel(FR_MOTIF));
                    
                    allChans_FR_vec_Stims_reps{1, this_chan} = reshape(FR_stims', 1, numel(FR_stims));
                    allChans_FR_vec_Spont_reps{1, this_chan} = reshape(FR_spont', 1, numel(FR_spont));
                    allChans_FR_vec_Stims_reps_MOTIF{1, this_chan} = reshape(FR_MOTIF', 1, numel(FR_MOTIF));
                    
                end
            end
        end
    end
    
    %% Package all the stuff for meta analysis
    
    FR_meta = [];
    
    % Find NaN channels and set to []
    noSpkChans = isnan(channel_numbers_w_spks);
    channel_numbers(noSpkChans) = [];
    num_channels_w_spks = numel(channel_numbers);
    
    FR_meta.channel_numbers = channel_numbers;
    FR_meta.num_channels = num_channels_w_spks;
    
    FR_meta.allChans_FR_vec_Stims = allChans_FR_vec_Stims;
    FR_meta.allChans_FR_vec_Spont = allChans_FR_vec_Spont;
    FR_meta.allChans_FR_vec_Stims_MOTIFS = allChans_FR_vec_Stims_MOTIF;
    
    FR_meta.allChans_FR_vec_Stims_reps = allChans_FR_vec_Stims_reps;
    FR_meta.allChans_FR_vec_Spont_reps = allChans_FR_vec_Spont_reps;
    FR_meta.allChans_FR_vec_Stims_reps_MOTIFS = allChans_FR_vec_Stims_reps_MOTIF;
    
    FR_meta.allBinnedFiringRates_Stims = allBinnedFiringRates_Stims;
    
    FR_meta.allFiringRates_Spont = allFiringRates_Spont;
    FR_meta.allDurations_s_Spont = allDurations_s_Spont;
    FR_meta.allSpkCnts_Spont = allSpkCnts_Spont;
    FR_meta.allSpkTimes_Spont = allSpkTimes_Spont;
    
    %% Full stims
    FR_meta.allFiringRates_Stim = allFiringRates_Stim;
    FR_meta.allDurations_s_Stim = allDurations_s_Stim;
    FR_meta.allSpkCnts_Stim = allSpkCnts_Stim ;
    FR_meta.allSpkTimes_Stim = allSpkTimes_Stim;
    
    %% Motifs
    FR_meta.allFiringRates_Stim_MOTIF = allFiringRates_Stim_MOTIF;
    FR_meta.allDurations_s_Stim_MOTIF = allDurations_s_Stim_MOTIF;
    FR_meta.allSpkCnts_Stim_MOTIF = allSpkCnts_Stim_MOTIF ;
    FR_meta.allSpkTimes_Stim_MOTIF = allSpkTimes_Stim_MOTIF;
    
    FR_meta.allBinnedSpkCnts_Stims_forXCOV = allBinnedSpkCnts_Stims_forXCOV;
    
end
end
