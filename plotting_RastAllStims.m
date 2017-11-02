function [] = plotting_RastAllStims(OnOff_params, spks, raw_data_info, plot_filename, data, z_score_stats, print_params, song_type)
%plotting_RastAllStims(cor_start_stop_params, spks, raw_data_info, rast_filename, data, z_score_chans, print_params)
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
%% Printing Params

print_orientation = print_params.print_orientation;
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

%% Check if directory exists, if not, create it

%% Find out which channels have spikes on them

spk_channels = cellfun(@(x) ~isempty(x), spks);
channel_numbers = find(spk_channels);
num_channels = sum(spk_channels);

total_reps = size(stim_start, 1);

%% Determine which unique stim has the longest length.We use this for the example spectrogram
for j = 1: size(stim_start, 1)
    length_stims(j) = stim_stop(j) - stim_start(j);
end

[longest_length, max_ind] = max(length_stims);
longest_length = longest_length+2*buffer_sampls;

allSpksFR = zeros(longest_length,1);

thisFig = figure(198);clf

%% Plot example spectrograms (uses the longest stim example)
this_data = data(mic_channel,(stim_start(max_ind)-buffer_sampls):(stim_stop(max_ind)+buffer_sampls));
axes('position',[0.05 0.84 0.45 0.12]);
specgram1(double(this_data)/spec_scale,512,scanrate_labview,400,360);
ylim([0 10000])
set(gca, 'xtick', []);

this_data = data(mic_channel,(stim_start(max_ind)-buffer_sampls):(stim_stop(max_ind)+buffer_sampls));
axes('position',[0.525 0.84 0.45 0.12]);
specgram1(double(this_data)/spec_scale,512,scanrate_labview,400,360);
ylim([0 10000])
set(gca, 'xtick', []);
set(gca, 'ytick', []);

%% Get list of colors to plot the repetitons

%define 20 unique colors
if OnOff_params.stim_selected == 7
    [colors, color_order] = getPlottingColors(25);
    colors = repmat(colors, [1, 4]);
    color_order = randperm(unique_stims);    
else
    [colors, color_order] = getPlottingColors(unique_stims);
end
%% Start for loop for plotting the spikes for each channel

runs = 1;

