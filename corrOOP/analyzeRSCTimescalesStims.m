function [] = analyzeRSCTimescalesStims()


textStr = '10ms';

%saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/';
saveDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/';


%d = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Stim-100ms.mat');
d = load('/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSC-Spont-100ms.mat');


saveStr = [saveDir 'RSCStim_' textStr];
    
song_set = [1 4 6 8 9 12]; % exclude CON
nStims = numel(song_set);

disp('');

%% Find Inds


presentInds = find(cellfun(@(x) ~isempty(x), d.RSC.nPosCorrs(:,1)));

dAllPosCorrs = d.RSC.nPosCorrs(presentInds,:);
dAllNegCorrs = d.RSC.nNegCorrs(presentInds,:);

nComparisons = size(dAllPosCorrs, 1);

for j = 1:nStims
    FinalScorePos = [];
    FinalScoreNeg = [];
    
    thisStim = song_set(j);
    
    PosCorrsThisStim  = dAllPosCorrs(:,thisStim);
    NegCorrsThisStim  = dAllNegCorrs(:,thisStim);
    
    cnt = 1;
    cnnt = 1;
    for k = 1:nComparisons
        
        thisComparison_pos = PosCorrsThisStim{k};
        thisComparison_neg = NegCorrsThisStim{k};
        
        dim1 = size(thisComparison_pos, 1);
        dim2 = size(thisComparison_pos, 2);
        
        mat_pos = [];
        for o = 1:dim1
            for oo = 1:dim2
                
                thisval_pos = thisComparison_pos{o,oo};
                
                if ~isempty(thisval_pos)
                    mat_pos(o,oo) = thisval_pos;
                else
                    mat_pos(o,oo) = nan;
                end
                
            end
        end
        
        %%
        mat_neg = [];
        for o = 1:dim1
            for oo = 1:dim2
                
               
                thisval_neg = thisComparison_neg{o,oo};
                
                if ~isempty(thisval_neg)
                    mat_neg(o,oo) = thisval_neg;
                else
                    mat_neg(o,oo) = nan;
                end
                
            end
        end
        
        %%
        x= diag(mat_pos);
        
        chanInds = find(~isnan(x));
        nChans = numel(chanInds);
        
        %%
        totalPosCorrs = [];
        for b = 1:nChans
            thisChan = chanInds(b);
            totalPosCorrs{thisChan} = x(thisChan);
        end
        
        %%
        for c = 1:nChans
            
            thisChan1 = chanInds(c);
            thisChan1Total = totalPosCorrs{thisChan1};
            
            for cc = 1:nChans
                
                thisChan2 = chanInds(cc);
                thisChan2Total = totalPosCorrs{thisChan2};
                
                if c>=cc
                    continue
                end
                thisCompPos = mat_pos(thisChan1, thisChan2);
                thisCompNeg = mat_neg(thisChan1, thisChan2);
                
                FinalScorePos(cnt) = (thisCompPos/(thisChan1Total+thisChan2Total)*100);
                cnt = cnt+1;
                
                FinalScoreNeg(cnnt) = (thisCompNeg/(thisChan1Total+thisChan2Total)*100);
                cnnt = cnnt+1;
                
            end
        end
        
    end
    
    allStims_pos{thisStim} = FinalScorePos;
    allStims_neg{thisStim} = FinalScoreNeg;
end


thisMean_pos = []; thisMean_neg = [];toPlot = [];
for q = 1:nStims
    
    thisStim = song_set(q);
    
    thisMean_pos(thisStim) = nanmean(allStims_pos{thisStim});
    thisMean_neg(thisStim) = nanmean(allStims_neg{thisStim});
    
    %allValsPos(:,q) = allStims_pos{thisStim};
    %allValsNeg(:,q) = allStims_neg{thisStim};
    
    %toPlot{q} = [allStims_pos{thisStim}  ;allStims_neg{thisStim}]';
    
end

%%


%{
figure(100); clf
subplot(1, 2, 1)
boxplot(allValsPos, 'whisker', 0, 'symbol', 'ko', 'outliersize', 5,  'jitter', 0.5, 'colors', [0 0 0], 'labels', {'WN-S', 'Stacks', 'REV', 'BOS', 'qBOS', 'WN-E'})
ylabel('Time lag (ms)')
title(['Pos Correlated Bins, ' textStr ' ms'])
ylim([0 60])

subplot(1, 2, 2)
boxplot(allValsNeg, 'whisker', 0, 'symbol', 'ko', 'outliersize', 5,  'jitter', 0.5, 'colors', [0 0 0], 'labels', {'WN-S', 'Stacks', 'REV', 'BOS', 'qBOS', 'WN-E'})
ylabel('Time lag (ms)')
title(['Neg Correlated Bins, ' textStr ' ms'])
ylim([0 60])

figure(100); clf
boxplot(toPlot, 'whisker', 0, 'symbol', 'ko', 'outliersize', 5,  'jitter', 0.5, 'colors', [0 0 0], 'labels', {'WN-S', 'Stacks', 'REV', 'BOS', 'qBOS', 'WN-E'})
%}

