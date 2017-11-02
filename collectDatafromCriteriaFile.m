function [] = collectDatafromCriteriaFile(CriteriaSelection)

dbstop if error

hardcodeCriteria = 0;
stimOrSpont = 1; % 1 stim, 0, spont


switch gethostname
    case 'd-01096'
        criteriaDir = '/storage/laur/Personal/OndracekJanie/INI/Projects/Extracellular/Quadruplet/Analysis/5ms/';
        
         case 'm-01237'
        criteriaDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/';
        
    otherwise
        
        criteriaDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/';
        
end

if nargin < 1
    if hardcodeCriteria
        criteriaDir = [criteriaDir 'NeuronSelections/Population-NeuronSelection.mat'];
        d = load(criteriaDir);
        CriteriaSelection = d.CriteriaSelection;
    else
        criteriaDir = [criteriaDir '/NeuronSelections/'];
        criteriaFiles = dir(fullfile(criteriaDir, '*Selection.mat*'));
        
        if numel(criteriaFiles) > 1
            nCriteriaFilesFound = numel(criteriaFiles);
            for o = 1:nCriteriaFilesFound
                critNames{o} = criteriaFiles(o).name;
            end
            
            [Selection,ok] = listdlg('PromptString', 'Choose a file', 'SelectionMode', 'single', 'ListString', critNames);
            
            if ok
                criteriaFile = critNames{Selection};
                d = load([criteriaDir criteriaFile]);
                CriteriaSelection = d.CriteriaSelection;
            else
                disp('Canceled, loading default file')
                criteriaDir = [criteriaDir '/NeuronSelections/Population-NeuronSelection.mat'];
                d = load(criteriaDir);
                CriteriaSelection = d.CriteriaSelection;
            end
        end
    end
    
end

%% Unpack Neuron Selection

mainDataDir = CriteriaSelection.mainDataDir;
saveStr = CriteriaSelection.saveStr;
criteriaMetaNames = CriteriaSelection.names_stimMeta;
Final_available_channels = CriteriaSelection.Final_available_channels;
criteria = CriteriaSelection.criteria;
duplicateINFO = CriteriaSelection.allDuplicateINFO;

neuronSelectionDir = [mainDataDir '/NeuronSelections/'];
if exist(neuronSelectionDir, 'dir') == 0
    mkdir(neuronSelectionDir);
end


[metaDir, names_metaSorted, n_meta]  = findSpontandStimMetaDirs(mainDataDir, stimOrSpont);

songSet = criteria.selectedStimsNum;

%%
cnnt = 1;
cnt = 1;
cnnnt = 1;

metaWithData = sum(cell2mat(cellfun(@(x) ~isempty(x), Final_available_channels, 'uniformoutput', 0)));

for s = 1: n_meta
    
    chansForMetaFile = Final_available_channels{s};
    
    
    if ~isempty(chansForMetaFile)
        
        disp([num2str(cnnnt) ' / ' num2str(metaWithData)])
       
        this_metafile = [metaDir names_metaSorted{s}];
        this_meta = load(this_metafile);
        m = this_meta.meta;
        
        %% IndividualStats
        for j = 1:numel(chansForMetaFile)
            thisChan = chansForMetaFile(j);
            
            for o = 1:numel(songSet)
                song = songSet(o);
                
                SingleNeuronStats = m.individual_neuron_stats{thisChan, song};
                OverallNeuronStats = m.overall_neuron_stats{thisChan, song};
                
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
                %% Mean Firing Rates
                
                singleNeuronData{1, song}.meanFR_Stim(cnt) = SingleNeuronStats.meanFR_Stim;
                singleNeuronData{1, song}.stdFR_Stim(cnt) = SingleNeuronStats.stdFR_Stim;
                
                singleNeuronData{1, song}.meanFR_Spont(cnt) = SingleNeuronStats.meanFR_Spont;
                singleNeuronData{1, song}.stdFR_Spont(cnt) = SingleNeuronStats.stdFR_Spont;
                
                singleNeuronData{1, song}.zscore(cnt) = SingleNeuronStats.zscore;
                
                %%
                singleNeuronData{1, song}.allSpkCnts_Stim{cnt} = reshape(SingleNeuronStats.allSpkCnts_Stim, [1, numel(SingleNeuronStats.allSpkCnts_Stim)]);
                singleNeuronData{1, song}.allSpkCnts_Spont{cnt} = reshape(SingleNeuronStats.allSpkCnts_Spont, [1, numel(SingleNeuronStats.allSpkCnts_Spont)]);
                
                singleNeuronData{1, song}.allChans_FR_vec_Stims{cnt} = SingleNeuronStats.allChans_FR_vec_Stims;
                singleNeuronData{1, song}.allChans_FR_vec_Spont{cnt} = SingleNeuronStats.allChans_FR_vec_Spont;
                
                singleNeuronData{1, song}.allReps_mean_AutoCov{cnt} = SingleNeuronStats.allReps_mean;
                singleNeuronData{1, song}.allReps_median_AutoCov{cnt} = SingleNeuronStats.allReps_median;
                
                singleNeuronData{1, song}.RSC_SpkCnt{cnt} = reshape(SingleNeuronStats.RSC_SpkCnt , [1, numel(SingleNeuronStats.RSC_SpkCnt)]);
                
                %% D Primes
                
                singleNeuronData{1, song}.dPrimeScores{cnt} = m.DPrimes{thisChan, 1}.dPrimeScores;
                singleNeuronData{1, song}.songset{cnt} = m.DPrimes{thisChan, 1}.songset;
                
                %% SpikeShapes
                singleNeuronData{1}.allSpikeShapes{cnt} = m.allSpikeShapes{1, thisChan};
                
            end
            
            cnt = cnt+1;
        end
        
        
        for j = 1:numel(chansForMetaFile)
            chan1 = chansForMetaFile(j);
            
            for k = 1:numel(chansForMetaFile)
                if j >= k
                    continue
                end
                
                chan2 = chansForMetaFile(k);
                
                %% For Comparison Data
                for o = 1:numel(songSet)
                    song = songSet(o);
                    
                    RSC_comparison_stats = m.RSC_comparison_stats{1, song};
                    COV_comparison_stats = m.COV_comparison_stats{1, song};
                    
                    if isempty(COV_comparison_stats.TL_n{chan1,chan2})
                        disp(['No TL Values for this pair: ' num2str(s) 'Ch1-' num2str(chan1) 'Ch2-' num2str(chan2)])
                        
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
                cnnt = cnnt+1;
            end
        end
        
        %% Final Stats
        
        BirdStats.bird_name{cnnnt} = m.bird_name;
        BirdStats.bird_age{cnnnt} = m.bird_age;
        BirdStats.BIN_size_ms(cnnnt) = m.BIN_size_ms;
        cnnnt = cnnnt+1;
        
        
    end
    