for m = 1 : num_channels
    chan = channel_numbers(m);
    
    % Check to make sure that there are spikes present
    spkThisStim = numel(spks{chan}(spks{chan} >= stim_start(1) & spks{chan} <= stim_start(end)));
    
    if  spkThisStim == 0 % no spikes present
        disp(['<<< No spikes on ch ' num2str(chan)])
        
    else
        %% We define different axes depending on how many channels there are
        
        %% Raster Axes
        if num_channels <= 4
            switch m
                case 1
                    axes('position',[0.05 0.64 0.45 0.2]);
                case 2
                    axes('position',[0.05 0.24 0.45 0.2]);
                case 3
                    axes('position',[0.525 0.64 0.45 0.2]);
                case 4
                    axes('position',[0.525 0.24 0.45 0.2]);
            end
            
        else
            
            switch m
                case 1
                    axes('position',[0.05 0.58 0.45 0.125]);%
                    
                case 2
                    axes('position',[0.05 0.35 0.45 0.125]);
                case 3
                    axes('position',[0.05 0.13 0.45 0.125]);
                    
                case 4
                    
                    axes('position',[0.525 0.58 0.45 0.125]);
                case 5
                    axes('position',[0.525 0.35 0.45 0.125]);
                    
                case 6
                    axes('position',[0.525 0.13 0.45 0.125]);
                    
            end
        end
        
        hold on;
        
        %% Plotting Raster
        allUniqueFRs = cell(1, unique_stims);
        for p = 1 : unique_stims
            i = p;
            
            for s = 1 : reps
                
                % Extract spikes within boundaries
                start_stim = stim_start(i)-buffer_sampls;
                stop_stim = stim_stop(i)+buffer_sampls;
                length_this_stim = stop_stim-start_stim; % includes the buffer times
                
                thisUniqStimFR  = zeros(length_this_stim,1); % we define a vector for integrated FR
                
                %must subtract start_stim to arrange spikes relative to onset
                these_spks_on_chan = spks{chan}(spks{chan} >= start_stim & spks{chan} <= stop_stim)-start_stim;
                
                %% Plot the raster
                
                y_low =  (runs * spk_size_y - spk_size_y);
                y_high = (runs * spk_size_y - y_offset_between_repetitions);
                
                spk_vct = repmat(these_spks_on_chan, 2, 1); % this draws a straight vertical line
                this_run_spks = size(spk_vct, 2);
                ln_vct = repmat([y_high; y_low], 1, this_run_spks); % this defines the line height
                
                line(spk_vct, ln_vct, 'LineWidth', 0.5, 'Color', colors{color_order(p)});
                
                %% Calculations for instantaneous firing rate - Unique Stims and All Stims
                nbr_spks = size(these_spks_on_chan, 2);
                
                % add a 1 to the FR vector for every spike
                for ind = 1 : nbr_spks
                    
                    if these_spks_on_chan(ind) == 0
                        continue
                    else
                        
                        thisUniqStimFR(these_spks_on_chan(ind)) = thisUniqStimFR(these_spks_on_chan(ind)) +1;
                        allSpksFR(these_spks_on_chan(ind)) = allSpksFR(these_spks_on_chan(ind)) +1;
                    end
                end
                
                %% Increment
                runs = runs + 1;
                i = i + unique_stims;
                
            end
            
            allUniqueFRs{p} = thisUniqStimFR;
            
        end
        
        %% Label the raster
        axis tight
        xlim([0 longest_length])
        set(gca, 'ytick', []);
        set(gca, 'xtick', []);
        ylab = ['N ' num2str(m), ' - Ch ', num2str(chan), ', Reps: ' num2str(total_reps)];
        ylabel(ylab);
        
         %% Integrated FR - Unique Stims Axes
         
        if num_channels <= 4
            switch m
                case 1
                    axes('position',[0.05 0.56 0.45 0.075]);
                case 2
                    axes('position',[0.05 0.16 0.45 0.075]);
                case 3
                    axes('position',[0.525 0.56 0.45 0.075]);
                case 4
                    axes('position',[0.525 0.16 0.45 0.075]);
            end
        else
            switch m
                case 1
                    axes('position',[0.05 0.525 0.45 0.05]);%
                case 2
                    axes('position',[0.05 0.29 0.45 0.05]);
                case 3
                    axes('position',[0.05 0.075 0.45 0.05]);
                case 4
                    
                    axes('position',[0.525 0.525 0.45 0.05]);
                case 5
                    
                    axes('position',[0.525 0.29 0.45 0.05]);
                case 6
                    axes('position',[0.525 0.075 0.45 0.05]);
            end
        end
        
        %% Plotting Integrated FR - Unique Stims 
        for j = 1: unique_stims
            
            thisUniqueFR = allUniqueFRs{j};
           
            FRsmoothed = smooth(thisUniqueFR, winsize,'lowess') * scanrate_labview/ total_reps;
            timepoints = 1:size(FRsmoothed, 1);
          
             hold on;
            plot(time_scale * timepoints / scanrate_labview, FRsmoothed, 'color', colors{color_order(j)}, 'LineWidth', 1)
           
        end
        
        %% Labels
        axis tight
        box off
        set(gca, 'xtick', []);
        
        %% Integrated FR - All Stims Axes
        
        if num_channels <= 4
            switch m
                case 1
                    axes('position',[0.05 0.48 0.45 0.075]);
                case 2
                    axes('position',[0.05 0.08 0.45 0.075]);
                case 3
                    axes('position',[0.525 0.48 0.45 0.075]);
                case 4
                    axes('position',[0.525 0.08 0.45 0.075]);
            end
        else
            switch m
                case 1
                    axes('position',[0.05 0.525 0.45 0.05]);%
                case 2
                    axes('position',[0.05 0.29 0.45 0.05]);
                case 3
                    axes('position',[0.05 0.075 0.45 0.05]);
                case 4
                    
                    axes('position',[0.525 0.525 0.45 0.05]);
                case 5
                    
                    axes('position',[0.525 0.29 0.45 0.05]);
                case 6
                    axes('position',[0.525 0.075 0.45 0.05]);
            end
        end
        
        
        %% Plotting Integrated FR - All Stims
        FRsmoothed = smooth(allSpksFR, winsize,'lowess') * scanrate_labview/ total_reps;
        timepoints = 1:size(FRsmoothed, 1);
        
        plot(time_scale * timepoints / scanrate_labview, FRsmoothed, 'k', 'LineWidth', 1)
          
        %% Labels
        axis tight
        box off
        xlabel('Time [ms]')
        ylabel('FR [Hz]')
        leg = ['Z-score = ' num2str(roundn(z_score_stats.z_score_cov(chan), -2))];
        legend(leg)
        legend('boxoff')
        
        %% Depending on the position of the raster, we leave off some labels
       
        if num_channels <= 4
            if m == 3 || m == 4
                ylabel('')
            end
            
            if m == 1 || m == 3
                xlabel('');
            end
            
        else
            if m == 4 || m == 5 || m == 6
                ylabel('')
            end
            
            if m == 1 || m == 2 || m == 4 || m == 5
                xlabel('');
            end
        end
        
    end
end
    
    %% Figure Title
       title_name = [recording_session ' | Rasterplot-AllStims | ' song_type ' | ' analysis_type];
    annotation(thisFig,'textbox',[0.05259 0.96 0.9227 0.02826],'String',{title_name},'HorizontalAlignment','center','FontSize',11,'FitBoxToText','off','LineStyle','none');
    
    %% Print to file
    
    figure(thisFig);
    pos = [0 0 20 23];
    export_to = set_export_file_format(print_format);
    print_in_A4(print_orientation, plot_filename, export_to, 0, pos);
    
    disp('Finished Rasters-AllStims...')
end
