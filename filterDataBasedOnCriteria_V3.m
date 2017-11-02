function [] = filterDataBasedOnCriteria_V3(criteria)

runForStimFiles = 1;
hardcodeCriteria = 0;
runDataCollection = 0;

dbstop if error

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
        criteriaDir = [criteriaDir 'Criteria.mat'];
        d = load(criteriaDir);
        criteria = d.criteria;
    else
        criteriaDir = criteriaDir;
        criteriaFiles = dir(fullfile(criteriaDir, '*Criteria.mat*'));
        
        if numel(criteriaFiles) >= 1
            nCriteriaFilesFound = numel(criteriaFiles);
            for o = 1:nCriteriaFilesFound
                critNames{o} = criteriaFiles(o).name;
            end
            
            [Selection,ok] = listdlg('PromptString', 'Choose a file', 'SelectionMode', 'single', 'ListString', critNames);
            
            if ok
                criteriaFile = critNames{Selection};
                d = load([criteriaDir criteriaFile]);
                criteria = d.criteria;
            else
                disp('Canceled, loading default file')
                criteriaDir = [criteriaDir 'Criteria.mat'];
                d = load(criteriaDir);
                criteria = d.criteria;
            end
        else
            criteriaFile =  criteriaFiles.name;
            d = load([criteriaDir criteriaFile]);
            criteria = d.criteria;
            
            
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
critSaveStr = criteria.saveStr;

neuronSelectionDir = [mainDataDir '/NeuronSelections/'];
if exist(neuronSelectionDir, 'dir') == 0
    mkdir(neuronSelectionDir);
end
%% Define Spont and Stim directories

mainDataDir = criteria.mainDataDir;

[spontDir, stimDir, names_stimMeta, names_spontMeta, num_meta_files]  = findSpontandStimMetaDirs(mainDataDir, runForStimFiles);


%% Load all Meta

meta = cell(num_meta_files, 1);
disp('Loading all meta data...')
for s = 1: num_meta_files
    
    
    this_metafile = [stimDir names_stimMeta{s}];
    this_meta = load(this_metafile);
    meta{s} = this_meta.meta;
    
    %disp(['File: ' names_stimMeta{s}])
    
    potentialChanIDs_orig{s} =  meta{s, 1}.totalChanNumber;
    nChansOverMeta_orig(s) = numel(potentialChanIDs_orig{s});
    
end

