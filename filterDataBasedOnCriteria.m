function [] = filterDataBasedOnCriteria(criteria)

runForStimFiles = 1;
hardcodeCriteria = 0;

dbstop if error

if nargin < 1
    if hardcodeCriteria
        criteriaDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/Criteria.mat';
        d = load(criteriaDir);
        criteria = d.criteria;
    else
        criteriaDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/';
        criteriaFiles = dir(fullfile(criteriaDir, '*Criteria.mat*'));
        
        if criteriaFiles > 1
            nCriteriaFilesFound = numel(criteriaFiles);
            for o = 1:nCriteriaFilesFound
                critNames{o} = criteriaFiles(o).name;
            end
            
            [Selection,ok] = listdlg('PromptString', 'Choose a file', 'SelectionMode', 'single', 'ListString', critNames);
            
            if ok
                criteriaDir = critNames{Selection};
                d = load(criteriaDir);
                criteria = d.criteria;
            else
                disp('Canceled, loading default file')
                criteriaDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/Criteria.mat';
                d = load(criteriaDir);
                criteria = d.criteria;
            end
        end
    end
end

%% Unpack Criteria

% Outliers/duplicates
removeOutliers = criteria.removeOutliers;
removeDuplicates = criteria.removeDuplicates;

% Area
sortArea = criteria.sortArea;
selectedAreas = criteria.selectedAreas;
nSelectedAreas = criteria.nSelectedAreas;
AreasSelectedNum = criteria.AreasSelectedNum;

% WN comparison
CompareWN = criteria.CompareWN;
sigLevel = criteria.sigLevel;
WNSel = criteria.WNSel;
WNSel_test = criteria.WNSel_test;

% Stim Set
defStimSet = criteria.defStimSet;
selectedStims = criteria.selectedStims;
nSelectedStims = criteria.nSelectedStims;
selectedStimsNum = criteria.selectedStimsNum;

% D prime
DPrimeRange = criteria.DPrimeRange;
dPrimeStim = criteria.dPrimeStim;
dprimeVal = criteria.dprimeVal;

% DataCutoff
dataCutoff = criteria.dataCutoff;
dataCutoffValue = criteria.dataCutoffValue;

% Data dir
mainDataDir = criteria.mainDataDir;

%% Define Spont and Stim directories

mainDataDir = criteria.mainDataDir;

[~, stimDir, names_stimMeta, ~, num_meta_files]  = findSpontandStimMetaDirs(mainDataDir, runForStimFiles);


%% Load all Meta

meta = cell(num_meta_files, 1);
disp('Loading meta data...')
tic 
for s = 1: num_meta_files
    
    
    this_metafile = [stimDir names_stimMeta{s}];
    this_meta = load(this_metafile);
    meta{s} = this_meta.meta;
    
    disp(['File: ' names_stimMeta{s}])
    
    potentialChanIDs_orig{s} =  meta{s, 1}.totalChanNumber;
    nChansOverMeta_orig(s) = numel(potentialChanIDs_orig{s});
    
end
toc

%%

nChansTotal = sum(nChansOverMeta_orig);

%% Sorting for stimulus filter


disp('Sorting meta files for stim selection...')
for s = 1: num_meta_files
    
    if defStimSet % Stimulus filter selected
        
        nPotentialChans = nChansOverMeta_orig(s);
        potentialChans = [];
        
        for j = 1: nPotentialChans
            
            thisChan = meta{s, 1}.totalChanNumber(j);
            thisChanStimSetcell = meta{s, 1}.individual_neuron_stats(thisChan,:); %cell array of stims w data
            thisChanStimSet = find(cell2mat(cellfun(@(x) ~isempty(x), thisChanStimSetcell, 'uniformoutput', 0)));
            allStimsPresent = ismember(selectedStimsNum, thisChanStimSet);
            
            if sum(allStimsPresent) == nSelectedStims
                potentialChans =  [potentialChans thisChan];
            end
        end
        
        disp(['File: ' names_stimMeta{s} ' | ' num2str(numel(potentialChans)) ' chans'])
        nChansOverMeta(s) = numel(potentialChans); % update the correct nChansOverMeta
        potentialChanIDs{s} = potentialChans; % update the potentialChanIDs
        
    else % No stimulus filter selected
        potentialChanIDs{s} =  potentialChanIDs_orig{s};
        nChansOverMeta(s) = nChansOverMeta_orig(s);
    end
    
