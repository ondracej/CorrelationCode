function [] = makeRastersForMotifs_2017()


directoryDelimiter = '/';

switch gethostname
    case 'Deadpool'
        PopulationInfoFile = '/home/janie/Documents/CorrPaper2016/Data/AuditoryForebrain-Population/PopulationInfo.mat';
        metaDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/24-Oct-2016-Motifs-Coef/PairwiseOutput/meta/NewMeta/';
        mainDataDir = '/home/janie/Data/INI/Quadruplet/';
        saveDir = '/home/janie/Dropbox/INI/DataPlots/MotifRasters/';
        
    case 'turtle'
        
        PopulationInfoFile = '/home/janie/Data/INI/CorrPaper2016/Data/AuditoryForebrain-Population/PopulationInfo.mat';
        metaDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/24-Oct-2016-Motifs-Coef/PairwiseOutput/meta/NewMeta/';
        mainDataDir = '/home/janie/Data/INI/Data/Quadruplet/';
        saveDir = '/home/janie/Dropbox/INI/DataPlots/MotifRasters/';
        
        
end

if exist(saveDir, 'dir') == 0
    mkdir(saveDir);
end
%%
info = load(PopulationInfoFile);
Stats = info.SongSet_stats;
IndividualNeurons_FileNames = Stats.Individual_chans_raw_data_file_cnt;
IndividualNeurons_Channels = Stats.Individual_chans_cnt;


metaFiles = dir(fullfile(metaDir, '*.mat*'));

nMetaFiles = numel(metaFiles);
% Now we find all the date directory names
for j = 1: nMetaFiles
    namesMetaFiles{j} = metaFiles(j).name;
end

[namesMetaFilesSorted,~] = sort(namesMetaFiles);

dash = '-';
dot = '.';
for q = 1: nMetaFiles
    dashes2 = find(namesMetaFilesSorted{q} == dash);
    dots2 = find(namesMetaFilesSorted{q} == dot);
    
    if numel(dots2) > 1
        dots2 = dots2(end);
    else
        dots2 = dots2(1);
        disp('')
    end
    
    if numel(dashes2) > 4
        dashes2 = dashes2(4);
    else
        dashes2 = dashes2(end);
        disp('')
    end
    
    str2 = namesMetaFilesSorted{q}(dashes2+1:dots2-1);
    
    tagNames{q} = str2;
    
end


%% First Get Info For Individual Neurons
buffer = 20; % in ms

