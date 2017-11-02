function [] = loadingAllDataforPaper()

switch gethostname
    
    case 'm-01237'
        
        %baseDir = '/home/janie/Documents/CorrPaper2016/Data/FieldL-Population/';
        baseDir = '/home/janie/Documents/CorrPaper2016/Data/AuditoryForebrain-Population/';
        dirD = '/';
        saveDir = [baseDir 'AllPooledData/'];
    otherwise
        disp('Please define the base directory and the directory delimiter')
end

if exist(saveDir, 'dir') == 0
    mkdir(saveDir);
end


%% 106  Neuron population

%% Stats about the Birds and Neuron Comparisons

popInfoFile = [baseDir 'PopulationInfo.mat'];

info = load(popInfoFile);

Stats = info.SongSet_stats;

BirdNames = Stats.bird_name;
BirdAges = Stats.bird_age;

PairwiseComparisons_FileNames = Stats.all_raw_data_files_comparison_cnnt;
PairwiseComparisons_Channels = Stats.all_comparisons_cnnt;

IndividualNeurons_FileNames = Stats.Individual_chans_raw_data_file_cnt;
IndividualNeurons_Channels = Stats.Individual_chans_cnt;

SongSet = Stats.song_set;
NeuronAreas = Stats.neuron_areas;
NeuronAreas_txt = Stats.area_text;

INFO.BirdNames = BirdNames;
INFO.BirdAges = BirdAges;
INFO.SongSet = SongSet;
INFO.NeuronAreas = NeuronAreas;
INFO.NeuronAreas_txt = NeuronAreas_txt;

INFO.PairwiseComparisons_FileNames = PairwiseComparisons_FileNames;
INFO.PairwiseComparisons_Channels = PairwiseComparisons_Channels;
INFO.IndividualNeurons_FileNames = IndividualNeurons_FileNames;
INFO.IndividualNeurons_Channels = IndividualNeurons_Channels;


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CCV, Signal COV, and Noise COV
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CCVBins.ms0 = [201];
CCVBins.ms5 = [200 201 202];
CCVBins.ms10 = [199 200 201 202 203];
CCVBins.ms15 = [198 199 200 201 202 203 204];
CCVBins.ms20 = [1987 198 199 200 201 202 203 204 205];

% Define directories
CCVDir = [baseDir 'CCVData' dirD];

CCV_StimDir = [CCVDir 'StimFiles' dirD];
CCV_SpontDir = [CCVDir 'SpontFiles' dirD];
CCV_MotifDir = [CCVDir 'MotifsFiles' dirD];

%% Stim

%matfileToLoad = 'TL--20.mat';
%[CCV_Stim] = loadDataFromFile('CCV_Stim','CCV', [CCV_StimDir matfileToLoad]);

% CCV
d = load([CCV_StimDir 'TL--20.mat']);
CCV_Stim.CCV.allMeans = d.this_data_means;
CCV_Stim.CCV.Mean = d.All_smoothed_mean_all_COV_means;
clear('d')

% Signal COV
%d = load([CCV_StimDir 'TSnp1--20.mat']);
d = load([CCV_StimDir 'TS--20.mat']);
CCV_Stim.SignalCOV.allMeans = d.this_data_means;
CCV_Stim.SignalCOV.Mean = d.All_smoothed_mean_all_COV_means;
clear('d')

% Noise COV
%d = load([CCV_StimDir 'TL-TSnp1-Diffs--20.mat']);
d = load([CCV_StimDir 'TL-TS-Diffs--20.mat']);
CCV_Stim.NoiseCOV.allMeans = d.this_data_means;
CCV_Stim.NoiseCOV.Mean = d.All_smoothed_mean_all_COV_means;
clear('d')

%% Spont

% CCV
d = load([CCV_SpontDir 'TL--20.mat']);
CCV_Spont.CCV.allMeans = d.this_data_means;
CCV_Spont.CCV.Mean = d.All_smoothed_mean_all_COV_means;
clear('d')

% Signal COV
d = load([CCV_SpontDir 'TSnp1--20.mat']);
CCV_Spont.SignalCOV.allMeans = d.this_data_means;
CCV_Spont.SignalCOV.Mean = d.All_smoothed_mean_all_COV_means;
clear('d')

% Noise COV
d = load([CCV_SpontDir 'TL-TSnp1-Diffs--20.mat']);
CCV_Spont.NoiseCOV.allMeans = d.this_data_means;
CCV_Spont.NoiseCOV.Mean = d.All_smoothed_mean_all_COV_means;
clear('d')

%% Motifs

% CCV
d = load([CCV_MotifDir 'TL--20.mat']);
CCV_Motif.CCV.allMeans = d.this_data_means;
CCV_Motif.CCV.Mean = d.All_smoothed_mean_all_COV_means;
clear('d')

% Signal COV
d = load([CCV_MotifDir 'TSnp1--20.mat']);
CCV_Motif.SignalCOV.allMeans = d.this_data_means;
CCV_Motif.SignalCOV.Mean = d.All_smoothed_mean_all_COV_means;
clear('d')

% Noise COV
d = load([CCV_MotifDir 'TL-TSnp1-Diffs--20.mat']);
CCV_Motif.NoiseCOV.allMeans = d.this_data_means;
CCV_Motif.NoiseCOV.Mean = d.All_smoothed_mean_all_COV_means;
clear('d')