end

nChansAfterFilter = sum(cell2mat(cellfun(@(x) numel(x), potentialChanIDs, 'uniformoutput', 0)));

if defStimSet
    disp('************************************')
    disp([ 'Stimulus set filter | ' num2str(nChansAfterFilter) '/' num2str(nChansTotal) ' neurons meet criteria'])
    disp('************************************')
end


%% Sort by neuron area

for s = 1: num_meta_files
    
    if sortArea
        
        nPotentialChans = nChansOverMeta(s);
        thesePotentialChanIDs = potentialChanIDs{s};
        
        potentialChans = [];
        
        for j = 1: nPotentialChans
            thisChan = thesePotentialChanIDs(j);
            
            try
                thisArea = meta{s,1}.overall_neuron_stats{thisChan,1}.putative_area_num; % check WN-S stim
            catch
                thisArea = meta{s,1}.overall_neuron_stats{thisChan,6}.putative_area_num; % if it doesnt exist, check BOS stim
            end
            
            correctArea = ismember(thisArea, AreasSelectedNum);
            
            if correctArea == 1
                potentialChans =  [potentialChans thisChan];
            end
        end
        
        disp(['File: ' names_stimMeta{s} ' | ' num2str(numel(potentialChans)) ' chans'])
        nChansOverMeta(s) = numel(potentialChans); % update the correct nChansOverMeta
        potentialChanIDs{s} = potentialChans; % update the potentialChanIDs
        
    else % No stimulus filter selected
        potentialChanIDs{s} =  potentialChanIDs{s};
        nChansOverMeta(s) = nChansOverMeta(s);
        
    end
end


nChansAfterFilter = sum(cell2mat(cellfun(@(x) numel(x), potentialChanIDs, 'uniformoutput', 0)));

if sortArea
    disp('************************************')
    disp([ 'Area filter | ' num2str(nChansAfterFilter) '/' num2str(nChansTotal) ' neurons meet criteria'])
    disp('************************************')
end

%% WN Search Criteria


for s = 1: num_meta_files
    
    if CompareWN
        
        nPotentialChans = nChansOverMeta(s);
        thesePotentialChanIDs = potentialChanIDs{s};
        
        potentialChans = [];
        WNSet = [1 12];
        
        for j = 1: nPotentialChans
            thisChan = thesePotentialChanIDs(j);
            
            thisChanStimSetcell = meta{s, 1}.individual_neuron_stats(thisChan,:); %cell array of stims w data
            thisChanStimSet = find(cell2mat(cellfun(@(x) ~isempty(x), thisChanStimSetcell, 'uniformoutput', 0)));
            allStimsPresent = ismember(thisChanStimSet, WNSet);
            
            if sum(allStimsPresent) == 2
                
                % Stim FR
                WN_BOF_FR_Stim = meta{s, 1}.individual_neuron_stats{thisChan,1}.allChans_FR_vec_Stims;
                WN_EOF_FR_Stim = meta{s, 1}.individual_neuron_stats{thisChan,12}.allChans_FR_vec_Stims;
                
                % Spont FR
                WN_BOF_FR_Spont = meta{s, 1}.individual_neuron_stats{thisChan,1}.allChans_FR_vec_Spont;
                WN_EOF_FR_Spont = meta{s, 1}.individual_neuron_stats{thisChan,12}.allChans_FR_vec_Spont;
                
                %Means
                WN_BOF_meanFRs = meta{s, 1}.individual_neuron_stats{thisChan,1}.meanFR_Stim;
                WN_EOF_meanFRs = meta{s, 1}.individual_neuron_stats{thisChan,12}.meanFR_Stim;
                
                % Select whether to use Spont or Stim evoked WN responses
                if WNSel ==1
                    WN_BOF_FR = WN_BOF_FR_Stim;
                    WN_EOF_FR = WN_EOF_FR_Stim;
                    
                elseif WNSel ==2
                    WN_BOF_FR = WN_BOF_FR_Spont;
                    WN_EOF_FR = WN_EOF_FR_Spont;
                end
                
                % Select which test to use
                switch WNSel_test
                    case 1
                        [h,p] = ttest(WN_BOF_FR, WN_EOF_FR);
                        
                    case 2
                        [p, h] = ranksum(WN_BOF_FR, WN_EOF_FR);
                        
                    case 3
                        [p, h] = signrank(WN_BOF_FR, WN_EOF_FR);%when h = 0; the FR are not sig different
                        
                end
                
                disp(['File: ' names_stimMeta{s} ' | ' num2str(numel(potentialChans)) ' chans'])
                
                if p >= sigLevel
                    potentialChans = [potentialChans thisChan];
                    disp(['~~~~~~~~WN Means are NOT diferent: WN-BOF = ' num2str(WN_BOF_meanFRs) ' | WN-EOF = ' num2str( WN_EOF_meanFRs)]);
                    
                else
                    disp(['          WN Means are diferent: WN-BOF = ' num2str(WN_BOF_meanFRs) ' | WN-EOF = ' num2str( WN_EOF_meanFRs)]);
                    
                end
                
            else
                disp('You have not selected WN as a stimulus')
                keyboard
            end
        end
        
        
        nChansOverMeta(s) = numel(potentialChans); % update the correct nChansOverMeta
        potentialChanIDs{s} = potentialChans; % update the potentialChanIDs
        
    else % No stimulus filter selected
        potentialChanIDs{s} =  potentialChanIDs{s};
        nChansOverMeta(s) = nChansOverMeta(s);
        
    end
    
