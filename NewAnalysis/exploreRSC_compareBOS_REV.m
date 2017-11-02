function []  = exploreRSC_compareBOS_REV()



dbstop if error
d = load('/home/janie/Dropbox/CorrPaper2016/Data/AuditoryForebrain-Population/AllPooledData/allPooledData.mat');
INFO = d.INFO;
RSC = d.RSC;

stimRSC_rs = RSC.RSC_Stim.RSC.r;
nRs = size(stimRSC_rs, 1);
timepoints = ones(1, nRs);



REV = stimRSC_rs(:,2);
BOS = stimRSC_rs(:,4);

%%
%BOSPosCorrs = find(BOS > REV);
BOSPosCorrs = find(BOS < 0 & REV >0);

diffsCorrs = BOS(BOSPosCorrs) - REV(BOSPosCorrs);


FRs = d.FRStats.FR.Stim.FR;
DPrimes = d.FRStats.DPrimes.D;
DPrimes_BOSVSREV = DPrimes.BOS_REV;

    
thisData = DPrimes_BOSVSREV;

 [AllIndividualInds] = lookupIndNeurons(criteriaInds, INFO);
[thisDATA] = getDataFromInds(thisData, AllIndividualInds);
%%
figure(105)
subplot(1, 3, 1)
toPlotBosPosCorrs = [ BOS(BOSPosCorrs) REV(BOSPosCorrs)];
nBosPos = numel(BOSPosCorrs);
plot(toPlotBosPosCorrs', 'linewidth', 2)
ylabel('Noise Correlation')
ylim([-1 1])
set(gca, 'xticklabel', {'BOS', [], 'REV'})
title(['R_S_C BOS vs REV  | n = ' num2str(nBosPos)])

subplot(1, 3, 2)
plot(thisDATA')
ylabel('D'' - Bos vs REV')
set(gca, 'xticklabel', {'N1', [], 'N2'})
title('D'' for neuron pair')

subplot(1, 3, 3)
DprimeDiffs = abs(thisDATA(:,1) - thisDATA(:,2));
plot(ones(1, numel(DprimeDiffs)), DprimeDiffs, 'ko')
ylabel('|\DeltaD''| - Bos vs REV')
set(gca, 'xticklabel', {[], [], []})
title('|\DeltaD''|')

end
