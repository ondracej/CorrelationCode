function [] = plotMotifJitter()

directoryDelimiter = '/';

switch gethostname
    case 'Deadpool'
        PopulationInfoFile = '/home/janie/Documents/CorrPaper2016/Data/AuditoryForebrain-Population/PopulationInfo.mat';
        metaDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/24-Oct-2016-Motifs-Coef/PairwiseOutput/meta/NewMeta/';
        mainDataDir = '/home/janie/Data/INI/Quadruplet/';
        saveDir = '/home/janie/Dropbox/INI/DataPlots/MotifJitter/';
        
    case 'turtle'
        
        PopulationInfoFile = '/home/janie/Data/INI/CorrPaper2016/Data/AuditoryForebrain-Population/PopulationInfo.mat';
        metaDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/24-Oct-2016-Motifs-Coef/PairwiseOutput/meta/NewMeta/';
        mainDataDir = '/home/janie/Data/INI/Data/Quadruplet/';
        saveDir = '/home/janie/Dropbox/INI/DataPlots/MotifJitter/';
        
        
end

if exist(saveDir, 'dir') == 0
    mkdir(saveDir);
end

%saveDir = '/home/janie/Data/INI/Quadruplet/WNRasters/';
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

currFilename = '';


%UniqueMotifSet = [1, 6, 18, 26, 28, 30, 42, 54, 69, 73, 77, 81, 88, 94];
UniqueMotifSet = [42, 54, 69, 73, 77, 81, 88, 94];

%for oo = 1:numel(IndividualNeurons_FileNames)
for oo = UniqueMotifSet
    
    thisFilename = IndividualNeurons_FileNames{oo};
    match = strcmp(thisFilename, currFilename);
    
    currFilename = thisFilename ;
    
    if match
        continue
    end
    
    
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
    
    FigSaveName = [saveDir data_name ];
    annotationTitle = [bird_name ' | ' data_name ];
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
    figH5 = figure(105); clf
    
    for j = 1:2
        if j == 1
            stim = 6;
            stimTitle = 'REV Motif';
        elseif j ==2
            stim = 8;
            stimTitle = 'BOS motif' ;
        end
        
        stim_start = m.stim_starts{1,stim};
        stim_stop = m.stim_stops{1,stim};
        reps = 30;
        
        if j == 1
            plotOffsetL = 0.05;
            %plotOffsetB = 0.01;
            plotOffsetB = 0.1;
            plotWidth = 0.45;
            plotHeight = (.90-plotOffsetB)/reps;
        elseif j == 2
            plotOffsetL = 0.51;
            plotOffsetB = 0.1;
            plotWidth = 0.45;
            plotHeight = (.90-plotOffsetB)/reps;
        end
        
        allXcorrs = [];
        for k = 1:reps
            
            this_data = data(mic_channel,(stim_start(k)-buffer_sampls):(stim_stop(k)+1*buffer_sampls));
            if reps == 1
                [pos] = [plotOffsetL plotOffsetB plotWidth plotHeight];
            else
                [pos] = [plotOffsetL plotOffsetB+plotHeight*(k-1) plotWidth plotHeight];
            end
            
            figure(figH)
            axes('position',pos);
            specgram1(double(this_data)/spec_scale,512,scanrate,400,360);
            
            axis tight
            ylim([0 8000])
            %axis off
            set(gca, 'ytick', []);
            xticks_s = get(gca, 'xtick');
            xticks_ms = xticks_s*1000;
            
            for q = 1:numel(xticks_ms);
                xlabs{q} = num2str(xticks_ms(q));
                
            end
            
            set(gca, 'xticklabels', xlabs)
            set(gca, 'XColor', [1 1 1]);
            
            if k == 1
                xlabel('Time [ms]')
                set(gca,'XMinorTick','on')
            end
            
            %% Calc Energy
            %ydata = ( smooth(roi.^2, effective) * getappdata(saH.h1200, 'energy_multiplier') );
            ydata = ( smooth(this_data.^2, 128));
            
            figure(figH5)
            axes('position',pos);
            %xdata = (1 : length(roi)) / base_rate;
            timepoints = (1:numel(ydata))/scanrate;
            plot(timepoints*1000, ydata, 'linewidth', 2, 'color', 'k')
            axis tight
            xlabel(['Time [ms]'])
            
            
            %% Calc Corrs
            %[xcorrs, lags] = xcorr(this_data, this_data, scanrate);
            [xcorrs, lags] = xcorr(ydata, ydata, scanrate);
            
            allXcorrs(k,:)  = xcorrs;
            
            
        end
        
        figure(figH)
        title(['Spectrogram | ' stimTitle])
        
        
        figure(figH5)
        title(['Energy | ' stimTitle])
    end
    
    %%
    
    disp('')
    annotation(figH,'textbox',...
        [0.03 0.93 0.5 0.05],...
        'String', annotationTitle,...
        'LineStyle','none',...
        'FitBoxToText','off');
    
    printThisFig(figH, FigSaveName, 4)
    
    
    disp('')
    annotation(figH5,'textbox',...
        [0.03 0.93 0.5 0.05],...
        'String', annotationTitle,...
        'LineStyle','none',...
        'FitBoxToText','off');
    
    printThisFig(figH5, [FigSaveName '-Energy.jpg'], 4)
    %%
    
    meansXcorr = nanmean(allXcorrs, 1);
    
    figh2 =  figure(100); clf
    plot(lags/scanrate, allXcorrs)
    hold on
    plot(lags/scanrate, meansXcorr, 'k')
    
    axis tight
    xlim([-.5 .5])
    set(gca,'XMinorTick','on')
    grid on
    grid minor
    xlabel('Time [s]')
    title([annotationTitle ' | Energy Autocorrelation'])
    
    printThisFig(figh2, [FigSaveName '_autocorr'] , 4)
    
    disp('')
end

end


function [] = printThisFig(figH, FigSaveName, print_format )


figure(figH)

disp('Printing Plot')
set(0, 'CurrentFigure', figH)

export_to = set_export_file_format(print_format);
plotpos = [0 0 40 18];
%print_in_A4(0, FigSaveName, export_to, 0, plotpos);
print_in_A4(0, FigSaveName, export_to, 3, plotpos);
% changed ewatype etc to print white axis
%http://de.mathworks.com/matlabcentral/newsreader/view_thread/30237

%%

end