end

nChansAfterFilter = sum(cell2mat(cellfun(@(x) numel(x), potentialChanIDs, 'uniformoutput', 0)));

if CompareWN
    disp('************************************')
    disp([ 'WN filter | ' num2str(nChansAfterFilter) '/' num2str(nChansTotal) ' neurons meet criteria'])
    disp('************************************')
end

%% Only keep channels that have at least a pair:


for s = 1: num_meta_files
    
    if numel(potentialChanIDs{s}) >=2
        potentialChanIDs{s} = potentialChanIDs{s};
        nChansOverMeta(s) = numel(potentialChanIDs{s});
    else
        potentialChanIDs{s} = [];
        nChansOverMeta(s) = numel(potentialChanIDs{s});
    end
    
end

nChansAfterFilter = sum(cell2mat(cellfun(@(x) numel(x), potentialChanIDs, 'uniformoutput', 0)));

if CompareWN
    disp('************************************')
    disp([ 'Pairs | ' num2str(nChansAfterFilter) '/' num2str(nChansTotal) ' neurons meet criteria'])
    disp('************************************')
end


%% Determine which neurons might be duplicated on other recordings

for s = 1: num_meta_files
    
    if removeDuplicates
        
        thesePotentialChanIDs = potentialChanIDs{s};
        
        
        nPotentialChans = nChansOverMeta(s);
        
        duplicateChan = [];
        for j = 1: nPotentialChans
            thisChan = thesePotentialChanIDs(j);
            
            thisChanStimSetcell = meta{s, 1}.individual_neuron_stats(thisChan,:); %cell array of stims w data
            thisChanStimSet = find(cell2mat(cellfun(@(x) ~isempty(x), thisChanStimSetcell, 'uniformoutput', 0)));
            
            thisChan_IsDuplicate = meta{s, 1}.database{thisChan,thisChanStimSet(1)}.is_duplicate;
            
            if thisChan_IsDuplicate
                
                duplicateChan = [duplicateChan  thisChan];
                
                
                
                %else
                
                % potentialChans = [potentialChans thisChan];
                
            end
            
        end
        
        %         if ~isempty(duplicateChan)
        %             if numel(duplicateChan) == nPotentialChans
        %                 potentialChans = [];
        %             else
        %
        %                 potentialChans = [potentialChans duplicateChan]; % hae to think about how to do this with pairs;,  g18r202
        %
        %             end
        %
        %         end
        %
        %   disp(['File: ' names_stimMeta{s} ' | ' num2str(numel(potentialChans)) ' chans'])
        %  nChansOverMeta(s) = numel(potentialChans); % update the correct nChansOverMeta
        nPotentialDuplicateChans(s) = numel(duplicateChan); % update the potentialChanIDs
        potentialDuplicateChans{s} = duplicateChan;
        
    else % No stimulus filter selected
        nPotentialDuplicateChans(s) = 0; % update the potentialChanIDs
        potentialDuplicateChans{s} = [];
        
    end
    
    
end

%%


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Start combining all of the data:



%%

disp('')


cnnt = 1;
stimSet = [];
singleNeuronData = [];

