function [] = analyzePopRSCResponses()

doStim = 1; % 1 stim, 2 = spont
close all

figH = figure(100);

doPLot = 1;

%textstr = '10ms' ;
textstr = '50ms' ;
%textstr = '100ms' ;
%textstr = '200ms' ;

switch gethostname
    case 'turtle'
        
        saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/';
        plotDir = ['/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/Plots/SpikeRSC/'];
        
%         
%         d_stim = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-10ms.mat');
%         d_spont = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Spont-10ms.mat');
%         
% %                         d_stim = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-50ms.mat');
%                         d_spont = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Spont-50ms.mat');
        
        
%                         d_stim = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-100ms.mat');
%                         d_spont = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Spont-100ms.mat');
%         
        
                        d_stim = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-200ms.mat');
                        d_spont = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Spont-200ms.mat');
        
    case 'deadpool'
        
        saveDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/';
        plotDir = ['/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/SpikeRSC/'];
        
        
%                 d_stim = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-100ms.mat');
%                 d_spont = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Spont-100ms.mat');
%         
        
        %         d_stim = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-10ms.mat');
        %         d_spont = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Spont-10ms.mat');
        
                d_stim = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-50ms.mat');
                d_spont = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Spont-50ms.mat');
%         %
%         d_stim = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-200ms.mat');
%         d_spont = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Spont-200ms.mat');
%         
        
        
        
end


if exist(saveDir, 'dir') == 0
    mkdir(saveDir);
end

if exist(plotDir, 'dir') == 0
    mkdir(plotDir);
end



stimSet = [1 4 6 7 8 9 12];
nStims = numel(stimSet );

allCCOverStims_P = d_stim.RSC.All_CC_P_OverStims;
allCCOverStims_R = d_stim.RSC.All_CC_R_OverStims;

allCCOverStims_R_Signal = d_stim.RSC.SignalR;
allCCOverStims_P_Signal = d_stim.RSC.SignalP;

cols = {'k', 'r', 'b', 'g', 'm', [0.5 0.5 0.5], [0.3 0.5 0.8]};
nComparisons = size(allCCOverStims_P, 1);

scanrate = d_stim.RSC.scanrate;
%% Stim
allRsThisStim = [];allPsThisStim = [];allpairs = [];allnPairs = []; allKsP = []; allKsR = [];
for j = 1:nStims
    thisStim = stimSet(j);
    
    cnt = 1;
    all_Rs = []; all_Ps = []; nPairs = [];
    all_Rs_Signal = []; all_Ps_Signal = [];
    for k = 1:nComparisons
        this_R = allCCOverStims_R{k, thisStim};
        this_P = allCCOverStims_P{k, thisStim};
        
        this_R_Signal = allCCOverStims_R_Signal{k, thisStim};
        this_P_Signal = allCCOverStims_P_Signal{k, thisStim};
        
        if ~isempty(this_R)
            
            pairInds = find(cellfun(@(x) ~isempty(x), this_R));
            nPairs(k) = numel(pairInds);
            figure(100); clf
            kcnt = 1; all_RsKcounter = []; all_PsKcounter = [];
            for o = 1:numel(pairInds)
                
                thistestR = this_R{pairInds(o)};
                if thistestR > 0.8 % This is the super correlated nueron
                    allExcludedStim{thisStim} = thistestR;
                    
                    continue
                else
                    
                    all_Rs(cnt) = this_R{pairInds(o)};
                    all_Ps(cnt) = this_P{pairInds(o)};
                    
                    all_Rs_Signal(cnt) = this_R_Signal{pairInds(o)};
                    all_Ps_Signal(cnt) = this_P_Signal{pairInds(o)};
                    
                    
                    all_RsKcounter(kcnt) = this_R{pairInds(o)};
                    all_PsKcounter(kcnt) = this_P{pairInds(o)};
                    
                    cnt = cnt+1;
                    kcnt = kcnt+1;
                end
            end
            
            allKsP{k, thisStim} = all_PsKcounter;
            allKsR{k, thisStim} = all_RsKcounter;
            
        end
        
    end
    
    allRsThisStim{thisStim} = all_Rs;
    allPsThisStim{thisStim} = all_Ps;
    
    allRsThisStim_Signal{thisStim} = all_Rs_Signal;
    allPsThisStim_Signal{thisStim} = all_Ps_Signal;
    
    
    allpairs{thisStim} = sum(nPairs);
    allnPairs{thisStim} = nPairs;
