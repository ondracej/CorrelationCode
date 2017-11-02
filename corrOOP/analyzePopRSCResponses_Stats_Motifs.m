function [] = analyzePopRSCResponses_Stats_Motifs()
doStim = 1; % 1 stim, 2 = spont
dbstop if error

figH = figure(100);

doPLot = 0;

textstr1 = '100 ms bin' ;
%textstr2 = '50 ms bin' ;

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

%100 vs 50
d_stim1 = load([baseDir 'SortedData/WNSpontOrStim-1s/AudSpkData/100msRSC_INFO_motifs.mat']);
%d_stim = load([baseDir 'SortedData/WNSpontOrStim-1s/AudSpkData/50msRSC_INFO_motifs.mat']);

%d_spont = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Spont-100ms.mat');

%d_stim = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-50ms.mat');
%d_spont = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Spont-50ms.mat');

%d_stim = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-10ms.mat');
%d_spont = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Spont-10ms.mat');

%d_stim2 = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-200ms.mat');
%d_spont = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Spont-200ms.mat');



if exist(saveDir, 'dir') == 0
    mkdir(saveDir);
end

if exist(plotDir, 'dir') == 0
    mkdir(plotDir);
end



stimSet = [6 8 9];
nStims = numel(stimSet );




allCCOverStims_P = d_stim1.RSC.All_CC_P_OverStims;
allCCOverStims_R = d_stim1.RSC.All_CC_R_OverStims;

cols = {'k', 'r', 'b', 'g', 'm', [0.5 0.5 0.5], [0.3 0.5 0.8]};
nComparisons = size(allCCOverStims_P, 1);

scanrate = d_stim1.RSC.scanrate;
%% Stim
allRsThisStim = [];allPsThisStim = [];allpairs = [];allnPairs = []; allKsP = []; allKsR = [];
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
                all_Rs(cnt) = this_R{pairInds(o)};
                all_Ps(cnt) = this_P{pairInds(o)};
                
                
                all_RsKcounter(kcnt) = this_R{pairInds(o)};
                all_PsKcounter(kcnt) = this_P{pairInds(o)};
                
                cnt = cnt+1;
                kcnt = kcnt+1;
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

BinSize1.allRsThisStim = allRsThisStim;
BinSize1.allPsThisStim = allPsThisStim;
%%

allCCOverStims_P = d_stim2.RSC.All_CC_P_OverStims;
allCCOverStims_R = d_stim2.RSC.All_CC_R_OverStims;

allRsThisStim = [];allPsThisStim = [];allpairs = [];allnPairs = []; allKsP = []; allKsR = [];
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
                all_Rs(cnt) = this_R{pairInds(o)};
                all_Ps(cnt) = this_P{pairInds(o)};
                
                
                all_RsKcounter(kcnt) = this_R{pairInds(o)};
                all_PsKcounter(kcnt) = this_P{pairInds(o)};
                
                cnt = cnt+1;
                kcnt = kcnt+1;
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

BinSize2.allRsThisStim = allRsThisStim;
BinSize2.allPsThisStim = allPsThisStim;


for j = 1:nStims
    thisStim = stimSet(j);
    [h{thisStim}, p{thisStim}] = ttest(BinSize1.allRsThisStim{thisStim}, BinSize2.allRsThisStim{thisStim});
end

%%

[pp,  hh] = ranksum(BinSize2.allRsThisStim{6}, BinSize2.allRsThisStim{8})
[hh,  pp] = ttest(BinSize1.allRsThisStim{6}, BinSize1.allRsThisStim{8})


disp('')
end

