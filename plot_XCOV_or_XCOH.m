function  [] = plot_XCOV_or_XCOH(COV_or_COH, binSpkCnts_RSC, title_name, RSC, x_time, TL_Calcs, TS_all_Calcs, TS_np1_Calcs, Diff_Calcs, chan1_stats, chan2_stats, save_name, export_to, pos, BinInfo, mean_or_median, zoom)

%plot_XCOV_or_XCOH(COV_or_COH, Binned_Spike_Count_CCs, title_name, stim_cor_cofs, x_lag, TL_Calcs, TS_Calcs, TS_np1_Calcs, Diff_Calcs, C_matrix_spktrain, chan1_stats, chan2_stats, save_name, export_to, pos, C_win_time, BIN_size_text, BIN_size_ms, mean_or_median)

switch COV_or_COH
    case 1
        ylab = 'Covariance';
        y_lim_scale = [-0.3 0.3];
    case 2
        ylab = 'Coherency';
        y_lim_scale = [-0.5 0.5];
end

gray = [.5,0.5,.5];
blue = [0,0.7,1];
red = [.9,0,.2];
green = [0 .5 .2];
dk_green = [0 .7 .3];

%% channelsss
this_chan1 = chan1_stats.chan;
this_chan2 = chan2_stats.chan;

%% COV/COH functions

%% TL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mean_TL_reps = TL_Calcs.mean_TL;
median_TL_reps = TL_Calcs.median_TL;
sem_TL = TL_Calcs.sem_TL;
all_TL_reps = TL_Calcs.TL_Reps_thisChanComparion;

n_TL = TL_Calcs.n_TL;
n_TL_max = TL_Calcs.n_TL_max;

%% TS -All %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mean_TS_all_reps = TS_all_Calcs.mean_TS;
median_TS_all_reps = TS_all_Calcs.median_TS;
sem_TS_all = TS_all_Calcs.sem_TS;
all_TS_all_reps = TS_all_Calcs.TS_all_Reps_thisChanComparion;

n_TS_all = TS_all_Calcs.n_TS;
n_TS_all_max = TS_all_Calcs.n_TS_max;

%% TS -n+1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mean_TS_np1_reps = TS_np1_Calcs.mean_TS;
median_TS_np1_reps = TS_np1_Calcs.median_TS;
sem_TS_np1 = TS_np1_Calcs.sem_TS;
all_TS_np1_reps = TS_np1_Calcs.TS_np1_Reps_thisChanComparion;

n_TS_np1 = TS_np1_Calcs.n_TS_np1;
n_TS_np1_max = TS_np1_Calcs.n_TS_np1_max;


%TL_spktrain = C_matrix_spktrain.C_matrix_TL_spktrain{this_chan1, this_chan2}';
%TS_spktrain = C_matrix_spktrain.C_matrix_TS_spktrain{this_chan1, this_chan2}';
%TS_plus1_spktrain = C_matrix_spktrain.C_matrix_TS_plus1_spktrain{this_chan1, this_chan2}';

%% Set the significance levels: Do a bonferroni correction for false positives
timebins = size(x_time, 2);
bonf = 0.05/timebins;
sig_levels = [bonf 0.01 0.05];

%% Switch between Means or Medians

switch mean_or_median
    case 0 % means
        m_TL_reps = mean_TL_reps;
        m_TS_all_reps = mean_TS_all_reps;
        m_TS_np1_reps = mean_TS_np1_reps;
        
        m_all_DIFFs_TS_all_reps = Diff_Calcs.mean_DIFF_TSall;
        m_all_DIFFs_TS_np1_reps = Diff_Calcs.mean_DIFF_TSnp1;
        m_all_DIFFs_TL_TSnp1_pairs_reps = Diff_Calcs.all_DIFFs_TL_TSnp1_pairs_mean;
        
        
    case 1 % medians
        m_TL_reps = median_TL_reps;
        m_TS_all_reps = median_TS_all_reps;
        m_TS_np1_reps = median_TS_np1_reps;
        
        m_all_DIFFs_TS_all_reps = Diff_Calcs.median_DIFF_TSall;
        m_all_DIFFs_TS_np1_reps = Diff_Calcs.median_DIFF_TSnp1;
        m_all_DIFFs_TL_TSnp1_pairs_reps = Diff_Calcs.all_DIFFs_TL_TSnp1_pairs_median;
        
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot mean XCOV/XCOH and sems %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
this_fig = figure(104);
axes('Fontsize', 14);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% First plot (top) TL & ALL TS calculations on individual reps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(3, 5, [1 2 3 4])
hold on