end

%%

metaRSC.allRsThisStim = allRsThisStim;
metaRSC.allPsThisStim = allPsThisStim;

metaRSC.allRsThisStim_Signal = allRsThisStim_Signal;
metaRSC.allPsThisStim_Signal = allPsThisStim_Signal;

metaRSC.allpairs = allpairs;
metaRSC.allnPairs = allnPairs;
metaRSC.allKsR_Stim = allKsR;
metaRSC.allKsP_Stim = allKsP;

%%

for OO = [1 4 6 7 8 9 12]
    
    thisStim = OO;
    
    maxRs = []; maxPs = []; fileNamesMaxs = [];
    minRs = []; minPs = []; fileNamesMins = [];
    for k = 1:nComparisons
        theseRs = allKsR{k, thisStim};
        thesePs = allKsP{k, thisStim};
        
        maxRsInds = find(theseRs > 0.1);
        if ~isempty(maxRsInds)
            disp('')
            maxRs{k} = theseRs(maxRsInds);
            maxPs{k} = thesePs(maxRsInds);
            fileNamesMaxs{k} = d_stim.RSC.allDatNames{k};
            
            
        end
        
        minRsInds = find(theseRs < -0.1);
        if ~isempty(minRsInds)
            disp('')
            minRs{k} = theseRs(minRsInds);
            minPs{k} = thesePs(minRsInds);
            fileNamesMins{k} = d_stim.RSC.allDatNames{k};
            
        end
        
    end
    
    allSigRs_Max = []; allSigPs_Max = [];
    
    for k = 1:numel(maxRs)
        
        allSigRs_Max = [allSigRs_Max maxRs{k}];
        allSigPs_Max = [allSigPs_Max maxPs{k}];
    end
    
    %nRealSigs_max = numel(find(allSigPs_Max < 0.0083));
    nRealSigs_max = numel(find(allSigPs_Max < 0.05));
    
    allSigRs_Min = []; allSigPs_Min = [];
    for k = 1:numel(minRs)
        
        allSigRs_Min = [allSigRs_Min minRs{k}];
        allSigPs_Min = [allSigPs_Min minPs{k}];
    end
    
    %nRealSigs_min = numel(find(allSigPs_Min < 0.0083));
    nRealSigs_min = numel(find(allSigPs_Min < 0.05));
    
    
    metaRSC.maxRsStim{OO} = maxRs;
    metaRSC.maxPsStim{OO} = maxPs;
    metaRSC.filesMax{OO} = fileNamesMaxs;
    
    metaRSC.minRsStim{OO} = minRs;
    metaRSC.minPsStim{OO} = minPs;
    metaRSC.filesMin{OO} = fileNamesMins;
    
    metaRSC.AllSigStimR_Max{OO} = allSigRs_Max;
    metaRSC.AllSigStimP_Max{OO} = allSigPs_Max;
    metaRSC.nAllSigStim_Max{OO} = nRealSigs_max;
    
    metaRSC.AllSigStimR_Min{OO} = allSigRs_Min;
    metaRSC.AllSigStimP_Min{OO} = allSigPs_Min;
    metaRSC.nAllSigStim_Min{OO} = nRealSigs_min;
    
end

disp('')
%% Spont

allCCOverSpont_P = d_spont.RSC.All_CC_P_OverStims;
allCCOverSpont_R = d_spont.RSC.All_CC_R_OverStims;


