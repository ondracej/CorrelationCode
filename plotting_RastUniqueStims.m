function [] = plotting_RastUniqueStims(OnOff_params, spks, raw_data_info, plot_filename, data, print_params, song_type)
%plotting_RastUniqueStims(cor_start_stop_params, spks, raw_data_info, rast_filename, data, print_params)

%% Unpack raw data information
if ~isempty(raw_data_info.wav_channel)
    mic_channel = raw_data_info.wav_channel(1); % here we use the wav channel, it looks nicer
else
    mic_channel = raw_data_info.mic_channel(1);
end

scanrate_labview = raw_data_info.scanrate_labview;
recording_session = raw_data_info.recording_session;

num_channels = raw_data_info.num_channels;
channel_numbers = raw_data_info.channel_numbers;
%% Unpack startstop time information

unique_stims = OnOff_params.unique_stims;
reps = OnOff_params.reps;
stim_start = OnOff_params.stim_start;
stim_stop = OnOff_params.stim_stop;
%song_type = OnOff_params.song_type;
analysis_type = OnOff_params.analysis_type;
total_reps = unique_stims*reps;

%% Printing Params

print_orientation =  print_params.print_orientation;
print_format = print_params.print_format;

%% Spike size parameters

spk_size_y = 0.005;
y_offset_between_repetitions = 0.001;
if OnOff_params.stim_analysis_type == 5
    buffer = 50; % in ms
else
    buffer = 1000; % in ms
end

buffer_sampls = floor((scanrate_labview*buffer)/1000); % We plot 1 s before and after stim onsets

%% Other parameters
time_scale = 1000; % put time in units of ms
winsize = 960; % For smoothing the FR, ~ 20 ms
spec_scale = 2000; % for changing the intesity of the spectrogram

%% Plot example spectrograms

for m = 1 : num_channels
    
    this_fig = figure(10+m);
    chan = channel_numbers(m);
    chan_name = num2str(chan);
    this_rast_filename = [plot_filename '_CH-' chan_name];
    
    % Check to make sure that there are spikes present
    spkThisStim = numel(spks{chan}(spks{chan} >= stim_start(1) & spks{chan} <= stim_start(end)));
    
    if  spkThisStim == 0 % no spikes present
        disp(['<<< No spikes on ch ' chan_name])
        
    else
        
        
        %% Plotting the spectrograms
        for j = 1: unique_stims
            
            this_data = data(mic_channel, stim_start(j)-buffer_sampls :  stim_stop(j)+buffer_sampls) ;
            
            %% Define axes for the spectrograms
            switch j % We will only plot the first 6 unique stims
                case 1
                    axes('position',[0.05 0.22 0.45 0.09]);
                case 2
                    axes('position',[0.05 0.55 0.45 0.09]);
                case 3
                    axes('position',[0.05 0.88 0.45 0.09]);
                case 4
                    axes('position',[0.525 0.22 0.45 0.09]);
                case 5
                    axes('position',[0.525 0.55 0.45 0.09]);
                case 6
                    axes('position',[0.525 0.88 0.45 0.09]);
            end
            
            specgram1(double(this_data)/spec_scale,512,scanrate_labview,400,360);
            ylim([0 10000]) % Filter to 10 kHz
            set(gca, 'xtick', []);
            set(gca, 'ytick', []);
        end
        
        %% Plotting the spikes for first 6 unique stimuli
        runs = 1;
        hold on;
        
        for p = 1 : unique_stims
            
            %% Define spike line axes
            switch p
                case 1
                    axes('position',[0.05 0.12 0.45 0.09]);
                case 2
                    axes('position',[0.05 0.45 0.45 0.09]);
                case 3
                    axes('position',[0.05 0.78 0.45 0.09]);
                case 4
                    axes('position',[0.525 0.12 0.45 0.09]);
                case 5
                    axes('position',[0.525 0.45 0.45 0.09]);
                case 6
                    axes('position',[0.525 0.78 0.45 0.09]);
            end
            
            %% Now we plot spikes for reps of 6 unique stimuli
            i = p;
            
            for s = 1 : reps
                
                start_stim = stim_start(i)-buffer_sampls;
                stop_stim = stim_stop(i)+buffer_sampls;
                length_this_stim = stop_stim-start_stim; % should be length of stim + 2 s
                
                %must subtract start_stim to arrange spikes relative to onset
                these_spks_on_chan = spks{chan}(spks{chan} >= start_stim & spks{chan} <= stop_stim)-start_stim;
                
                %% Plot the spike lines
                
                y_low =  (runs * spk_size_y - spk_size_y);
                y_high = (runs * spk_size_y - y_offset_between_repetitions);
                
                spk_vct = repmat(these_spks_on_chan, 2, 1); % this draws a straight vertical line
                this_run_spks = size(spk_vct, 2);
                ln_vct = repmat([y_high; y_low], 1, this_run_spks); % this defines the line height
                
                line(spk_vct, ln_vct, 'LineWidth', 0.5, 'Color', 'k');
                
                %% Label the raster
                
                axis tight
                xlim([0 length_this_stim])
                
                set(gca, 'ytick', []);
                set(gca, 'xtick', []);
                
                ylabel(['reps: ' num2str(reps)]);
                
                %% Calculations for plotting the instantaneous firing rate
                
                if s == 1
                    FR = zeros(length_this_stim,1);
                end
                
                nbr_spks = size(these_spks_on_chan, 2);
                
                % add a 1 to the FR vector for every spike
                for ind = 1 : nbr_spks
                    if these_spks_on_chan(ind) == 0  || these_spks_on_chan(ind) > size(FR, 1)% sometimes it might be that the spike is at 0
                        continue
                    else
                        FR(these_spks_on_chan(ind)) = FR(these_spks_on_chan(ind)) +1;
                    end
                    
                end
                
                %% Increment
                runs = runs + 1;
                i = i + unique_stims;
                
            end
            
            %% Define axes for instantaneous firing rates
            switch p
                case 1
                    axes('position',[0.05 0.02 0.45 0.09]);
                case 2
                    axes('position',[0.05 0.35 0.45 0.09]);
                case 3
                    axes('position',[0.05 0.68 0.45 0.09]);
                case 4
                    axes('position',[0.525 0.02 0.45 0.09]);
                case 5
                    axes('position',[0.525 0.35 0.45 0.09]);
                case 6
                    axes('position',[0.525 0.68 0.45 0.09]);
            end
            
            FRsmoothed = smooth(FR, winsize,'lowess') * scanrate_labview/ total_reps; % lowess works well
            timepoints = 1:size(FRsmoothed, 1);
            plot(time_scale * timepoints / scanrate_labview, FRsmoothed, 'k', 'LineWidth', 1)
            axis tight
            box off
            xlabel('Time (ms)')
            ylabel('Firing Rate [Hz]')
            
        end
        
        %% Make a title box
        title_name = [recording_session ' | Rasterplot-UniqueStims | ' song_type ' | ' analysis_type '- | CH-' chan_name];
        annotation(this_fig,'textbox',[0.29 0.97 0.470 0.03],'String',title_name,'HorizontalAlignment','center','FitBoxToText','on','LineStyle','none');
        
        %% Print to file
        figure(10+m)
        pos = [0 0 30 20];
        export_to = set_export_file_format(print_format);
        print_in_A4(print_orientation, this_rast_filename, export_to, 0, pos);
        
    end
end

disp('Finished Rasters-UniqueStims...')
end