function [autoCOV] = analysis_CalcBinnedAutoCOV(allDirPaths, raw_data_info, FR_meta, OnOff_params, Lags, selected_stim, Plot_other_figs)

%% Unpack stim-related variables
unique_stims = OnOff_params.unique_stims;
fig106 = figure(106);
if OnOff_params.stim_analysis_type == 5
    all_reps = OnOff_params.reps;
    song_type = OnOff_params.BOUT_song_type;
    reps = OnOff_params.reps;
else
    reps = OnOff_params.reps;
    song_type = OnOff_params.song_type;
end

totalReps = unique_stims*reps;

%% Data-related variables

channel_numbers = FR_meta.channel_numbers;
num_channels = FR_meta.num_channels;

BIN_size_ms = OnOff_params.BIN_size_ms;

%% lag x lim
autocov_xlim = [-200 200];

% To simply things, we define a maxLag
max_lag_bins = Lags.max_lag_bins;
lagDur = max_lag_bins*2+1;
%%

figOffset = 0;

%% Calculatate the auto covariance for one channel at a time
for r = 1 : num_channels
    this_chan = channel_numbers(r);
    
    binnedSpks = FR_meta.allBinnedSpkCnts_Stims_forXCOV{this_chan};
    
    if isempty(binnedSpks)
        continue
    end
    
    sumSpks = sum(cell2mat(cellfun(@(x) sum(sum(x)), binnedSpks, 'uniformOutput', 0)));
    
    if sumSpks <= 1
        disp('<<< There is only 1 spike or fewer for all the repetitions for this channel, skipping...')
        
        autoCOV.Yreps_all{1, this_chan} = [];
        autoCOV.Y_allReps{1, this_chan} = [];
        autoCOV.allReps_mean{1, this_chan} = [];
        autoCOV.allReps_median{1, this_chan} = [];
        autoCOV.allReps_std{1, this_chan} = [];
        
    else
        
        Yreps_all = cell(unique_stims, 1);
        if OnOff_params.stim_analysis_type == 5 && selected_stim == 7
            Y_allReps = nan(lagDur,sum(all_reps));
        else
            Y_allReps = nan(lagDur, unique_stims*reps);
        end
        reps_0_spikes = 0; % NanCounter
        repCnt = 1;
        
        for k = 1: unique_stims
            
            if OnOff_params.stim_analysis_type == 5 && selected_stim == 7 % CON motifs
                reps = all_reps(k);
            end
            
            Yrep = [];
            
            for o = 1: reps
                binnedSpktrain = binnedSpks{k}(o,:);
                
                
                if sum(binnedSpktrain) == 0 % If there are no spikes, we set as nans
                    y = nan(1, lagDur);
                    reps_0_spikes = reps_0_spikes  +1; % NanCounter
                else
                    %% Calculating auto covariances
                    [y, lags] =  xcov(binnedSpktrain, max_lag_bins, 'coef'); % lags are in units of 5 ms bins (400 = 2000ms)
                end
                
                Yrep(:,o) = y;
                Y_allReps(:,repCnt) = y;
                repCnt = repCnt+1;
            end
            
            Yreps_all{k} = Yrep;
            
        end
        
        %% Averaging all reps together
        allReps_mean = nanmean(Y_allReps, 2);
        allReps_median = nanmedian(Y_allReps, 2);
        allReps_std = nanstd(Y_allReps', 1);
        
        %% Plotting
        if Plot_other_figs
            fig106 = figure(106);
            figure(fig106)
            hold on
            
            plot(lags, allReps_mean+figOffset, 'r'); % mean
            plot(lags, allReps_median+figOffset, 'b') % median
            plot(lags, ones(lagDur, 1)*figOffset, 'k') % 0 line
            
            text(autocov_xlim(1)+2, figOffset+.05, {['chan ' num2str(this_chan) ' | ' num2str(sumSpks) ' spikes | ' num2str(totalReps-reps_0_spikes) '/' num2str(totalReps)]})
            
            figOffset = figOffset + 0.75;
        end
        
        % Save info for channels
        autoCOV.Yreps_all{1, this_chan} = Yreps_all;
        autoCOV.Y_allReps{1, this_chan} = Y_allReps;
        autoCOV.allReps_mean{1, this_chan} = allReps_mean;
        autoCOV.allReps_median{1, this_chan} = allReps_median;
        autoCOV.allReps_std{1, this_chan} = allReps_std;
    end
end

if Plot_other_figs
    %% Convert x ticks from 5 bins to ms
    
    figure(fig106)
    
    autocov_xticks = autocov_xlim(1):50:autocov_xlim(2);
    autocov_xticks_ms_cell = num2cell(autocov_xticks*BIN_size_ms);
    autocov_xticks_ms_labs_str = cellfun(@(x) num2str(x),autocov_xticks_ms_cell, 'uniformoutput', 0);
    
    xlim(autocov_xlim)
    set(gca, 'xtick',  autocov_xticks)
    set(gca, 'xtickLabel',  autocov_xticks_ms_labs_str)
    
    legend({'Mean', 'Median'});
    xlabel('Time Lag [ms]')
    ylabel('R')
    
    title([raw_data_info.recording_session ' | AutoCovariance | ' song_type ' | ' num2str(unique_stims*reps) ' total reps' ])
    
    %% Printing
    AutoCovDir = [allDirPaths.bird_corr_dir 'AutoCov/'];
    
    this_save_name = [AutoCovDir raw_data_info.recording_session '-' song_type '_AutoCov.png'];
    
    if exist(AutoCovDir, 'dir') == 0
        mkdir(AutoCovDir);
        disp('Created AutoCov directory.')
    end
    
    pos = [2.5 2.5 25 15];
    
    figure(fig106);
    print_in_A4(0, this_save_name, '-dpng', 0, pos);
end

end
