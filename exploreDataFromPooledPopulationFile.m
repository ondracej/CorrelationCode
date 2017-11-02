function [] = exploreDataFromPooledPopulationFile()

allPooledFileToLoad = '/home/janie/Documents/CorrPaper2016/Data/AuditoryForebrain-Population/AllPooledData/Stim_75_Neurons-102.mat';
%allPooledFileToLoad = '/home/janie/Documents/CorrPaper2016/Data/AuditoryForebrain-Population/AllPooledData/Spont_75_Neurons-102.mat';

load(allPooledFileToLoad);

disp('')

StimSet = INFO.SongSet;
nNeurons = numel(INFO.IndividualNeurons_Channels);

%% Bin Definitions
CCVBins.ms0 = [201];
CCVBins.ms5 = [200 201 202];
CCVBins.ms10 = [199 200 201 202 203];
CCVBins.ms15 = [198 199 200 201 202 203 204];
CCVBins.ms20 = [1987 198 199 200 201 202 203 204 205];

%% Check how many CCV stim have negative CCVs for BOS-REV

%% Check Firing Rates
for j = 1: nNeurons
    
    WN_BOF_FR_Stim = singleNeuronData{1,1}.allChans_FR_vec_Stims{1, j};    
    WN_EOF_FR_Stim = singleNeuronData{1,12}.allChans_FR_vec_Stims{1, j};
    
    [h(j),p(j)] = ttest(WN_BOF_FR_Stim, WN_EOF_FR_Stim, 'alpha', 0.01);
    
end

%%
controlBins = [4 5 6 398 397 396];

%toPlot = ComparisonData{1,1}.TS_np1_means;
%toPlot = ComparisonData{1,8}.TS_np1_means;
toPlot = ComparisonData{1,8}.TL_means;
for j = 1: size(toPlot, 1)
%toPlot = singleNeuronData{1,8}.allReps_mean_AutoCov{1,j}{1,1};
    
figure(100); clf; 
plot(smooth(toPlot(j,:), 1))
toPlotsymmet = (toPlot(j,:) + fliplr(toPlot(j,:)))/2;

controlVals = nanmean(toPlot(j,controlBins));

%controlValsSTD = controlVals*3;
controlValsSTD = allSTDVals(j)
hold on
%plot(smooth(toPlotsymmet, 1))
hold on



title([INFO.PairwiseComparisons_FileNames{j} '-' num2str(INFO.PairwiseComparisons_Channels(j,:)) 'nts:' num2str(ComparisonData{1,8}.TS_np1_n(j))])

%plot(smooth(toPlot, 3))
axis tight    
ylim([-.05 0.05])
%xlims = [150 250];
xlims = [0 401];

xlim([xlims])

line([xlims(1) xlims(2)], [ controlValsSTD controlValsSTD])
    hold on
    line([xlims(1) xlims(2)], [-controlValsSTD -controlValsSTD])
    
%allSTDVals(j) =  controlValsSTD;
%plot(CCV.CCV_Stim.CCV.allMeans{1, 1}(j,:))
pause
end


%% Anova - Signal Cov
StimSet2 = [1 6 8 12];

for j = 1:numel(StimSet2)
thisStim = StimSet2(j);

CCV_Stim_SignalCONV_binWin_BOS = ComparisonData{1,thisStim}.TS_np1_means(:,binWin);
CCV_Stim_SignalCONV_binWin_BOS_means = nanmean(CCV_Stim_SignalCONV_binWin_BOS, 2);

nans = find(isnan(CCV_Stim_SignalCONV_binWin_BOS));
CCV_Stim_SignalCONV_binWin_BOS(nans) = [];

xtime = ones(1, numel(CCV_Stim_SignalCONV_binWin_BOS_means)) * j;
hold on
plot(xtime, CCV_Stim_SignalCONV_binWin_BOS, 'k*')

allVars(:,j) = CCV_Stim_SignalCONV_binWin_BOS_means;
end

[p, table] = anova_rm(allVars)

binWin = CCVBins.ms10;
allVars =[]
StimSet2 = [1 6 7 8 12];
figure
for j = 1:numel(StimSet2)
thisStim = StimSet2(j);

%ToPLot = ComparisonData{1,thisStim}.TS_np1_means;
ToPLot = ComparisonData{1,thisStim}.TL_means(:,binWin);
Symmet = (ToPLot + fliplr(ToPLot) )/2;

symmetsum = sum(Symmet, 2);
%CCV_Stim_SignalCONV_binWin_BOS = ComparisonData{1,thisStim}.TL_means(:,binWin);
%CCV_Stim_SignalCONV_binWin_BOS_means = nanmean(CCV_Stim_SignalCONV_binWin_BOS, 2);

%nans = find(isnan(CCV_Stim_SignalCONV_binWin_BOS));
%CCV_Stim_SignalCONV_binWin_BOS(nans) = [];

xtime = ones(1, numel(symmetsum)) * j;
hold on
plot(xtime, symmetsum, 'k*')

allVars(:,j) = reshape(Symmet, 1, numel(Symmet)) ;
end

BOS = allVars(:,4);


REV = allVars(:,2);
WN = allVars(:,1);

[p, h] = ttest(BOS, REV);
[p, h] = ttest(BOS, WN);
%%



%%





figure 



allVars = [];
for j = 1:4
thisStim = StimSet2(j);

CCV_Stim_SignalCONV_binWin_BOS = CCV.CCV_Stim.SignalCOV.allMeans{1,thisStim}(:,binWin);

nans = find(isnan(CCV_Stim_SignalCONV_binWin_BOS));
CCV_Stim_SignalCONV_binWin_BOS(nans) = [];

xtime = ones(1, numel(CCV_Stim_SignalCONV_binWin_BOS)) * j;
hold on
plot(xtime, CCV_Stim_SignalCONV_binWin_BOS, 'k*')

allVars(:,j) = CCV_Stim_SignalCONV_binWin_BOS;
end




bla = find(allVars(:,4) > .05)

kuts = kurtosis(allVars)

allVars2 = allVars;
allVars2(nans) = [];




[sorted indsS] = sort(CCV_Stim_SignalCONV_binWin_BOS, 'ascend');
CCV_Stim_SignalCONV_binWin_BOS_means = nanmean(CCV_Stim_SignalCONV_binWin_BOS, 2);

bla1 = reshape(CCV_Stim_SignalCONV_binWin_BOS, 1, numel(CCV_Stim_SignalCONV_binWin_BOS));

CCV_Stim_SignalCONV_binWin_REV = CCV.CCV_Stim.SignalCOV.allMeans{1,6}(:,binWin);
CCV_Stim_SignalCONV_binWin_REV_means = nanmean(CCV_Stim_SignalCONV_binWin_REV, 2);

bla2 = reshape(CCV_Stim_SignalCONV_binWin_REV, 1, numel(CCV_Stim_SignalCONV_binWin_REV));

toPlot = [CCV_Stim_SignalCONV_binWin_BOS_means CCV_Stim_SignalCONV_binWin_REV_means];

[p, h] = ttest(bla1, bla2)

figure;boxplot(toPlot)

negBOS_SignalCOV  = find(CCV_Stim_SignalCONV_binWin_BOS_means < -1);

%% D Primes


DPrime_BOS_VS_CON = FRStats.DPrimes.D.BOS_CON;
BOSSelInds_1 = find(DPrime_BOS_VS_CON >1);


RSC_BOS = RSC.RSC_Stim.RSC.r(:,4);

RSC_BOS_Sel = RSC_BOS(:,BOSSelInds_1);


BOSSelInds


end
