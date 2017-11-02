function [] = mainAnanalysisForCorrelationData()
% This function requires the 'correlationDataInfo' database m file
dbstop if error
close all
%% Parameters
% Analysis Settings
stim_analysis_type = 0; % Stims (0), Spontaneous (4), CON-Motif (5), STRF Preparation (6)
doSubsetAnalaysis = 0; % Analyze a specific hardcoded subset of data recording sessions for each bird

%% Path settings
switch gethostname
    case {'d-01096', 'lnx-cm-6010', 'lnx-cm-6007', 'lnx-cm-6011', 'lnx-cm-6009', 'lnx-cm-6001'}
        mainDataDir = '/storage/laur/Personal/OndracekJanie/INI/Projects/Extracellular/Quadruplet/';
    case 'deadpool'
        mainDataDir = '/home/janie/Data/INI/Quadruplet/';
    otherwise
        
        mainDataDir = '/home/janie/Data/INI/Data/Quadruplet/';
end

directoryDelimiter = '/';

if ispc
    directoryDelimiter = '\';
end

%% Correlation Parameters
xCC_norm.xCOV = 3; % for xCC calculation: Raw (0), biased (1), unbiased(2), coef (3)
xCC_norm.xCOH = 2; % for xCC calculation: Raw (0), biased (1), unbiased(2), coef (3)
xCorrType = 3; % COH (1), COR (2), COV (3)

% Plotting Parameters
Plot_other_figs = 0;
rasterplot_vers = [0]; %no plots(0), ind stims(1), all stims (2), full raw data (3), raw data 5 Reps + spike shapes (4) FR plots (5)
plot_z_scores = 0; % Plot (1), dont plot  (0);
overwrite = 0; % overwrite 1 means automatically loading previously calculated/plotted stuff

print_params.print_orientation = 0; %(0) = portrait; (1) = landscape
print_params.print_format = 2; %(1) = -epsc;; (2) = -png; (3) = -pdf; (4) = -jpeg; (5) = -fig;

%% Define the resolution for spike binning
BinInfo.BIN_size_ms = 5; % in ms
%BIN_size_ms = 1; % in ms
%BIN_size_ms = 10; % in ms
BinInfo.BIN_size = BinInfo.BIN_size_ms/1000;
BinInfo.BIN_size_text = [num2str(BinInfo.BIN_size*1000) 'ms'];

todaysDate = date;

%% Load information about the data from 'correlationDataInfo.m'
[raw_data_file_db] = correlationDataInfo();

% Find number of entries in the database
for a = 1:size(raw_data_file_db, 2)
    bird_ids(a) = raw_data_file_db(a).birdID;
end

% Find the unique number of birds
unique_bird_ids = unique(bird_ids);
nBirds = numel(unique_bird_ids);

