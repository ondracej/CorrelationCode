function []  = compareRSCNsForStims()

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

d_stim_10ms = load([baseDir 'SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-10ms.mat']);
d_stim_50ms = load([baseDir 'SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-50ms.mat']);
d_stim_100ms = load([baseDir 'SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-100ms.mat']);
d_stim_200ms = load([baseDir 'SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-200ms.mat']);

d_spont_10ms = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Spont-10ms.mat');
d_spont_50ms = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Spont-50ms.mat');
d_spont_100ms = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Spont-100ms.mat');
d_spont_200ms = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Spont-200ms.mat');

disp('')
%%

ms10 = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/10msRSC_INFO.mat');
ms50 = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/50msRSC_INFO.mat');
ms100 = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/100msRSC_INFO.mat');
ms200 = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/200msRSC_INFO.mat');


%%
stimSet = [1 4 6 7 8 9 12];
nStims = numel(stimSet);


%% Identical comparisons

for j = 1:4
    
    switch j
        case 1
            
            stim = d_stim_10ms.RSC;
            spont = d_spont_10ms.RSC;
            col = [0 0 0];
        case 2
            
            stim = d_stim_50ms.RSC;
            spont = d_spont_50ms.RSC;
            col = [0.2 0.2 0.2];
            
        case 3
            
            stim = d_stim_100ms.RSC;
            spont = d_spont_100ms.RSC;
            col = [0.4 0.4 0.4];
        case 4
            
            stim = d_stim_200ms.RSC;
            spont = d_spont_200ms.RSC;
            col = [0.6 0.6 0.6];
    end
    
    for o = [1:77]
        
        allRatiosOverStims_POS = []; allRatiosOverStims_NEG = [];
        for k = 1:numel(stimSet)
            thisStim = stimSet(k);
            
            theseChans = stim.allDataSpkInds_Aud{1, o};
            nChans = numel(theseChans);
            
            test = stim.ID_nPosCorrs{o, thisStim};
            
            if ~isempty(test)
                
                thisComp_Stim_IDs = [];
                
                for oo = 1:nChans
                    thisChan = theseChans(oo);
                    thisComp_Stim_IDs{thisChan} = stim.ID_nPosCorrs{o, thisStim}{thisChan,thisChan};
                end
                
                %%
                cnt = 1;
                allRatios_POS = []; allRatios_NEG = [];
                for oo = 1:nChans
                    thisChan1 = theseChans(oo);
                    
                    for qq = 1:nChans
                        thisChan2 = theseChans(qq);
                        
                        if oo >=qq
                            continue
                        end
                        
                        POS_thisComp_Stim_nonID = stim.nPosCorrs{o,thisStim}{thisChan1,thisChan2};
                        NEG_thisComp_Stim_nonID = stim.nNegCorrs{o,thisStim}{thisChan1,thisChan2};
                        
                        Chan1max = thisComp_Stim_IDs{thisChan1};
                        Chan2max = thisComp_Stim_IDs{thisChan2};
                        
                        allRatios_POS(cnt) = (POS_thisComp_Stim_nonID / (Chan1max+Chan2max))*100;
                        allRatios_NEG(cnt) = (NEG_thisComp_Stim_nonID / (Chan1max+Chan2max))*100;
                        
                        cnt = cnt+1;
                    end
                end
                
                allRatiosOverStims_POS{thisStim} = allRatios_POS;
                allRatiosOverStims_NEG{thisStim} = allRatios_NEG;
                disp('')
            end
        end
        allComps_allRatiosOverStims_POS{o} = allRatiosOverStims_POS;
        allComps_allRatiosOverStims_NEG{o} = allRatiosOverStims_NEG;
        disp('')
    end
    
    allVals_POS{j} = allComps_allRatiosOverStims_POS;
    allVals_NEG{j} = allComps_allRatiosOverStims_NEG;
    
end


for j = 1:4
    
    ThisPOS = allVals_POS{j};
    ThisNEG = allVals_NEG{j};
    
    allPosStims = [];allNegStims = [];
    for o = 1:nStims
        thisStim = stimSet(o);
        
        allPosVals = []; allNegVals = [];
        
        for p  = 1:numel(ThisPOS)
            test = ThisPOS{1, p};
            if ~isempty(test)
                allPosVals  = [allPosVals ThisPOS{1, p}{1,thisStim}];
                allNegVals  = [allNegVals  ThisNEG{1, p}{1,thisStim}];
            end
        end
        
        allPosStims{thisStim} = allPosVals;
        allNegStims{thisStim} = allNegVals;
        
        allmeans_POS{thisStim} = nanmean(allPosVals);
        allmeans_NEG{thisStim} = nanmean(allNegVals);
        
        allstd_POS = nanstd(allPosVals);
        allstd_NEG= nanstd(allNegVals);
        
        allsem_POS{thisStim} = allstd_POS / sqrt(numel(allstd_POS));
        allsem_NEG{thisStim} = allstd_NEG / sqrt(numel(allstd_NEG));
        
    end
    
    allPosDist{j} = allPosStims;
    allNegDist{j} = allNegStims;
