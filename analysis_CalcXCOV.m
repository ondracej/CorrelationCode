function [C_Matrix] = analysis_CalcXCOV(FR_meta, Lags, corrOutputFilename, this_bias, OnOff_params)

%% This function creates a variable C_Matrix which contains a channel x channel
% cell array of the non-redunant channel comparisons. Each cell of the
% channel comparison contains a cell array for each of the unique stims.
% Each cell of this cell array contains all the possible stimlus reptition
% combinations for each unique stim. The identical reptitions are on the diagonal.

%%
dbstop if error;
close all;
%% Decide whether to plot the calculations (1) or not (0)
plot_calc = 0;

%% Unpacking variables
num_channels = FR_meta.num_channels;
channel_numbers = FR_meta.channel_numbers;

unique_stims = OnOff_params.unique_stims;
if OnOff_params.stim_analysis_type == 5 && OnOff_params.stim_selected == 7  %CON motifs
    all_reps = OnOff_params.reps;
else
    reps = OnOff_params.reps;
end

max_lag_bins = Lags.max_lag_bins;

%% Define channel comparisons
for i = 1 : num_channels
    chan1 = channel_numbers(i);
    
    chan1_binnedFR = FR_meta.allBinnedSpkCnts_Stims_forXCOV{chan1};
    
    if isempty(chan1_binnedFR)
        disp(['>> No Bins found for chan | ' num2str(chan1)]);
        continue
    end
    
    for j = i: num_channels
        
        if i >= j % We do not calculated mirrored comparisons
            continue
        end
        
        chan2 = channel_numbers(j);
        chan2_binnedFR = FR_meta.allBinnedSpkCnts_Stims_forXCOV{chan2};
        
        if isempty(chan2_binnedFR)
            disp(['>> No Bins found for chan | ' num2str(chan2)]);
            continue
        end
        
        disp(['>> Calculating | Ch-' num2str(chan1) ' | Ch-' num2str(chan2)]);
        
        %% Define stim and rep comparison
        C_allStimReps_COV = cell(unique_stims, 1);
        C_allStimReps_COH = cell(unique_stims, 1);
        
        for k = 1 : unique_stims
            
            disp(['>> Stim | ' num2str(k)]);
            
            if OnOff_params.stim_analysis_type == 5 && OnOff_params.stim_selected == 7 % CON motifs
                reps = all_reps(k);
            end
            
            C_bin_COV = cell(reps, reps);
            C_bin_COH = cell(reps, reps);
            
            for m = 1: reps
                for n = 1: reps
                    %disp(['>> Rep | ' num2str(n)]);
                    
                    bin_spks1 = chan1_binnedFR{k, 1}(m,:);
                    bin_spks2 = chan2_binnedFR{k, 1}(n,:);
                    
                    comp = ['>> Stim-' num2str(k) ' | Ch-' num2str(chan1) ' Rep-' num2str(m) ' | Ch-' num2str(chan2) ' Rep-' num2str(n)];
                    
                    if sum(bin_spks1) >= 1 && sum(bin_spks2) >= 1 % Check to see if there are more than 1 spike on the channels
                        
                        %% This is the Switch between different COV parameters
                        
                        %% for XCov Calculation
                        switch this_bias.xCOV
                            case 0 % raw
                                [this_COV_bin, rlags] = xcov(bin_spks1, bin_spks2, max_lag_bins);
                                titleTxt_xcov = '-raw';
                            case 1 % biased
                                [this_COV_bin, rlags] = xcov(bin_spks1, bin_spks2, max_lag_bins, 'biased');
                                titleTxt_xcov = '-biased';
                            case 2 % unbiased
                                [this_COV_bin, rlags] = xcov(bin_spks1, bin_spks2, max_lag_bins, 'unbiased');
                                titleTxt_xcov = '-unbiased';
                            case 3 % coef
                                [this_COV_bin, rlags] = xcov(bin_spks1, bin_spks2, max_lag_bins, 'coef');
                                titleTxt_xcov = '-coef';
                        end
                        
                        C_bin_COV{m, n} = this_COV_bin;
                        
                        %% For XCOH Calculation
                        switch this_bias.xCOH
                            case 0 % raw
                                [this_COV_bin, rlags] = xcov(bin_spks1, bin_spks2, max_lag_bins);
                                ch1_auto = xcov(bin_spks1, max_lag_bins);
                                ch2_auto = xcov(bin_spks2, max_lag_bins);
                                this_COH_bin = (ifft(fft(this_COV_bin)./sqrt(fft(ch1_auto).*fft(ch2_auto))));
                                titleTxt_xcoh = '-raw';
                            case 1 % biased
                                [this_COV_bin, rlags] = xcov(bin_spks1, bin_spks2, max_lag_bins, 'biased');
                                ch1_auto = xcov(bin_spks1, max_lag_bins, 'biased');
                                ch2_auto = xcov(bin_spks2, max_lag_bins, 'biased');
                                this_COH_bin = (ifft(fft(this_COV_bin)./sqrt(fft(ch1_auto).*fft(ch2_auto))));
                                titleTxt_xcoh = '-biased';
                            case 2 % unbiased
                                [this_COV_bin, rlags] = xcov(bin_spks1, bin_spks2, max_lag_bins, 'unbiased');
                                ch1_auto = xcov(bin_spks1, max_lag_bins, 'unbiased');
                                ch2_auto = xcov(bin_spks2, max_lag_bins, 'unbiased');
                                this_COH_bin = (ifft(fft(this_COV_bin)./sqrt(fft(ch1_auto).*fft(ch2_auto))));
                                titleTxt_xcoh = '-unbiased';
                            case 3 % coef - should not do this for xCOH
                                disp('Choose another xCOH normaliziation')
                                %[this_cov_bin, rlags] = xcov(bin_spks1, bin_spks2, max_lag_bins, 'coef');
                                %ch1_auto = xcov(bin_spks1, C_win_time, 'coef');
                                %ch2_auto = xcov(bin_spks2, C_win_time, 'coef');
                                %this_COH_bin = (ifft(fft(this_cov_bin)./sqrt(fft(ch1_auto).*fft(ch2_auto))));
                        end
                        
                        C_bin_COH{m, n} = this_COH_bin;
                        
                        %% Plotting
                        if plot_calc ==1
                            
                            subplot(2,1, 1)
                            plot(rlags, C_bin_COV{m, n})
                            hold on
                            title(['xCOV |' titleTxt_xcov ])
                            
                            subplot(2, 1, 2)
                            plot(rlags, C_bin_COH{m, n})
                            hold on
                            title(['xCOH |' titleTxt_xcoh ])
                            
                        end
                        
                        %% If there are less than 1 spikes on the channels.
                    else
                        disp(['<< No spikes | ' comp]);
                        disp(['<< | ' num2str(sum(bin_spks1)) ' | ' num2str(sum(bin_spks2))]);
                        C_bin_COV{m, n} = [];
                        C_bin_COH{m, n} = [];
                    end
                    
                end
            end
            
            %% Here we have to decide which info to save!!
            
            C_allStimReps_COV{k,1} = C_bin_COV;
            C_allStimReps_COH{k,1} = C_bin_COH;
       
        end
        
        COVs{chan1, chan2} = C_allStimReps_COV;
        COHs{chan1, chan2} = C_allStimReps_COH;
    end
end

C_Matrix.COVs = COVs;
C_Matrix.COHs = COHs;

save(corrOutputFilename, 'C_Matrix', '-v7.3')
disp(['<< Finished and saved: ' corrOutputFilename]);

end

