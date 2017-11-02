function [] = makePlotsFor_FR_Zscores()

fileToLoad = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/Fr-Zscore/FR-Zscore.mat';
saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/Fr-Zscore/';

dbstop if error 

% fileToLoad = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/FR-Zscore/FR-Zscore.mat';
% saveDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/FR-Zscore/';


if exist(saveDir, 'dir') == 0
    mkdir(saveDir);
end

%%

data = load(fileToLoad);
data = data.nStats;

% First estimate
nStims = size(data.allFR_Stim, 2);
for j = 1:nStims
    
    thisStim = data.allFR_Stim(:,j);
    stimReps(j) = numel(find(cellfun(@(x) ~isempty(x), thisStim)));
end

stimsSet = find(stimReps ~= 0);
nStims = numel(stimsSet);

allFR_Stim = data.allFR_Stim;
allFR_Spont = data.allFR_Spont;

allSigStims_H = [];allSigStims_P = [];
for j = 1:nStims
    
    thisFR_Stim = allFR_Stim(:,stimsSet(j));
    thisFR_Spont = allFR_Spont(:,stimsSet(j));
    
    allHs = []; allPs = [];
    
    for k = 1:size(thisFR_Stim, 1);
        
        thisNeuronStim = reshape(thisFR_Stim{k}, 1, numel(thisFR_Stim{k}));
        thisNeuronSpont = reshape(thisFR_Spont{k}, 1, numel(thisFR_Spont{k}));
        
        [h, p] = ttest(thisNeuronStim, thisNeuronSpont);
        
        allHs(k) = h;
        allPs(k) = p;
    end
    
    allSigStims_H(:,j) = allHs;
    allSigStims_P(:,j) = allPs;
    
end

for s = 1:size(allSigStims_H, 1)
    
    thisTest = allSigStims_H(s,:);
    allZeros(s) = numel(find(thisTest == 0));
    allOnes(s) = numel(find(thisTest == 1));
    
end

%% Auditory Defintion
AI = (allOnes)./(allOnes+allZeros);

notAud = numel(find(AI < 0.25));
audInds = find(AI >= 0.25);

%% Check that WN Comparisons are still not sig differet

WNS_Stim = allFR_Stim(:,1);
WNE_Stim = allFR_Stim(:,12);

WNS_Spont = allFR_Spont(:,1);
WNE_Spont = allFR_Spont(:,12);

cnt = 1; cnnt = 1;

for k = 1:size(WNS_Stim, 1);
    
    thisNeuronWNS_Stim = reshape(WNS_Stim{k}, 1, numel(WNS_Stim{k}));
    thisNeuronWNE_Stim = reshape(WNE_Stim{k}, 1, numel(WNE_Stim{k}));
    
    thisNeuronWNS_Spont = reshape(WNS_Spont{k}, 1, numel(WNS_Spont{k}));
    thisNeuronWNE_Spont = reshape(WNE_Spont{k}, 1, numel(WNE_Spont{k}));
    
    [hWN_Stim, p_WN_Stim] = ttest(thisNeuronWNS_Stim, thisNeuronWNE_Stim, 0.01);
    [hWN_Spont, p_WN_Spont] = ttest(thisNeuronWNS_Spont, thisNeuronWNE_Spont, 0.01);
    
    sigRec(k) = hWN_Stim+hWN_Spont;
    
    allhWN_Stim(k) = hWN_Stim;
    allhWN_Spont(k) = hWN_Spont;
    
    allpWN_Stim(k) = p_WN_Stim;
    allpWN_Spont(k) = p_WN_Spont;
    
    if p_WN_Stim >= 0.01 || p_WN_Spont >= 0.01
        
        okInds(cnt) = k;
        cnt = cnt +1;
    else
        notOkInds(cnnt) = k;
        cnnt = cnnt +1;
    end
    
end

%% This shows which ones are sig diferent

SigOne = find(sigRec ==1);
sigDiffStims = find(allhWN_Stim ==1);
sigDiffSponts = find(allhWN_Spont ==1);

