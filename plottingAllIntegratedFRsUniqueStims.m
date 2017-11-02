function [] = plottingAllIntegratedFRsUniqueStims(OnOff_params, spks, raw_data_info, plot_filename, data, print_params, song_type)
%(cor_start_stop_params, spks, raw_data_info, rast_filename, data, print_params, stim_selected_by_user)

%% Unpack raw data information

mic_channel = raw_data_info.wav_channel(1); % here we use the wav channel, it looks nicer
scanrate_labview = raw_data_info.scanrate_labview;
recording_session = raw_data_info.recording_session;
channel_numbers = raw_data_info.channel_numbers;
num_channels = raw_data_info.num_channels;

%% Unpack startstop time information

unique_stims = OnOff_params.unique_stims;
reps = OnOff_params.reps;
stim_start = OnOff_params.stim_start;
stim_stop = OnOff_params.stim_stop;
%song_type = OnOff_params.song_type;
analysis_type = OnOff_params.analysis_type;
%% Printing Params

print_orientation =  print_params.print_orientation;
print_format = print_params.print_format;

%% Spike size parameters

buffer = 1000; % in ms
buffer_sampls = (scanrate_labview*buffer)/1000;

%% Other parameters
time_scale = 1000; % put time in units of ms
winsize = 960; % For smoothing the FR, ~ 20 ms
spec_scale = 5000;

title_name = [recording_session '| Integrated FR - Unique Stims |' song_type  analysis_type];

leg_cell = cell(1, num_channels);
for n = 1: num_channels
    leg_cell{n} = ['Ch-' num2str(channel_numbers(n))];
end

total_reps = reps*unique_stims;

%% Get list of colors to plot the repetitons

[colors, ~] = getPlottingColors(unique_stims);

this_fig = figure(519); clf

%% Plot example spectrograms
switch unique_stims
    
    case 1
        subplot(2, 1, 1)
        this_data = data(mic_channel, stim_start(1)-buffer_sampls :  stim_stop(1)+buffer_sampls) ;
        specgram1(double(this_data)/spec_scale,512,scanrate_labview,400,360);
        ylim([0 8000])
        set(gca, 'xtick', []);
        set(gca, 'ytick', []);
        title(title_name)
        
    case {5 6}
        
        for j = 1: unique_stims
            this_data = data(mic_channel, stim_start(j)-buffer_sampls :  stim_stop(j)+buffer_sampls) ;
            
            switch j
                case 1
                    axes('position',[0.05 0.88 0.45 0.09]);
                case 2
                    axes('position',[0.05 0.55 0.45 0.09]);
                case 3
                    axes('position',[0.05 0.22 0.45 0.09]);
                case 4
                    axes('position',[0.525 0.88 0.45 0.09]);
                case 5
                    axes('position',[0.525 0.55 0.45 0.09]);
                case 6
                    axes('position',[0.525 0.22 0.45 0.09]);
            end
            
            specgram1(double(this_data)/spec_scale,512,scanrate_labview,400,360);
            ylim([0 8000])
            set(gca, 'xtick', []);
            set(gca, 'ytick', []);
            %title(title_name)
            
        end
        
    otherwise
        
        for j = 1: 6
            this_data = data(mic_channel, stim_start(j)-buffer_sampls :  stim_stop(j)+buffer_sampls) ;
            
            switch j
                case 1
                    axes('position',[0.05 0.88 0.45 0.09]);
                case 2
                    axes('position',[0.05 0.55 0.45 0.09]);
                case 3
                    axes('position',[0.05 0.22 0.45 0.09]);
                case 4
                    axes('position',[0.525 0.88 0.45 0.09]);
                case 5
                    axes('position',[0.525 0.55 0.45 0.09]);
                case 6
                    axes('position',[0.525 0.22 0.45 0.09]);
            end
            
            specgram1(double(this_data)/spec_scale,512,scanrate_labview,400,360);
            ylim([0 8000])
            set(gca, 'xtick', []);
            set(gca, 'ytick', []);
            %title(title_name)
            
        end
        
end