for s = 1: num_meta_files
    
    thesePotentialChanIDs = potentialChanIDs{s};
    thesePotentialDuplicateChanIDs = potentialDuplicateChans{s};
    nChans = numel(thesePotentialChanIDs);
    
    %% First check the duplicate channel situation
    
    if ~isempty(thesePotentialDuplicateChanIDs)
        validChans = [];
        
        for q = 1: numel(thesePotentialDuplicateChanIDs)
            thisChan = thesePotentialDuplicateChanIDs(q);
            
            thisChan_thisDataInd = meta{s, 1}.data_number; % data ind for this data set
            thisChan_duplicatedInd = meta{s, 1}.database{thisChan,thisChanStimSet(1)}.same_as_ind; % data ind for the dulicate chans
            
            indDiff = thisChan_duplicatedInd - thisChan_thisDataInd; % diff between the current data ind and the duplciate ind
            
            
            if indDiff < 0 % if this is negative, than the previous file was the first instance of this data duplication (which we keep)
                
                
                indChanMatch  = ismember(thisChan, potentialChanIDs{s+indDiff(1)}); % is this channel actually present on both recordings
                
                if indChanMatch == 1
                    
                    disp([names_stimMeta{s} ': ch- ' num2str(thisChan) ' is duplicated'])
                    % Do nout count it as a valid channel
                    
                else % when its a 0
                    validChans = [validChans thisChan];
                end
                
            else % if indDiff is greater than zero
                validChans = [validChans thisChan];
                
            end
        end
        
        nValidChans = numel(validChans);
    else
        
        validChans = thesePotentialChanIDs;
        nValidChans = numel(validChans);
    end
    
    allValidSingleChans{s} = validChans;
    
    %%
    for o = 1:nValidChans
        
        for k = 1:nSelectedStims
            
            selectedStim = selectedStimsNum(k);
            
            %stimSet{k} = selectedStims{k};
            
            
            thisChan = validChans(o);
            
            singleNeuronData{1, selectedStim}.meanFR_Stim(cnnt) = meta{s, 1}.individual_neuron_stats{thisChan, selectedStim}.meanFR_Stim;
            singleNeuronData{1, selectedStim}.meanFR_Spont(cnnt) = meta{s, 1}.individual_neuron_stats{thisChan, selectedStim}.meanFR_Spont;
            
            singleNeuronData{1, selectedStim}.stdFR_Stim(cnnt) = meta{s, 1}.individual_neuron_stats{thisChan, selectedStim}.stdFR_Stim;
            singleNeuronData{1, selectedStim}.stdFR_Spont(cnnt) = meta{s, 1}.individual_neuron_stats{thisChan, selectedStim}.stdFR_Spont;
            
            singleNeuronData{1, selectedStim}.zscore(cnnt) = meta{s, 1}.individual_neuron_stats{thisChan, selectedStim}.zscore;
            
            %%
            singleNeuronData{1, selectedStim}.allSpkCnts_Stim{cnnt} = reshape(meta{s, 1}.individual_neuron_stats{thisChan, selectedStim}.allSpkCnts_Stim, [1, numel(meta{s, 1}.individual_neuron_stats{thisChan, selectedStim}.allSpkCnts_Stim)]);
            singleNeuronData{1, selectedStim}.allSpkCnts_Spont{cnnt} = reshape(meta{s, 1}.individual_neuron_stats{thisChan, selectedStim}.allSpkCnts_Spont, [1, numel(meta{s, 1}.individual_neuron_stats{thisChan, selectedStim}.allSpkCnts_Spont)]);
            
            singleNeuronData{1, selectedStim}.allChans_FR_vec_Stims{cnnt} = meta{s, 1}.individual_neuron_stats{thisChan, selectedStim}.allChans_FR_vec_Stims;
            singleNeuronData{1, selectedStim}.allChans_FR_vec_Spont{cnnt} = meta{s, 1}.individual_neuron_stats{thisChan, selectedStim}.allChans_FR_vec_Spont;
            
            singleNeuronData{1, selectedStim}.allReps_mean_AutoCov{cnnt} = meta{s, 1}.individual_neuron_stats{thisChan, selectedStim}.allReps_mean;
            singleNeuronData{1, selectedStim}.allReps_median_AutoCov{cnnt} = meta{s, 1}.individual_neuron_stats{thisChan, selectedStim}.allReps_median;
            
            singleNeuronData{1, selectedStim}.RSC_SpkCnt{cnnt} = reshape(meta{s, 1}.individual_neuron_stats{thisChan, selectedStim}.RSC_SpkCnt , [1, numel(meta{s, 1}.individual_neuron_stats{thisChan, selectedStim}.RSC_SpkCnt)]);
            
            
            
        end
        cnnt = cnnt +1;
    end
    
    
    