allRsThisSpont= [];allPsThisSpont = [];allpairs_spont = [];allnPairs_spont = [];
for j = 1:nStims
    thisStim = stimSet(j);
    
    cnt = 1;
    all_Rs = []; all_Ps = []; nPairs = [];
    for k = 1:nComparisons
        this_R = allCCOverSpont_R{k, thisStim};
        this_P = allCCOverSpont_P{k, thisStim};
        
        if ~isempty(this_R)
            pairInds = find(cellfun(@(x) ~isempty(x), this_R));
            nPairs(k) = numel(pairInds);
            figure(100); clf
            
            kcnt = 1; all_RsKcounter = []; all_PsKcounter = [];
            for o = 1:numel(pairInds)
                
                thistestR = this_R{pairInds(o)};
                if thistestR > 0.8
                    allExcludedSpont{thisStim} = thistestR;
                    continue
                else
                    all_Rs(cnt) = this_R{pairInds(o)};
                    all_Ps(cnt) = this_P{pairInds(o)};
                    
                    all_RsKcounter(kcnt) = this_R{pairInds(o)};
                    all_PsKcounter(kcnt) = this_P{pairInds(o)};
                    
                    cnt = cnt+1;
                    kcnt = kcnt+1;
                end
            end
            allKsP_spont{k, thisStim} = all_PsKcounter;
            allKsR_spont{k, thisStim} = all_RsKcounter;
            
            
        end
    end
    
    allRsThisSpont{thisStim} = all_Rs;
    allPsThisSpont{thisStim} = all_Ps;
    
    allpairs_spont{thisStim} = sum(nPairs);
    allnPairs_spont{thisStim} = nPairs;
end


%%

metaRSC.allRsThisSpont = allRsThisSpont;
metaRSC.allPsThisSpont = allPsThisSpont;
metaRSC.allpairs_spont = allpairs_spont;
metaRSC.allnPairs_spont = allnPairs_spont;
metaRSC.allKsR_Spont = allKsR_spont;
metaRSC.allKsP_Spont = allKsP_spont;


%% Spont Sig Counts

for OO = [1 4 6 7 8 9 12]
    
    thisStim = OO;
    
    maxRs = []; maxPs = []; fileNamesMaxs = [];
    minRs = []; minPs = []; fileNamesMins = [];
    for k = 1:nComparisons
        theseRs = allKsR_spont{k, thisStim};
        thesePs = allKsP_spont{k, thisStim};
        
        maxRsInds = find(theseRs > 0.1);
        if ~isempty(maxRsInds)
            disp('')
            maxRs{k} = theseRs(maxRsInds);
            maxPs{k} = thesePs(maxRsInds);
            fileNamesMaxs{k} = d_stim.RSC.allDatNames{k}; 
        end
        
        minRsInds = find(theseRs < -0.1);
        if ~isempty(minRsInds)
            disp('')
            minRs{k} = theseRs(minRsInds);
            minPs{k} = thesePs(minRsInds);
            fileNamesMins{k} = d_stim.RSC.allDatNames{k};
            
        end
        
    end
    
    allSigRs_Max = []; allSigPs_Max = [];
    
    for k = 1:numel(maxRs)
        
        allSigRs_Max = [allSigRs_Max maxRs{k}];
        allSigPs_Max = [allSigPs_Max maxPs{k}];
    end
    
    %nRealSigs_max = numel(find(allSigPs_Max < 0.0083));
    nRealSigs_max = numel(find(allSigPs_Max < 0.05));
    
    allSigRs_Min = []; allSigPs_Min = [];
    for k = 1:numel(minRs)
        
        allSigRs_Min = [allSigRs_Min minRs{k}];
        allSigPs_Min = [allSigPs_Min minPs{k}];
    end
    
    %nRealSigs_min = numel(find(allSigPs_Min < 0.0083));
    nRealSigs_min = numel(find(allSigPs_Min < 0.05));
    
    
    metaRSC.maxRsSpont{OO} = maxRs;
    metaRSC.maxPsSpont{OO} = maxPs;
    metaRSC.filesMax_Spont{OO} = fileNamesMaxs;
    
    metaRSC.minRsSpont{OO} = minRs;
    metaRSC.minPsSpont{OO} = minPs;
    metaRSC.filesMin_Spont{OO} = fileNamesMins;
    
    metaRSC.AllSigSpontR_Max{OO} = allSigRs_Max;
    metaRSC.AllSigSpontP_Max{OO} = allSigPs_Max;
    metaRSC.nAllSigSpont_Max{OO} = nRealSigs_max;
    
    metaRSC.AllSigSpontR_Min{OO} = allSigRs_Min;
    metaRSC.AllSigSpontP_Min{OO} = allSigPs_Min;
    metaRSC.nAllSigSpont_Min{OO} = nRealSigs_min;
    
