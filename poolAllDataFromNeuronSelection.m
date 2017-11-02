function [] = poolAllDataFromNeuronSelection()


fileToLoad = '/home/janie/Data/INI/Quadruplet/Analysis/5ms//NeuronSelections/PopulationStim--Pairs-80_Neurons-106.mat';

d = load(fileToLoad);


All_REPS = d.All_REPS;
BirdStats = d.BirdStats;

ComparisonData = d.ComparisonData;
Stats = d.Stats;
singleNeuronData = d.singleNeuronData;

songSet = Stats.criteria.selectedStimsNum;

nNeurons = Stats.number_of_neurons;
nPairs = Stats.number_of_pairs;



%%


ComparisonData = d.ComparisonData;
ComparisonData_All_REPS = d.All_REPS;

singleNeuronData = d.singleNeuronData;
BirdStats = d.BirdStats;
Stats = d.Stats;

number_of_neurons = Stats.number_of_neurons;
number_of_pairs = Stats.number_of_pairs;
criteria = d.Stats.criteria;

songSet =  criteria.selectedStimsNum;

%% Check that all the pairs for all the stims have info
noDataPairs = [];
for k = 1: numel(songSet)
    
    thisCompData = ComparisonData{1, songSet(k)};
    thisStim_TS_np1_n = thisCompData.TS_np1_n;
    
    noDataPairs{k} = find(thisStim_TS_np1_n == 0);
    
end
    
IndWMostEmptyData = find(cell2mat(cellfun(@(x) ~isempty(x), noDataPairs, 'uniformoutput', 0)));

noDataPairs_unique = [];
for o = 1:numel(IndWMostEmptyData)
    noDataPairs_unique = [noDataPairs_unique noDataPairs{IndWMostEmptyData(o)}];
end

    noDataPairs_unique = unique(noDataPairs_unique);
    
    disp(['No Data for chans: ' num2str(noDataPairs_unique)])
    
    
    
    
    
disp('')



end