end

%%
















%%

a1 = allPosDist{1, 1}{1,1}';
a4 = allPosDist{1, 1}{1,4}';
a6 = allPosDist{1, 1}{1, 6}';
a7 = allPosDist{1, 1}{1, 7}';
a8 = allPosDist{1, 1}{1, 8}';
a9 = allPosDist{1, 1}{1, 9}';
a12 = allPosDist{1, 1}{1, 12}';

b1 = allPosDist{1, 2}{1,1}';
b4 = allPosDist{1, 2}{1,4}';
b6 = allPosDist{1, 2}{1, 6}';
b7 = allPosDist{1, 2}{1, 7}';
b8 = allPosDist{1, 2}{1, 8}';
b9 = allPosDist{1, 2}{1, 9}';
b12 = allPosDist{1, 2}{1, 12}';

c1 = allPosDist{1, 3}{1,1}';
c4 = allPosDist{1, 3}{1,4}';
c6 = allPosDist{1, 3}{1, 6}';
c7 = allPosDist{1, 3}{1, 7}';
c8 = allPosDist{1, 3}{1, 8}';
c9 = allPosDist{1, 3}{1, 9}';
c12 = allPosDist{1, 3}{1, 12}';

d1 = allPosDist{1, 4}{1,1}';
d4 = allPosDist{1, 4}{1,4}';
d6 = allPosDist{1, 4}{1, 6}';
d7 = allPosDist{1, 4}{1, 7}';
d8 = allPosDist{1, 4}{1, 8}';
d9 = allPosDist{1, 4}{1, 9}';
d12 = allPosDist{1, 4}{1, 12}';


group1 = [repmat({'WN-S'}, numel(a1), 1);   repmat({'Stacks'}, numel(a4), 1);      repmat({'REV'}, numel(a6), 1);  repmat({'CON'}, numel(a7), 1);
    repmat({'BOS'}, numel(a8), 1);     repmat({'qBOS'}, numel(a9), 1);   repmat({'WN-E'}, numel(a12), 1)];

group2 = [repmat({'WN-S'}, numel(b1), 1);   repmat({'Stacks'}, numel(b4), 1);      repmat({'REV'}, numel(b6), 1);  repmat({'CON'}, numel(b7), 1);
    repmat({'BOS'}, numel(b8), 1);     repmat({'qBOS'}, numel(b9), 1);   repmat({'WN-E'}, numel(b12), 1)];

group3 = [repmat({'WN-S'}, numel(c1), 1);   repmat({'Stacks'}, numel(c4), 1);      repmat({'REV'}, numel(c6), 1);  repmat({'CON'}, numel(c7), 1);
    repmat({'BOS'}, numel(c8), 1);     repmat({'qBOS'}, numel(c9), 1);   repmat({'WN-E'}, numel(c12), 1)];

group4 = [repmat({'WN-S'}, numel(d1), 1);   repmat({'Stacks'}, numel(d4), 1);      repmat({'REV'}, numel(d6), 1);  repmat({'CON'}, numel(d7), 1);
    repmat({'BOS'}, numel(d8), 1);     repmat({'qBOS'}, numel(d9), 1);   repmat({'WN-E'}, numel(d12), 1)];

%%
figHH = figure(200); clf
%poss = [1 1.5 2.5 3 4 4.5 5.5 6 7 7.5 8.5 9 10 10.5 11.5 12];
poss = [1 2 3 4 5 6 7];
rng(4);
subplot(2, 2,1)
boxplot([a1;a4;a6; a7; a8; a9; a12], group1, 'whisker', 0, 'symbol', 'ko', 'outliersize', 4, 'jitter', 0.7, 'colors', [0 0 0], 'positions', poss)
ylabel(['Pos Corr Bins'])
axis tight
ylim([-2 40])

subplot(2, 2, 2)
boxplot([b1;b4;b6; b7; b8; b9; b12], group2, 'whisker', 0, 'symbol', 'ko', 'outliersize', 4, 'jitter', 0.7, 'colors', [0 0 0], 'positions', poss)
ylabel(['Pos Corr Bins'])
axis tight
ylim([-2 40])

subplot(2, 2, 3)
boxplot([c1;c4;c6; c7; c8; c9; c12], group3, 'whisker', 0, 'symbol', 'ko', 'outliersize', 4, 'jitter', 0.7, 'colors', [0 0 0], 'positions', poss)
ylabel(['Pos Corr Bins'])
axis tight
ylim([-2 40])

subplot(2, 2, 4)
boxplot([d1;d4;d6; d7; d8; d9; d12], group4, 'whisker', 0, 'symbol', 'ko', 'outliersize', 4, 'jitter', 0.7, 'colors', [0 0 0], 'positions', poss)
ylabel(['Pos Corr Bins'])
axis tight
ylim([-2 40])

