function [C_Matrix] = analysis_LoadOrCalcCorrOutput(FR_meta, overwrite, allDirPaths, OnOff_params, raw_data_info, Lags, this_bias)
%analysis_CalcXCOV(FR_meta, overwrite, all_spks, cor_paths, cor_start_stop_params, raw_data_info, Lags, data_T, all_lengths_on_chans, this_bias)

%% Define the CorMatrix filename

calc_type = OnOff_params.xCorrType;
if OnOff_params.stim_analysis_type ==5
    song_type = OnOff_params.BOUT_song_type;
else
    
    song_type = OnOff_params.song_type;
end

analysis_type = OnOff_params.analysis_type;
recording_session = raw_data_info.recording_session;

switch calc_type
    case 1
        file_ending = ['-' num2str(roundn(Lags.max_lag_bins), -2) '-COH_Matrix-Reps.mat'];
    case 2
        file_ending = ['-' num2str(roundn(Lags.max_lag_bins), -2) '-COR_Matrix-Reps.mat'];
    case 3
        file_ending = ['-' num2str(roundn(Lags.max_lag_bins), -2) '-COV_Matrix-Reps.mat'];
end

bird_mat_dir = allDirPaths.bird_mat_dir;
corrOutputFilename = [bird_mat_dir recording_session '-' song_type analysis_type file_ending];

%% Check to see if a previously-calculated CorMatrix file exists

if exist(corrOutputFilename, 'file') == 0 || overwrite % If no file exists or if we overwrite it
    %[C_Matrix] = analysis_CalcXCOV(FR_meta, all_spks, Lags, calc_type, corrOutputFilename, data_T, all_lengths_on_chans, this_bias,cor_start_stop_params);
    
    [C_Matrix] = analysis_CalcXCOV(FR_meta, Lags, corrOutputFilename, this_bias, OnOff_params);
    
    disp('<<< Calculating new correlation output.')
else
    disp('<<< Loading previously calculated correlation output.')    
    load(corrOutputFilename) % should return C_Matrix
end


end