%% Filter 1 -- Stimulus Selection %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for s = 1: num_meta_files
    
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
    
    disp('*********************************************************************************')
    disp(['Stim Filter | File: ' names_stimMeta{s} ' | Chans: ' num2str(potentialChans)])
    disp('************************************')
    
    
    potentialChanIDs_1{s} = potentialChans; % update the potentialChanIDs
    nChansAfterFilter_1 = numel(potentialChans);
    
    
    %% Filter 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Sort by neuron area
    
    nPotentialChans_2 = nChansAfterFilter_1;
    thesePotentialChanIDs = potentialChanIDs_1{s};
    
    potentialChans = [];
    
    for j = 1: nPotentialChans_2
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
    
    
    potentialChanIDs_2{s} = potentialChans; % update the potentialChanIDs
    nChansAfterFilter_2(s) = numel(potentialChans); % update the correct nChansOverMeta
    
    disp(['Area Filter | File: ' names_stimMeta{s} ' | Chans: ' num2str(potentialChans)])
    disp('************************************')
    
    %% Filter 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% WN Search Criteria
    
    
    if CompareWN
        
        nPotentialChans = nChansAfterFilter_2(s);
        thesePotentialChanIDs = potentialChanIDs_2{s};
        
        potentialChans = [];
        WNSet = [1 12];
        disp(['File: ' names_stimMeta{s}])
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
                
                if p >= sigLevel
                    potentialChans = [potentialChans thisChan];
                    disp(['        WN means are NOT diferent: WN-BOF = ' num2str(WN_BOF_meanFRs) ' | WN-EOF = ' num2str( WN_EOF_meanFRs) 'CH: ' num2str(thisChan)]);
                else
                    disp(['>>>>>>> WN means are diferent: WN-BOF = ' num2str(WN_BOF_meanFRs) ' | WN-EOF = ' num2str( WN_EOF_meanFRs) 'CH: ' num2str(thisChan)]);
                end
            else
                disp('You have not selected WN as a stimulus')
                keyboard
            end
        end
        
        potentialChanIDs_3{s} = potentialChans; % update the potentialChanIDs
        nChansAfterFilter_3(s) = numel(potentialChans); % update the correct nChansOverMeta
        
    else % No stimulus filter selected
        potentialChanIDs_3{s} =  potentialChanIDs_2{s};
        nChansAfterFilter_3(s) = nChansAfterFilter_2(s);
        
    end
    
    disp('************************************')
    disp(['WN Filter | File: ' names_stimMeta{s} ' | Chans: ' num2str(potentialChans)])
    disp('************************************')
    
    %% Only keep channels that have at least a pair:
    %{

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
    %}
    
    %% Determine which neurons might be duplicated on other recordings
    
    
    if removeDuplicates
        
        thesePotentialChanIDs = potentialChanIDs_3{s};
        
        
        nPotentialChans = nChansAfterFilter_3(s);
        
        theseDuplicateChans = 0;
        potentialChans = [];
        allDuplicateChansID = []; allDuplicateChans = []; allDuplicateChansDataInds = []; allDuplicateChansSameAsDataInds = [];
        
        for j = 1: nPotentialChans
            thisChan = thesePotentialChanIDs(j);
            
            thisChanStimSetcell = meta{s, 1}.individual_neuron_stats(thisChan,:); %cell array of stims w data
            thisChanStimSet = find(cell2mat(cellfun(@(x) ~isempty(x), thisChanStimSetcell, 'uniformoutput', 0)));
            
            thisChan_IsDuplicate = meta{s, 1}.database{thisChan,thisChanStimSet(1)}.is_duplicate;
            
            allDuplicateChansID(j) = thisChan;
            allDuplicateChans(j) = thisChan_IsDuplicate;
            allDuplicateChansDataInds(j) = meta{s, 1}.data_number;
            allDuplicateChansSameAsDataInds(j) = nan;
            
            if thisChan_IsDuplicate
                allDuplicateChansSameAsDataInds(j) = meta{s, 1}.database{thisChan,thisChanStimSet(1)}.same_as_ind(1);
                
                thisChan_thisDataInd = meta{s, 1}.data_number; % data ind for this data set
                thisChan_duplicatedInd = meta{s, 1}.database{thisChan,thisChanStimSet(1)}.same_as_ind(1); % data ind for the dulicate chans
                
                indDiff = thisChan_duplicatedInd - thisChan_thisDataInd; % diff between the current data ind and the duplciate ind
                
                if indDiff < 0 % if this is negative, than the previous file was the first instance of this data duplication (which we keep)
                    
                    indChanMatch  = ismember(thisChan, potentialChanIDs_3{s+indDiff(1)}); % is this channel actually present on both recordings
                    
                    if indChanMatch == 1
                        
                        theseDuplicateChans(j) = 1;
                        potentialChans = [potentialChans thisChan];
                        %disp([names_stimMeta{s} ': ch- ' num2str(thisChan) ' is duplicated'])
                        % Do not count it as a valid channel
                        
                    else % when its a 0
                        
                        potentialChans = [potentialChans thisChan];
                    end
                    
                else % if indDiff is greater than zero
                    
                    potentialChans = [potentialChans thisChan];
                    %listOfDuplicateIndsToCheck(s) = thisChan_duplicatedInd;
                    
                end
                
            else
                
                potentialChans = [potentialChans thisChan];
                
            end
            
        end
        
        if sum(theseDuplicateChans) == nPotentialChans
            potentialChans = [];
            
        end
        
        potentialChanIDs_4{s} = potentialChans;
        nChansAfterFilter_4(s) = numel(potentialChans); % update the potentialChanIDs
        
    else % No stimulus filter selected
        
        potentialChanIDs_4{s} = potentialChanIDs_3;
        nChansAfterFilter_4(s) = nChansAfterFilter_3; % update the potentialChanIDs
    end
    
    %% SaveDuplicateInfo
    
    allDuplicateINFO{s}.allDuplicateChans = allDuplicateChans;
    allDuplicateINFO{s}.allDuplicateChansID = allDuplicateChansID;
    allDuplicateINFO{s}.allDuplicateChansDataInds = allDuplicateChansDataInds;
    allDuplicateINFO{s}.allDuplicateChansSameAsDataInds = allDuplicateChansSameAsDataInds;
    
    %% Filter 5
    %% Data Cutoff
    
    thesePotentialChanIDs =  potentialChanIDs_4{s};
    nPotentialChans = nChansAfterFilter_4(s);
    
    if dataCutoff
        
        if nPotentialChans <= 1
            disp(['There are fewer than 2 pairs left for this data file: ' names_stimMeta{s} ])
            Final_available_channels{s} = [];
            continue
        end
        
        %these_duplicate_chans = all_duplicate_channels{a};
        
        validChans = [];
        for j = 1:nPotentialChans
            chan1 = thesePotentialChanIDs(j);
            
            for k = 1:nPotentialChans
                
                if j >= k
                    continue
                end
                
                chan2 = thesePotentialChanIDs(k);
                
                WN_comp_stats = meta{s,1}.COV_comparison_stats{1,1};
                CON_comp_stats = meta{s,1}.COV_comparison_stats{1,7};
                
                WN_TL_n = WN_comp_stats.TL_n{chan1, chan2};
                WN_TL_n_Max = WN_comp_stats.TL_n_max{chan1, chan2};
                
                WN_ratio = WN_TL_n/WN_TL_n_Max;
                
                if ~isempty(CON_comp_stats)
                    
                    CON_TL_n = CON_comp_stats.TL_n{chan1, chan2};
                    CON_TL_n_Max = CON_comp_stats.TL_n_max{chan1, chan2};
                    
                    CON_ratio = CON_TL_n/CON_TL_n_Max;
                    
                else
                    CON_comp_stats = eval(['this_data.' C_text 'comparison_stats{1,8};']); % Use the BOS instead of CON
                    disp('used BOS for TL/TS ratio')
                    
                    CON_TL_n = CON_comp_stats.TL_n{chan1, chan2};
                    CON_TL_n_Max = CON_comp_stats.TL_n_max{chan1, chan2};
                    
                    CON_ratio = CON_TL_n/CON_TL_n_Max;
                    
                end
                
                WN_empty = 0;
                CON_empty = 0;
                
                if isempty(WN_ratio)
                    WN_ratio = 0;
                    WN_empty = 1;
                end
                
                if isempty(CON_ratio)
                    CON_ratio = 0;
                    CON_empty = 1;
                end
                
                if WN_ratio < dataCutoffValue && CON_ratio < dataCutoffValue || WN_empty == 1 || CON_empty == 1
                    disp([names_stimMeta{s} ': Current Data Cutoff = ' num2str(dataCutoffValue) ', WN data ratio: ' num2str(WN_ratio) '; CON data ratio: ' num2str(CON_ratio)])
                    
                else
                    validChans = [validChans chan1 chan2];
                    
                    %Final_available_channels{s} = potential_chans4{a};
                    %Final_all_duplicate_channels{s} = all_duplicate_channels{a};
                end
                
            end
        end
        
        Final_available_channels{s} = unique(validChans);
        
    else
        Final_available_channels{s} = potential_chans4{s};
        %Final_all_duplicate_channels{s} = all_duplicate_channels{a};
        
    end
    
    %%
    
    if removeOutliers
        outlierFile = 'k18r4-MetaData-COEF-Stims-k18r4 03.mat';
        
        fileMatch = strcmpi(names_stimMeta{s}, outlierFile);
        
        if fileMatch
            Final_available_channels{s} = [];
            disp(['Outlier File: ' outlierFile ' removed']);
        else
            Final_available_channels{s} = Final_available_channels{s};
            
        end
        
    end
    
