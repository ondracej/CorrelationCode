function [] = analysis_calc_DprimesFromMetaData()
dbstop if error

metaFileDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/13-Oct-2016-Motifs-Coef/PairwiseOutput/meta/';
newSaveDir = [metaFileDir 'NewMeta/'];
isMotif = 1;


if exist(newSaveDir, 'dir') == 0
    mkdir(newSaveDir);
    disp('Created new meta directory.')
end


metaFiles = dir([metaFileDir '*.mat']);

nMetaFiles = numel(metaFiles);

for k = 1:nMetaFiles
    
    d = load([metaFileDir metaFiles(k).name]);
    
    %d = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/03-Mar-2015-Stims-Coef/PairwiseOutput/MetaAnalysis/b20r1-MetaData-COEF-Stims-b20r1 01.mat');
    
    meta = d.meta;
    
    disp('')
    
    %song_set = find(cellfun(@(x) ~isempty(x), d.meta.stim_type));
    
    %nStimsPresent = numel(song_set);
    
    chanNumbers = d.meta.channel_numbers;
    num_neruons = d.meta.num_channels;
    
    close all;
    
    if isMotif %MOTIF
        
        for j = 1:num_neruons
            
            thisChan = chanNumbers(j);
            
            song_set_thisChanel = find(cellfun(@(x) ~isempty(x), d.meta.individual_neuron_stats(thisChan,:)));
            nStimsPresent = numel(song_set_thisChanel);
            this_d_prime = [];
            
            for u = 1: nStimsPresent % CON
                thisStim_1 = song_set_thisChanel(u);
                
                if thisStim_1 == 7
                    
                    allFRs_1 = cell2mat(d.meta.individual_neuron_stats{thisChan, thisStim_1}.allFiringRates_Stim_MOTIF{1, thisChan});
                else
                    allFRs_1 = d.meta.individual_neuron_stats{thisChan, thisStim_1}.allFiringRates_Stim_MOTIF{1, thisChan};
                end
                
                mean_this_stim_1 = nanmean(allFRs_1);
                this_std_1 = nanstd(allFRs_1);
                
                meta.MotifFR{thisChan,thisStim_1}.meanFR = mean_this_stim_1;
                meta.MotifFR{thisChan,thisStim_1}.meanStd = this_std_1;
                
                for v = 1: nStimsPresent
                    thisStim_2 = song_set_thisChanel(v);
                    
                    if thisStim_2 == 7 %CON
                        
                        allFRs_2 = cell2mat(d.meta.individual_neuron_stats{thisChan, thisStim_2}.allFiringRates_Stim_MOTIF{1, thisChan});
                    else
                        allFRs_2 = d.meta.individual_neuron_stats{thisChan, thisStim_2}.allFiringRates_Stim_MOTIF{1, thisChan};
                    end
                    
                    mean_this_stim_2 = nanmean(allFRs_2);
                    this_std_2 = nanstd(allFRs_2);
                    
                    meta.MotifFR{thisChan,thisStim_2}.meanFR = mean_this_stim_2;
                    meta.MotifFR{thisChan,thisStim_2}.meanStd = this_std_2;
                    
                    
                    this_d_prime(u,v) = roundn(2 * (mean_this_stim_1 - mean_this_stim_2) / sqrt(this_std_1^2 + this_std_2^2), -2);
                    
                end
            end
            
            meta.DPrimes{thisChan,1}.dPrimeScores = this_d_prime;
            meta.DPrimes{thisChan,1}.songset = song_set_thisChanel;
            
        end
        
    else
        
        for j = 1:num_neruons
            
            thisChan = chanNumbers(j);
            
            song_set_thisChanel = find(cellfun(@(x) ~isempty(x), d.meta.individual_neuron_stats(thisChan,:)));
            nStimsPresent = numel(song_set_thisChanel);
            this_d_prime = [];
            for u = 1: nStimsPresent
                thisStim_1 = song_set_thisChanel(u);
                
                
                mean_this_stim_1 = d.meta.individual_neuron_stats{thisChan, thisStim_1}.meanFR_Stim;
                this_std_1 = d.meta.individual_neuron_stats{thisChan, thisStim_1}.stdFR_Stim;
                
                for v = 1: nStimsPresent
                    thisStim_2 = song_set_thisChanel(v);
                    
                    mean_this_stim_2 = d.meta.individual_neuron_stats{thisChan, thisStim_2}.meanFR_Stim;
                    this_std_2 = d.meta.individual_neuron_stats{thisChan, thisStim_2}.stdFR_Stim;
                    
                    this_d_prime(u,v) = roundn(2 * (mean_this_stim_1 - mean_this_stim_2) / sqrt(this_std_1^2 + this_std_2^2), -2);
                    
                end
            end
            
            meta.DPrimes{thisChan,1}.dPrimeScores = this_d_prime;
            meta.DPrimes{thisChan,1}.songset = song_set_thisChanel;
            
        end
    end
    
    disp('')
    
    saveName = [newSaveDir metaFiles(k).name];
    
    save(saveName, 'meta', '-v7.3')
    disp(['Saved: '  saveName]);
    
end


end