for oo = 73:numel(IndividualNeurons_FileNames)
    
    thisFilename = IndividualNeurons_FileNames{oo};
    thisChan = IndividualNeurons_Channels(oo);
    
    fileMatchInd = find(cell2mat(cellfun(@(x) strcmpi(x, thisFilename), tagNames, 'uniformoutput', 0)));
    
    namesMetaFilesSorted{fileMatchInd}
    
    this_metafile = [metaDir namesMetaFilesSorted{fileMatchInd}];
    this_meta = load(this_metafile);
    m = this_meta.meta;
    bird_name = m.bird_name;
    data_name = m.raw_data_filename;
    mic_channel = m.wav_chan;
    spec_scale = 2000; % for changing the intesity of the spectrogram
    if isempty(mic_channel)
        mic_channel = m.mic_chan(1);
        spec_scale = 1000; % for changing the intesity of the spectrogram
        
    end
    
    thisBirdPath = [mainDataDir bird_name directoryDelimiter];
    thisRawDataPath = [thisBirdPath 'Data' directoryDelimiter];
    thisRecordingSessionPath = [thisRawDataPath data_name];
    
    FigSaveName = [saveDir data_name '_CH-' num2str(thisChan)];
    annotationTitle = [bird_name ' | ' data_name ' | CH-' num2str(thisChan) ];
    data_file_format = m.data_file_format;
    
    if data_file_format ~= 8 % file format 8 needs to be loaded with the chronic file loader
        [data data_scanrate]= load_labview_acute(thisRecordingSessionPath, 0);
        disp('Loading raw data file..');
    else
        [data data_scanrate] = load_labview_chronic(thisRecordingSessionPath, 0);
        disp('Loading raw data file..');
    end
    
    scanrate = data_scanrate;
    buffer_sampls = floor((buffer/1000)*scanrate);
    
    figH = figure(104);clf
    
    for j = 1:2
        
        if j == 1
            %stim = 1;
            stim = 8;
            p.p1 = 1;
            p.p2 = [3 5];
            p.p3 = 7;
            %stimTitle = 'WN-Start';
            stimTitle = 'BOS Motif';
        elseif j ==2
            %stim = 12;
            stim = 6;
            p.p1 = 2;
            p.p2 = [4 6];
            p.p3 = 8;
            %stimTitle = 'WN-End' ;
            stimTitle = 'REV Motif' ;
            
        end
        
        isPresent = ismember(stim, cell2mat(m.stim_type));
        if ~isPresent
            continue
        else
            stim_start = m.stim_starts{1,stim};
            stim_stop = m.stim_stops{1,stim};
            spks = m.allSpikes{1,thisChan};
            reps = numel(stim_start);
            
            %%
            start_stim = stim_start-buffer_sampls;
            stop_stim = stim_stop+buffer_sampls;
            length_this_stim = max(stop_stim-start_stim); % includes the buffer times
            
            this_data = data(mic_channel,(stim_start(1)-buffer_sampls):(stim_stop(1)+buffer_sampls));
            subplot(4, 2, p.p1)
            specgram1(double(this_data)/spec_scale,512,scanrate,400,360);
            ylim([0 10000])
            set(gca, 'xtick', []);
            title(stimTitle)
            
            %%
            thisUniqStimFR  = zeros(1,length_this_stim); % we define a vector for integrated FR
            allSpksFR = zeros(length_this_stim,1);
            
            spk_size_y = 0.005;
            y_offset_between_repetitions = 0.001;
            
            subplot(4, 2, p.p2)
            for s = 1 : reps
                start_stim = stim_start(s)-buffer_sampls;
                stop_stim = stim_stop(s)+buffer_sampls;
                
                %must subtract start_stim to arrange spikes relative to onset
                
                these_spks_on_chan = spks(spks >= start_stim & spks <= stop_stim)-start_stim;
                
                
                y_low =  (s * spk_size_y - spk_size_y);
                y_high = (s * spk_size_y - y_offset_between_repetitions);
                
                spk_vct = repmat(these_spks_on_chan, 2, 1); % this draws a straight vertical line
                this_run_spks = size(spk_vct, 2);
                ln_vct = repmat([y_high; y_low], 1, this_run_spks); % this defines the line height
                
                line(spk_vct, ln_vct, 'LineWidth', 0.5, 'Color', 'k');
                
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
                
                
            end
            axis tight
            xlim([0 length_this_stim])
            
            set(gca, 'xtick', []);
            set(gca, 'ytick', []);
            
            winsize = round(0.010*scanrate);
            subplot(4, 2, p.p3)
            
            smoothiWin = round(scanrate*.005);% 5 ms
            
            FRsmoothed = smooth(thisUniqStimFR, smoothiWin)/reps;
            timepoints = 1:1:numel(FRsmoothed);
            timepoints_ms = timepoints/scanrate*1000;
            
            plot(timepoints_ms, FRsmoothed, 'color', 'k', 'LineWidth', 1)
            
            axis tight
            ylim([0 0.005])
            %ylim([0 1])
            xlabel('Time [ms]')
            
            %plotting_RastAllStims(OnOff_params, spks, raw_data_info, plot_filename, data, z_score_stats, print_params, song_type)
        end
        
    end
    disp('')
    annotation(figH,'textbox',...
        [0.03 0.93 0.5 0.05],...
        'String', annotationTitle,...
        'LineStyle','none',...
        'FitBoxToText','off');
    
    printThisFig(figH, FigSaveName, 4)
    
end
end


function [] = printThisFig(figH, FigSaveName, print_format )


figure(figH)

disp('Printing Plot')
set(0, 'CurrentFigure', figH)

export_to = set_export_file_format(print_format);
plotpos = [0 0 30 20];
print_in_A4(0, FigSaveName, export_to, 0, plotpos);


%%

end