% plot mean TL and mean TS_all (for legend)
plot(x_time, real(m_TL_reps), 'k', 'linewidth', 1);
plot(x_time, real(m_TS_all_reps), 'Color', dk_green, 'linewidth', 1);
line([0 0], [y_lim_scale(1) y_lim_scale(2)], 'color', [0 0 0], 'linestyle', ':')

% add shading for sems
smoothedpart1 = real(m_TS_all_reps+sem_TS_all); %TS_all
smoothedpart1a = real(m_TS_all_reps-sem_TS_all); %TS_all

smoothedpart2 = real(m_TL_reps+sem_TL); %TL
smoothedpart2a = real(m_TL_reps-sem_TL); %TL

jbfill(x_time,[smoothedpart1],[smoothedpart1a],[0 .8 .2],[0 .8 .2],[],.3);
jbfill(x_time,[smoothedpart2],[smoothedpart2a],[.5,0.5,.5],[.5,0.5,.5],[],.3);

% plot mean TL and mean TS_all
plot(x_time, real(m_TL_reps), 'k', 'linewidth', 1);
plot(x_time, real(m_TS_all_reps), 'Color', dk_green, 'linewidth', 1);

% legend/axis info
if mean_or_median == 0
    leg = {['Mean TL (signal+noise), n = ' num2str(n_TL) '/' num2str(n_TL_max)], ['Mean TS all (signal), n = ' num2str(n_TS_all) '/' num2str(n_TS_all_max)]};
elseif mean_or_median ==1
    leg = {['Median TL (signal+noise), n = ' num2str(n_TL) '/' num2str(n_TL_max)], ['Median TS all (signal), n = ' num2str(n_TS_all) '/' num2str(n_TS_all_max)]};
end

% Set legend
legend(leg, 'FontSize', 10);
legend('boxoff');
ylabel(ylab, 'FontSize',12);


% Hardcode the x axis labels
updateXaxis(zoom, BinInfo, gca)

ylim(y_lim_scale)
xlabel(['Time Lag [ms]'],'FontSize',12)
title(title_name)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Second plot (middle) TL & TS n+1 calculations on individual reps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(3, 5, [6 7 8 9])

hold on
% plot mean TL and mean TS_np1 (for legend)
plot(x_time, real(m_TL_reps), 'k', 'linewidth', 1);
plot(x_time, real(m_TS_np1_reps), 'b', 'linewidth', 1);
line([0 0], [y_lim_scale(1) y_lim_scale(2)], 'color', [0 0 0], 'linestyle', ':')

% add shading for sems
smoothedpart1 = real(m_TL_reps+sem_TL); %TL
smoothedpart1a = real(m_TL_reps-sem_TL); %TL

smoothedpart2a = real(m_TS_np1_reps-sem_TS_np1); %TS_np1
smoothedpart2 = real(m_TS_np1_reps+sem_TS_np1); %TS_np1

jbfill(x_time,[smoothedpart1],[smoothedpart1a],[.5,0.5,.5],[.5,0.5,.5],[],.3);
jbfill(x_time,[smoothedpart2],[smoothedpart2a],[0,0.7,1],[0,0.7,1],[],.3);

% plot mean TL and mean TS_np1
plot(x_time, real(m_TL_reps), 'k', 'linewidth', 1);
plot(x_time, real(m_TS_np1_reps), 'b', 'linewidth', 1);


% legend/axis info
if mean_or_median ==0
    leg = {['Mean TL (signal+noise), n = ' num2str(n_TL) '/' num2str(n_TL_max)], ['Mean TS n+1 (signal), n = ' num2str(n_TS_np1) '/' num2str(n_TS_np1_max)]};
elseif mean_or_median ==1
    leg = {['Median TL (signal+noise), n = ' num2str(n_TL) '/' num2str(n_TL_max)], ['Median TS n+1 (signal), n = ' num2str(n_TS_np1) '/' num2str(n_TS_np1_max)]};
