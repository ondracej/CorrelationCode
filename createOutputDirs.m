function [allDirPaths, quad_metafile_name] = createOutputDirs(mainDataDir, BIN_size_text, directoryDelimiter, birdName, stim_analysis_type, this_bias, plot_z_scores, todaysDate)

%% Main bird directory

switch this_bias.xCOV
    case 0
        bias_type_text = 'Raw';
    case 1
        bias_type_text = 'Biased';
    case 2
        bias_type_text = 'Unbiased';
    case 3
        bias_type_text = 'Coef';
end

switch stim_analysis_type
    case 0
        analysis_type_text = 'Stims';
    case 4
        analysis_type_text = 'Spont';
    case 5
        analysis_type_text = 'Motifs';
    case 6
        analysis_type_text = 'STRF-Prep';
end

%% Main Output directory
analysisOutputDirectory = [mainDataDir 'Analysis' directoryDelimiter];

binDateStimBiasPath_Id = [BIN_size_text '/' todaysDate '-' analysis_type_text '-' bias_type_text directoryDelimiter];

%% Bird-specific paths
birdDir_Corrs = [analysisOutputDirectory  binDateStimBiasPath_Id birdName directoryDelimiter];

% if exist(birdDir_Corrs, 'dir') == 0
%     mkdir(birdDir_Corrs);
%     disp('Created main bird-specific correlation output directory.')
% end

%% Correlation Output Directory

pairwiseOutputDir =[analysisOutputDirectory  binDateStimBiasPath_Id 'PairwiseOutput/'];
if exist(pairwiseOutputDir, 'dir') == 0
    mkdir(pairwiseOutputDir);
    disp('Created pairwiseoutput directory.')
end

%% Bird specific correlation output data
corrOutputDir_bird = [pairwiseOutputDir birdName directoryDelimiter 'XCorr_Output' directoryDelimiter];
if exist(corrOutputDir_bird, 'dir') == 0
    mkdir(corrOutputDir_bird);
    disp('Created pairwise XCorr directory.')
end

%% Figure Output Directories

mainFigureDir = [pairwiseOutputDir(1:end-1) '-Figures' directoryDelimiter];
if exist(mainFigureDir, 'dir') == 0
    mkdir(mainFigureDir);
    disp('Created main correlation figure directory.')
end

%% Bird-specific pairwise comparisons - figure output directory
%main pairwise figure dir
corrOutputFigDir_bird = [mainFigureDir birdName directoryDelimiter];
if exist(corrOutputFigDir_bird, 'dir') == 0
    mkdir(corrOutputFigDir_bird);
    disp('Created correlation bird figure directory.')
end

%cross covariance/coherency
figDir_COV = [corrOutputFigDir_bird 'COV' directoryDelimiter];
if exist(figDir_COV, 'dir') == 0
    mkdir(figDir_COV);
    disp('Created COV correlation figures directory.')
end

figDir_COH = [corrOutputFigDir_bird 'COH' directoryDelimiter];
if exist(figDir_COH, 'dir') == 0
    mkdir(figDir_COH);
    disp('Created COH correlation figures directory.')
end

% spike count correlations
figDir_RSC = [corrOutputFigDir_bird 'RSC' directoryDelimiter];
if exist(figDir_RSC, 'dir') == 0
    mkdir(figDir_RSC);
    disp('Created RSC figures directory.')
end

%% Rasterplot directory
rasterplotFigDir = [corrOutputFigDir_bird 'Rasterplots' directoryDelimiter];
if exist(rasterplotFigDir, 'dir') == 0
    mkdir(rasterplotFigDir);
    disp('Created rasterplot directory.')
end

%% Z-scores
if plot_z_scores
    zscoreFigDir = [corrOutputFigDir_bird 'Z-Scores' directoryDelimiter];
    if exist(zscoreFigDir, 'dir') == 0
        mkdir(zscoreFigDir);
        disp('Created Z-score figures directory.')
    end
    allDirPaths.bird_zscore_dir = zscoreFigDir;
end


%% Quad-Meta Filename
switch this_bias.xCOV
    case 0
        quad_metafile_name = [pairwiseOutputDir birdName '-MetaData-RAW-' analysis_type_text '.mat' ];
    case 1
        quad_metafile_name = [pairwiseOutputDir birdName '-MetaData-BIASED- ' analysis_type_text '.mat' ];
    case 2
        quad_metafile_name = [pairwiseOutputDir birdName '-MetaData-UNBIASED-' analysis_type_text '.mat' ];
    case 3
        quad_metafile_name = [pairwiseOutputDir birdName '-MetaData-COEF-' analysis_type_text '.mat' ];
end

%% Package the paths into one var

allDirPaths.main_corr_dir = pairwiseOutputDir;
allDirPaths.corr_COV_dir = figDir_COV;
allDirPaths.corr_COH_dir = figDir_COH;
allDirPaths.bird_corr_dir = corrOutputFigDir_bird;
allDirPaths.bird_rast_dir = rasterplotFigDir;
allDirPaths.bird_mat_dir = corrOutputDir_bird;
allDirPaths.figDir_RSC = figDir_RSC;
allDirPaths.figDir_RSC = figDir_RSC;

%{
%% Package the paths into one var
cor_paths.main_corr_dir = corr_bird_dir;
cor_paths.corr_COV_dir = corr_COV_dir;
cor_paths.corr_COH_dir = corr_COH_dir;
cor_paths.bird_corr_dir = corr_dir;
cor_paths.bird_rast_dir = rast_dir;
cor_paths.bird_mat_dir = mat_dir;
cor_paths.bird_CC_plots_dir = CC_plots_dir;
%cor_paths.bird_newCov = NewCOV_dir;
%}
end