function [] = plotRasterplotsRawData(rasterplot_vers, allDirPaths, OnOff_params, spks, spikeShapes, raw_data_info, data, z_score_stats, overwrite, print_params)

%% Stim info
analysis_type = OnOff_params.analysis_type;


if OnOff_params.stim_analysis_type== 5
song_type = OnOff_params.BOUT_song_type;
else
    
song_type = OnOff_params.song_type;
end

%% Dir info
rast_dir = allDirPaths.bird_rast_dir;
recording_session = raw_data_info.recording_session;

%%

nplots = numel(rasterplot_vers);

for p = 1:nplots
    
    thisPlotVer = rasterplot_vers(p);
    
    if thisPlotVer == 0
        
        disp('<<< No rasterplot to be plotted.');
        %% Raster plot - Unique Stim Raster
    elseif thisPlotVer == 1
        
        plot_filename = [rast_dir recording_session '_RasterUniqStims_' song_type analysis_type ''];
        search_file = [plot_filename '*'];
        nbr_files = dir(search_file);
        
        %% Check to see if the rasterplot already exists
        if size(nbr_files, 1) > 0 && overwrite ||  size(nbr_files, 1) <= 0 % A file exists, but user selected to overwrite or file doenst exist
            plotting_RastUniqueStims(OnOff_params, spks, raw_data_info, plot_filename, data, print_params, song_type);
        else
            disp('<<< Keeping previously plotted rasterplot: UniqueStims');
        end
        
        %% Raster plot - All Stim Raster
    elseif thisPlotVer == 2
        
        plot_filename = [rast_dir recording_session '_RasterAllStims_' song_type analysis_type ''];
        search_file = [plot_filename '*'];
        nbr_files = dir(search_file);
        
        if size(nbr_files, 1) > 0 && overwrite ||  size(nbr_files, 1) <= 0 % A file exists, but user selected to overwrite or file doenst exist
            plotting_RastAllStims(OnOff_params, spks, raw_data_info, plot_filename, data, z_score_stats, print_params, song_type)
        else
            disp('<<< Keeping previously plotted rasterplot: AllStims');
        end
        
        %% Raw data plot - Full Stim block
    elseif thisPlotVer == 3
        
        plot_filename = [rast_dir recording_session '_RawDataStimBlock_' song_type analysis_type ];
        
        search_file = [plot_filename '*'];
        nbr_files = dir(search_file);
        
        if size(nbr_files, 1) > 0 && overwrite ||  size(nbr_files, 1) <= 0 % A file exists, but user selected to overwrite or file doenst exist
            plottingRawDataStimBlock(OnOff_params, raw_data_info, plot_filename, data, print_params, song_type);
        else
            disp('<<< Keeping previously plotted raw data: rawDataAll');
        end
        %% Raw data plot - ParitalStim block + spikforms
    elseif thisPlotVer == 4
        
        plot_filename = [rast_dir recording_session '_RawDataSubset_' song_type analysis_type ];
        
        search_file = [plot_filename '*'];
        nbr_files = dir(search_file);
        
        if size(nbr_files, 1) > 0 && overwrite ||  size(nbr_files, 1) <= 0 % A file exists, but user selected to overwrite or file doenst exist
            plottingRawDataStimSubset(OnOff_params, raw_data_info, plot_filename, data, spikeShapes, print_params, song_type);
        else
            disp('<<< Keeping previously plotted raw data: rawDataSubset');
        end
        
        %% Integrated FR for Unique Stims
    elseif thisPlotVer == 5
        
        plot_filename = [rast_dir recording_session '_IntegratedFRs-UniqueStims_' song_type analysis_type ];
        search_file = [plot_filename '*'];
        nbr_files = dir(search_file);
        
        if size(nbr_files, 1) > 0 && overwrite ||  size(nbr_files, 1) <= 0 % A file exists, but user selected to overwrite or file doenst exist
            plottingAllIntegratedFRsUniqueStims(OnOff_params, spks, raw_data_info, plot_filename, data, print_params, song_type);
            
        else
            disp('<<< Keeping previously plotted FRs: IntegratedFRs-UniqueStims');
        end
     
    else
          disp('<<< No rasterplot to be plotted.');
        
    end
end

end