end

% Set legend
legend(leg, 'FontSize', 10);
legend('boxoff');
ylabel(ylab, 'FontSize',12);

axis tight
ylim(y_lim_scale)
xlabel(['Time Lag [ms]'],'FontSize',12)

% Hardcode the x axis labels
updateXaxis(zoom, BinInfo, gca)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Third plot (bottom) Difference plots for TL-TS all and TL-TS-np1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(3, 5, [11 12 13 14])

%% plot mean TL and mean TS

hold on

plot(x_time, real(m_all_DIFFs_TS_all_reps), 'Color', dk_green, 'linewidth', 1);
plot(x_time, real(m_all_DIFFs_TS_np1_reps), 'b', 'linewidth', 1);
plot(x_time, real(m_all_DIFFs_TL_TSnp1_pairs_reps), 'Color', red, 'linewidth', 1);
line([0 0], [y_lim_scale(1) y_lim_scale(2)], 'color', [0 0 0], 'linestyle', ':')

% add shading for sems
smoothedpart1 = real(m_all_DIFFs_TL_TSnp1_pairs_reps+Diff_Calcs.all_DIFFs_TL_TSnp1_pairs_sem); %TL
smoothedpart1a = real(m_all_DIFFs_TL_TSnp1_pairs_reps-Diff_Calcs.all_DIFFs_TL_TSnp1_pairs_sem); %TL
jbfill(x_time,[smoothedpart1],[smoothedpart1a],[.9,0,.2],[.9,0,.2],[],.3);

plot(x_time, real(m_all_DIFFs_TS_all_reps), 'Color', dk_green, 'linewidth', 1);
plot(x_time, real(m_all_DIFFs_TS_np1_reps), 'b', 'linewidth', 1);
plot(x_time, real(m_all_DIFFs_TL_TSnp1_pairs_reps), 'Color', red, 'linewidth', 1);

% legend/axis info
leg = {['TL-TS all (Noise)'], ['TL-TS n+1 (Noise)'], ['TL-TS n+1 pairs (Noise)']};
legend(leg, 'FontSize', 10);
legend('boxoff');
ylabel(ylab, 'FontSize',12);
xlabel(['Time Lag [ms]'],'FontSize',12)

axis tight

ylim(y_lim_scale)

% Hardcode the x axis labels
updateXaxis(zoom, BinInfo, gca)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLotting the Data Table %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% spike count correlations
if this_chan2 > size(RSC.pSC, 2) || this_chan1 > size(RSC.pSC, 1) % if no spikes were present for one of the RSC calcs, it gets skipped in the calculation
    RSC_p = NaN;
    RSC_r = NaN;
else
    RSC_p = roundn(RSC.pSC(this_chan1, this_chan2), -6);
    RSC_r = roundn(RSC.rSC(this_chan1, this_chan2), -3);
end

if iscell(binSpkCnts_RSC.SpkCnt{1, this_chan1})
RSC_chan1Spkcnt = sum(sum(cell2mat(binSpkCnts_RSC.SpkCnt{1, this_chan1})));
RSC_chan2Spkcnt = sum(sum(cell2mat(binSpkCnts_RSC.SpkCnt{1, this_chan2})));
else
RSC_chan1Spkcnt = sum(sum(binSpkCnts_RSC.SpkCnt{1, this_chan1}));
RSC_chan2Spkcnt = sum(sum(binSpkCnts_RSC.SpkCnt{1, this_chan2}));
end

%% Chan1 Stats
chan1z = chan1_stats.z_score;
chan1F = chan1_stats.F;
chan1SpontFR = chan1_stats.spontFR;
chan1StimFR = chan1_stats.stimFR;
chan1SpontSEM = chan1_stats.spontSEM;
chan1StimSEM = chan1_stats.stimSEM;

%% Chan2 stats
chan2z = chan2_stats.z_score;
chan2F = chan2_stats.F;
chan2SpontFR = chan2_stats.spontFR;
chan2StimFR = chan2_stats.stimFR;
chan2SpontSEM = chan2_stats.spontSEM;
chan2StimSEM = chan2_stats.stimSEM;

