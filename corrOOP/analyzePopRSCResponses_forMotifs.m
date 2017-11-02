function [] = analyzePopRSCResponses_forMotifs()

dbstop if error

doStim = 1; % 1 stim, 2 = spont

figH = figure(100);

doPLot = 1;

%textstr = '10ms' ;
%textstr = '50ms' ;
textstr = '100ms' ;
%textstr = '200ms' ;

switch gethostname
    case 'turtle'
        
        saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/';
        plotDir = ['/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/Plots/SpikeRSC/'];
        
        
          rscINFO = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/100msRSC_INFO_motifs.mat');
          R = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-Motif_100ms.mat');
        
%         
%         rscINFO = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/50msRSC_INFO_motifs.mat');
%         R = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-Motif_50ms.mat');
        
    case 'deadpool'
        
        saveDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/';
        plotDir = ['/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/SpikeRSC_MotifBins/'];
        
        
%          rscINFO = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/50msRSC_INFO_motifs.mat');
%         R = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-Motif_50ms.mat');
        
        rscINFO = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/100msRSC_INFO_motifs.mat');
        R = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-Motif_100ms.mat');

        %       d_stim = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-Motif_100ms.mat');
%         d_spont = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Spont-100ms.mat');
        
        
end


if exist(saveDir, 'dir') == 0
    mkdir(saveDir);
end

if exist(plotDir, 'dir') == 0
    mkdir(plotDir);
end



metaRSC = rscINFO.metaRSC;
RSC = R.RSC;

stimSet = [6 8 9];
nStims = numel(stimSet );



%%
cols = {'k', 'r', 'b', 'g', 'm', [0.5 0.5 0.5], [0.3 0.5 0.8]};
nComparisons = size(metaRSC.allKsP_Spont, 1);
scanrate = RSC.scanrate;
allDatNamesLong = RSC.AudDatFiles;
datFiles_77 = RSC.allDataFiles_Aud;
dash = '-';allNamesShort = [];

for j = 1:numel(allDatNamesLong)
    
    thisName = allDatNamesLong{j};
    
    if strcmpi(thisName(end-3:end), '.lvd')
        dashInd = find(thisName == dash);
        allNamesShort{j} = thisName(1:dashInd-2);
    else
        
        allNamesShort{j} = thisName(1:end-3);
    end
end

allNamesShort_77 = [];
for j = 1:numel(datFiles_77)
    
    thisName = datFiles_77{j};
    
    if ~isempty(thisName)
        if strcmpi(thisName(end-3:end), '.lvd')
            dashInd = find(thisName == dash);
            allNamesShort_77{j} = thisName(1:dashInd-2);
        else
            
            allNamesShort_77{j} = thisName(1:end-3);
        end
    end
end

allBirdMatchInds = [];
allBirdMatchInds_77 = [];
nBirds = 16;
for j = 1:nBirds
    
    switch j
        
        case 1
            bird = 'b20r1';
        case 2
            bird = 'g18r2';
        case 3
            bird = 'g4r4';
        case 4
            bird = 'k17r4';
        case 5
            bird = 'k18r4';
        case 6
            bird = 'o19r1';
        case 7
            bird = 'o1r4';
        case 8
            bird = 'o5r3';
        case 9
            bird = 'p11r4';
        case 10
            bird = 'p17r2';
        case 11
            bird = 'r2y20';
        case 12
            bird = 'r3p';
        case 13
            bird = 'r6y11';
        case 14
            bird = 'r6y12';
        case 15
            bird = 'y5y10';
        case 16
            bird = 'yellow20';
    end
    
    allBirdList{j} = bird;
    
    %allBirdMatchInds{j} = cellfun(@x, strfind(x, bird), allNamesShort);
    allBirdMatchInds{j} = find(cellfun(@(x) ~isempty(strfind(bird, x)), allNamesShort));
    allBirdMatchInds_77{j} = find(cellfun(@(x) ~isempty(strfind(bird, x)), allNamesShort_77));
    
end


stimSet = [6 8 9];
nStims = numel(stimSet );

