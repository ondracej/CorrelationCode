function [TL_Calcs, TS_all_Calcs, TS_np1_Calcs, Diff_Calcs] = analysis_organizeRepsCalcMeanMedianXcorrs(chans_TL, chans_TS, chans_TS_np1, stim_selected_by_user, OnOff_params)

%% This calculates the mean and median cov/coh function for a specific channel pair

unique_stims = OnOff_params.unique_stims;
reps = OnOff_params.reps;

%% Counters
cnt_Tl = 1;
cnt_TS_all = 1;
cnt_TS_np1 = 1;

%% Here we find which TL rep is not empty so that we can determine the length
not_empty = find(cellfun(@(x) ~isempty(x),chans_TL));

size_of_cor = size(chans_TL{not_empty(1)}, 2);

for o = 1: unique_stims
    
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% TL reps
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if OnOff_params.stim_analysis_type == 5 % Motifs
        TL_Reps_thisChanComparion = NaN(size(chans_TL, 2), size_of_cor);
    end
    
    %% If the TL rep is empty, we change it to a NaN for computing the means
    for p = 1: reps
        if isempty(chans_TL{o, p})
            TL_Reps_thisChanComparion(cnt_Tl,:) = NaN(1,size_of_cor);
        else
            TL_Reps_thisChanComparion(cnt_Tl,:) = chans_TL{o, p};
        end
        cnt_Tl = cnt_Tl +1; % increment counter
    end
    
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% All TS_All comparison reps
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if stim_selected_by_user ~= 7 || OnOff_params.stim_analysis_type == 4 % Spont and Non-CON
        
        if OnOff_params.stim_analysis_type == 5 % Motifs
            TS_all_Reps_thisChanComparion = NaN(size(chans_TS, 2), size_of_cor);
        end
        
        %% If the TS_all rep is empty, we change it to a NaN for computing the means
        for q = 1: reps
            if isempty(chans_TS{o, q})
                TS_all_Reps_thisChanComparion(cnt_TS_all, :) = NaN(1,size_of_cor);
            else
                TS_all_Reps_thisChanComparion(cnt_TS_all, :) = chans_TS{o, q};
            end
            cnt_TS_all = cnt_TS_all +1 ;
        end
        
        
    else
        % Set all CON reps to NaN (no identical repetitions)
        TS_all_Reps_thisChanComparion = NaN(1,size(TL_Reps_thisChanComparion, 2));
    end
    
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% All TS n+1 TS reps
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if stim_selected_by_user ~= 7 || OnOff_params.stim_analysis_type ==4 % Spont and Non-CON
        
        if OnOff_params.stim_analysis_type == 5 % Motifs
            TS_np1_Reps_thisChanComparion = NaN(size(chans_TS_np1, 2), size_of_cor);
        end
        
        %% If the TS_np1 rep is empty, we change it to a NaN for computing the means
        for q = 1: size(chans_TS_np1, 2)
            if isempty(chans_TS_np1{o, q})
                TS_np1_Reps_thisChanComparion(cnt_TS_np1, :) = NaN(1,size_of_cor);
            else
                TS_np1_Reps_thisChanComparion(cnt_TS_np1, :) = chans_TS_np1{o, q};
            end
            cnt_TS_np1 = cnt_TS_np1 +1 ;
        end
        
    else
        % Set all CON reps to NaN (no identical repetitions)
        TS_np1_Reps_thisChanComparion = NaN(1,size(TL_Reps_thisChanComparion, 2));
    end
    
end

%% Determine ratios of TL/TS_All/TS_np1 reps

% Max reps
n_TL_max = numel(chans_TL);
n_TS_all_max = numel(chans_TS);
n_TS_np1_max = numel(chans_TS_np1);

% Empty reps - TL
n_TL_empty  = sum(sum(cellfun(@(x) isempty(x), chans_TL)));
n_TL = n_TL_max - n_TL_empty;

% Empty reps - TS_all
if stim_selected_by_user ~= 7
    n_TS_all_empty  = sum(sum(cellfun(@(x) isempty(x), chans_TS)));
    n_TS_all = n_TS_all_max - n_TS_all_empty;
    % Empty reps - TS_np1
    n_TS_np1_empty  = sum(sum(cellfun(@(x) isempty(x), chans_TS_np1)));
    n_TS_np1 = n_TS_np1_max - n_TS_np1_empty;
    
else
    n_TS_all = NaN;    
    n_TS_np1 = NaN;
end


%% Calculate the Means, Medians, and Stds for the Reps

[TL_Calcs, TS_all_Calcs, TS_np1_Calcs, Diff_Calcs] = analysis_calcXCorrMeansMedians(TL_Reps_thisChanComparion, TS_all_Reps_thisChanComparion, TS_np1_Reps_thisChanComparion);
%[TL_Calcs, TS_Calcs, TS_np1_Calcs, Diff_Calcs] = cc_calc_TL_TS_means_and_medians(all_these_TL_reps, all_these_TS_all_reps, all_these_TS_np1_reps);

%% Save all reps to structure

TL_Calcs.TL_Reps_thisChanComparion = TL_Reps_thisChanComparion;
TS_all_Calcs.TS_all_Reps_thisChanComparion = TS_all_Reps_thisChanComparion;
TS_np1_Calcs.TS_np1_Reps_thisChanComparion = TS_np1_Reps_thisChanComparion;

TL_Calcs.n_TL = n_TL;
TL_Calcs.n_TL_max = n_TL_max;

TS_all_Calcs.n_TS = n_TS_all;
TS_all_Calcs.n_TS_max = n_TS_all_max;

TS_np1_Calcs.n_TS_np1 = n_TS_np1;
TS_np1_Calcs.n_TS_np1_max = n_TS_np1_max;

disp('<< Finished calculating means and medians.')
end




