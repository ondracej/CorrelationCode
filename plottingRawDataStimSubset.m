function [] = plottingRawDataStimSubset(OnOff_params, raw_data_info, plot_filename, data, spikeShapes, print_params, song_type)

dbstop if error

%% Unpack raw data information

if ~isempty(raw_data_info.wav_channel)
    mic_channel = raw_data_info.wav_channel(1); % here we use the wav channel, it looks nicer
else
    mic_channel = raw_data_info.mic_channel(1);
end

scanrate_labview = raw_data_info.scanrate_labview;
recording_session = raw_data_info.recording_session;
channel_numbers = raw_data_info.channel_numbers;

%% Unpack startstop time information

stim_start = OnOff_params.stim_start;
stim_stop = OnOff_params.stim_stop;
%song_type = OnOff_params.song_type;

%% Printing Params

print_orientation = print_params.print_orientation;
print_format = print_params.print_format;

%% plot raw data
chans = [mic_channel channel_numbers];
chanToPLot = find(chans <=6);

nplots = numel(chanToPLot);

%% We plot the the first 6 unique stims

this_stim_start = stim_start(1);
this_stim_stop = stim_stop(6);

x_axis = (this_stim_start:this_stim_stop)/scanrate_labview;

figure(41); clf
cnt = 1;

%% Plotting raw voltage trace
for j = 1:nplots
    
    this_chan = chans(j);
    
    if this_chan > 6 % we only have 6 channels
        continue
    end
    
    this_data_snippet = data(this_chan, this_stim_start:this_stim_stop);
    
    % Filter the data with HP = 300 and LP = 6000 (code from spikesort)
    this_fil_data_snippet = int16(ftfil(double(this_data_snippet),scanrate_labview,300,6000)); % filter the data
    
    subplot(nplots, 4, [cnt cnt+1 cnt+2])
    plot(x_axis, this_fil_data_snippet,'k')
    
    %% Label
    axis tight
    set(gca, 'ytick', [])
    axis off
    
    if j == 1
        title([recording_session ' | ' song_type ' | 6 Unique Stims']);
    else
        title(['Channel ' num2str(this_chan)]);
    end
    
    if j == nplots
        
        axis on
        box off
        set(gca, 'ytick', [])
        xlabel('Time [s]')
        
    end
    
    %% Spike shapes
    if this_chan > size(spikeShapes.spkforms_this_chan, 2)
        theseSpikforms = [];
    else
        
        theseSpikforms = spikeShapes.spkforms_this_chan{this_chan};
    end
    
    x_axis_spkforms = ((1:size(theseSpikforms, 1))/scanrate_labview)*1000;
    
    if ~isempty(theseSpikforms) % dont plot empty spikeforms
        subplot(nplots, 4, [cnt+3])
        plot(x_axis_spkforms, theseSpikforms(:,1:25), 'k')
    end
    
    %% Labels
    axis tight
    set(gca, 'ytick', [])
    
    if j == nplots
        xlabel('Time [ms]')
        
    end
    
    cnt = cnt+4;
end

%% Printing to file
figure(41)
pos = [0 0 30 20];
export_to = set_export_file_format(print_format);
print_in_A4(print_orientation, plot_filename, export_to, 0, pos);
print_in_A4(print_orientation, plot_filename, '-depsc', 0, pos);

disp('Finished plotting raw data -StimBlock');

end