%% collate all data
for k = 1:nBirds
    
    
    theseIndsToUse = allBirdMatchInds_77{k};
    
    allR_OverStims = []; allP_OverStims = [];  allR_Inds_OverStims = []; allP_Inds_OverStims = [];
    for s = 1: nStims
        thisStim = stimSet(s);
        
        cnt = 1;
        all_Rs = []; all_Ps = []; AllRsForInds = [];AllPsForInds = [];
        for q = 1:numel(theseIndsToUse)
            
            
            thisInd = theseIndsToUse(q);
            theseCorrStims_R = RSC.CC_R_OverStims{thisInd, thisStim};
            theseCorrStims_P = RSC.CC_P_OverStims{thisInd, thisStim};
            
            if ~isempty(theseCorrStims_R)
                pairInds = find(cellfun(@(x) ~isempty(x), theseCorrStims_R));
                nPairs(k) = numel(pairInds);
                
                kcnt = 1; all_RsKcounter = []; all_PsKcounter = [];
                for o = 1:numel(pairInds)
                    
                    % test = theseCorrStims_R{pairInds(o)};
                    
                    
                    
                    all_Rs(cnt,:) = theseCorrStims_R{pairInds(o)};
                    all_Ps(cnt,:) = theseCorrStims_P{pairInds(o)};
                    
                    all_RsKcounter(kcnt,:) = theseCorrStims_R{pairInds(o)};
                    all_PsKcounter(kcnt,:) = theseCorrStims_P{pairInds(o)};
                    
                    cnt = cnt+1;
                    kcnt = kcnt+1;
                    
                    
                end
                AllRsForInds{q} = all_RsKcounter;
                AllPsForInds{q} = all_PsKcounter;
                
            end
        end
        allR_OverStims{thisStim} = all_Rs;
        allP_OverStims{thisStim} = all_Ps;
        
        
        allLengths(k, thisStim) = size(all_Rs, 2);
        
        allR_Inds_OverStims{thisStim} = AllRsForInds;
        allP_Inds_OverStims{thisStim} = AllPsForInds;
        
    end
    
    AllR_OverBirds{k} = allR_OverStims;
    allP_OverBirds{k} = allP_OverStims;
    
end


%%





BOS = 8;
jitterAmount = 0.15;
for oo = 1:numel(AllR_OverBirds)
    theseRs = AllR_OverBirds{oo};

 thisRStim = theseRs{BOS};
 %thisRStim = thisRStim(1:8,:)
 
figH = figure(100) ; clf
 for k = 1:size(thisRStim, 2)
        theseRs = thisRStim(:,k);
        
        xes = ones(1, numel(theseRs))*k;
        
        jitterValuesX = 2*(rand(size(xes))-0.5)*jitterAmount;   % +/-jitterAmount max
        hold on
        plot(xes+jitterValuesX, theseRs, 'k.')
        
        
        thisMedian = nanmedian(theseRs);
        thisMean = nanmean(theseRs);
        line([xes(1)-.3 xes(1)+.3], [thisMedian thisMedian], 'color', 'r')

 end
 
 line([.5 size(thisRStim, 2)+.5], [ 0 0], 'color', 'k')
 axis tight
 ylim([-1 1])
 title(allBirdList{oo})
 
 figure(figH)
 plot_filename = [plotDir allBirdList{oo} '-MotifBinsScatter-' textstr];
 plotpos = [0 0 10 5];
 print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
 print_in_A4(0, plot_filename, '-depsc', 0, plotpos);
 
 
 
 disp('')
end





for oo = 1:numel(AllR_OverBirds)
    theseRs = AllR_OverBirds{oo};
    thesePs = allP_OverBirds{oo};
    figH = figure(100); clf
    allStimRs_means = []; allStimRs_medians = []; allStimRs_negs = [];
    
    for s = 1: nStims
        thisStim = stimSet(s);
        
        thisRStim = theseRs{thisStim};
        thisPStim = thesePs{thisStim};
        
        nBins = size(thisRStim, 2);
        
        thesemedians = []; thesemeans = []; CV = [];negs = [];
        
        for o = 1:nBins
            theseBins = thisRStim(:,o);
            
            nanbins = numel(find(isnan(theseBins)));
            negs(o) = (numel(find(theseBins < 0)))/(numel(theseBins) -nanbins) ;
            thesemedians(o) = nanmedian(theseBins);
            thesemeans(o) = nanmean(theseBins);
            %CV(o) = nanstd(theseBins);
            xs = ones(1, numel(theseBins))*o;
            
            
            
            subplot(3, 3, s)
            hold on
            plot(xs, theseBins, 'ko')
            ylim([-1 1])
            title([allBirdList{oo} ' | All RSCs, Stim-' num2str(thisStim)])
            xlim([.5 [nBins+.5]])
            
            subplot(3, 3, s+3)
            
            plot(thesemeans, 'b')
            hold on
            plot(thesemedians, 'k')
            plot(thesemedians, 'ko')
            plot(thesemeans, 'bo')
            title(['Means and Medians, Stim-' num2str(thisStim)])
            legend({'Mean', 'Median'})
            line([1 nBins], [0 0], 'color', 'k')
            ylim([-.3 .3])
            xlim([.5 [nBins+.5]])
            
            subplot(3, 3, s+6)
            hold on
            plot(negs, 'ko')
            plot(negs, 'k')
            title(['Fraction Negative, Stim-' num2str(thisStim)])
            ylim([0 1])
            line([1 nBins], [.5 .5], 'color', 'k')
            xlim([.5 [nBins+.5]])
        end
        
        
        allStimRs_means{thisStim} = thesemeans;
        allStimRs_medians{thisStim} = thesemedians;
        allStimRs_negs{thisStim} = negs;
        
    end
    
    allMeansBirds{oo} = allStimRs_means;
    allMediansBirds{oo} = allStimRs_medians;
    allNegsBirds{oo} = allStimRs_negs;
    
    figure(figH)
    plot_filename = [plotDir allBirdList{oo} '-MotifBins-' textstr];
    plotpos = [0 0 30 15];
    print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
    print_in_A4(0, plot_filename, '-depsc', 0, plotpos);
    