end

disp('')







for s = 1: num_meta_files
    
    if ~isempty(potentialChanIDs{s})
        
        disp(['File: ' names_stimMeta{s}])
        disp(['UniqueNeurons: ' num2str(allValidSingleChans{s})])
        disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
    end
    
end


%% Sort by data cutofff



disp('Sorting meta files for stim selection...')
for s = 1: num_meta_files
    
    if dataCutoff && defStimSet
        
        nPotentialChans = potentialChanIDs(s);
        potentialChans = [];
        
        for j = 1: nPotentialChans
            
            thisChan = meta{s, 1}.totalChanNumber(j);
            thisChanStimSetcell = meta{s, 1}.individual_neuron_stats(thisChan,:); %cell array of stims w data
            thisChanStimSet = find(cell2mat(cellfun(@(x) ~isempty(x), thisChanStimSetcell, 'uniformoutput', 0)));
            allStimsPresent = ismember(selectedStimsNum, thisChanStimSet);
            
            
        end
    end
end




%% Save all search Criteria

CriteriaSelection.names_stimMeta = names_stimMeta;
CriteriaSelection.potentialChanIDs = potentialChanIDs;

CriteriaSelection.criteria.removeOutliers = removeOutliers;
CriteriaSelection.criteria.removeDuplicates = removeDuplicates;
CriteriaSelection.criteria.sortArea = sortArea;
CriteriaSelection.criteria.selectedAreas = selectedAreas;
CriteriaSelection.criteria.nSelectedAreas = nSelectedAreas;
CriteriaSelection.criteria.AreasSelectedNum = AreasSelectedNum;
CriteriaSelection.criteria.CompareWN = CompareWN;
CriteriaSelection.criteria.sigLevel = sigLevel;
CriteriaSelection.criteria.WNSel = WNSel;
CriteriaSelection.criteria.WNSel_test = WNSel_test;
CriteriaSelection.criteria.selectedStims = selectedStims;
CriteriaSelection.criteria.CompareWN = CompareWN;
CriteriaSelection.criteria.nSelectedStims = nSelectedStims;
CriteriaSelection.criteria.DPrimeRange = DPrimeRange;
CriteriaSelection.criteria.dPrimeStim = dPrimeStim;
CriteriaSelection.criteria.dprimeVal = dprimeVal;


saveName = [criteriaDir(1:end-4) '-Selection.mat'];
save(saveName, 'CriteriaSelection');
disp(['Saved: ' saveName])

%% Now start extracting all this stuff:



for s = 1: num_meta_files
    
    thesePotentialChanIDs = potentialChanIDs{s};
    
    potentialChans = [];
    duplicateChan = [];
    for j = 1: nPotentialChans
        thisChan = thesePotentialChanIDs(j);
        
        
        
        
        
        
        
        
        
        
        
    end
end

end

%% File loading  Functions

function [spontMetaDir, stimMetaDir, names_stimMetaSorted, names_spontMetaSorted, n_stimMeta]  = findSpontandStimMetaDirs(mainDataDir, runForStimFiles)
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
    
    spontMetaDir = [];
    names_spontMetaSorted = [];

else
    
    spontDirSearch = dir(fullfile(mainDataDir, '*Spont*'));
    spontDir =  [mainDataDir spontDirSearch.name dirD];
    
    %% Find n meta files in each dir
    
    
    spontMetaDir = [spontDir '/PairwiseOutput/meta/']; % no dprime scores calculated, all data in 'meta'
    spontMetaFiles = dir(fullfile(spontMetaDir, '*.mat*'));
    
    if numel(stimMetaFiles) ~= numel(spontMetaFiles)
        disp('*********************************************************')
        disp('Unequal numbers of spont and stim meta files, quitting...')
        disp('*********************************************************')
        keyboard
    end
    
    n_spontMeta = numel(spontMetaFiles);
    
    % Now we find all the date directory names
    for j = 1: n_spontMeta
        names_spontMeta{j} = spontMetaFiles(j).name;
    end
    
    [names_spontMetaSorted,~] = sort(names_spontMeta);
end



end

