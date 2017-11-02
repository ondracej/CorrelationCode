function []  = exploreRSC_compareWN()

dbstop if error
d = load('/home/janie/Dropbox/CorrPaper2016/Data/AuditoryForebrain-Population/AllPooledData/allPooledData.mat');
INFO = d.INFO;
RSC = d.RSC;

stimRSC_rs = RSC.RSC_Stim.RSC.r;
nRs = size(stimRSC_rs, 1);
timepoints = ones(1, nRs);

%%

%% WN changes in RSC

WN_BOF = stimRSC_rs(:,1);
WN_EOF = stimRSC_rs(:,5);


WN_BOF_p = RSC.RSC_Stim.RSC.p(:,1);
WN_EOF_p = RSC.RSC_Stim.RSC.p(:,5);

toPlot = [WN_BOF WN_EOF];

%%
figure(100); clf; hold on
subplot(1, 4, 1)

diffsBetweenWNBOF_WNEOF = WN_EOF-WN_BOF;
%figure(105); clf;
plot(ones(1, numel(diffsBetweenWNBOF_WNEOF)), diffsBetweenWNBOF_WNEOF, 'k.')
line([0 2], [.3 .3], 'color', 'r')
line([0 2], [-.3 -.3], 'color', 'r')
%bincenters = -1:.03:1;
%figure
%hist(diffsBetweenWNBOF_WNEOF, bincenters)
ylim([-1 1])
ylabel('Noise Correlation')
title('\DeltaR_S_C | WN')
%bla = median(diffsBetweenWNBOF_WNEOF);
set(gca, 'xticklabel', {[], 'WN \DeltaR_S_C', []})
%% WN Increase
subplot(1, 4, 2)
%plot(toPlot')
Rincrease_inds = find(WN_EOF > WN_BOF);
diffInRsc = WN_EOF(Rincrease_inds) - WN_BOF(Rincrease_inds);

largeIncreasesInds = find(diffInRsc >threshold );

LargeIncreasesIndsRemapped = Rincrease_inds(largeIncreasesInds);
nIncreases = numel(LargeIncreasesIndsRemapped);
WNEOFIncrease =  WN_EOF(LargeIncreasesIndsRemapped);
hold on

toPlotIncrease = [WN_BOF(LargeIncreasesIndsRemapped) WN_EOF(LargeIncreasesIndsRemapped)];

% BOF
TheseSigs = WN_BOF_p(LargeIncreasesIndsRemapped);
sigInds = find(TheseSigs <0.05);
sigRemapped = LargeIncreasesIndsRemapped(sigInds);
plot(ones(1, numel(sigRemapped))*1, WN_BOF(sigRemapped), 'ko')

% EOF
TheseSigs = WN_EOF_p(LargeIncreasesIndsRemapped);
sigInds = find(TheseSigs <0.05);
sigRemapped = LargeIncreasesIndsRemapped(sigInds);
plot(ones(1, numel(sigRemapped))*2, WN_EOF(sigRemapped), 'ko')

plot(toPlotIncrease', 'linewidth', 2)
ylim([-1 1])
title(['\DeltaR_S_C > 0.3 | n = ' num2str(nIncreases)])
set(gca, 'xticklabel', {'WN-BOF', [], 'WN-EOF'})
%% WN Decreases

subplot(1, 4, 3)
%plot(toPlot')

Rdecrease_inds = find(WN_EOF < WN_BOF);
diffInRsc = WN_BOF(Rdecrease_inds) - WN_EOF(Rdecrease_inds);

largeDecreasesInds = find(diffInRsc >threshold);

LargeDecreasesIndsRemapped = Rdecrease_inds(largeDecreasesInds);
nDecreases = numel(LargeDecreasesIndsRemapped);
WNEOFDecrease =  WN_EOF(LargeDecreasesIndsRemapped);

hold on

toPlotDecrease = [WN_BOF(LargeDecreasesIndsRemapped) WN_EOF(LargeDecreasesIndsRemapped)];
plot(toPlotDecrease', 'linewidth', 2)

% BOF
TheseSigs = WN_BOF_p(LargeDecreasesIndsRemapped);
sigInds = find(TheseSigs <0.05);
sigRemapped = LargeDecreasesIndsRemapped(sigInds);
plot(ones(1, numel(sigRemapped))*1, WN_BOF(sigRemapped), 'ko')

% EOF
TheseSigs = WN_EOF_p(LargeDecreasesIndsRemapped);
sigInds = find(TheseSigs <0.05);
sigRemapped = LargeDecreasesIndsRemapped(sigInds);
plot(ones(1, numel(sigRemapped))*2, WN_EOF(sigRemapped), 'ko')

ylim([-1 1])
title(['\DeltaR_S_C < 0.3 | n = ' num2str(nDecreases)])
set(gca, 'xticklabel', {'WN-BOF', [], 'WN-EOF'})
%% Stay the same

subplot(1, 4, 4)
%plot(toPlot')

allChangingInds = [LargeDecreasesIndsRemapped ; LargeIncreasesIndsRemapped];
allNonchaningsInds = [];
for j = 1: numel(WN_EOF)
    
    if ~ismember(j, allChangingInds)
        
        allNonchaningsInds = [allNonchaningsInds j];
    end
end
hold on
nNoChange = numel(allNonchaningsInds);
toPlotNoChange = [WN_BOF(allNonchaningsInds) WN_EOF(allNonchaningsInds)];


% BOF
TheseSigs = WN_BOF_p(allNonchaningsInds);
sigInds = find(TheseSigs <0.05);
sigRemapped = allNonchaningsInds(sigInds);
plot(ones(1, numel(sigRemapped))*1, WN_BOF(sigRemapped), 'ko')

% EOF
TheseSigs = WN_EOF_p(allNonchaningsInds);
sigInds = find(TheseSigs <0.05);
sigRemapped = allNonchaningsInds(sigInds);
plot(ones(1, numel(sigRemapped))*2, WN_EOF(sigRemapped), 'ko')

meandiff = mean(WN_EOF(allNonchaningsInds) - WN_BOF(allNonchaningsInds));
plot(toPlotNoChange', 'linewidth', 2)
ylim([-1 1])
title(['\DeltaR_S_C ~ 0  | n = ' num2str(nNoChange)])
set(gca, 'xticklabel', {'WN-BOF', [], 'WN-EOF'})


[AllIndividualInds] = lookupIndNeurons(criteriaInds, INFO);

 [thisDATA] = getDataFromInds(thisData, AllIndividualInds);

WNBOF = thisDATA;
WNEOF = thisDATA;
%%

%%
figure(102)
subplot(1, 2, 1)

toPlotInds = [reshape(WNBOF, 1, numel(WNBOF)) ; reshape(WNEOF, 1, numel(WNEOF))];
plot(toPlotInds )
set(gca, 'xticklabel', {'WN-BOF', [], 'WN-EOF'})
ylabel('FR [Hz]')
title(['\DeltaR_S_C > 0.3 | n = ' num2str(nIncreases)])


%%
subplot(1, 2, 2)

toPlotInds = [reshape(WNBOF, 1, numel(WNBOF)) ; reshape(WNEOF, 1, numel(WNEOF))];
plot(toPlotInds )
set(gca, 'xticklabel', {'WN-BOF', [], 'WN-EOF'})
ylabel('FR [Hz]')
title(['\DeltaR_S_C < 0.3 | n = ' num2str(nDecreases)])
end
