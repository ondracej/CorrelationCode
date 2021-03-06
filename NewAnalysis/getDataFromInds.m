 function [thisDATA] = getDataFromInds(thisData, AllIndividualInds)
  
    for j = 1:size(AllIndividualInds, 1)
        
        thisPair = AllIndividualInds(j,:);
        
        for k = 1:2;
            
            thisInd = thisPair(k);
            if iscell(thisData)
                thisDATA{j,k} = thisData{thisInd};
            else
                thisDATA(j,k) = thisData(thisInd);
            end
            
        end
    end
    end