for m = 1 : num_channels
    
    chan = channel_numbers(m);
    
    spikesonChan = spks{chan}(spks{chan} >= stim_start(1) & spks{chan} <= stim_stop(end));
    
    if isempty(spikesonChan)
        
    else
        %% Start for loop for plotting the spikes for each channel
        runs = 1;
        for p = 1 : unique_stims
            
            i = p;
            
            for s = 1 : reps
                
                start_stim = stim_start(i)-buffer_sampls;
                stop_stim = stim_stop(i)+buffer_sampls;
                length_this_stim = stop_stim-start_stim;
                
                %must subtract start_stim to arrange spikes relative to onset
                these_spks_on_chan = spks{chan}(spks{chan} >= start_stim & spks{chan} <= stop_stim)-start_stim;
                
                %% Calculations for plotting the instantaneous firing rate
                
                nbr_spks = size(these_spks_on_chan, 2);
                
                if s == 1
                    FR = zeros(length_this_stim,1);
                end
                
                % add a 1 to the FR vector for every spike
                for ind = 1 : nbr_spks
                    
                    if these_spks_on_chan(ind) == 0
                        continue
                    else
                        FR(these_spks_on_chan(ind)) = FR(these_spks_on_chan(ind)) +1;
                    end
                end
                
                %% Increment
                runs = runs + 1;
                i = i + unique_stims;
                
            end
            %% Saving all the smoothed integrated firing rates in one variable
            
            if sum(FR) == 0;
                FRsmoothed{m,p} = nan(length_this_stim, 1);
            end
            
            FRsmoothed{m,p} = smooth(FR, winsize,'lowess') * scanrate_labview/ total_reps;
        end
    end
    
end



%%
switch unique_stims
    
    case 1 % WN
        subplot(2, 1, 2)
        this_uniqe_stim_FR = FRsmoothed(:, p);
        timepoints = 1:size(this_uniqe_stim_FR{1}, 1);
        hold on
        
        for f = 1: size(this_uniqe_stim_FR, 1)
            
            chan_FR = this_uniqe_stim_FR{f,1};
            plot(time_scale * timepoints / scanrate_labview, chan_FR, 'Color', colors{f}, 'LineWidth', 1)
        end
        
        axis tight
        box off
        xlabel('Time (ms)')
        ylabel('Firing Rate [Hz]')
        hold on
        legend(leg_cell)
        legend('boxoff')
        
    case {5 6} % Others
        
        for p = 1: unique_stims
            switch p
                case 1
                    axes('position',[0.05 0.78 0.45 0.09]);
                case 2
                    axes('position',[0.05 0.45 0.45 0.09]);
                case 3
                    axes('position',[0.05 0.12 0.45 0.09]);
                case 4
                    axes('position',[0.525 0.78 0.45 0.09]);
                case 5
                    axes('position',[0.525 0.45 0.45 0.09]);
                case 6
                    axes('position',[0.525 0.12 0.45 0.09]);
            end
            
            % There is some problem w the smoothing that sometimes creates a
            % negative-going artifact if there are spike right at the onet of the
            % stimulus...sucky...
            
            this_uniqe_stim_FR = FRsmoothed(:, p);
            timepoints = 1:size(this_uniqe_stim_FR{1}, 1);
            hold on
            
            for f = 1: size(this_uniqe_stim_FR, 1)
                chan_FR = this_uniqe_stim_FR{f,1};
                plot(time_scale * timepoints / scanrate_labview, chan_FR, 'Color', colors{f}, 'LineWidth', 1)
            end
            
            axis tight
            box off
            xlabel('Time (ms)')
            
            if p == 1 || p == 2 || p == 3
                ylabel('Firing Rate [Hz]')
            end
            
            hold on
            legend(leg_cell)
            legend('boxoff')
        end
        
    otherwise
        
        for p = 1: 6
            switch p
                case 1
                    axes('position',[0.05 0.78 0.45 0.09]);
                case 2
                    axes('position',[0.05 0.45 0.45 0.09]);
                case 3
                    axes('position',[0.05 0.12 0.45 0.09]);
                case 4
                    axes('position',[0.525 0.78 0.45 0.09]);
                case 5
                    axes('position',[0.525 0.45 0.45 0.09]);
                case 6
                    axes('position',[0.525 0.12 0.45 0.09]);
            end
            
            % There is some problem w the smoothing that sometimes creates a
            % negative-going artifact if there are spike right at the onet of the
            % stimulus...sucky...
            
            this_uniqe_stim_FR = FRsmoothed(:, p);
            timepoints = 1:size(this_uniqe_stim_FR{1}, 1);
            hold on
            
            for f = 1: size(this_uniqe_stim_FR, 1)
                chan_FR = this_uniqe_stim_FR{f,1};
                plot(time_scale * timepoints / scanrate_labview, chan_FR, 'Color', colors{f}, 'LineWidth', 1)
            end
            
            axis tight
            box off
            xlabel('Time (ms)')
            
            if p == 1 || p == 2 || p == 3
                ylabel('Firing Rate [Hz]')
            end
            
            hold on
            legend(leg_cell)
            legend('boxoff')
        end
        
end

%% Make a title box
this_title = [recording_session ' | Integrated FRs - UniqueStims | ' song_type ' | ' analysis_type ];
annotation(this_fig,'textbox',[0.29 0.97 0.470 0.03],'String',this_title,'HorizontalAlignment','center','FitBoxToText','on','LineStyle','none');

%% Print to file
pos = [0 0 30 20];
export_to = set_export_file_format(print_format);
print_in_A4(print_orientation, plot_filename, export_to, 0, pos);

end