%% Annotate!!

% Y labels

this_String = {' ','Z-Score: ','F-Value: ','FR Spont: ','FR Evoked: '};
annotation(this_fig,'textbox',[0.75 0.15 .2 0.75],'String',this_String,'FitBoxToText','on','Fontsize',8,'LineStyle','none');

% Neuron 1
this_String_chan1 = {['Neuron ' chan1_stats.chan_txt], num2str(chan1z), num2str(chan1F),[num2str(chan1SpontFR) ' \pm ' num2str(chan1SpontSEM)], [num2str(chan1StimFR) ' \pm ' num2str(chan1StimSEM)] };
annotation(this_fig,'textbox',[0.83 0.15 0.25 0.75],'String',this_String_chan1, 'FitBoxToText','on', 'Fontsize',8,'LineStyle','none');

% Neuron 2
this_String_chan2 = {['Neuron ' chan2_stats.chan_txt], num2str(chan2z), num2str(chan2F),[num2str(chan2SpontFR) ' \pm ' num2str(chan2SpontSEM)], [num2str(chan2StimFR) ' \pm ' num2str(chan2StimSEM)]};
annotation(this_fig,'textbox',[0.92 0.15 0.25 0.75],'String',this_String_chan2, 'FitBoxToText','on', 'Fontsize',8,'LineStyle','none');

% Both neurons

this_String_RCC = {' ', ['Ch-' chan1_stats.chan_txt ' & ' chan2_stats.chan_txt ': Noise Correlations'], 'RSC: ', 'SpkCnts:'};
annotation(this_fig,'textbox',[0.75 0.06 0.15 0.6],'String',this_String_RCC, 'FitBoxToText','on', 'Fontsize',8,'LineStyle','none');

this_String_RCC_values = {' ', ' ', [num2str(RSC_r) ', p = ' num2str(RSC_p)], [num2str(RSC_chan1Spkcnt) ' & ' num2str(RSC_chan2Spkcnt) ' spks']};
annotation(this_fig,'textbox',[0.83 0.15 0.15 0.51],'String',this_String_RCC_values, 'FitBoxToText','on', 'Fontsize',8,'LineStyle','none');

disp('')

figure(104);
if mean_or_median == 0
    this_save_name = [save_name(1:end-4) '-Means'];
elseif mean_or_median == 1
    this_save_name = [save_name(1:end-4) '-Medians'];
end

if zoom
    this_save_name = [this_save_name '-Zoom'];
end

print_in_A4(0, this_save_name, export_to, 1, pos);
disp(['<<< Saved:' this_save_name]);

end

function updateXaxis(zoom, BinInfo, gca)

if zoom
    switch BinInfo.BIN_size_ms
        case 1
            xlim([-200 200]);
            set(gca,'XTick',[-200 -150 -100 -50 0 50 100 150 200])
            set(gca,'XTickLabel',{'-200','-150','-100','-50','0', '50', '100', '150', '200'});
        case 5
            xlim([-40 40]);
            set(gca,'XTick',[-40 -30 -20 -10 0 10 20 30 40])
            set(gca,'XTickLabel',{'-200','-150','-100','-50','0', '50', '100', '150', '200'})
        case 10
            xlim([-20 20]);
            set(gca,'XTick',[-20 -15 -10 -5 0 5 10 15 20])
            set(gca,'XTickLabel',{'-200','-150','-100','-50','0', '50', '100', '150', '200'})
    end
else
    
    switch BinInfo.BIN_size_ms
        case 1
            set(gca,'XTick',[-1000 -750 -500 -250 0 250 500 750 1000])
            set(gca,'XTickLabel',{'-1000','-750','-500','-250','0', '250', '500', '750', '1000'})
        case 5
            set(gca,'XTick',[-200 -150 -100 -50 0 50 100 150 200])
            set(gca,'XTickLabel',{'-1000','-750','-500','-250','0', '250', '500', '750', '1000'})
        case 10
            set(gca,'XTick',[-100 -75 -50 -25 0 25 50 75 100])
            set(gca,'XTickLabel',{'-1000','-750','-500','-250','0', '250', '500', '750', '1000'})
    end
end
end