%%


a1 = allNegDist{1, 1}{1,1}';
a4 = allNegDist{1, 1}{1,4}';
a6 = allNegDist{1, 1}{1, 6}';
a7 = allNegDist{1, 1}{1, 7}';
a8 = allNegDist{1, 1}{1, 8}';
a9 = allNegDist{1, 1}{1, 9}';
a12 = allNegDist{1, 1}{1, 12}';

b1 = allNegDist{1, 2}{1,1}';
b4 = allNegDist{1, 2}{1,4}';
b6 = allNegDist{1, 2}{1, 6}';
b7 = allNegDist{1, 2}{1, 7}';
b8 = allNegDist{1, 2}{1, 8}';
b9 = allNegDist{1, 2}{1, 9}';
b12 = allNegDist{1, 2}{1, 12}';

c1 = allNegDist{1, 3}{1,1}';
c4 = allNegDist{1, 3}{1,4}';
c6 = allNegDist{1, 3}{1, 6}';
c7 = allNegDist{1, 3}{1, 7}';
c8 = allNegDist{1, 3}{1, 8}';
c9 = allNegDist{1, 3}{1, 9}';
c12 = allNegDist{1, 3}{1, 12}';

d1 = allNegDist{1, 4}{1,1}';
d4 = allNegDist{1, 4}{1,4}';
d6 = allNegDist{1, 4}{1, 6}';
d7 = allNegDist{1, 4}{1, 7}';
d8 = allNegDist{1, 4}{1, 8}';
d9 = allNegDist{1, 4}{1, 9}';
d12 = allNegDist{1, 4}{1, 12}';


group1 = [repmat({'WN-S'}, numel(a1), 1);   repmat({'Stacks'}, numel(a4), 1);      repmat({'REV'}, numel(a6), 1);  repmat({'CON'}, numel(a7), 1);
    repmat({'BOS'}, numel(a8), 1);     repmat({'qBOS'}, numel(a9), 1);   repmat({'WN-E'}, numel(a12), 1)];

group2 = [repmat({'WN-S'}, numel(b1), 1);   repmat({'Stacks'}, numel(b4), 1);      repmat({'REV'}, numel(b6), 1);  repmat({'CON'}, numel(b7), 1);
    repmat({'BOS'}, numel(b8), 1);     repmat({'qBOS'}, numel(b9), 1);   repmat({'WN-E'}, numel(b12), 1)];

group3 = [repmat({'WN-S'}, numel(c1), 1);   repmat({'Stacks'}, numel(c4), 1);      repmat({'REV'}, numel(c6), 1);  repmat({'CON'}, numel(c7), 1);
    repmat({'BOS'}, numel(c8), 1);     repmat({'qBOS'}, numel(c9), 1);   repmat({'WN-E'}, numel(c12), 1)];

group4 = [repmat({'WN-S'}, numel(d1), 1);   repmat({'Stacks'}, numel(d4), 1);      repmat({'REV'}, numel(d6), 1);  repmat({'CON'}, numel(d7), 1);
    repmat({'BOS'}, numel(d8), 1);     repmat({'qBOS'}, numel(d9), 1);   repmat({'WN-E'}, numel(d12), 1)];

%%
figHH2 = figure(202); clf
%poss = [1 1.5 2.5 3 4 4.5 5.5 6 7 7.5 8.5 9 10 10.5 11.5 12];
poss = [1 2 3 4 5 6 7];
rng(4);
subplot(2, 2,1)
boxplot([a1;a4;a6; a7; a8; a9; a12], group1, 'whisker', 0, 'symbol', 'ko', 'outliersize', 4, 'jitter', 0.7, 'colors', [0 0 0], 'positions', poss)
ylabel(['Pos Corr Bins'])
axis tight
ylim([-2 40])

subplot(2, 2, 2)
boxplot([b1;b4;b6; b7; b8; b9; b12], group2, 'whisker', 0, 'symbol', 'ko', 'outliersize', 4, 'jitter', 0.7, 'colors', [0 0 0], 'positions', poss)
ylabel(['Pos Corr Bins'])
axis tight
ylim([-2 40])

subplot(2, 2, 3)
boxplot([c1;c4;c6; c7; c8; c9; c12], group3, 'whisker', 0, 'symbol', 'ko', 'outliersize', 4, 'jitter', 0.7, 'colors', [0 0 0], 'positions', poss)
ylabel(['Pos Corr Bins'])
axis tight
ylim([-2 40])

subplot(2, 2, 4)
boxplot([d1;d4;d6; d7; d8; d9; d12], group4, 'whisker', 0, 'symbol', 'ko', 'outliersize', 4, 'jitter', 0.7, 'colors', [0 0 0], 'positions', poss)
ylabel(['Pos Corr Bins'])
axis tight
ylim([-2 40])



end