end


%% Exclude data from ind  = 61
%% CV analysis


for j = 1:nStims
    thisStim = stimSet(j);
    
    RsThisStim = allRsThisStim{thisStim};
    RsThisStim_Signal = allRsThisStim_Signal{thisStim};
    RsThisSpont = allRsThisSpont{thisStim};
    
    STD_Stim{thisStim} = nanstd(RsThisStim);
    STD_Stim_Signal{thisStim} = nanstd(RsThisStim_Signal);
    STD_Spont{thisStim} = nanstd(RsThisSpont);
    
    CV_Stim{thisStim} = nanstd(RsThisStim) / nanmean(RsThisStim);
    CV_Stim_Signal{thisStim} = nanstd(RsThisStim_Signal) / nanmean(RsThisStim_Signal);
    CV_Spont{thisStim} = nanstd(RsThisSpont) / nanmean(RsThisSpont);
    
end

metaRSC.CV_Stim = CV_Stim;
metaRSC.CV_Spont = CV_Spont;
metaRSC.CV_Stim_Signal = CV_Stim_Signal;

metaRSC.std_Stim = STD_Stim;
metaRSC.std_Spont = CV_Spont;
metaRSC.std_StimSignal = CV_Stim_Signal;

metaRSC.textstr = textstr;

saveFile = [saveDir textstr 'RSC_INFO'];
save(saveFile, 'metaRSC')
disp(saveFile)

