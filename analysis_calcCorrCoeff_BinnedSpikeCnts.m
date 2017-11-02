function[RSC] = analysis_calcCorrCoeff_BinnedSpikeCnts(binSpkCnts_RSC, allDirPaths, OnOff_params, raw_data_info, stim_selected_by_user, Plot_other_figs)
%analysis_calcCorrCoeff_BinnedSpikeCnts(all_spk_count_on_chans, cor_start_stop_params,stim_selected_by_user)

%% Unpack stim-related varibles
RSC.rSC = [];
RSC.pSC = [];

unique_stims = OnOff_params.unique_stims;
if OnOff_params.stim_analysis_type == 5
    song_type = OnOff_params.BOUT_song_type;
    all_reps = OnOff_params.reps;
else
    reps = OnOff_params.reps;
    song_type = OnOff_params.song_type;
end

allReps = unique_stims*OnOff_params.reps;

%% Determine which channels have spikes on them

channel_numbers = raw_data_info.channel_numbers;
num_channels = raw_data_info.num_channels;

if num_channels == 1
    disp('<<< Only 1 channel found, cannot calculate RSC.');
    RSC = NaN;
    
else
    
    plotcnt = 1;
    
    for m = 1 : num_channels
        this_chan1 = channel_numbers(m);
        chan1_name = ['Neuron ' num2str(this_chan1)];
        
        if OnOff_params.stim_analysis_type == 5  && stim_selected_by_user == 7
            spkCnt_chan_1 = cell2mat(binSpkCnts_RSC.SpkCnt{this_chan1});
            spkCnt_chan_1_reshape = reshape(spkCnt_chan_1, 1, numel(spkCnt_chan_1));
            
        else
            spkCnt_chan_1 = binSpkCnts_RSC.SpkCnt{this_chan1};
            spkCnt_chan_1_reshape = reshape(spkCnt_chan_1, 1, numel(spkCnt_chan_1));
        end
        
        if sum(spkCnt_chan_1_reshape) ==0
            continue
        end
        
        
        for n = 1: num_channels
            
            if m>=n
                continue
            end
            
            this_chan2 = channel_numbers(n);
            chan2_name = ['Neuron ' num2str(this_chan2)];
            
            if OnOff_params.stim_analysis_type == 5  && stim_selected_by_user == 7
                spkCnt_chan_2 = cell2mat(binSpkCnts_RSC.SpkCnt{this_chan2});
                spkCnt_chan_2_reshape = reshape(spkCnt_chan_2, 1, numel(spkCnt_chan_2));
            else
                
                spkCnt_chan_2 = binSpkCnts_RSC.SpkCnt{this_chan2};
                spkCnt_chan_2_reshape = reshape(spkCnt_chan_2, 1, numel(spkCnt_chan_2));
            end
            
            if sum(spkCnt_chan_2_reshape) ==0
                continue
            end
            
            %% Noise Correlations - CorrCoef - RSC
            [R, P]  = corrcoef(spkCnt_chan_1_reshape, spkCnt_chan_2_reshape);
            
            rSC = R(1, 2);
            %pSC(this_chan1, this_chan2) = P(1, 2);
            pSC = P(1, 2);
            
            %% If plotting
            
            % Z-normalize spike counts
            
            this_chan1_Z = (spkCnt_chan_1_reshape - mean(spkCnt_chan_1_reshape))/std(spkCnt_chan_1_reshape);
            this_chan2_Z = (spkCnt_chan_2_reshape - mean(spkCnt_chan_2_reshape))/std(spkCnt_chan_2_reshape);
            
            %[R_z, P_z]  = corrcoef(this_chan1_Z, this_chan2_Z);
            
            % stats for plots
            meanSpkcnt_chan1 = mean(spkCnt_chan_1_reshape);
            meanSpkcnt_chan2 = mean(spkCnt_chan_2_reshape);
            
            semSpkcnt_chan1 = nanstd(spkCnt_chan_1_reshape)/(sqrt(numel(spkCnt_chan_1_reshape)));
            semSpkcnt_chan2 = nanstd(spkCnt_chan_2_reshape)/(sqrt(numel(spkCnt_chan_2_reshape)));
            
            sumSpkcnt_chan1 = sum(spkCnt_chan_1_reshape);
            sumSpkcnt_chan2 = sum(spkCnt_chan_2_reshape);
            
            if Plot_other_figs
                figure(100);
                
                if num_channels < 5
                    subplot(3, 2, plotcnt)
                else
                    subplot(5, 3, plotcnt) % for 5 channels, we need atleast 10 subplots
                end
                
                plot(this_chan1_Z, this_chan2_Z, 'MarkerFaceColor',[0 0 0],'Marker','o','LineStyle','none','Color',[0 0 0]);
                hold on
                
                xlim([-4, 4])
                ylim([-4, 4])
                
                % Add reference fit
                hline = refline(rSC, 0);
                hline.Color = 'r';
                
                % Legend
                leg = {['n =  ' num2str(allReps) ' reps'], ['Rsc = ' num2str(roundn(rSC, -2)) ', p = ' num2str(roundn(pSC, -3))]};
                %legend(leg, 'location', 'northeast')
                legend(leg)
                
                % Text info
                textChan1 = {[chan1_name ' | spks = ' num2str(sumSpkcnt_chan1) ' | mean = ' num2str(roundn(meanSpkcnt_chan1, -2)) '\pm' num2str(roundn(semSpkcnt_chan1, -2)) ' hz']};
                text(-3.8, -3.0, textChan1)
                
                textChan2 = {[chan2_name ' | spks = ' num2str(sumSpkcnt_chan2) ' | mean = ' num2str(roundn(meanSpkcnt_chan2, -2)) '\pm' num2str(roundn(semSpkcnt_chan2, -2)) ' hz']};
                text(-3.8, -3.5, textChan2)
                
                
                xlabel([chan1_name ' [z-score]'])
                ylabel([chan2_name ' [z-score]'])
                
                title(['Rsc | ' raw_data_info.recording_session ' | ' song_type ' | Neurons ' num2str(this_chan1) ' & ' num2str(this_chan2)])
                plotcnt = plotcnt+1;
            end
            
            RSC.rSC(this_chan1, this_chan2) = rSC;
            RSC.pSC(this_chan1, this_chan2) = pSC;
            
            
        end
    end
    
    if Plot_other_figs
        this_save = [allDirPaths.figDir_RSC 'RSC-' raw_data_info.recording_session '-' song_type '.png'];
        pos = [2.5 2.5 35 35];
        figure(100)
        print_in_A4(0, this_save, '-dpng', 0, pos);
    end
    
    
end

end