allpWN_Stim(42)
allhWN_Stim(42)
allHs(k) = h;
allPs(k) = p;

%% Resort Data to Exclide the non Aud data

saveName = [saveDir 'FR-Zscore_OnlyAud'];

AudSorted.allAudInds = audInds;

AudSorted.allDataFiles_Aud = data.allDataFiles(audInds);
AudSorted.allDataChans_Aud = data.allDataChans(audInds);
AudSorted.allSpkChansInds_Aud = data.allDataChansSpkInds(audInds);

AudSorted.allFR_Stim_Aud = data.allFR_Stim(audInds,:);
AudSorted.allFR_Spont_Aud = data.allFR_Spont(audInds,:);
AudSorted.allmean_Stim_Aud = data.allmean_Stim(audInds,:);
AudSorted.allmean_Spont_Aud = data.allmean_Spont(audInds,:);
AudSorted.allmedian_Stim_Aud = data.allmedian_Stim(audInds,:);
AudSorted.allmedian_Spont_Aud = data.allmedian_Spont(audInds,:);
AudSorted.allsem_Stim_Aud = data.allsem_Stim(audInds,:);
AudSorted.allsem_Spont_Aud = data.allsem_Spont(audInds,:);
AudSorted.allZScore_Aud = data.allZScore(audInds,:);

save(saveName, 'AudSorted', '-v7.3')
disp(saveName);
%% Make a barplot

toPLotStim = []; toPLotSpont = []; allZscores = [];
for q = 1:nStims
    
    allmean_Stim_Aud = cell2mat(AudSorted.allmean_Stim_Aud(:,stimsSet(q)));
    allmean_Spont_Aud = cell2mat(AudSorted.allmean_Spont_Aud(:,stimsSet(q)));
    
    [h(q), p(q)] = ttest(allmean_Stim_Aud, allmean_Spont_Aud);
    
    stdStimAud = nanstd(allmean_Stim_Aud);
    stdSpontAud = nanstd(allmean_Spont_Aud);
    
    meanStimAud(q) = nanmean(allmean_Stim_Aud);
    meanSpontAud(q) = nanmean(allmean_Spont_Aud);
    
    medianStimAud(q) = nanmedian(allmean_Stim_Aud);
    medianSpontAud(q) = nanmedian(allmean_Spont_Aud);
    
    semStimAud(q) = stdStimAud / (sqrt(numel(allmean_Stim_Aud)));
    semSpontAud(q) = stdSpontAud / (sqrt(numel(allmean_Spont_Aud)));
    
    toPLotStim{q} = [allmean_Stim_Aud];
    toPLotSpont{q} = [allmean_Spont_Aud];
    
    allZscores{q} = cell2mat(AudSorted.allZScore_Aud(:,stimsSet(q)));
    
    barplot(q,:) = [ medianStimAud(q) medianSpontAud(q)];
    barplotSEM(q,:) = [semStimAud(q) semSpontAud(q)];
    
    barplotZ(q) = nanmedian(allZscores{q});
    barplotZstd = nanstd(allZscores{q});
    barplotZsem(q) = barplotZstd / sqrt(numel(allZscores{q}));
end



%% Z score significange
allZPs = []; allZhs = [];
for w = 1:8
    stim1 = w;
   
    for ww = 1:8
        
        stim2 = ww;
        
        [p, h] = ranksum(allZscores{stim1}, allZscores{stim2});
        
        allZPs(w,ww) = p;
        allZhs(w,ww) = h;
    end
    
end








%% barplots
fig24 = figure(242); clf
barweb(barplot, barplotSEM, [], [], [], [], [], bone, [], [])
ylim([-0 10])
ylabel('Firing rate (Hz)')
legend({'Stim', 'Spont'})
legend('boxoff')

figure(fig24)
plot_filename = [saveDir 'FiringRateBarPlot'];
plotpos = [0 0 30 15];
print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
print_in_A4(1, plot_filename, '-depsc', 0, plotpos);