if doPLot
    %% Boxplot
    
    a1 = allRsThisStim{1}';
    a11 = allRsThisSpont{1}';
    a2 = allRsThisStim{4}';
    a22 = allRsThisSpont{4}';
    a3 = allRsThisStim{6}';
    a33 = allRsThisSpont{6}';
    a4 = allRsThisStim{7}';
    a44 = allRsThisSpont{7}';
    a5 = allRsThisStim{8}';
    a55 = allRsThisSpont{8}';
    a6 = allRsThisStim{9}';
    a66 = allRsThisSpont{9}';
    a7 = allRsThisStim{12}';
    a77 = allRsThisSpont{12}';
    
    group = [repmat({'WNS'}, numel(a1), 1);   repmat({'WNS_sp'}, numel(a11), 1);      repmat({'Stacks'}, numel(a2), 1);  repmat({'Stacks_sp'}, numel(a22), 1);
        repmat({'REV'}, numel(a3), 1);     repmat({'REV_sp'}, numel(a33), 1);   repmat({'CON'}, numel(a4), 1);    repmat({'CON_sp'}, numel(a44), 1);
        repmat({'BOS'}, numel(a5), 1);        repmat({'BOS_sp'}, numel(a55), 1);      repmat({'qBOS'}, numel(a6), 1);    repmat({'qBOS_sp'}, numel(a66), 1);
        repmat({'WNE'}, numel(a7), 1);       repmat({'WNE_sp'}, numel(a77), 1)];
    
    %%
    figH = figure(100); clf
    poss = [1 1.5 2.5 3 4 4.5 5.5 6 7 7.5 8.5 9 10 10.5];
    rng(1);
    boxplot([a1;a11;a2; a22; a3; a33; a4; a44; a5; a55; a6; a66; a7; a77], group, 'whisker', 0, 'symbol', 'ko', 'outliersize', 4, 'jitter', 0.7, 'colors', [0 0 0], 'positions', poss)
    ylabel(['Correlation coefficient'])
    ylim([-.5 1.1])
    
    title(['Spike count correlation, ' textstr])
    
    %%
    
    figure(figH)
    plot_filename = [plotDir 'RSC_Boxoplot' textstr];
    plotpos = [0 0 30 15];
    print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
    print_in_A4(0, plot_filename, '-depsc', 0, plotpos);
    
    
    %%
    
    
    
    a111 = allRsThisStim_Signal{1}';
    a1 = allRsThisStim{1}';
    a11 = allRsThisSpont{1}';
    
    a222 = allRsThisStim_Signal{4}';
    a2 = allRsThisStim{4}';
    a22 = allRsThisSpont{4}';
    
    a333 = allRsThisStim_Signal{6}';
    a3 = allRsThisStim{6}';
    a33 = allRsThisSpont{6}';
    
    a444 = allRsThisStim_Signal{7}';
    a4 = allRsThisStim{7}';
    a44 = allRsThisSpont{7}';
    
    a555 = allRsThisStim_Signal{8}';
    a5 = allRsThisStim{8}';
    a55 = allRsThisSpont{8}';
    
    a666 = allRsThisStim_Signal{9}';
    a6 = allRsThisStim{9}';
    a66 = allRsThisSpont{9}';
    
    a777 = allRsThisStim_Signal{12}';
    a7 = allRsThisStim{12}';
    a77 = allRsThisSpont{12}';
    
    group = [repmat({'WNS_sig'}, numel(a111), 1); repmat({'WNS_noise'}, numel(a1), 1);   repmat({'WNS_sp'}, numel(a11), 1);
        repmat({'Stacks_sig'}, numel(a222), 1); repmat({'Stacks_noise'}, numel(a2), 1);  repmat({'Stacks_sp'}, numel(a22), 1);
        repmat({'REV_sig'}, numel(a333), 1);     repmat({'REV_noise'}, numel(a3), 1);     repmat({'REV_sp'}, numel(a33), 1);
        repmat({'CON_sig'}, numel(a444), 1);    repmat({'CON_noise'}, numel(a4), 1);    repmat({'CON_sp'}, numel(a44), 1);
        repmat({'BOS_sig'}, numel(a555), 1); repmat({'BOS_noise'}, numel(a5), 1);        repmat({'BOS_sp'}, numel(a55), 1);
        repmat({'qBOS_sig'}, numel(a666), 1); repmat({'qBOS_noise'}, numel(a6), 1);    repmat({'qBOS_sp'}, numel(a66), 1);
        repmat({'WNE_sig'}, numel(a777), 1);       repmat({'WNE_noise'}, numel(a7), 1);       repmat({'WNE_sp'}, numel(a77), 1)];
    
    %%
    figH = figure(100); clf
    poss = [1 1.5 2.0  3 3.5 4  5 5.5 6  7 7.5 8  9 9.5 10  11 11.5 12  13 13.5 14];
    line([poss(1)-1 poss(end)+1], [0 0], 'color', 'r') 
    hold on
    rng(1);
    boxplot([a111; a1;a11; a222; a2; a22; a333; a3; a33; a444; a4; a44; a555; a5; a55; a666; a6; a66; a777; a7; a77], group, 'whisker', 0, 'symbol', 'ko', 'outliersize', 4, 'jitter', 0.7, 'colors', [0 0 0], 'positions', poss)
    ylabel(['Correlation coefficient'])
    hold on
    
    
    ylim([-1.1 1.1])
    
    title(['Spike count correlation, ' textstr])
     
    figure(figH)
    plot_filename = [plotDir 'RSC_Boxoplot_SigNoiseSpont' textstr];
    plotpos = [0 0 30 15];
    print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
    print_in_A4(0, plot_filename, '-depsc', 0, plotpos);
    
    
    
    %% Sig Diffs
    
    %{
    [h1, p1] = ttest(a111, a1);
    [h2, p2] = ttest(a222, a2);
    [h3, p3] = ttest(a333, a3);
    [h4, p4] = ttest(a444, a4);
    [h5, p5] = ttest(a555, a5);
    [h6, p6] = ttest(a666, a6);
    [h7, p7] = ttest(a777, a7);
    
    [hs1, ps1] = ttest(a11, a1);
    [hs2, ps2] = ttest(a22, a2);
    [hs3, ps3] = ttest(a33, a3);
    [hs4, ps4] = ttest(a44, a4);
    [hs5, ps5] = ttest(a55, a5);
    [hs6, ps6] = ttest(a66, a6);
    [hs7, ps7] = ttest(a77, a7);
    
    
    [hn1, pn1] = ttest(a111, a11);
    [hn2, pn2] = ttest(a222, a22);
    [hn3, pn3] = ttest(a333, a33);
    [hn4, pn4] = ttest(a444, a44);
    [hn5, pn5] = ttest(a555, a55);
    [hn6, pn6] = ttest(a666, a66);
    [hn7, pn7] = ttest(a777, a77);
    
    %%
    
     [h1, p1] = signrank(a111, a1);
    [h2, p2] = signrank(a222, a2);
    [h3, p3] = signrank(a333, a3);
    [h4, p4] = signrank(a444, a4);
    [h5, p5] = signrank(a555, a5);
    [h6, p6] = signrank(a666, a6);
    [h7, p7] = signrank(a777, a7);
    
    [hs1, ps1] = signrank(a11, a1);
    [hs2, ps2] = signrank(a22, a2);
    [hs3, ps3] = signrank(a33, a3);
    [hs4, ps4] = signrank(a44, a4);
    [hs5, ps5] = signrank(a55, a5);
    [hs6, ps6] = signrank(a66, a6);
    [hs7, ps7] = signrank(a77, a7);
    
    
    [hn1, pn1] = signrank(a111, a11);
    [hn2, pn2] = signrank(a222, a22);
    [hn3, pn3] = signrank(a333, a33);
    [hn4, pn4] = signrank(a444, a44);
    [hn5, pn5] = signrank(a555, a55);
    [hn6, pn6] = signrank(a666, a66);
    [hn7, pn7] = signrank(a777, a77);
    
    
    %%
    [h,p] = lillietest(a555); % h = 1 when the data is not normal
    [h,p]  = jbtest(a555);
    [h, p] = kstest(a555);
    
    %}
    
    %%
    
    for b = 1:nStims
        thisStim = stimSet(b);
        figHH =  figure(200+b); clf;
        
        x = allRsThisStim{thisStim};
        y = allRsThisSpont{thisStim};
        z = allRsThisStim_Signal{thisStim};
        
        %%
        h2 = histogram(y);
        hold on
        h1 = histogram(x);
        h3 = histogram(z);
        
        h1.Normalization = 'probability';
        h1.BinWidth = 0.02;
        
        h2.Normalization = 'probability';
        h2.BinWidth = 0.02;
        
        h3.Normalization = 'probability';
        h3.BinWidth = 0.02;
        
        h2.FaceColor = [.5 .5 .5];
        h1.FaceColor = [0 .2 .5];
        h3.FaceColor = [1 1 1];
        
        h1.DisplayStyle = 'stairs';
        h2.DisplayStyle = 'stairs';
        h3.DisplayStyle = 'stairs';
        
        %xlim([-.25 .75])
        xlim([-1 1])
        ylim([0 0.2])
        xlabel('Correlation coefficient')
        legend('Spont', 'Stim', 'Signal')
        legend('boxoff')
        title(['Stim ' num2str(thisStim) ' | ' textstr])
        
        figure(figHH)
        plot_filename = [plotDir 'RSC_Hist' textstr num2str(thisStim)];
        plotpos = [0 0 10 10];
        print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
        print_in_A4(0, plot_filename, '-depsc', 0, plotpos);
        
        
    end
end
%{
disp('')

for b = 1:nStims
    thisStim = stimSet(b);
    figHH =  figure(200+b); clf;
    
    x = allRsThisStim{thisStim};
    y = allRsThisSpont{thisStim};
    
    allxy = [x y];
    
    minX = min(allxy);
    maxX = max(allxy);
    x_values = minX:.01:maxX;
    
    
    pdX = fitdist(x', 'Exponential');
    pdY = fitdist(y', 'Exponential');
    
    blay1 = pdf(pdX,x_values);
    blay2 = pdf(pdY,x_values);
    
    figure(300); clf
plot(x_values,blay1,'LineWidth',2)
hold on
plot(x_values,blay2,'LineWidth',2)

%}


end
