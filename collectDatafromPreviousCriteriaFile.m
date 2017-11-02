function [] = collectDatafromPreviousCriteriaFile()

%dbstop if error

PopulationInfoFile = '/home/janie/Documents/CorrPaper2016/Data/AuditoryForebrain-Population/PopulationInfo.mat';

%metaDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/22-Aug-2016-Stims-Coef/PairwiseOutput/meta/NewMeta/';
metaDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/23-Aug-2016-Spont-Coef/PairwiseOutput/meta/NewMeta/';
%metaDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/13-Oct-2016-Motifs-Coef/PairwiseOutput/meta/NewMeta/';

saveStr = ['Spont'];
isMotif = 0;


saveDir = '/home/janie/Documents/CorrPaper2016/Data/AuditoryForebrain-Population/AllPooledData/';

%outliersToSkip = 'o1r4 03 - CH 3-4 ; y5y10 09 CH 3-8';

%PairwiseCompOutliers = [28 77];
%IndividualNeuronsOutliers = [30 31, 105, 106];

%% Unpack Neuron Selection

info = load(PopulationInfoFile);

Stats = info.SongSet_stats;

BirdNames = Stats.bird_name;
BirdAges = Stats.bird_age;

PairwiseComparisons_FileNames = Stats.all_raw_data_files_comparison_cnnt;
PairwiseComparisons_Channels = Stats.all_comparisons_cnnt;

IndividualNeurons_FileNames = Stats.Individual_chans_raw_data_file_cnt;
IndividualNeurons_Channels = Stats.Individual_chans_cnt;

%% Remove Outliers

%PairwiseComparisons_FileNames(PairwiseCompOutliers) = [];
%PairwiseComparisons_Channels(PairwiseCompOutliers,:) = [];

%IndividualNeurons_FileNames(IndividualNeuronsOutliers) = [];
%IndividualNeurons_Channels(IndividualNeuronsOutliers) = [];

if isMotif
    songSet = [6 7 8];
else
    songSet = Stats.song_set;
end

NeuronAreas = Stats.neuron_areas;
NeuronAreas_txt = Stats.area_text;

INFO.BirdNames = BirdNames;
INFO.BirdAges = BirdAges;
INFO.SongSet = songSet;
INFO.NeuronAreas = NeuronAreas;
INFO.NeuronAreas_txt = NeuronAreas_txt;

INFO.PairwiseComparisons_FileNames = PairwiseComparisons_FileNames;
INFO.PairwiseComparisons_Channels = PairwiseComparisons_Channels;
INFO.IndividualNeurons_FileNames = IndividualNeurons_FileNames;
INFO.IndividualNeurons_Channels = IndividualNeurons_Channels;


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

cnt = 1;

