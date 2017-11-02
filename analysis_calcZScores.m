function [z_score_stats] = analysis_calcZScores(allDirPaths, raw_data_info, OnOff_params, FR_meta, plot_z_scores, selected_stim)

unique_stims = OnOff_params.unique_stims;

if OnOff_params.stim_analysis_type == 5
    all_reps = OnOff_params.reps;
    total_reps = sum(all_reps);
    song_type = OnOff_params.BOUT_song_type;
else
    reps = OnOff_params.reps;
    total_reps = unique_stims*reps;
    song_type = OnOff_params.song_type;
end

%% Unpack variables
recording_session = raw_data_info.recording_session;
channel_numbers = FR_meta.channel_numbers;
num_channels = FR_meta.num_channels;

%%
if num_channels == 0
    
    z_score_stats = NaN;
    
else
    
    for m = 1 : num_channels
        this_chan = channel_numbers(m);
        chan_name = ['Ch-' num2str(this_chan)];
        
        chan_FR_vec_Stims = FR_meta.allChans_FR_vec_Stims{this_chan};
        chan_FR_vec_Spont = FR_meta.allChans_FR_vec_Spont{this_chan};
        
        if isempty(chan_FR_vec_Stims) ||  isempty(chan_FR_vec_Spont)
            disp(['Firing rates for chan: ' num2str(this_chan)])
            continue
        else
          
            %% Collect ordered rates for spont and stim repeptitions of identical stimuli
            spontBoxes = FR_meta.allFiringRates_Spont{this_chan};
            stimBoxes = FR_meta.allFiringRates_Stim{this_chan};
            
            forBoxes = [];
            xlabels = [];
            for j = 1:unique_stims
                forBoxes = [forBoxes; spontBoxes(j,:); stimBoxes(j,:)];
                xlabels = [xlabels {[''] , ['V.' num2str(j)]}];
            end
            
            %% Calculate z-score
            meanStim = nanmean(chan_FR_vec_Stims);
            meanSpont = nanmean(chan_FR_vec_Spont);
            
            stdStim = nanstd(chan_FR_vec_Stims);
            stdSpont = nanstd(chan_FR_vec_Spont);
            
            covar = cov(chan_FR_vec_Stims, chan_FR_vec_Spont);
            z_score_cov = (meanStim - meanSpont) / sqrt((stdStim^2 + stdSpont^2) - 2*covar(1, 2));
            
            
            %% calculate Firing Rate Significance
            
            %h = 1 indicates a rejection of the null hypothesis at the 5% significance
            %level null hypothesis that data in the vectors x and y are independent
            %samples from identical continuous distributions with equal medians
            
            [h, sig1] = ttest2(chan_FR_vec_Stims, chan_FR_vec_Spont);
            [sig2, h] = ranksum(chan_FR_vec_Stims, chan_FR_vec_Spont);
            
            %% plot figure
            
            if plot_z_scores
                
                this_fig = figure(100 + m);
                green = [0.2 0.5 0];
                gray = [0.6 0.6 0.6];
                subplot(3, 1, 1)
                
                %% Plotting the individually calculated z scores for each repeptition
                %% (1) This plot is in the order that the stimulus was played back, ie, first rep of first stime, first rep of 2nd stim, etc..
                
                plot(chan_FR_vec_Stims, '-*', 'color', green, 'linewidth', 2)
                hold on
                plot(chan_FR_vec_Spont, '-*', 'color', gray, 'linewidth', 2)
                legend({['Evoked Firing Rate, \mu = ' num2str(roundn(meanStim), -2) ' Hz'], ['Baseline Firing Rate, \mu = ' num2str(roundn(meanSpont), -2) ' Hz']});
                legend('boxoff')
                xlabel('Consecutive Stimulus Repetitions')
                ylabel('Firing Rate [Hz]')
                title([chan_name ' | Firing Rate Comparison | ' song_type ' Consecutive Repetitions'])
                annotation(this_fig,'textbox',[0.13 0.72 0.3 0.2],...
                    'String',{['Z-Score = ' num2str(roundn(z_score_cov), -2)],['Ranksum: p = ' num2str(sig2)],['T-test: p = ' num2str(sig1)]},...
                    'FitBoxToText','on',...
                    'LineStyle','none');
                ylim([-5 25]);
                
                %% (2) Box plots for comparisons of identical repetitions of unique stimuli
                subplot(3, 1, 2)
                title([chan_name ' | Firing Rate Comparison | ' song_type ' | Identical Repetitions'])
                boxplot(forBoxes', 'whisker', 0, 'symbol', 'k*', 'outliersize', 2,  'jitter', 0.3, 'colors', [0 0 0])
                set(gca, 'xtickLabel', xlabels)
                xlabel('Stimulus Versions')
                ylabel('Firing Rate [Hz]')
                ylim([-5 25]);
                
                %% (3) Plotting evoked vs baseline raw firing rates for each repetition
                subplot (3, 1, 3)
                plot(chan_FR_vec_Spont, chan_FR_vec_Stims, '*', 'color', green, 'linewidth', 2)
                hold on
                xlabel('Baseline Firing Rate [Hz]')
                ylabel('Evoked Firing Rate [Hz]')
                title([chan_name ' - Evoked Firing Rate vs Baseline Firing Rate for ' song_type ' Repetitions'])
                xlim([-5 25]);
                ylim([-5 25]);
                legend( ['reps = ' num2str(total_reps)])
                legend('boxoff')
                
                
                %% Save figure
                
                save_name = [recording_session '-' song_type '-zscore-' chan_name ];
                full_save_path = [allDirPaths.bird_zscore_dir save_name];
                pos = [0 0 30 20];
                export_to = set_export_file_format(2);
                print_in_A4(this_fig, full_save_path, export_to, 0, pos);
                
            end
            
            z_score_stats.z_score_cov(this_chan) = z_score_cov;
            z_score_stats.FR_ttest_p(this_chan) = sig1;
            z_score_stats.FR_RS_p(this_chan) = sig2;
            z_score_stats.meanFR_Stim(this_chan) = meanStim;
            z_score_stats.stdFR_Stim(this_chan) = stdStim;
            z_score_stats.meanFR_Spont(this_chan) = meanSpont;
            z_score_stats.stdFR_Spont(this_chan) = stdSpont;
            z_score_stats.chan_FR_vec_Stims{this_chan} = chan_FR_vec_Stims;
            z_score_stats.chan_FR_vec_Spont{this_chan} = chan_FR_vec_Spont;
        end
        
    end
end

disp('<<< Done calculating z-scores.');

end
