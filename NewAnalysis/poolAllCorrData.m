function [] = poolAllCorrData()

dbstop if error

stimFile = '/home/janie/Documents/CorrPaper2016/Data/AuditoryForebrain-Population/AllPooledData/Stim_77_Neurons-106.mat';
motiFile = '/home/janie/Documents/CorrPaper2016/Data/AuditoryForebrain-Population/AllPooledData/Motif_77_Neurons-106.mat';
spontFile = '/home/janie/Documents/CorrPaper2016/Data/AuditoryForebrain-Population/AllPooledData/Spont_77_Neurons-106.mat';

d = load(stimFile);

saveDir = '/home/janie/Documents/CorrPaper2016/Data/AuditoryForebrain-Population/AllPooledData/';

%%

INFO = d.INFO;
SongSet = INFO.SongSet;
%%

CCVBins.ms0 = [201];
CCVBins.ms5 = [200 201 202];
CCVBins.ms10 = [199 200 201 202 203];
CCVBins.ms15 = [198 199 200 201 202 203 204];
CCVBins.ms20 = [1987 198 199 200 201 202 203 204 205];

%% Stim CCVs

ComparisonData = d.ComparisonData;

for j = 1:numel(SongSet)
    stim = SongSet(j);
    
    ComparisonDataStim = ComparisonData{1,stim};
    
    CCV_Stim.CCV.allMeans{1,stim} = ComparisonDataStim.TL_means;
    CCV_Stim.CCV.allMedians{1,stim} = ComparisonDataStim.TL_medians;
    CCV_Stim.CCV.n{1,stim} = ComparisonDataStim.TL_n;
    CCV_Stim.CCV.n_max{1,stim} = ComparisonDataStim.TL_n_max;
    
    CCV_Stim.SignalCOV.allMeans{1,stim} = ComparisonDataStim.TS_np1_means;
    CCV_Stim.SignalCOV.allMedians{1,stim} = ComparisonDataStim.TS_np1_medians;
    CCV_Stim.SignalCOV.n{1,stim} = ComparisonDataStim.TS_np1_n;
    CCV_Stim.SignalCOV.n_max{1,stim} = ComparisonDataStim.TS_np1_max;
    
    CCV_Stim.NoiseCOV.allMeans{1,stim} = ComparisonDataStim.Diff_TL_TS_np1_pairdiff_mean;
    CCV_Stim.NoiseCOV.allMedians{1,stim} = ComparisonDataStim.Diff_TL_TS_np1_pairdiff_median;
    
    %%
    RSC_Stim.RSC.r{1,stim} = ComparisonDataStim.RSC_rSC;
    RSC_Stim.RSC.p{1,stim} = ComparisonDataStim.RSC_pSC;
    
    %%
    FR_Info = d.singleNeuronData{1, stim};
    
    FR.Stim.meanFR{1,stim} = FR_Info.meanFR_Stim;
    FR.Stim.SpkCnts{1,stim} = FR_Info.allSpkCnts_Stim;
    FR.Stim.SpkCntsRSC{1,stim} = FR_Info.RSC_SpkCnt;
    FR.Stim.SpkCntBinned{1,stim} = FR_Info.allBinnedSpkCnts_Stims_forXCOV;
    
    FR.Stim.FRVector{1,stim} = FR_Info.allChans_FR_vec_Stims;
    FR.Stim.FRVectorReps{1,stim} = FR_Info.allFiringRates_Stim;
    
    AutoCov.Stim.mean{1,stim} = FR_Info.allReps_mean_AutoCov;
    AutoCov.Stim.median{1,stim} = FR_Info.allReps_median_AutoCov;
    
    ZScores.Z{1,stim} = FR_Info.zscore;
    
end

FRStats.DPrimes.Stim = d.singleNeuronData{1, SongSet(1)}.DPrimeComparisons;

%% Spont Data

d = load(spontFile);

ComparisonData = d.ComparisonData;