%%
a1 = allStims_pos{1}';
a11 = allStims_neg{1}';
a2 = allStims_pos{4}';
a22 = allStims_neg{4}';
a3 = allStims_pos{6}';
a33 = allStims_neg{6}';
a4 = allStims_pos{8}';
a44 = allStims_neg{8}';
a5 = allStims_pos{9}';
a55 = allStims_neg{9}';
a6 = allStims_pos{12}';
a66 = allStims_neg{12}';

group = [repmat({'WNS+'}, numel(a1), 1);   repmat({'WNS-'}, numel(a11), 1);      repmat({'Stacks+'}, numel(a2), 1);  repmat({'Stacks-'}, numel(a22), 1);
    repmat({'REV+'}, numel(a3), 1);        repmat({'REV-'}, numel(a33), 1);     repmat({'BOS+'}, numel(a4), 1);    repmat({'BOS-'}, numel(a44), 1);
    repmat({'qBOS+'}, numel(a5), 1);        repmat({'qBOS-'}, numel(a55), 1);      repmat({'WNE+'}, numel(a6), 1);    repmat({'WNE-'}, numel(a66), 1)];

%%
figH = figure(100); clf
poss = [1 1.5 2.5 3 4 4.5 5.5 6 7 7.5 8.5 9];
rng(1);
boxplot([a1; a11; a2; a22; a3; a33; a4; a44; a5; a55; a6; a66], group, 'whisker', 0, 'symbol', 'ko', 'outliersize', 4, 'jitter', 0.7, 'colors', [0 0 0], 'positions', poss)
ylabel(['Norm Corr %'])
ylim([0 70])
title(textStr)


figure(figH)
plot_filename = [saveStr];
plotpos = [0 0 30 15];
print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
print_in_A4(0, plot_filename, '-depsc', 0, plotpos);



%% Stats

sig = 0.05;

comp6Sig = sig/5;

%%
for a = 1: nStims
    stim1 = song_set(a);
    
    data_stim1 = allStims_pos{stim1};
    data1_nonnans = find(~isnan(data_stim1));
    nonan_data1 = data_stim1(data1_nonnans);
    
    for b = 1: nStims
        stim2 = song_set(b);
        
        data_stim2 = allStims_pos{stim2};
        data2_nonnans = find(~isnan(data_stim2));
        nonan_data2 = data_stim2(data2_nonnans);
        
        [pr,h] = ranksum(nonan_data1, nonan_data2, sig); % Use non-nanned for Ranksum
        
        [h, pt] = ttest(data_stim1, data_stim2, sig); % Use non-nanned for Ranksum
        %[h, pt] = ttest2(nonan_data1, nonan_data2, sig); % Use non-nanned for Ranksum
        
        %[h, pk] = kstest2(this_data{:,stim1}, this_data{:,stim2}, sig, 'unequal');
        
        
        prs_pos(a, b) = pr;
        pts_pos(a,b) = pt;
        %pks(a, b) = pk;
    end
end


%% Neg
for a = 1: nStims
    stim1 = song_set(a);
    
    data_stim1 = allStims_neg{stim1};
    data1_nonnans = find(~isnan(data_stim1));
    nonan_data1 = data_stim1(data1_nonnans);
    
    for b = 1: nStims
        stim2 = song_set(b);
        
        data_stim2 = allStims_neg{stim2};
        data2_nonnans = find(~isnan(data_stim2));
        nonan_data2 = data_stim2(data2_nonnans);
        
        [pr,h] = ranksum(nonan_data1, nonan_data2, sig); % Use non-nanned for Ranksum
        
        %[h, pt] = ttest(data_stim1, data_stim2, sig); % Use non-nanned for Ranksum
        %[h, pt] = ttest2(nonan_data1, nonan_data2, sig); % Use non-nanned for Ranksum
        
        %[h, pk] = kstest2(this_data{:,stim1}, this_data{:,stim2}, sig, 'unequal');
        
        
        prs_neg(a, b) = pr;
        %pts_neg(a,b) = pt;
        %pks(a, b) = pk;
    end
end


end
