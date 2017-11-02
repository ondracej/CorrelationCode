function [] = plottingRawDataStimBlock(OnOff_params, raw_data_info, plot_filename, data, print_params, song_type)

dbstop if error

%% Unpack raw data information

mic_channel = raw_data_info.wav_channel(1); % here we use the wav channel, it looks nicer
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
nplots = size(chans, 2);

figure(40); clf
cnt = 0;

%% We plot the entire stimulus block
this_stim_start = stim_start(1);
this_stim_stop = stim_stop(end);

x_axis = (this_stim_start:this_stim_stop)/scanrate_labview;

%% Plotting raw voltage trace
for j = 1:nplots
    
    this_chan = chans(j);
    
    if this_chan > 6 % we only have 6 channels
        continue
    end
    
    this_data_snippet = data(this_chan, this_stim_start:this_stim_stop);
   
    % Filter the data with HP = 300 and LP = 6000 (code from spikesort)
    this_fil_data_snippet = int16(ftfil(double(this_data_snippet),scanrate_labview,300,6000)); % filter the data
    
    cnt = cnt+1;
    subplot(nplots,1,cnt)
    plot(x_axis, this_fil_data_snippet,'k')
    axis tight
    set(gca, 'ytick', [])
    axis off
    
    if j == 1
        title([recording_session ' | ' song_type ' | Full Stimulus Block']);
    else
        title(['Channel ' num2str(this_chan)]);
    end
    
end

%% Label
axis on
box off
set(gca, 'ytick', [])
xlabel('Time [s]')

%% Printing to file
figure(40)
pos = [0 0 30 20];
export_to = set_export_file_format(print_format);
print_in_A4(print_orientation, plot_filename, export_to, 0, pos);

disp('Finished plotting raw data -FullStimBlock');

end
