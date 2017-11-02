function [chan_stats] = analysis_extractIndividualChanStats(this_chan, z_score_stats, AnovaStats, autoCOV, stim_selected_by_user)

chan_stats = [];

%% Channel Name
chan_stats.chan = this_chan;
chan_stats.chan_txt = num2str(this_chan);

%% Stereotypy

chan_stats.F = roundn(AnovaStats.mean_f(this_chan), -2);

%% Z score
chan_stats.z_score = roundn(z_score_stats.z_score_cov(this_chan), -2);

%% FR statistics
chan_stats.stimFR = roundn(z_score_stats.meanFR_Stim(this_chan), -2);
chan_stats.spontFR = roundn(z_score_stats.meanFR_Spont(this_chan), -2);

chan_stats.stimSTD = roundn(z_score_stats.stdFR_Stim(this_chan), -2);
chan_stats.spontSTD = roundn(z_score_stats.stdFR_Spont(this_chan), -2);

chan_stats.stimSEM = roundn((chan_stats.stimSTD)/(sqrt(numel(z_score_stats.chan_FR_vec_Stims{this_chan}))));
chan_stats.spontSEM = roundn((chan_stats.spontSTD)/(sqrt(numel(z_score_stats.chan_FR_vec_Spont{this_chan}))));

%% Auto-covariance
if stim_selected_by_user ~= 7 % No CONs
    chan_stats.AutoCOV = autoCOV.allReps_mean{this_chan};
else
    chan_stats.AutoCOV = NaN;
end

end