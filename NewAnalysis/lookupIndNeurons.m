 function [AllIndividualInds] = lookupIndNeurons(criteriaInds, INFO)
        IndsToLookup = criteriaInds;
        
        PairwiseFilenames = INFO.PairwiseComparisons_FileNames(IndsToLookup);
        PairwiseChannels = INFO.PairwiseComparisons_Channels(IndsToLookup,:);
        AllIndividualInds = [];
        for j = 1: numel(PairwiseFilenames)
            thesePairwiseChannels = PairwiseChannels(j,:);
            thisFilename = PairwiseFilenames(j);
            
            fileMatchInd = find(cell2mat(cellfun(@(x) strcmpi(x, INFO.IndividualNeurons_FileNames), thisFilename, 'uniformoutput', 0)));
            
            cnt = 1;
            for k = 1: numel(fileMatchInd)
                
                thisFileMatchInd = fileMatchInd(k);
                ChanMatch = ismember(INFO.IndividualNeurons_Channels(thisFileMatchInd), thesePairwiseChannels);
                if ChanMatch
                    AllIndividualInds(j, cnt) = thisFileMatchInd;
                    cnt = cnt+1;
                end
            end
        end
    end