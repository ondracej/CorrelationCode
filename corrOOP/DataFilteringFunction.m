function [] = DataFilteringFunction()



%% To Use
filterBasedOnWNComparison_BothStimSpont
%organizeDataForCorrAnalysis
organizeDataForCorrAnalysis_V2

calc_FRs_zscores_forSortedData

howManyNeuronsInCritFile

makePlotsFor_FR_Zscores
organizeAudDataforRSC
analyzeRSCTimescalesStims


getSpkShapesForSortedData
calcSpikeWidthForNeurons

%%
    
filterBasedOnWNComparison
loadAndBinSpikeTimesForAC        
loadAndBinSpikeTimesForCorrAnalysis

%% RSC analysis 
analyzePopRSCResponses_Stats
analyzePopRSCResponses
organizeAudDataforRSC

organizeAudDataforCCV

%%
getOnsetsForMotifs
analyzePopRSCResponses_forMotifs
organizeAudDataForRSC_Motifs


%% Load AudSorted: FR-Zscore_OnlyAud.mat

for j = 1:numel(AudSorted.allDataFiles_Aud)
    disp([ num2str(j) ': ' AudSorted.allDataFiles_Aud{j} '-chan: ' num2str(AudSorted.allDataChans_Aud{j}) ' | ' num2str(AudSorted.allSpkChansInds_Aud{j})])
end





end
