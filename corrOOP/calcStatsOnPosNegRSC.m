function [] = calcStatsOnPosNegRSC()

switch gethostname
    case 'turtle'
        
        baseDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/';
        saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/';
        plotDir = ['/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/Plots/SpikeRSC/'];
        
        
    case 'deadpool'
        baseDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/';
        
        saveDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/';
        plotDir = ['/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/SpikeRSC/'];
end


ms10 = load([ baseDir 'SortedData/WNSpontOrStim-1s/AudSpkData/10msRSC_INFO.mat']);
ms50 = load([baseDir 'SortedData/WNSpontOrStim-1s/AudSpkData/50msRSC_INFO.mat']);
ms100 = load([ baseDir 'SortedData/WNSpontOrStim-1s/AudSpkData/100msRSC_INFO.mat']);
ms200 = load([baseDir 'SortedData/WNSpontOrStim-1s/AudSpkData/200msRSC_INFO.mat']);



Pos_Stim_10ms = ms10.metaRSC.nAllSigStim_Max;
Neg_Stim_10ms  = ms10.metaRSC.nAllSigStim_Min;
allRs_10ms = ms10.metaRSC.allRsThisStim;

Pos_Stim_50ms = ms50.metaRSC.nAllSigStim_Max;
Neg_Stim_50ms = ms50.metaRSC.nAllSigStim_Min;
allRs_50ms = ms50.metaRSC.allRsThisStim;

Pos_Stim_100ms = ms100.metaRSC.nAllSigStim_Max;
Neg_Stim_100ms = ms100.metaRSC.nAllSigStim_Min;
allRs_100ms = ms100.metaRSC.allRsThisStim;

Pos_Stim_200ms = ms200.metaRSC.nAllSigStim_Max;
Neg_Stim_200ms = ms200.metaRSC.nAllSigStim_Min;
allRs_200ms = ms200.metaRSC.allRsThisStim;


Pos_Spont_10ms = ms10.metaRSC.nAllSigSpont_Max;
Neg_Spont_10ms  = ms10.metaRSC.nAllSigSpont_Min;

Pos_Spont_50ms = ms50.metaRSC.nAllSigSpont_Max;
Neg_Spont_50ms = ms50.metaRSC.nAllSigSpont_Min;

Pos_Spont_100ms = ms100.metaRSC.nAllSigSpont_Max;
Neg_Spont_100ms = ms100.metaRSC.nAllSigSpont_Min;

Pos_Spont_200ms = ms200.metaRSC.nAllSigSpont_Max;
Neg_Spont_200ms = ms200.metaRSC.nAllSigSpont_Min;



stimSet = [1 4 6 7 8 9 12];

figH = figure(100); clf

for j = 1:4
    
    switch j
        case 1
            
            stim_P = Pos_Stim_10ms;
            stim_N = Neg_Stim_10ms;
            
            spont_P = Pos_Spont_10ms;
            spont_N = Neg_Spont_10ms;
            
            allRs = allRs_10ms;
            col = [0 0 0];
        case 2
            
            
            stim_P = Pos_Stim_50ms;
            stim_N = Neg_Stim_50ms;
            
            spont_P = Pos_Spont_50ms;
            spont_N = Neg_Spont_50ms;
            
            allRs = allRs_50ms;
            
            col = [0.2 0.2 0.2];
            
        case 3
            
            stim_P = Pos_Stim_100ms;
            stim_N = Neg_Stim_100ms;
            
            spont_P = Pos_Spont_100ms;
            spont_N = Neg_Spont_100ms;
            
            allRs = allRs_100ms;
            
            col = [0.4 0.4 0.4];
        case 4
            
            stim_P = Pos_Stim_200ms;
            stim_N = Neg_Stim_200ms;
            
            spont_P = Pos_Spont_200ms;
            spont_N = Neg_Spont_200ms;
            
            allRs = allRs_200ms;
            
            col = [0.6 0.6 0.6];
    end
    
    
    toPLot_stim_P = []; toPLot_stim_N = [];
    toPLot_spont_P = []; toPLot_spont_N = [];
    for k = 1:numel(stimSet)
        thisStim = stimSet(k);
        
        toPLot_stim_P(k) = (stim_P{thisStim} / numel(allRs{thisStim}))*100;
        toPLot_stim_N(k) = (stim_N{thisStim} / numel(allRs{thisStim}))*100;
        
        toPLot_spont_P(k) = (spont_P{thisStim} / numel(allRs{thisStim}))*100;
        toPLot_spont_N(k) = (spont_N{thisStim} / numel(allRs{thisStim}))*100;
        
    end
    
    for k = 1:numel(stimSet)
        thisStim = stimSet(k);
        
        maxN(k) = numel(allRs{thisStim});
        
        toPLot_stim_P_ns(k) = stim_P{thisStim};
        toPLot_stim_N_ns(k) = stim_N{thisStim};
        
        toPLot_spont_P_ns(k) = spont_P{thisStim};
        toPLot_spont_N_ns(k) = spont_N{thisStim};
        
    end
    
    %%
      
    figure(figH)
    
    subplot(1, 4, j)
    
    hold on
    plot(toPLot_stim_P, 'color', [0 0 0], 'marker', 'o')
    plot(toPLot_stim_P, 'color', [0 0 0], 'linewidth', 2)
    
    plot(toPLot_stim_N, 'color', [.5 .5 .5], 'marker', 'o')
    plot(toPLot_stim_N, 'color', [.5 .5 .5], 'linewidth', 2)
    
    %plot(toPLot_spont_P, 'color', [0 0 0], 'marker', 'x')
    %plot(toPLot_spont_P, 'color', [0 0 0], 'linewidth', 2, 'linestyle', '--')
    
    %plot(toPLot_spont_N, 'color', [.5 .5 .5], 'marker', 'x')
    %plot(toPLot_spont_N, 'color', [.5 .5 .5], 'linewidth', 2, 'linestyle', '--')
    
    ylim([-1 50])
    xlim([0 8])

    xticks = 0:1:8;
    set(gca,'XTick',xticks)

    ylabel ('Percentage of neurons')
    legend({'R > 0.1', 'R < -0.1'})
    legend('boxoff')
    
    testData = toPLot_spont_P_ns;
    
    allZs = [];
    for q1 = 1:numel(stimSet)
        Stim_q1 = q1;
        for q2 = 1:numel(stimSet)
            Stim_q2 = q2;
            
            
            %p_hat = (toPLot_stim_N_ns(stim1)+toPLot_stim_N_ns(stim2 ))/(maxN(stim1)+maxN(stim2 ));
            %Z = (toPLot_stim_N_ns(stim1)/maxN(stim1) - toPLot_stim_N_ns(stim2)/maxN(stim2))/(sqrt(p_hat*(1-p_hat) * (1/maxN(stim1) + 1/maxN(stim2))));
            
            p_hat = (testData(Stim_q1)+testData(Stim_q2 ))/(maxN(Stim_q1)+maxN(Stim_q2 ));
            Z = (testData(Stim_q1)/maxN(Stim_q1) - testData(Stim_q2)/maxN(Stim_q2))/(sqrt(p_hat*(1-p_hat) * (1/maxN(Stim_q1) + 1/maxN(Stim_q2))));
            allZs(Stim_q1, Stim_q2) = Z;
            
        end
    end
    
    allZsBins{j} = allZs;
    
end


    figure(figH)
    plot_filename = [plotDir 'RSC_SigRs'];
    plotpos = [0 0 30 8];
    print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
    print_in_A4(0, plot_filename, '-depsc', 0, plotpos);
    
    
disp('')

end