for oo = 1:numel(IndividualNeurons_FileNames)
    
    thisFilename = IndividualNeurons_FileNames{oo};
    thisChan = IndividualNeurons_Channels(oo);
    
    fileMatchInd = find(cell2mat(cellfun(@(x) strcmpi(x, thisFilename), tagNames, 'uniformoutput', 0)));
    
    namesMetaFilesSorted{fileMatchInd}
    
    this_metafile = [metaDir namesMetaFilesSorted{fileMatchInd}];
    this_meta = load(this_metafile);
    m = this_meta.meta;
    
    SongsPresent = find(cellfun(@(x) ~isempty(x), m.stim_type));
    
    if isMotif
        if sum(ismember(SongsPresent, songSet)) ~= numel(songSet)
            
            disp('We are missing a stimulus for this record')
            % songSet = SongsPresent;
        end
    end
    
    for o = 1:numel(songSet)
        song = songSet(o);
        
        if size(m.song_type, 2) < song
            
        else
            
            StimInfo{1, song}.song_type{cnt} = m.song_type{1, song};
            StimInfo{1, song}.stim_type(cnt) = m.stim_type(1, song);
            StimInfo{1, song}.unique_stims(cnt) = m.unique_stims(1, song);
            StimInfo{1, song}.reps(cnt) = m.reps(1, song);
           
            OverallNeuronStats = m.overall_neuron_stats{thisChan, song};
            
            %% Signal to noise, manipulator, AP, MP, DV Coordinates
            
            singleNeuronData{1, song}.SN_ratio_raw(cnt) = OverallNeuronStats.SN_ratio_raw;
            
            if isempty(OverallNeuronStats.SN_ratio_fil)
                singleNeuronData{1, song}.SN_ratio_fil(cnt) = nan;
            else
                singleNeuronData{1, song}.SN_ratio_fil(cnt) = OverallNeuronStats.SN_ratio_fil;
            end
            
            if isempty(OverallNeuronStats.manipulator)
                singleNeuronData{1, song}.manipulator(cnt) = nan;
            else
                singleNeuronData{1, song}.manipulator(cnt) = OverallNeuronStats.manipulator;
            end
            
            if isempty(OverallNeuronStats.ap) || isempty(OverallNeuronStats.ml) || isempty(OverallNeuronStats.dv)
                
                singleNeuronData{1, song}.ap(cnt) = nan;
                singleNeuronData{1, song}.ml(cnt) = nan;
                singleNeuronData{1, song}.dv(cnt) = nan;
                
            else
                singleNeuronData{1, song}.ap(cnt) = OverallNeuronStats.ap;
                singleNeuronData{1, song}.ml(cnt) = OverallNeuronStats.ml;
                singleNeuronData{1, song}.dv(cnt) = OverallNeuronStats.dv;
            end
            
            singleNeuronData{1, song}.putative_area_num(cnt) = OverallNeuronStats.putative_area_num;
            
            %% Scalar Values
            %% Mean Firing Rates - Full Stim
            
            SingleNeuronStats = m.individual_neuron_stats{thisChan, song};
            
            singleNeuronData{1, song}.meanFR_Stim(cnt) = SingleNeuronStats.meanFR_Stim;
            singleNeuronData{1, song}.stdFR_Stim(cnt) = SingleNeuronStats.stdFR_Stim;
            
            singleNeuronData{1, song}.meanFR_Spont(cnt) = SingleNeuronStats.meanFR_Spont;
            singleNeuronData{1, song}.stdFR_Spont(cnt) = SingleNeuronStats.stdFR_Spont;
            
            singleNeuronData{1, song}.zscore(cnt) = SingleNeuronStats.zscore;
            
            %% - Full Stim
            singleNeuronData{1, song}.allSpkCnts_Stim{cnt} = reshape(SingleNeuronStats.allSpkCnts_Stim, [1, numel(SingleNeuronStats.allSpkCnts_Stim)]);
            singleNeuronData{1, song}.allSpkCnts_Spont{cnt} = reshape(SingleNeuronStats.allSpkCnts_Spont, [1, numel(SingleNeuronStats.allSpkCnts_Spont)]);
            
            singleNeuronData{1, song}.allChans_FR_vec_Stims{cnt} = SingleNeuronStats.allChans_FR_vec_Stims;
            singleNeuronData{1, song}.allChans_FR_vec_Spont{cnt} = SingleNeuronStats.allChans_FR_vec_Spont;
            
            
            %% Full Stim or Motifs
            singleNeuronData{1, song}.allReps_mean_AutoCov{cnt} = SingleNeuronStats.allReps_mean;
            singleNeuronData{1, song}.allReps_median_AutoCov{cnt} = SingleNeuronStats.allReps_median;
            
            singleNeuronData{1, song}.RSC_SpkCnt{cnt} = reshape(SingleNeuronStats.RSC_SpkCnt , [1, numel(SingleNeuronStats.RSC_SpkCnt)]);
            
            %%
            singleNeuronData{1, song}.allBinnedSpkCnts_Stims_forXCOV{cnt} = SingleNeuronStats.allBinnedSpkCnts_Stims_forXCOV{:};
            
            if isMotif
                
                if song == 7
                    
                    singleNeuronData{1, song}.allSpkTimes_Stim_MOTIF{cnt} = SingleNeuronStats.allSpkTimes_Stim_MOTIF{1, thisChan};
                    singleNeuronData{1, song}.allSpkTimes_Stim_MOTIF{cnt} = cell2mat(SingleNeuronStats.allSpkCnts_Stim_MOTIF{1, thisChan});
                    singleNeuronData{1, song}.allFiringRates_Stim_MOTIF{cnt} = cell2mat(SingleNeuronStats.allFiringRates_Stim_MOTIF{1, thisChan});
                    singleNeuronData{1, song}.allDurations_s_Stim_MOTIF{cnt} = cell2mat(SingleNeuronStats.allDurations_s_Stim_MOTIF{1, thisChan});
                    
                else
                    
                    singleNeuronData{1, song}.allSpkTimes_Stim_MOTIF{cnt} = SingleNeuronStats.allSpkTimes_Stim_MOTIF{1, thisChan};
                    singleNeuronData{1, song}.allSpkTimes_Stim_MOTIF{cnt} = SingleNeuronStats.allSpkCnts_Stim_MOTIF{1, thisChan};
                    singleNeuronData{1, song}.allFiringRates_Stim_MOTIF{cnt} = SingleNeuronStats.allFiringRates_Stim_MOTIF{1, thisChan};
                    singleNeuronData{1, song}.allDurations_s_Stim_MOTIF{cnt} = SingleNeuronStats.allDurations_s_Stim_MOTIF{1, thisChan};
                end
                
                singleNeuronData{1, song}.meanFR_MOTIF{cnt} = m.MotifFR{thisChan, song}.meanFR;
                singleNeuronData{1, song}.stdFR_MOTIF{cnt} = m.MotifFR{thisChan, song}.meanStd;
                
            else
                
                singleNeuronData{1, song}.allSpkTimes_Stim{cnt} = SingleNeuronStats.allSpkTimes_Stim;
                singleNeuronData{1, song}.allFiringRates_Stim{cnt} = SingleNeuronStats.allFiringRates_Stim;
                stimStarts = m.stim_starts{1, song};
                stimStops = m.stim_stops{1, song};
                
                durs = (stimStops-stimStarts)/m.scanrate;
                singleNeuronData{1, song}.allDurations_s_Stim{cnt} = durs;
                
                
            end
        end
        %% D Primes
        
        singleNeuronData{1, song}.dPrimeScores{cnt} = m.DPrimes{thisChan, 1}.dPrimeScores;
        singleNeuronData{1, song}.songset{cnt} = m.DPrimes{thisChan, 1}.songset;
        
        
        WN_Ind = find(m.DPrimes{thisChan, 1}.songset ==1);
        REV_Ind = find(m.DPrimes{thisChan, 1}.songset ==6);
        CON_Ind = find(m.DPrimes{thisChan, 1}.songset ==7);
        BOS_Ind = find(m.DPrimes{thisChan, 1}.songset ==8);
        
        
        thisDPrime = m.DPrimes{thisChan, 1}.dPrimeScores;
        
        if isMotif
            if ~isempty(BOS_Ind)
                
                %D.REV_WN(cnt) = thisDPrime(REV_Ind, WN_Ind);
                D.REV_CON(cnt) = thisDPrime(REV_Ind, CON_Ind);
                D.REV_BOS(cnt) = thisDPrime(REV_Ind, BOS_Ind);
                
                %D.CON_WN(cnt) = thisDPrime(CON_Ind, WN_Ind);
                D.CON_REV(cnt) = thisDPrime(CON_Ind, REV_Ind);
                D.CON_BOS(cnt) = thisDPrime(CON_Ind, BOS_Ind);
                
                %D.BOS_WN(cnt) = thisDPrime(BOS_Ind, WN_Ind);
                D.BOS_REV(cnt) = thisDPrime(BOS_Ind, REV_Ind);
                D.BOS_CON(cnt) = thisDPrime(BOS_Ind, CON_Ind);
                
            else
                
                %D.REV_WN(cnt) = thisDPrime(REV_Ind, WN_Ind);
                D.REV_CON(cnt) = thisDPrime(REV_Ind, CON_Ind);
                %D.REV_BOS(cnt) = thisDPrime(REV_Ind, BOS_Ind);
                
                %D.CON_WN(cnt) = thisDPrime(CON_Ind, WN_Ind);
                D.CON_REV(cnt) = thisDPrime(CON_Ind, REV_Ind);
                %D.CON_BOS(cnt) = thisDPrime(CON_Ind, BOS_Ind);
                
                %D.BOS_WN(cnt) = thisDPrime(BOS_Ind, WN_Ind);
                %D.BOS_REV(cnt) = thisDPrime(BOS_Ind, REV_Ind);
                %D.BOS_CON(cnt) = thisDPrime(BOS_Ind, CON_Ind);
            end
            
            
            singleNeuronData{1, song}.DPrimeComparisons = D;
            
        else
            
            D.WN_REV(cnt) = thisDPrime(WN_Ind, REV_Ind);
            D.WN_CON(cnt) = thisDPrime(WN_Ind, CON_Ind);
            D.WN_BOS(cnt) = thisDPrime(WN_Ind, BOS_Ind);
            
            D.REV_WN(cnt) = thisDPrime(REV_Ind, WN_Ind);
            D.REV_CON(cnt) = thisDPrime(REV_Ind, CON_Ind);
            D.REV_BOS(cnt) = thisDPrime(REV_Ind, BOS_Ind);
            
            D.CON_WN(cnt) = thisDPrime(CON_Ind, WN_Ind);
            D.CON_REV(cnt) = thisDPrime(CON_Ind, REV_Ind);
            D.CON_BOS(cnt) = thisDPrime(CON_Ind, BOS_Ind);
            
            D.BOS_WN(cnt) = thisDPrime(BOS_Ind, WN_Ind);
            D.BOS_REV(cnt) = thisDPrime(BOS_Ind, REV_Ind);
            D.BOS_CON(cnt) = thisDPrime(BOS_Ind, CON_Ind);
            
            singleNeuronData{1, song}.DPrimeComparisons = D;
        end
        
        %% SpikeShapes
        
        singleNeuronData{1, songSet(1)}.allSpikeShapes{cnt} = m.allSpikeShapes{1, thisChan};
        singleNeuronData{1, songSet(1)}.scanrate(cnt) = m.scanrate;
    end
    
    cnt = cnt+1;
