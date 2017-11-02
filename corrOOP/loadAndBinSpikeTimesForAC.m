function [] = loadAndBinSpikeTimesForAC()

 
dbstop if error

CritMet = 1; % 1, criteria met, 2 = criteria not met


dbstop if error
switch gethostname
    
    case 'turtle'

        if CritMet == 1    
            fileToLoad = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim/SpontStimAllCriteriaMet.mat';
            plotDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim/Plots/';
            AC_Dir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim/SpontStimCriteriaAnalysis_AC/';
            
        elseif CritMet == 2
           
        end
        
        
    case 'deadpool'
        
        if CritMet == 1    
            fileToLoad = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpont/SpontAllCriteriaMet.mat';
            plotDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpont/Plots/';
            AC_Dir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpont/SpontCriteriaAnalysis_AC/';
            
        elseif CritMet == 2
            fileToLoad = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpont/SpontAllCriteriaNOTMet.mat';
            plotDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpont/Plots-CritNotMet/';
            AC_Dir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpont/SpontCriteriaAnalysis_AC-CritNotMet/';
        end
end



if exist(plotDir, 'dir') == 0
    mkdir(plotDir);
end

if exist(AC_Dir, 'dir') == 0
    mkdir(AC_Dir);
end

d = load(fileToLoad);

if CritMet == 1
    AllCriteriaMet = d.AllCriteriaMet_Final;
    nFiles = size(AllCriteriaMet, 2);
elseif CritMet == 2
    AllCriteriaNotMet = d.AllCriteriaNOTMet_Final;
    nFiles = size(AllCriteriaNotMet, 2);
end

for j = 1: nFiles
    
    
    thisData = AllCriteriaMet(j);
    
    StimOnsets = thisData.allSortedStimOnsets;
    StimOffsets = thisData.allSortedStimOffsets;
    StimLengths = thisData.allSortedStimLengths;
    
    SpontOnsets = thisData.allSortedStimOnsets_spont;
    SpontOffsets = thisData.allSortedStimOffsets_spont;
    SpontLengths = thisData.allSortedStimLengths_spont;
    
    scanrate = thisData.scanrate;
    smoothWin_ms = 1;
    smoothWin_samps = round(scanrate/1000*smoothWin_ms);
    w = gausswin(smoothWin_samps);
    
    songSet = find(cellfun(@(x) ~isempty(x), SpontOnsets));
    
    nNeurons = numel(thisData.sigLevel_spont);
    
    for k = 1:nNeurons
        
        spks = thisData.allSpikes{1,k}{:};
        nStims = numel(songSet);
        
        thisNeuron = thisData.rawDataChan(k);
        thisrawDataFile = thisData.raw_data_filename;
        
        for o = 1:nStims
            
            theseOnsets = round(SpontOnsets{songSet(o)});
            theseOffsets = round(SpontOffsets{songSet(o)});
            
            reshapedOnsets = reshape(theseOnsets, 1, numel(theseOnsets));
            reshapedOffsets = reshape(theseOffsets, 1, numel(theseOffsets));
            
            nReps = numel(reshapedOnsets);
            
            length_samp = ceil(max(reshapedOffsets - reshapedOnsets));
            length_s = length_samp/scanrate;
            
            allSpikesInt = []; allNSpks = []; allGausSmooth = []; ACovs = [];
            
            for p =1:nReps
                
                these_spks_on_chan = spks(spks >= reshapedOnsets(p) & spks <= reshapedOffsets(p))-reshapedOnsets(p);
                nSpks = numel(these_spks_on_chan);
                intFR  = zeros(1,length_samp); % we define a vector for integrated FR
                
                % add a 1 to the FR vector for every spike
                for ind = 1 : nSpks
                    if these_spks_on_chan(ind) ~= 0
                        intFR(these_spks_on_chan(ind)) = intFR(these_spks_on_chan(ind)) +1;
                    end
                end
                
                allNSpks(p) = nSpks;
                allSpikesInt(p,:) = intFR;
                allGausSmooth(p,:) = filter(w, 1, intFR);
                [acov, lags] = xcov(allGausSmooth(p,:), 'coeff');
                
                ACovs(p,:) = acov;
                
            end
            
            allSpikesCnts(k) = thisNeuron;
            allSpikesCnts{k} = thisrawDataFile;
            
            allSpikesCnts{k, songSet(o)} = allNSpks;
            allSpikes{k, songSet(o)} = allSpikesInt;
            allGaussSmooth{k, songSet(o)} = allGausSmooth;
            allACovs{k, songSet(o)} = ACovs;
            
            disp('')
            
        end
    end
    
    %%
    semAutocov = []; meanAutocov = []; lags_ms = [];
    for k = 1:nNeurons
        
        allAutoCovs = [];
        thisAutocov = allACovs(k,:);
        
        for o = 1:nStims
            allAutoCovs = [allAutoCovs; thisAutocov{songSet(o)}];
        end
        
        all_AutoCovs{k} = allAutoCovs;
        meanAutocov(k,:) = nanmean(allAutoCovs);
        
        nansum = sum(isnan(sum(allAutoCovs, 2)));
        
        stdAutocov = nanstd(allAutoCovs, 1);
        semAutocov(k,:) = stdAutocov / sqrt(size(allAutoCovs, 1)-nansum);
        
        lags_ms(k,:) = lags/scanrate*1000;
        
        %%
        figH = figure(100); clf
        plot(lags_ms, meanAutocov(k,:), 'k', 'linewidth', 1);
        hold on
        plot(lags_ms, meanAutocov(k,:)+semAutocov(k,:), 'r');
        hold on
        plot(lags_ms, meanAutocov(k,:)-semAutocov(k,:), 'r');
        axis tight
        xlim([-25 25]); ylim([-.2 1])
        title([thisData.raw_data_filename '| AC | N-' num2str(thisData.rawDataChan{k})])
        %%
        figure(figH)
        plot_filename = [plotDir thisData.raw_data_filename '_AC_N-' num2str(thisData.rawDataChan{k})];
        plotpos = [0 0 10 12];
        print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
        
    end
    
    
    %CritData.thisData = thisData;
    
    
    
    INFO.StimOnsets = StimOnsets;
    INFO.StimOffsets = StimOffsets;
    INFO.StimLengths = StimLengths;
    
    INFO.SpontOnsets = SpontOnsets;
    INFO.SpontOffsets = SpontOffsets;
    INFO.SpontLengths = SpontLengths;
    
    INFO.scanrate = scanrate;
    INFO.smoothWin_ms = smoothWin_ms;
    INFO.smoothWin_samps = smoothWin_samps;
    INFO.GausWin = w;
    
    INFO.songSet = songSet;
    INFO.nNeurons = nNeurons;
    
    AC.allSpikesCnts = allSpikesCnts;
    AC.allSpikes = allSpikes;
    AC.allGaussSmooth = allGaussSmooth;
    AC.allACovs = allACovs;
    AC.all_AutoCovs = all_AutoCovs;
    AC.meanAutocov = meanAutocov;
    AC.semAutocov = semAutocov;
    AC.lags_ms = lags_ms;
         
    textnum = sprintf('%02d', j);
    saveDir = [AC_Dir 'ACFile-' textnum];
    save(saveDir, 'CritData', 'INFO', 'AC', '-v7.3')
    
    clear('CritData', 'INFO', 'AC', 'thisData');
    
end

end