end





disp('')

%% Stim
allRsThisStim = [];allPsThisStim = [];allpairs = [];allnPairs = []; allKsP = []; allKsR = [];

%% First find all the same birds
allDataFiles



for j = 1:nStims
    thisStim = stimSet(j);
    
    cnt = 1;
    all_Rs = []; all_Ps = []; nPairs = [];
    for k = 1:nComparisons
        this_R = allCCOverStims_R{k, thisStim};
        this_P = allCCOverStims_P{k, thisStim};
        
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
    
    allpairs{thisStim} = sum(nPairs);
    allnPairs{thisStim} = nPairs;
end

%%

metaRSC.allRsThisStim = allRsThisStim;
metaRSC.allPsThisStim = allPsThisStim;
metaRSC.allpairs = allpairs;
metaRSC.allnPairs = allnPairs;
metaRSC.allKsR_Stim = allKsR;
metaRSC.allKsP_Stim = allKsP;

%%

for OO = [6 8 9 ]
    
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
            fileNamesMaxs{k} = d_stim.RSC.allDataChans_Aud{k};
            
            
        end
        
        minRsInds = find(theseRs < -0.1);
        if ~isempty(minRsInds)
            disp('')
            minRs{k} = theseRs(minRsInds);
            minPs{k} = thesePs(minRsInds);
            fileNamesMins{k} = d_stim.RSC.allDataChans_Aud{k};
            
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

for OO = [6 8 9]
    
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
            fileNamesMaxs{k} = d_stim.RSC.allDataChans_Aud{k};
        end
        
        minRsInds = find(theseRs < -0.1);
        if ~isempty(minRsInds)
            disp('')
            minRs{k} = theseRs(minRsInds);
            minPs{k} = thesePs(minRsInds);
            fileNamesMins{k} = d_stim.RSC.allDataChans_Aud{k};
            
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
    RsThisSpont = allRsThisSpont{thisStim};
    
    CV_Stim{thisStim} = nanstd(RsThisStim) / nanmean(RsThisStim);
    CV_Spont{thisStim} = nanstd(RsThisSpont) / nanmean(RsThisSpont);
    
end

metaRSC.CV_Stim = CV_Stim;
metaRSC.CV_Spont = CV_Spont;

metaRSC.textstr = textstr;

saveFile = [saveDir textstr 'RSC_INFO_motifs'];
save(saveFile, 'metaRSC')
disp(saveFile)

if doPLot
    %% Boxplot
    
    a3 = allRsThisStim{6}';
    a33 = allRsThisSpont{6}';
    a5 = allRsThisStim{8}';
    a55 = allRsThisSpont{8}';
    a6 = allRsThisStim{9}';
    a66 = allRsThisSpont{9}';
    
    group = [repmat({'REV'}, numel(a3), 1);     repmat({'REV_sp'}, numel(a33), 1);
        repmat({'BOS'}, numel(a5), 1);        repmat({'BOS_sp'}, numel(a55), 1);      repmat({'qBOS'}, numel(a6), 1);    repmat({'qBOS_sp'}, numel(a66), 1);];
    
    %%
    figH = figure(100); clf
    poss = [1 1.5 2.5 3 4 4.5];
    rng(1);
    boxplot([a3; a33; a5; a55; a6; a66], group, 'whisker', 0, 'symbol', 'ko', 'outliersize', 4, 'jitter', 0.7, 'colors', [0 0 0], 'positions', poss)
    ylabel(['Correlation coefficient'])
    ylim([-.5 1.1])
    
    title(['Spike count correlation, ' textstr])
    
    %%
    
    figure(figH)
    plot_filename = [plotDir 'RSC_Boxoplot-Motif' textstr];
    plotpos = [0 0 30 15];
    print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
    print_in_A4(0, plot_filename, '-depsc', 0, plotpos);
    
    
    %%
    
    
    for b = 1:nStims
        thisStim = stimSet(b);
        figHH =  figure(200+b); clf;
        
        x = allRsThisStim{thisStim};
        y = allRsThisSpont{thisStim};
        
        
        %%
        h2 = histogram(y);
        hold on
        h1 = histogram(x);
        
        h1.Normalization = 'probability';
        h1.BinWidth = 0.02;
        
        h2.Normalization = 'probability';
        h2.BinWidth = 0.02;
        
        h2.FaceColor = [.5 .5 .5];
        h1.FaceColor = [0 .2 .5];
        h1.DisplayStyle = 'stairs';
        h2.DisplayStyle = 'stairs';
        xlim([-.25 .75])
        ylim([0 0.2])
        xlabel('Correlation coefficient')
        legend('Spont', 'Stim')
        legend('boxoff')
        title(['Stim ' num2str(thisStim) ' | ' textstr])
        
        figure(figHH)
        plot_filename = [plotDir 'RSC_Hist-Motif' textstr num2str(thisStim)];
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