end

disp('')

cnnt = 1;

%%

for oo = 1:numel(PairwiseComparisons_FileNames)
    
    thisFilename = PairwiseComparisons_FileNames{oo};
    theseChans = PairwiseComparisons_Channels(oo,:);
    
    fileMatchInd = find(cell2mat(cellfun(@(x) strcmpi(x, thisFilename), tagNames, 'uniformoutput', 0)));
    
    
    this_metafile = [metaDir namesMetaFilesSorted{fileMatchInd}];
    this_meta = load(this_metafile);
    m = this_meta.meta;
    
    chan1 = theseChans(1);
    chan2 = theseChans(2);
    
    %% For Comparison Data
    for o = 1:numel(songSet)
        song = songSet(o);
        
        if size(m.RSC_comparison_stats, 2) < song
            
        else
            
            RSC_comparison_stats = m.RSC_comparison_stats{1, song};
            COV_comparison_stats = m.COV_comparison_stats{1, song};
            
            if isempty(COV_comparison_stats.TL_n{chan1,chan2})
                disp(['No TL Values for this pair: Ch1-' num2str(chan1) 'Ch2-' num2str(chan2)])
                
            else
                %% Scalar Values
                %% Spike count correlations - Whole Stims
                
                ComparisonData{1,song}.RSC_rSC(cnnt) = RSC_comparison_stats.RSC_rSC{chan1,chan2};
                ComparisonData{1,song}.RSC_pSC(cnnt) = RSC_comparison_stats.RSC_pSC{chan1,chan2};
                
                %% Ns of TLs,TSs
                
                ComparisonData{1,song}.TL_n(cnnt) =  COV_comparison_stats.TL_n{chan1,chan2};
                ComparisonData{1,song}.TL_n_max(cnnt) =  COV_comparison_stats.TL_n_max{chan1,chan2};
                
                ComparisonData{1,song}.TS_all_n(cnnt) =  COV_comparison_stats.TS_all_n{chan1,chan2};
                ComparisonData{1,song}.TS_all_max(cnnt) =  COV_comparison_stats.TS_all_max{chan1,chan2};
                
                ComparisonData{1,song}.TS_np1_n(cnnt) =  COV_comparison_stats.TS_np1_n{chan1,chan2};
                ComparisonData{1,song}.TS_np1_max(cnnt) =  COV_comparison_stats.TS_np1_max{chan1,chan2};
                
                %% Vectors
                %% TL Means and Medians
                
                ComparisonData{1,song}.TL_means(cnnt,:) = COV_comparison_stats.TL_means{chan1,chan2};
                ComparisonData{1,song}.TL_medians(cnnt,:) = COV_comparison_stats.TL_medians{chan1,chan2};
                ComparisonData{1,song}.TL_sems(cnnt,:) = COV_comparison_stats.TL_sems{chan1,chan2};
                
                ComparisonData{1,song}.TS_all_means(cnnt,:) = COV_comparison_stats.TS_all_means{chan1,chan2};
                ComparisonData{1,song}.TS_all_medians(cnnt,:) = COV_comparison_stats.TS_all_medians{chan1,chan2};
                ComparisonData{1,song}.TS_all_sems(cnnt,:) = COV_comparison_stats.TS_all_sems{chan1,chan2};
                
                ComparisonData{1,song}.TS_np1_means(cnnt,:) = COV_comparison_stats.TS_np1_means{chan1,chan2};
                ComparisonData{1,song}.TS_np1_medians(cnnt,:) = COV_comparison_stats.TS_np1_medians{chan1,chan2};
                ComparisonData{1,song}.TS_np1_sems(cnnt,:) = COV_comparison_stats.TS_np1_sems{chan1,chan2};
                
                ComparisonData{1,song}.Diff_TL_TS_np1_pairdiff_mean(cnnt,:) = COV_comparison_stats.Diff_TL_TS_np1_pairdiff_mean{chan1,chan2};
                ComparisonData{1,song}.Diff_TL_TS_np1_pairdiff_median(cnnt,:) = COV_comparison_stats.Diff_TL_TS_np1_pairdiff_median{chan1,chan2};
                ComparisonData{1,song}.Diff_TL_TS_np1_pairdiff_sem(cnnt,:) = COV_comparison_stats.Diff_TL_TS_np1_pairdiff_sem{chan1,chan2};
                
                %% All Reps
                All_REPS{1,song}.TL_reps{cnnt, 1} = COV_comparison_stats.TL_reps{chan1,chan2};
                All_REPS{1,song}.TS_all_reps{cnnt, 1} = COV_comparison_stats.TS_all_reps{chan1,chan2};
                All_REPS{1,song}.TS_np1_reps{cnnt, 1} = COV_comparison_stats.TS_np1_reps{chan1,chan2};
                All_REPS{1,song}.Diff_TL_TS_np1_pairdiff_reps{cnnt, 1} = COV_comparison_stats.Diff_TL_TS_np1_pairdiff_reps{chan1,chan2};
            end
            
            
        end
        
    end
    
    cnnt = cnnt+1;
end

disp('')


%%
number_of_pairs = numel(ComparisonData{1, 6}.RSC_rSC);
number_of_neurons = numel(singleNeuronData{1, 6}.meanFR_Stim);

disp('#############################################################################################')
disp(['Number of neurons = ' num2str(number_of_neurons) ' | Number of pairs = ' num2str(number_of_pairs)])
disp('#############################################################################################')
%%

data_name = [ saveStr '_' num2str(number_of_pairs) '_Neurons-' num2str(number_of_neurons)]; %

short_filename = [saveDir data_name '.mat'];
disp('starting to save...')
save(short_filename, 'singleNeuronData', 'ComparisonData', 'All_REPS', 'INFO', 'StimInfo', '-v7.3')
disp(['saved file: ' short_filename])


disp('')

end