for j = 1:numel(SongSet)
    stim = SongSet(j);
    
    ComparisonDataStim = ComparisonData{1,stim};
    
    CCV_Spont.CCV.allMeans{1,stim} = ComparisonDataStim.TL_means;
    CCV_Spont.CCV.allMedians{1,stim} = ComparisonDataStim.TL_medians;
    CCV_Spont.CCV.n{1,stim} = ComparisonDataStim.TL_n;
    CCV_Spont.CCV.n_max{1,stim} = ComparisonDataStim.TL_n_max;
    
    CCV_Spont.SignalCOV.allMeans{1,stim} = ComparisonDataStim.TS_np1_means;
    CCV_Spont.SignalCOV.allMedians{1,stim} = ComparisonDataStim.TS_np1_medians;
    CCV_Spont.SignalCOV.n{1,stim} = ComparisonDataStim.TS_np1_n;
    CCV_Spont.SignalCOV.n_max{1,stim} = ComparisonDataStim.TS_np1_max;
    
    CCV_Spont.NoiseCOV.allMeans{1,stim} = ComparisonDataStim.Diff_TL_TS_np1_pairdiff_mean;
    CCV_Spont.NoiseCOV.allMedians{1,stim} = ComparisonDataStim.Diff_TL_TS_np1_pairdiff_median;
    
    %%
    RSC_Spont.RSC.r{1,stim} = ComparisonDataStim.RSC_rSC;
    RSC_Spont.RSC.p{1,stim} = ComparisonDataStim.RSC_pSC;
    
    %%
    FR_Info = d.singleNeuronData{1, stim};
    
    FR.Spont.meanFR{1,stim} = FR_Info.meanFR_Stim;
    FR.Spont.SpkCnts{1,stim} = FR_Info.allSpkCnts_Stim;
    FR.Spont.SpkCntsRSC{1,stim} = FR_Info.RSC_SpkCnt;
    FR.Spont.SpkCntBinned{1,stim} = FR_Info.allBinnedSpkCnts_Stims_forXCOV;
    
    FR.Spont.FRVector{1,stim} = FR_Info.allChans_FR_vec_Stims;
    FR.Spont.FRVectorReps{1,stim} = FR_Info.allFiringRates_Stim;
    
    AutoCov.Spont.mean{1,stim} = FR_Info.allReps_mean_AutoCov;
    AutoCov.Spont.median{1,stim} = FR_Info.allReps_median_AutoCov;
    
end

%% Motif
d = load(motiFile);

ComparisonData = d.ComparisonData;
SongSet = [6 7 8];

for j = 1:numel(SongSet)
    stim = SongSet(j);
    
    ComparisonDataStim = ComparisonData{1,stim};
    
    CCV_Motif.CCV.allMeans{1,stim} = ComparisonDataStim.TL_means;
    CCV_Motif.CCV.allMedians{1,stim} = ComparisonDataStim.TL_medians;
    CCV_Motif.CCV.n{1,stim} = ComparisonDataStim.TL_n;
    CCV_Motif.CCV.n_max{1,stim} = ComparisonDataStim.TL_n_max;
    
    CCV_Motif.SignalCOV.allMeans{1,stim} = ComparisonDataStim.TS_np1_means;
    CCV_Motif.SignalCOV.allMedians{1,stim} = ComparisonDataStim.TS_np1_medians;
    CCV_Motif.SignalCOV.n{1,stim} = ComparisonDataStim.TS_np1_n;
    CCV_Motif.SignalCOV.n_max{1,stim} = ComparisonDataStim.TS_np1_max;
    
    CCV_Motif.NoiseCOV.allMeans{1,stim} = ComparisonDataStim.Diff_TL_TS_np1_pairdiff_mean;
    CCV_Motif.NoiseCOV.allMedians{1,stim} = ComparisonDataStim.Diff_TL_TS_np1_pairdiff_median;
    
    %%
    RSC_Motif.RSC.r{1,stim} = ComparisonDataStim.RSC_rSC;
    RSC_Motif.RSC.p{1,stim} = ComparisonDataStim.RSC_pSC;
    
    %%
    FR_Info = d.singleNeuronData{1, stim};
    
    FR.Motif.meanFR{1,stim} = FR_Info.meanFR_MOTIF;
    FR.Motif.SpkCnts{1,stim} = FR_Info.allSpkTimes_Stim_MOTIF;
    FR.Motif.SpkCntsRSC{1,stim} = FR_Info.RSC_SpkCnt;
    FR.Motif.SpkCntBinned{1,stim} = FR_Info.allBinnedSpkCnts_Stims_forXCOV;
    
    FR.Motif.FRVector{1,stim} = FR_Info.allFiringRates_Stim_MOTIF;
    
    AutoCov.Motif.mean{1,stim} = FR_Info.allReps_mean_AutoCov;
    AutoCov.Motif.median{1,stim} = FR_Info.allReps_median_AutoCov;
    
end

FRStats.DPrimes.Motif = d.singleNeuronData{1, SongSet(1)}.DPrimeComparisons;

CCV.CCVBins = CCVBins;
CCV.CCV_Stim = CCV_Stim;
CCV.CCV_Spont = CCV_Spont;
CCV.CCV_Motif = CCV_Motif;

RSC.RSC_Stim = RSC_Stim;
RSC.RSC_Spont = RSC_Spont;
RSC.RSC_Motif = RSC_Motif;

FRStats.FR = FR;
FRStats.ZScores = ZScores;
FRStats.AutoCov = AutoCov;

%%
save([saveDir 'allPooledData_2016.mat'], 'INFO', 'CCV', 'RSC', 'FRStats')
disp(['Saved: ' [saveDir 'AllPooledData']]);


end
