function [TL_Calcs, TS_all_Calcs, TS_np1_Calcs, Diff_Calcs] = analysis_calcXCorrMeansMedians(TL_Reps_thisChanComparion, TS_all_Reps_thisChanComparion, TS_np1_Reps_thisChanComparion)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Time-locked
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~isempty(TL_Reps_thisChanComparion)
    
    TL_Reps_thisChanComparion_cleaned = real(TL_Reps_thisChanComparion); % for xCOH, sometimes imaginary
    
    infs = isinf(TL_Reps_thisChanComparion_cleaned);
    
    TL_Reps_thisChanComparion_cleaned(infs) = nan; % change infs to nans
    
    TL_Calcs.median_TL = nanmedian(TL_Reps_thisChanComparion_cleaned, 1);
    TL_Calcs.mean_TL = nanmean(TL_Reps_thisChanComparion_cleaned, 1);
    TL_Calcs.std_TL = nanstd(TL_Reps_thisChanComparion_cleaned, 1);
    TL_Calcs.sem_TL = TL_Calcs.std_TL/(sqrt(size(TL_Reps_thisChanComparion_cleaned, 1)));
    TL_Calcs.all_TL_Reps = TL_Reps_thisChanComparion_cleaned;
    
else
    TL_Calcs.median_TL = NaN;
    TL_Calcs.mean_TL = NaN;
    TL_Calcs.std_TL = NaN;
    TL_Calcs.sem_TL = NaN;
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Time-shuffled - all reps
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~isempty(TS_all_Reps_thisChanComparion)
    
    TS_all_Reps_thisChanComparion_cleaned = real(TS_all_Reps_thisChanComparion); % change to real
    
    infs = isinf(TS_all_Reps_thisChanComparion);
    
    TS_all_Reps_thisChanComparion_cleaned(infs) = nan; % change infs to nans
    
    TS_all_Calcs.median_TS = nanmedian(TS_all_Reps_thisChanComparion_cleaned, 1);
    TS_all_Calcs.mean_TS = nanmean(TS_all_Reps_thisChanComparion_cleaned, 1);
    TS_all_Calcs.std_TS = nanstd(TS_all_Reps_thisChanComparion_cleaned, 1);
    TS_all_Calcs.sem_TS = TS_all_Calcs.std_TS/(sqrt(size(TS_all_Reps_thisChanComparion_cleaned, 1)));
    TS_all_Calcs.all_TS_all_Reps = TS_all_Reps_thisChanComparion_cleaned;
else
    TS_all_Calcs.median_TS = NaN;
    TS_all_Calcs.mean_TS = NaN;
    TS_all_Calcs.std_TS = NaN;
    TS_all_Calcs.sem_TS = NaN;
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Time-shuffled n +1
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~isempty(TS_np1_Reps_thisChanComparion)
    
    TS_np1_Reps_thisChanComparion_cleaned = real(TS_np1_Reps_thisChanComparion); % change to real
    
    infs = isinf(TS_np1_Reps_thisChanComparion);
    
    TS_np1_Reps_thisChanComparion_cleaned(infs) = nan; % change infs to nans
    
    TS_np1_Calcs.median_TS = nanmedian(TS_np1_Reps_thisChanComparion_cleaned, 1);
    TS_np1_Calcs.mean_TS = nanmean(TS_np1_Reps_thisChanComparion_cleaned, 1);
    TS_np1_Calcs.std_TS = nanstd(TS_np1_Reps_thisChanComparion_cleaned, 1);
    TS_np1_Calcs.sem_TS = TS_np1_Calcs.std_TS/(sqrt(size(TS_np1_Reps_thisChanComparion_cleaned, 1)));
    TS_np1_Calcs.all_TS_np1_Reps = TS_np1_Reps_thisChanComparion_cleaned;
else
    TS_np1_Calcs.median_TS = NaN;
    TS_np1_Calcs.mean_TS = NaN;
    TS_np1_Calcs.std_TS = NaN;
    TS_np1_Calcs.sem_TS = NaN;
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TL - TS differences - Signal Corr
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~isempty(TL_Reps_thisChanComparion) && ~isempty(TS_all_Reps_thisChanComparion)
    
    Diff_Calcs.median_DIFF_TSall = TL_Calcs.median_TL - TS_all_Calcs.median_TS;
    Diff_Calcs.mean_DIFF_TSall = TL_Calcs.mean_TL - TS_all_Calcs.mean_TS;
    
    Diff_Calcs.median_DIFF_TSnp1 = TL_Calcs.median_TL -  TS_np1_Calcs.median_TS;
    Diff_Calcs.mean_DIFF_TSnp1 = TL_Calcs.mean_TL -  TS_np1_Calcs.mean_TS;
    
end

if sum(sum(isnan(TS_all_Reps_thisChanComparion))) ~= numel(TS_all_Reps_thisChanComparion)
    %% pairwise Diff calculation between TL and TSn+1
    
    Diff_Calcs.all_DIFFs_TL_TSnp1_pairs = TL_Reps_thisChanComparion_cleaned - TS_np1_Reps_thisChanComparion_cleaned;
    Diff_Calcs.all_DIFFs_TL_TSnp1_pairs_mean = nanmean(Diff_Calcs.all_DIFFs_TL_TSnp1_pairs, 1);
    Diff_Calcs.all_DIFFs_TL_TSnp1_pairs_median = nanmedian(Diff_Calcs.all_DIFFs_TL_TSnp1_pairs, 1);
    Diff_Calcs.all_DIFFs_TL_TSnp1_pairs_std = nanstd(Diff_Calcs.all_DIFFs_TL_TSnp1_pairs, 1);
    Diff_Calcs.all_DIFFs_TL_TSnp1_pairs_sem = Diff_Calcs.all_DIFFs_TL_TSnp1_pairs_std /(sqrt(size(Diff_Calcs.all_DIFFs_TL_TSnp1_pairs, 1)));
    
else
    Diff_Calcs.median_DIFF_TSall = NaN;
    Diff_Calcs.mean_DIFF_TSall = NaN;
    
    Diff_Calcs.median_DIFF_TSnp1 = NaN;
    Diff_Calcs.mean_DIFF_TSnp1 = NaN;
    
    Diff_Calcs.all_DIFFs_TL_TSnp1_pairs = NaN;
    Diff_Calcs.all_DIFFs_TL_TSnp1_pairs_mean = NaN;
    Diff_Calcs.all_DIFFs_TL_TSnp1_pairs_median = NaN;
    Diff_Calcs.all_DIFFs_TL_TSnp1_pairs_std = NaN;
    Diff_Calcs.all_DIFFs_TL_TSnp1_pairs_sem = NaN;
    
end


end