%% Loop over bird IDs and run analysis
for bID = 1:nBirds
    
    % Find database entries that correspond to this bird ID (bID)
    datafiles_inds_for_this_bird = find(ismember(bird_ids, bID));
    
    if doSubsetAnalaysis
        switch bID
            case 1 % b20r1
                set = [1 2];
            case 2 % g4r4
                set = [1 2 4 5];
            case 3 % g18r2
                set = [1 2 3];
            case 4 % k17r4
                set = 2;
            case 5 % k18r4
                set = 1;
            case 6 %o1r4
                set = [3 4 5 6 7];
            case 7 % o5r3
                set = [2 4 5 6 7];
            case 9 % p11r4
                set = [2 3 4 5 6 8];
            case 10 % p17r2
                set = [1 3];
            case 11 % r2y20
                set = [1 3] ;
            case 12 % r3p
                set = [4 6];
            case 13 % r6y11
                set = [1 4 6];
            case 14 %r6y12
                set = [2 3 6];
            case 15 %y5y10
                set = [1 2 3 6 7 8 9];
            otherwise
                continue
        end
    else
        set = 1:size(datafiles_inds_for_this_bird, 2);
        
    end
    
    nRecordingSessions = numel(set);
    
    %% the data information about this bird and the associated data set
    for o = 1:nRecordingSessions
        
        thisRecordingSession = set(o);
        this_data_info = raw_data_file_db(datafiles_inds_for_this_bird(thisRecordingSession)); % Bird and recording session related information
        
        %% Define Bird/Recording session-related variables
        
        % Bird Info
        bird_name = this_data_info.bird_name;
        bird_age = this_data_info.bird_age;
        
        thisBirdPath = [mainDataDir bird_name directoryDelimiter];
        
        % Raw Data Info
        data_name = this_data_info.raw_file;
        data_file_format = this_data_info.data_file_format;
        
        % Data Paths
        thisRawDataPath = [thisBirdPath 'Data' directoryDelimiter];
        thisRecordingSessionPath = [thisRawDataPath data_name];
        
        %% sound channel info
        wav_chan = this_data_info.wav;
        mic_chan = this_data_info.mic;
        
        % Package raw data info into a structure
        raw_data_info.recording_session = data_name;
        raw_data_info.mic_channel = mic_chan;
        raw_data_info.wav_channel = wav_chan;
        
        %% Spike-Related Info
        
        % Paths
        %SpikeTimes
        spikeTimesPath = [thisBirdPath 'Spikes' directoryDelimiter];
        spikeTimesFile = this_data_info.spike_file;
        
        % SpikeForms
        spikeformPath = [spikeTimesPath 'Spikeforms' directoryDelimiter];
        spikeforms_file = this_data_info.spikeforms;
        
        % Load Spike Times
        spikeTimes = load([spikeTimesPath spikeTimesFile '.mat']);
        spks = spikeTimes.spks;
        
        % Load Spike shapes
        spikeShapes = load([spikeformPath spikeforms_file]);
        
        %% Soundfile Version
        
        % soundfile version
        % This is a file that contains information about how many repeptitions of each stimulus there are
        soundfile_vers = this_data_info.soundfile_vers;
        
        if isempty(soundfile_vers)
            disp('You have not set any information about the songfile version.')
            disp('Please make sure to add this information to your bird database.')
            keyboard
        end
        
        %% Stimuls Onsets and Offsets
        
        OnsetOffsetFilePath = [thisBirdPath 'Startstop' directoryDelimiter];
        
        % Stims and Spont
        OnsetOffsetFile_Stims = this_data_info.BOUT_startstop;
        OnsetOffsetFile_Spont = this_data_info.SPONT_startstop;
      
        %Motifs and Stims are not mutually selectable
        if stim_analysis_type == 5 %Motifs
            OnsetOffsetFile_Motifs = this_data_info.NEW_MOTIF_startstop;
            if isempty (OnsetOffsetFile_Motifs) % If there is not a NEW_MOTIF file, take the old version
                disp('No New Motif File')
                %continue
                OnsetOffsetFile_Motifs = this_data_info.MOTIF_startstop;
            end
            OnsetOffsetsPath_Motifs = [OnsetOffsetFilePath OnsetOffsetFile_Motifs];
            OnsetOffsets_Motifs = load(OnsetOffsetsPath_Motifs);
        end
        OnsetOffsetsPath_Stims = [OnsetOffsetFilePath OnsetOffsetFile_Stims];
        OnsetOffsetsPath_Spont = [OnsetOffsetFilePath OnsetOffsetFile_Spont];

        OnsetOffsets_Stims = load(OnsetOffsetsPath_Stims);
        OnsetOffsets_Spont = load(OnsetOffsetsPath_Spont);
      
        % Outputs the stimulus identity
        [stim_selected_by_user, stim_names_selected] = mapStimsToCorrectInds(OnsetOffsetsPath_Stims, soundfile_vers); % Needs to have the path
        
        %% Create bird-specific directories & set printing params
        
        [allDirPaths, quad_metafile_name] = createOutputDirs(mainDataDir, BinInfo.BIN_size_text, directoryDelimiter, bird_name, stim_analysis_type, xCC_norm, plot_z_scores, todaysDate);
        %[cor_paths, quad_metafile_name] = cc_create_corr_file_dirs(BIN_size_text, directoryDelimiter, bird_name, stim_analysis_type, this_bias, plot_z_scores, todays_data);
        
        %% User Feedback
        
        disp('');
        disp('********************************************')
        disp(['   Now calculating for data file: ' data_name])
        disp(['   Bird ' num2str(bID) ' of ' num2str(size(unique_bird_ids, 2)) ])
        disp(['   Bird Data File ' num2str(thisRecordingSession) ' of ' num2str(size(datafiles_inds_for_this_bird, 2)) ])
        disp('********************************************')
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Loading the data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        tic
        if data_file_format ~= 8 % file format 8 needs to be loaded with the chronic file loader
            [data data_scanrate]= load_labview_acute(thisRecordingSessionPath, 0);
            disp('Loading raw data file..');
        else
            [data data_scanrate] = load_labview_chronic(thisRecordingSessionPath, 0);
            disp('Loading raw data file..');
        end
        toc
        
        raw_data_info.scanrate_labview = data_scanrate;
        
        dataLength = (size(data, 2)/data_scanrate); % in seconds
        
        disp (['data is ' num2str(dataLength) ' seconds long.']);
        
        if dataLength == 0
            disp('************************')
            disp('************************')
            disp(['There is a file loading problem for bird: '  bird_name])
            disp('************************')
            disp('************************')
            keyboard
        end
        
        %% Define the Correlation Lags
        
        [Lags] = cc_define_cor_lags(data_scanrate, BinInfo.BIN_size_ms);
        
        % Give the use some feedback as to the parameters set
        disp('********************************************')
        disp ('Used the following files and parameters:')
        disp(' ');
        disp(['Data file: ' thisRecordingSessionPath])
        disp(['Soundfile version: ' num2str(soundfile_vers)])
        disp(['Spike File: ' OnsetOffsetsPath_Stims])
        disp(['Bin Size: ' num2str(BinInfo.BIN_size_ms) ' ms'])
        disp('********************************************')
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Start for loop for analyzing spikes over stimuli
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % hardcode override for a specific stimulus of interest
        %stim_selected_by_user = [1 6  7 8 12];
        
        if stim_analysis_type == 5
            stim_selected_by_user = [6  7 8 ];
        end
        
        %num_stims_selected = size(stim_selected_by_user, 2);
        nStimsSelected = size(stim_selected_by_user, 2);
        
        for j = 1:nStimsSelected(end)
            
            %% load stim-related files from "bird/neuron database" and "stims_and_reps database"
            % we need to find the unique stimulus versions within the stimulus repetitions.
            % This information is hardcoded in the 'uniqueReps_Stims' and 'uniqueReps_Motifs'database.
            % This maps the soundfile version parameter to a list of repetitions and stimuli present in that data file
            
            if stim_analysis_type == 5
                
                [uniqueRepInfo_Motifs] = uniqueReps_Motifs(stim_selected_by_user(j), OnsetOffsets_Motifs);
                OnOff_params.OnsetOffsets_Motifs = OnsetOffsets_Motifs;
            end
            
            [uniqueRepInfo_Stims] = uniqueReps_Stims(stim_selected_by_user(j), soundfile_vers);
            
            %% Propagate the correct onsets and offsets for this specifc stimlus and save as a variable
            
            OnOff_params.OnsetOffsets_Stims = OnsetOffsets_Stims;
            OnOff_params.OnsetOffsets_Spont = OnsetOffsets_Spont;
            OnOff_params.BIN_size_ms = BinInfo.BIN_size_ms ;
            
            if  stim_analysis_type == 0 || stim_analysis_type == 6
                
                [OnOff_params.stim_start, OnOff_params.stim_stop, OnOff_params.song_type] = cc_choose_stim(stim_selected_by_user(j),  OnsetOffsets_Stims);
                [OnOff_params.stim_start_Spont, OnOff_params.stim_stop_Spont, OnOff_params.song_type] = cc_choose_stim(stim_selected_by_user(j),  OnsetOffsets_Spont);
                
            elseif stim_analysis_type == 4
                [OnOff_params.stim_start, OnOff_params.stim_stop, OnOff_params.song_type] = cc_choose_stim(stim_selected_by_user(j), OnsetOffsets_Spont);
                
            elseif stim_analysis_type == 5 % For motifs, we need both the bout and motif onsets/offsets
                
                [OnOff_params.stim_start, OnOff_params.stim_stop, OnOff_params.BOUT_song_type] = cc_choose_stim(stim_selected_by_user(j),  OnOff_params.OnsetOffsets_Motifs);
                [OnOff_params.BOUT_stim_start, OnOff_params.BOUT_stim_stop, OnOff_params.BOUT_song_type] = cc_choose_stim(stim_selected_by_user(j),  OnOff_params.OnsetOffsets_Stims);
            end
            
            OnOff_params.xCorrType = xCorrType;
            OnOff_params.stim_analysis_type = stim_analysis_type;
            OnOff_params.stim_selected = stim_selected_by_user(j);
            
            if  stim_analysis_type == 0 % Bouts
                OnOff_params.reps = uniqueRepInfo_Stims.stim_reps;
                OnOff_params.unique_stims = uniqueRepInfo_Stims.unique_stims;
                
                % In order to calculate z scores, we need the spont onsets too
                OnOff_params.reps_spont = uniqueRepInfo_Stims.spont_reps;
                OnOff_params.unique_stims_spont = uniqueRepInfo_Stims.spont_versions;
                analysis_type = '-Complete-Stims';
                
            elseif stim_analysis_type == 4 % Spont
                OnOff_params.reps = uniqueRepInfo_Stims.spont_reps;
                OnOff_params.unique_stims = uniqueRepInfo_Stims.spont_versions;
                analysis_type = '-Spontaneous-Intervals';
            
            elseif stim_analysis_type == 5 % Motifs
                %OnOff_params.reps = uniqueRepInfo_Motifs.stim_reps;
                %OnOff_params.unique_stims = uniqueRepInfo_Motifs.unique_stims;
                OnOff_params.reps = uniqueRepInfo_Motifs.bout_reps;
                OnOff_params.unique_stims = uniqueRepInfo_Motifs.unique_bouts;
                
                OnOff_params.bout_reps = uniqueRepInfo_Stims.stim_reps;
                OnOff_params.bout_unique_stims = uniqueRepInfo_Stims.unique_stims;
                analysis_type = '-Motifs';
                
            elseif stim_analysis_type == 6 % STRF Prep
                OnOff_params.reps = uniqueRepInfo_Stims.stim_reps;
                OnOff_params.unique_stims = uniqueRepInfo_Stims.unique_stims;
                
                % In order to calculate z scores, we need the spont onsets too
                OnOff_params.reps_spont = uniqueRepInfo_Stims.spont_reps;
                OnOff_params.unique_stims_spont = uniqueRepInfo_Stims.spont_versions;
                analysis_type = '-STRFs-';
            end
            
            OnOff_params.analysis_type = analysis_type;
            
            if isempty(OnOff_params.stim_start)
                continue
            else
                
                disp('Finished loading stimulus start and stop times.');
             
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %% Starting Analysis
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                %% STRF Analysis
                if stim_analysis_type == 6
                    cc_run_STRF_preprocessing(spks, allDirPaths.main_corr_dir, data_name, data, OnOff_params, nStimsSelected, wav_chan, data_scanrate, directoryDelimiter, mic_chan)
                else
                    
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %% Single Neuron Analysis: FR, Z-scores, Auto-Covariance
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                    %% Extracting spike times, calculating firing rates on full stims and spont, binning spikes
                    % For CON motifs, we have a special method
                    if stim_analysis_type == 5 % Motifs
                        if  stim_selected_by_user(j) == 7 % CON
                            [FR_meta, AnovaStats]  = analysis_calcFR_binSpikes_Motifs_CON(BinInfo.BIN_size, OnOff_params, spks, raw_data_info, allDirPaths, stim_selected_by_user(j), Plot_other_figs);
                        else
                            %[FR_meta, channel_numbers, AnovaStats] = cc_calc_FRs_for_reps_new_binning_method_CON_motifs(BIN_size, OnOff_params, spks, raw_data_info, cor_paths, stim_selected_by_user(j), Plot_other_figs);
                            [FR_meta, AnovaStats] = analysis_calcFR_binSpikes_Motifs(BinInfo.BIN_size, OnOff_params, spks, raw_data_info, allDirPaths, stim_selected_by_user(j), Plot_other_figs);
                            %[FR_meta, channel_numbers, AnovaStats] = cc_calc_FRs_for_reps_new_binning_method_CON_motifs(BinInfo.BIN_size, OnOff_params, spks, raw_data_info, allDirPaths, stim_selected_by_user(j), Plot_other_figs);
                            % For all other stim cases
                        end
                    else
                        [FR_meta, AnovaStats] = analysis_calcFR_binSpikes(BinInfo.BIN_size, OnOff_params, spks, raw_data_info, allDirPaths, stim_selected_by_user(j), Plot_other_figs);
                    end
                
                    %% Checking numbers of channels
                    if isstruct(FR_meta)
                        raw_data_info.channel_numbers = FR_meta.channel_numbers;
                        raw_data_info.num_channels = FR_meta.num_channels;
                    else
                        continue
                    end
                    if  raw_data_info.num_channels == 0
                        disp('skipping this analysis, no chans with spikes detected')
                        continue
                    end
                    
                    %% Calculate the zscore
                    z_score_stats = analysis_calcZScores(allDirPaths, raw_data_info, OnOff_params, FR_meta, plot_z_scores, stim_selected_by_user(j));
                    
                    %% Calculate Autocov on binned spikes
                    
                    [autoCOV] = analysis_CalcBinnedAutoCOV(allDirPaths, raw_data_info, FR_meta, OnOff_params, Lags, stim_selected_by_user(j), Plot_other_figs);
                    
                    %% Extracting spike times for spike count correlations (requires certain defined time windows)

                    if stim_analysis_type == 5 % Motifs
                        if  stim_selected_by_user(j) == 7 % CON Motifs
                            binSpkCnts_RSC = extractSpikeAnalysisWindows_RSC_CON(OnOff_params, spks, raw_data_info, 0.2); % 200 ms window for motifs
                            %SpikeCounts = cc_organize_spikes_forSCCs_CON_motifs(OnOff_params, spks, raw_data_info, cor_paths);
                        else % REV & BOS Motifs
                            binSpkCnts_RSC = extractSpikeAnalysisWindows_RSC(OnOff_params, spks, raw_data_info, 0.2); % 200 ms window for motifs
                            %SpikeCounts = cc_organize_spikes_forSCCs_motifs(OnOff_params, spks, raw_data_info, cor_paths);
                        end
                    else % All other analysis
                        binSpkCnts_RSC = extractSpikeAnalysisWindows_RSC(OnOff_params, spks, raw_data_info, 1.5); % 1.5 second window for stims
                    end
                    
                    %% here we check to see if there are any any channels with spikes
                    if isempty(raw_data_info.channel_numbers)
                        disp('<<< FR data is empty for all channels, calculating next stimulus...')
                        continue
                    else
                        
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %% Pair Analysis: RSC, CCV, Signal COV
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
                        %% Calculating Noise correlations
                        [RSC] = analysis_calcCorrCoeff_BinnedSpikeCnts(binSpkCnts_RSC, allDirPaths, OnOff_params, raw_data_info, stim_selected_by_user(j), Plot_other_figs);
                        
                        %% Plot rasterplots or raw data
                        if stim_analysis_type == 5 && stim_selected_by_user(j) == 7
                        else
                            plotRasterplotsRawData(rasterplot_vers, allDirPaths, OnOff_params, spks, spikeShapes, raw_data_info, data, z_score_stats, overwrite, print_params)
                        end
                        
                        %% Check to make sure pair comparisons are present before continuing
                        
                        if ~isstruct(RSC) % If there are no correaltion pairs, we cannot continue
                            disp('<<< No pairs for this stimulus comparison')
                            continue
                        else
                            nonZeroCorrs = numel(find(RSC.rSC ~= 0));
                            
                            if nonZeroCorrs >=1 % we need at least 2 channels to make pairwise comparisons (1 corr)
                                
                                %% Calculate xCOV and xCOH
                                
                                [C_Matrix] = analysis_LoadOrCalcCorrOutput(FR_meta, overwrite, allDirPaths, OnOff_params, raw_data_info, Lags, xCC_norm);
                                
                                %% Sort Reps into shuffled and non shuffled pairs
                                
                                if stim_analysis_type == 5 && stim_selected_by_user(j) == 7
                                    [COV_sorted_C_matrix, COH_sorted_C_matrix] = analysis_sortXCOVReps_CON(C_Matrix, OnOff_params, FR_meta, stim_selected_by_user(j));
                                    %[COV_sorted_C_matrix, COH_sorted_C_matrix] = cc_sort_corr_matrix_motifs_V2(C_Matrix, OnOff_params, FR_meta.all_spks_on_chans, stim_selected_by_user(j));
                                else
                                    [COV_sorted_C_matrix, COH_sorted_C_matrix] = analysis_sortXCOVReps(C_Matrix, OnOff_params, FR_meta, stim_selected_by_user(j));
                                end
                                
                                %% Plotting!!!!
                                
                                if isstruct(C_Matrix) && size(C_Matrix.COVs, 2) ~=1 % Check to make sure C_Matrix isnt empty and that there is more than 1 entry
                                    
                                    [COV_metaINFO] = analysis_calcXCorrMeans_makePlots(1, binSpkCnts_RSC, FR_meta, COV_sorted_C_matrix, Lags, allDirPaths, OnOff_params, raw_data_info, RSC, z_score_stats, AnovaStats, autoCOV, print_params, stim_selected_by_user(j), Plot_other_figs, BinInfo) ;
                                    
                                    % [COH_metaINFO] = analysis_calcXCorrMeans_makePlots(2, binSpkCnts_RSC, FR_meta, COH_sorted_C_matrix, Lags, allDirPaths, OnOff_params, raw_data_info, RSC, z_score_stats, AnovaStats, autoCOV, print_params, stim_selected_by_user(j), Plot_other_figs, BinInfo) ;
                                    
                                    disp ('>>> Finished plotting!!!')
                                    
                                else
                                    keyboard
                                    
                                    COV_metaINFO = NaN;
                                    COH_metaINFO = NaN;
                                    
                                end
                                
                                
                            else
                                
                                COV_sorted_C_matrix = NaN;
                                COH_sorted_C_matrix = NaN;
                                COV_metaINFO = NaN;
                                COH_metaINFO = NaN;
                                
                            end
                            
                        end
                        
                        disp('>>> updating quad meta data...')
                        tic
                        appendMetaINFO(binSpkCnts_RSC, this_data_info, spks, quad_metafile_name, stim_selected_by_user(j), z_score_stats, COV_metaINFO, FR_meta, autoCOV, OnOff_params, AnovaStats, RSC, COV_sorted_C_matrix, spikeShapes, BinInfo, 1)
                        toc
                    end
                end
            end
        end
        
    end
end
end