end

disp('*********************************************************************************')
disp('*********************************************************************************')
disp('*********************************************************************************')
disp('*********************************************************************************')
disp('******************* Final Cell Count ********************************************')
for s = 1: num_meta_files
    
    if ~isempty(Final_available_channels{s})
        
        disp(['File: ' names_stimMeta{s}])
        disp(['UniqueNeurons: ' num2str(Final_available_channels{s})])
        disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
    end
    
end


%% Save all search Criteria

CriteriaSelection.names_stimMeta = names_stimMeta;
CriteriaSelection.Final_available_channels = Final_available_channels;
CriteriaSelection.allDuplicateINFO = allDuplicateINFO;

CriteriaSelection.mainDataDir = mainDataDir;
CriteriaSelection.saveStr = critSaveStr;

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
CriteriaSelection.criteria.nSelectedStims = nSelectedStims;
CriteriaSelection.criteria.selectedStimsNum = selectedStimsNum;

CriteriaSelection.criteria.DPrimeRange = DPrimeRange;
CriteriaSelection.criteria.dPrimeStim = dPrimeStim;
CriteriaSelection.criteria.dprimeVal = dprimeVal;

CriteriaSelection.criteria.dataCutoff = dataCutoff;
CriteriaSelection.criteria.dataCutoffValue = dataCutoffValue;

saveName = [neuronSelectionDir critSaveStr '-NeuronSelection.mat'];
save(saveName, 'CriteriaSelection');
disp(['Saved: ' saveName])


if runDataCollection
    
    collectDatafromCriteriaFile(CriteriaSelection)
    
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