%%
fig243 = figure(243); clf
barweb(barplotZ, barplotZsem, .8, [], [], [], [], bone, [], [])

ylabel('Mean Z-score')
legend('boxoff')

ylim([ 0 1.5])
%%
figure(fig243)
plot_filename = [saveDir 'ZBar'];
plotpos = [0 0 30 15];
print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
print_in_A4(1, plot_filename, '-depsc', 0, plotpos);


%%
a1 = toPLotStim{1};
a11 = toPLotSpont{1};
a2 = toPLotStim{2};
a22 = toPLotSpont{2};
a3 = toPLotStim{3};
a33 = toPLotSpont{3};
a4 = toPLotStim{4};
a44 = toPLotSpont{4};
a5 = toPLotStim{5};
a55 = toPLotSpont{5};
a6 = toPLotStim{6};
a66 = toPLotSpont{6};
a7 = toPLotStim{7};
a77 = toPLotSpont{7};
a8 = toPLotStim{8};
a88 = toPLotSpont{8};

group = [repmat({'WNS'}, numel(a1), 1);   repmat({'WNS_sp'}, numel(a11), 1);      repmat({'Tones'}, numel(a2), 1);  repmat({'Tones_sp'}, numel(a22), 1);
    repmat({'Stacks'}, numel(a3), 1);     repmat({'Stacks_sp'}, numel(a33), 1);   repmat({'REV'}, numel(a4), 1);    repmat({'REV_sp'}, numel(a44), 1);
    repmat({'CON'}, numel(a5), 1);        repmat({'CON_sp'}, numel(a55), 1);      repmat({'BOS'}, numel(a6), 1);    repmat({'BOS_sp'}, numel(a66), 1);
    repmat({'qBOS'}, numel(a7), 1);       repmat({'qBOS_sp'}, numel(a77), 1);     repmat({'WNE'}, numel(a8), 1);    repmat({'WNE_sp'}, numel(a88), 1)];

%%
figH = figure(100); clf
poss = [1 1.5 2.5 3 4 4.5 5.5 6 7 7.5 8.5 9 10 10.5 11.5 12];
rng(1);
boxplot([a1;a11;a2; a22; a3; a33; a4; a44; a5; a55; a6; a66; a7; a77; a8; a88], group, 'whisker', 0, 'symbol', 'ko', 'outliersize', 4, 'jitter', 0.7, 'colors', [0 0 0], 'positions', poss)
ylabel(['Firing rate (Hz)'])
ylim([0 50])
%%
figure(figH)
plot_filename = [saveDir 'FiringRateBoxPlot'];
plotpos = [0 0 30 15];
print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
print_in_A4(1, plot_filename, '-depsc', 0, plotpos);

%% Z scores

z1 = allZscores{1};
z2 = allZscores{2};
z3 = allZscores{3};
z4 = allZscores{4};
z5 = allZscores{5};
z6 = allZscores{6};
z7 = allZscores{7};
z8 = allZscores{8};

group = [repmat({'WNS'}, numel(z1), 1);   repmat({'Tones'}, numel(z2), 1);  repmat({'Stacks'}, numel(z3), 1);
    repmat({'REV'}, numel(z4), 1);   repmat({'CON'}, numel(z5), 1);    repmat({'BOS'}, numel(z6), 1);
    repmat({'qBOS'}, numel(z7), 1);   repmat({'WNE'}, numel(z8), 1)];

%%
rng(1);
figH = figure(100); clf
poss = [1:1:8];
boxplot([z1;z2;z3;z4;z5;z6;z7;z8], group, 'whisker', 0, 'symbol', 'ko', 'outliersize', 4, 'jitter', 0.8, 'colors', [0 0 0], 'positions', poss)
ylabel(['Z-Score'])
ylim([-6 10])

%%
figure(figH)
plot_filename = [saveDir 'ZscoreRateBoxPlot'];
plotpos = [0 0 30 15];
print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
print_in_A4(1, plot_filename, '-depsc', 1, plotpos);

print_in_A4(0, this_save_name, export_to, 1, pos);
%%
end

