function [binSpkCnts_RSC] = extractSpikeAnalysisWindows_RSC_CON(OnOff_params, spks, raw_data_info, spikeWindow_RSC_s)

dbstop if error

%% Unpack startstop time information

unique_stims = OnOff_params.unique_stims;
reps = OnOff_params.reps;
stim_start = OnOff_params.stim_start;
stim_stop = OnOff_params.stim_stop;
scanrate_labview = raw_data_info.scanrate_labview;

channel_numbers = raw_data_info.channel_numbers;
num_channels = raw_data_info.num_channels;

%% We look at RSC Window Duration = 1.5 s

%spikeWindow_RSC_s = 1.5;
spikeWindow_RSC_samps = scanrate_labview * spikeWindow_RSC_s;

%%
if isempty(stim_start) || isempty(stim_stop)
    disp(['There are not start stop times defined for this stimulus: ' OnOff_params.song_type])
    
    RSC = [];
    
else
    
    for m = 1 : num_channels
        chan = channel_numbers(m);
        
        for p = 1 : unique_stims
            
           % i = p;
            chan_SpkTimes_RSC = [];
            chan_SpksCnts_RSC = [];
            for s = 1 : reps(p)
                
                %% Defining the start and stop times of the stimulus on/off set
                start_stim = stim_start{p}(s);
                stop_stim = stim_stop{p}(s);
                
                RSC_WinOnset = start_stim ;
                RSC_WinOfset = start_stim + spikeWindow_RSC_samps;
                
                %% 1.5 second Window
                RSC_Spks = spks{chan}(spks{chan} >= RSC_WinOnset & spks{chan} <= RSC_WinOfset)-RSC_WinOnset;
                RSC_SpkCnt = numel(RSC_Spks);
                
                chan_SpkTimes_RSC{s} = RSC_Spks;
                chan_SpksCnts_RSC(s) = RSC_SpkCnt;
                
                %% Increment
               % i = i + unique_stims;
                
            end
              chan_SpkTimes_RSC_uniqueMotifs{p} = chan_SpkTimes_RSC;
              chan_SpksCnts_RSC_uniqueMotifs{p} = chan_SpksCnts_RSC;
                
        end
        
        binSpkCnts_RSC.SpkTimes{1, chan} = chan_SpkTimes_RSC_uniqueMotifs;
        binSpkCnts_RSC.SpkCnt{1, chan} = chan_SpksCnts_RSC_uniqueMotifs;
        binSpkCnts_RSC.spikeWindow_RSC_s = spikeWindow_RSC_s;
        binSpkCnts_RSC.spikeWindow_RSC_samps = spikeWindow_RSC_samps;
        
    end
end