end

%%
number_of_pairs = numel(ComparisonData{1, 1}.RSC_rSC);
number_of_neurons = numel(singleNeuronData{1, 1}.meanFR_Stim);
Stats.number_of_neurons = number_of_neurons;
Stats.number_of_pairs = number_of_pairs;
Stats.criteria = criteria;

disp('#############################################################################################')
disp(['Number of neurons = ' num2str(number_of_neurons) ' | Number of pairs = ' num2str(number_of_pairs)])
disp('#############################################################################################')
%%

data_name = [ saveStr 'Stim--Pairs-' num2str(number_of_pairs) '_Neurons-' num2str(number_of_neurons)]; %

short_filename = [neuronSelectionDir data_name '.mat'];
disp('starting to save...')
save(short_filename, 'singleNeuronData', 'ComparisonData', 'All_REPS', 'BirdStats', 'Stats', '-v7.3')
disp(['saved file: ' short_filename])


disp('')

end






function [metaDir, names_metaSorted, n_meta]  = findSpontandStimMetaDirs(mainDataDir, runForStimFiles)
dirD = '/';

if runForStimFiles
    
    stimDirSearch = dir(fullfile(mainDataDir, '*Stims*'));
    stimDir =  [mainDataDir stimDirSearch.name dirD];
    stimMetaDir = [stimDir '/PairwiseOutput/meta/NewMeta/']; % we calculate d prime scores, hence the 'newmeta' dir
    stimMetaFiles = dir(fullfile(stimMetaDir, '*.mat*'));
    
    n_stimMeta = numel(stimMetaFiles);
    % Now we find all the date directory names
    for j = 1: n_stimMeta
        names_stimMeta{j} = stimMetaFiles(j).name;
    end
    
    [names_stimMetaSorted,~] = sort(names_stimMeta);
    
    metaDir = stimMetaDir;
    names_metaSorted = names_stimMetaSorted;
    n_meta = n_stimMeta;
    
    
else
    
    spontDirSearch = dir(fullfile(mainDataDir, '*Spont*'));
    spontDir =  [mainDataDir spontDirSearch.name dirD];
    
    %% Find n meta files in each dir
    
    spontMetaDir = [spontDir 'PairwiseOutput/meta/']; % no dprime scores calculated, all data in 'meta'
    spontMetaFiles = dir(fullfile(spontMetaDir, '*.mat*'));
   
    n_spontMeta = numel(spontMetaFiles);
    
    % Now we find all the date directory names
    for j = 1: n_spontMeta
        names_spontMeta{j} = spontMetaFiles(j).name;
    end
    
    [names_spontMetaSorted,~] = sort(names_spontMeta);
    n_stimMeta = numel(names_spontMetaSorted);
    
    metaDir = spontMetaDir;
    names_metaSorted = names_spontMetaSorted;
    n_meta = n_spontMeta;
    
end
end