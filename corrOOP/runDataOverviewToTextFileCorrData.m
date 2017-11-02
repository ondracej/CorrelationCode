function [] = runDataOverviewToTextFileCorrData()

dbstop if error
switch gethostname
    
    case 'turtle'
        metaFileDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/22-Aug-2016-Stims-Coef/PairwiseOutput/meta/NewMeta/';
        dataSummaryDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/DataSummariesTxt/';
        
    case 'deadpool'
        
        metaFileDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/22-Aug-2016-Stims-Coef/PairwiseOutput/meta/NewMeta/';
        dataSummaryDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/DataSummariesTxt/';
end

fileName = [dataSummaryDir 'Stim.txt'];


metaFiles = dir([metaFileDir '*.mat']);

nMetaFiles = numel(metaFiles);

fileID = fopen(fileName,'w');

starFiller = '******************************************************************************';
shortFil = '______________________________________________________';
vShortFil = '--------------------------------';

for k = 1:nMetaFiles
    
    d = load([metaFileDir metaFiles(k).name]);
    
    %d = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/03-Mar-2015-Stims-Coef/PairwiseOutput/MetaAnalysis/b20r1-MetaData-COEF-Stims-b20r1 01.mat');
    
    meta = d.meta;
    
    dID = '%s\r\n';
    fprintf(fileID,dID, starFiller);
    dID = 'BirdName: %s\r\n';               % Bird Name
    fprintf(fileID,dID, meta.bird_name);
    dID = 'RawDataFile: %s\r\n';            % Raw File Name
    fprintf(fileID,dID, meta.raw_data_filename);
    dID = 'Data ID: %d\r\n';                % Data ID
    fprintf(fileID, dID, meta.data_number);
    
    
    chanNumbers = meta.channel_numbers;
    num_neruons = meta.num_channels;
    dID = '%s\r\n';
    fprintf(fileID,dID, shortFil);
    
    for j = 1:num_neruons
        
        thisChan = chanNumbers(j);
        
        song_set_thisChanel = find(cellfun(@(x) ~isempty(x), d.meta.individual_neuron_stats(thisChan,:)));
        nStimsPresent = numel(song_set_thisChanel);
        
        theseStims = [];
        for o = 1:nStimsPresent
            if o ==1
                theseStims = [meta.song_type{song_set_thisChanel(o)}];
            else
                theseStims = [theseStims '  ' meta.song_type{song_set_thisChanel(o)}];
            end
            
        end
        
        
        rawDataChan = meta.database{thisChan,song_set_thisChanel(o)}.rawDataChan;
        spikefile_index = meta.database{thisChan,song_set_thisChanel(o)}.spikefile_index;
        
        dID = 'ChannelNumber: %d; RawDataChannelNumber: %d; SpikeFileIndex: %d\r\n';
        fprintf(fileID, dID, thisChan, rawDataChan, spikefile_index); % Channel
        
        
        %dID = 'RawDataChannelNumber: %d\r\n';
        %fprintf(fileID, dID, rawDataChan); % Channel Raw Data
        
        
        %dID = 'SpikeFileIndex: %d\r\n';
        %fprintf(fileID, dID, spikefile_index); % Spike Channel Index
        
        area = meta.database{thisChan,song_set_thisChanel(o)}.putative_area;
        dID = 'BrainArea: %s\r\n';
        fprintf(fileID, dID, area); % Brain Area
        
        dID = 'StimsPresent: %s\r\n';
        fprintf(fileID, dID, theseStims); % Stims
        
        %%
        is_duplicate = meta.database{thisChan,song_set_thisChanel(o)}.is_duplicate;
        same_as_ind = meta.database{thisChan,song_set_thisChanel(o)}.same_as_ind;
        dID = 'IsDuplicate: %d; SameAsInd: %d\r\n';
        fprintf(fileID, dID, is_duplicate, same_as_ind ); % Spike Channel Index
        
        
        %dID = 'SameAsInd: %d\r\n';
        %fprintf(fileID, dID, same_as_ind); % Spike Channel Index
        
        crosstalk_from_channel = meta.database{thisChan,song_set_thisChanel(o)}.crosstalk_from_channel;
        dID = 'CrossTalkFromCh: %d\r\n';
        fprintf(fileID, dID, crosstalk_from_channel); % Spike Channel Index
        
        notes = meta.database{thisChan,song_set_thisChanel(o)}.notes;
        dID = 'notes: %s\r\n';
        fprintf(fileID, dID, notes); % Spike Channel Index
        
        
        %% Now some stats..
        
        
        match_WNS = ismember(1, song_set_thisChanel);
        match_WNE = ismember(12, song_set_thisChanel);
        
        if match_WNS && match_WNE
            
            
            WNS_AllFRs = meta.individual_neuron_stats{thisChan, 1}.allChans_FR_vec_Stims;
            WNS_mean = meta.individual_neuron_stats{thisChan, 1}.meanFR_Stim;
            
            WNE_AllFRs = meta.individual_neuron_stats{thisChan, 12}.allChans_FR_vec_Stims;
            WNE_mean = meta.individual_neuron_stats{thisChan, 12}.meanFR_Stim;
            
            [p, sigLevel_stim] = ttest(WNS_AllFRs, WNE_AllFRs);
            
            dID = 'WN-S Stim: %2.2f; WN-E Stim: %2.2f\r\n';
            fprintf(fileID, dID, WNS_mean,WNE_mean); % WN-S FR
            dID = 'WN StimSig: %2.5f; p = %d\r\n';
            fprintf(fileID, dID, sigLevel_stim, p); % % WN FR
            
            
            WNS_AllFRs_spont = meta.individual_neuron_stats{thisChan, 1}.allChans_FR_vec_Spont;
            WNS_mean_spont = meta.individual_neuron_stats{thisChan, 1}.meanFR_Spont;
            
            WNE_AllFRs_spont = meta.individual_neuron_stats{thisChan, 12}.allChans_FR_vec_Spont;
            WNE_mean_spont = meta.individual_neuron_stats{thisChan, 12}.meanFR_Spont;
            
            [pspont, sigLevel_spont] = ttest(WNS_AllFRs_spont, WNE_AllFRs_spont);
            dID = 'WN-S Spont: %2.2f; WN-E Spont %2.2f\r\n';
            fprintf(fileID, dID, WNS_mean_spont, WNE_mean_spont); % Spike Channel Index
            dID = 'WN SpontSig: %2.5f; p = %d\r\n';
            fprintf(fileID, dID, sigLevel_spont, pspont); % Spike Channel Index
            
        else
            
            
            bla = 'WN comparison not possible';
            dID = '%s\r\n';
            fprintf(fileID,dID, bla);
            
        end
        %%
        
        
        
        dID = '%s\r\n';
        fprintf(fileID,dID, vShortFil);
        
        
        
    end
    
    disp('')
end

fclose(fileID);
%% Stuff to Take from Meta Files


%data_number

% putative_area

% Channel number
%rawDataChan
%spikefile_index

% Available Stimulis

% FR comparison WN-WN

%is_duplicate
%same_as_ind

%crosstalk_from_channel
%notes

%{
x = 0:.1:1;
A = [x; exp(x)];

fileID = fopen('exp.txt','w');
fprintf(fileID,'%6s %12s\n','x','exp(x)');
fprintf(fileID,'%6.2f %12.8f\n',A);
fclose(fileID);
%}
%{
The first call to fprintf prints header text x and exp(x), and the second call prints the values from variable A.

If you plan to read the file with Microsoft® Notepad, use '\r\n' instead of '\n' to move to a new line. For example, replace the calls to fprintf with the following:

fprintf(fileID,'%6s %12s\r\n','x','exp(x)');
fprintf(fileID,'%6.2f %12.8f\r\n',A);
%}


end

