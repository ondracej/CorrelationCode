function [] = exploreRSC()

dbstop if error
d = load('/home/janie/Dropbox/CorrPaper2016/Data/AuditoryForebrain-Population/AllPooledData/allPooledData.mat');
INFO = d.INFO;
RSC = d.RSC;

stimRSC_rs = RSC.RSC_Stim.RSC.r;
nRs = size(stimRSC_rs, 1);
timepoints = ones(1, nRs);

threshold = 0.3;
%%
figure;
hold on

for j = 1:5
    hold on
    plot(timepoints*j, stimRSC_rs(:,j), 'k*')
    
end
%%
%% FInd all BOs with large negative RSCs

allRSCs = d.RSC.RSC_Stim.RSC.r(:,4);

largeNegInd = find(allRSCs > .5);
allNegRSC = allRSCs(largeNegInd);
[AllIndividualInds] = lookupIndNeurons(largeNegInd, INFO);

thisData = d.FRStats.FR.Stim.SpkCntBinned{1,8};

[thisDATA] = getDataFrimInds(thisData, AllIndividualInds);


cols = {'r', 'b', 'k', [.6 .6 .6], [.3 .6 .4], [.2 .5 .1]};

for k = 1:size(thisDATA, 1)
    
    thisPair = thisDATA(k,:);
    spks1 = thisPair{1, 1};
    spks2 = thisPair{1, 2};
    
   
       
       
    figure(107);clf
    allRSC = []; allNumels = [];
    for p =1: size(spks1, 1)
        
        rs = [];
        spkcnt1 = spks1{p,1};
        spkcnt2 = spks2{p,1};
        
            %[~, indices_in_same_bin] = histc(1:size(spkcnt1, 2), [1:2:size(spkcnt1, 2)]);
            %nBins_unique = unique(indices_in_same_bin);
          % for w = 1: numel(nBins_unique)
               
           % samples_this_bin = spkcnt1(indices_in_same_bin == w);
            
            
            
        for j = 1:size(spkcnt1, 2)
            [r h] = corrcoef(spkcnt1(:,j), spkcnt2(:,j), 'rows', 'pairwise');
            rs(j) = r(2, 1);
           
        end
        
        figure(300+p)
        subplot(2, 1, 1)
        imagesc(spkcnt1)
        subplot(2, 1, 2)
        imagesc(spkcnt2)
        
        allRSC{p} = rs;
        allNumels(p) = numel(rs);
        
        nonNanRs = rs;
        nonNanRs(isnan(rs)) = 0;
         figure(107)
         subplot(6, 1, p)
        plot(smooth(nonNanRs, 3), 'color', cols{p})
        hold on
        plot(rs,'o', 'color', cols{p})
        axis tight
    ylim([-1.1 1.1])    
    
    ylabel(['R'])
    if p == size(spks1, 1)
        xlabel(['Time [5ms bins]'])
    end
    
    if p == 1
         title(['RSC in 1.5 s | ' num2str(allNegRSC(k))])
    end
    
    end
    
    end
    
   
    axis tight
    
   
    
    
    maxLenght = max(allNumels);
    array = zeros(size(allRSC, 2), maxLenght);
    for q = 1:size(allRSC, 2)
        array(q, 1:allNumels(q)) = allRSC{:,q};
    end
    figure(105); clf
    imagesc(array)
    colormap('jet')
    
    pause    
    
end




    