CCV.CCVBins = CCVBins;
CCV.CCV_Stim = CCV_Stim;
CCV.CCV_Spont = CCV_Spont;
CCV.CCV_Motif = CCV_Motif;
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Spike Count Correlations - RSC  -- 1.5 s & 200 ms
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define directories
RSCDir = [baseDir 'RSCData' dirD];

RSC_StimDir = [RSCDir 'StimFiles' dirD];
RSC_SpontDir = [RSCDir 'SpontFiles' dirD];
RSC_MotifDir = [RSCDir 'MotifsFiles' dirD];

%% Stims - 1.5 s
% Noise Correlation, RSC (1.5s)
d = load([RSC_StimDir 'RSC.mat']);
RSC_Stim.RSC.r = d.all_data_r;
RSC_Stim.RSC.p = d.all_data_p;
RSC_Stim.RSC.sigInds = d.all_sig_data_inds;
clear('d')

% Noise Correlation, RSC shuffled (1.5s)
d = load([RSC_StimDir 'RSC_Shuffle.mat']);
RSC_Stim.RSC_Shuffle.r = d.all_data_r;
RSC_Stim.RSC_Shuffle.p = d.all_data_p;
RSC_Stim.RSC_Shuffle.sigInds = d.all_sig_data_inds;
clear('d')

%% Spont - 1.5s
% Noise Correlation, RSC (1.5s)
d = load([RSC_SpontDir 'RSC.mat']);
RSC_Spont.RSC.r = d.all_data_r;
RSC_Spont.RSC.p = d.all_data_p;
RSC_Spont.RSC.sigInds = d.all_sig_data_inds;
clear('d')

% Noise Correlation, RSC shuffled (1.5s)
d = load([RSC_SpontDir 'RSC_Shuffle.mat']);
RSC_Spont.RSC_Shuffle.r = d.all_data_r;
RSC_Spont.RSC_Shuffle.p = d.all_data_p;
RSC_Spont.RSC_Shuffle.sigInds = d.all_sig_data_inds;
clear('d')

%% Motifs - 200 ms
% Noise Correlation, RSC (1.5s)
d = load([RSC_MotifDir 'RSC.mat']);
RSC_Motif.RSC.r = d.all_data_r;
RSC_Motif.RSC.p = d.all_data_p;
RSC_Motif.RSC.sigInds = d.all_sig_data_inds;
clear('d')

% Noise Correlation, RSC shuffled (1.5s)
d = load([RSC_MotifDir 'RSC_Shuffle.mat']);
RSC_Motif.RSC_Shuffle.r = d.all_data_r;
RSC_Motif.RSC_Shuffle.p = d.all_data_p;
RSC_Motif.RSC_Shuffle.sigInds = d.all_sig_data_inds;
clear('d')

RSC.RSC_Stim = RSC_Stim;
RSC.RSC_Spont = RSC_Spont;
RSC.RSC_Motif = RSC_Motif;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Population Statistics - FR, Z-Score, D-Prime
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FR_StatsDir = [baseDir 'FRStats' dirD];

%% Firing Rates

d = load([FR_StatsDir 'FRs.mat']);
FR.Stim.FR = d.All_stim_FR_Song;
FR.Spont.FR = d.All_base_FR_Song;
clear('d')

fileExists = dir(fullfile(FR_StatsDir, 'FRVector.mat'));
if numel(fileExists) >= 1
    d = load([FR_StatsDir 'FRVector.mat']);
    FR.Stim.FRVector = d.All_stim_FR_vector;
    FR.Spont.FRVector = d.All_spont_FR_vector;
    clear('d')
end

fileExists = dir(fullfile(FR_StatsDir, 'binnedFRs-STIM.mat'));
if numel(fileExists) >= 1
    
    d = load([FR_StatsDir 'binnedFRs-STIM.mat']);
    FR.Stim.SpkCntBinned = d.All_binned_Spike_Counts;
    clear('d')
    
    d = load([FR_StatsDir 'binnedFRs-Spont.mat']);
    FR.Spont.SpkCntBinned = d.All_binned_Spike_Counts;
    clear('d')
    
end

d = load([FR_StatsDir 'Z-scores.mat']);
ZScores.Z = d.All_Zs_Song;
clear('d')

DPrimes = [];
fileExists = dir(fullfile(FR_StatsDir, 'DPrimes.mat'));
if numel(fileExists) >= 1
    d = load([FR_StatsDir 'DPrimes.mat']);
    DPrimes.D = d.D;
    clear('d')
   
end

FRStats.FR = FR;
FRStats.DPrimes = DPrimes;
FRStats.ZScores = ZScores;
disp('')
%% Save

save([saveDir 'allPooledData.mat'], 'INFO', 'CCV', 'RSC', 'FRStats')
disp(['Saved: ' [saveDir 'AllPooledData']]);


end



function [output] = loadDataFromFile(CCV_Var,CCV_SubField, CCV_DirFile)

d = load(CCV_DirFile);

eval( [CCV_Var '.' CCV_SubField '.allMeans = d.this_data_means;'])
eval([CCV_Var '.' CCV_SubField '.Mean = d.All_smoothed_mean_all_COV_means;'])
clear('d')

eval(['output = ' CCV_Var ';' ])
disp('')


end

