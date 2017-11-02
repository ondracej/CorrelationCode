function [] = compareMismatchSignalNoisePairs()


switch gethostname
    case 'turtle'
        
        baseDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/';
        saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/';
        plotDir = ['/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/Plots/SpikeRSC/'];
        
        
    case 'deadpool'
        baseDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/';
        
        saveDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/';
        plotDir = ['/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/SpikeRSC/'];
end



%ms10 = load([ baseDir 'SortedData/WNSpontOrStim-1s/AudSpkData/10msRSC_INFO.mat']);
ms50 = load([baseDir 'SortedData/WNSpontOrStim-1s/AudSpkData/50msRSC_INFO.mat']);
ms100 = load([ baseDir 'SortedData/WNSpontOrStim-1s/AudSpkData/100msRSC_INFO.mat']);
ms200 = load([baseDir 'SortedData/WNSpontOrStim-1s/AudSpkData/200msRSC_INFO.mat']);



% R_Stim_10ms = ms10.metaRSC.allRsThisStim;
% R_Spont_10ms = ms10.metaRSC.allRsThisSpont;
% R_StimSig_10ms = ms10.metaRSC.allRsThisStim_Signal;

R_Stim_50ms = ms50.metaRSC.allRsThisStim;
R_Spont_50ms = ms50.metaRSC.allRsThisSpont;
R_StimSig_50ms = ms50.metaRSC.allRsThisStim_Signal;

R_Stim_100ms = ms100.metaRSC.allRsThisStim;
R_Spont_100ms = ms100.metaRSC.allRsThisSpont;
R_StimSig_100ms = ms100.metaRSC.allRsThisStim_Signal;

R_Stim_200ms = ms200.metaRSC.allRsThisStim;
R_Spont_200ms = ms200.metaRSC.allRsThisSpont;
R_StimSig_200ms = ms200.metaRSC.allRsThisStim_Signal;


stimSet = [6 7 8];


fiH = figure(101); clf
stimSet = [1 4 6 7 8 9 12];
for j = 1:2
    
    switch j
%         case 3
%             
%             stim = R_Stim_10ms;
%             spont = R_Spont_10ms;
%             signal = R_StimSig_10ms;
%             col = [0 0 0];
%             txtend = '10ms';
        case 2
            
            stim = R_Stim_50ms;
            spont = R_Spont_50ms;
            signal = R_StimSig_50ms;
            col = [0.2 0.2 0.2];
            txtend = '50ms';
            
        case 1
            
            stim = R_Stim_100ms;
            spont = R_Spont_100ms;
            signal = R_StimSig_100ms;
            col = [0.4 0.4 0.4];
            txtend = '100ms';
        case 4
            
            stim = R_Stim_200ms;
            spont = R_Spont_200ms;
            signal = R_StimSig_200ms;
            col = [0.6 0.6 0.6];
            txtend = '200ms';
    end
    
    
    jitterAmount = 0.25;
    subplot(1, 3, 2)
    for k = 1:numel(stimSet)
        thisStim = stimSet(k);
        
        thisStimR = stim{thisStim};
        %thisSignalR = signal{thisStim};
        %thisSpontR = spont{thisStim};
        
        xes = ones(1, numel(thisStimR))*k*2;
        
        
        jitterValuesX = 2*(rand(size(xes))-0.5)*jitterAmount;   % +/-jitterAmount max
        hold on
        plot(xes+jitterValuesX, thisStimR, 'b.')
        thismedian = nanmedian(thisStimR);
        thismean = nanmean(thisStimR);
        line([xes(1)-.4 xes(1)+.4], [thismedian  thismedian ], 'color', 'r', 'linewidth', 2')
        line([xes(1)-.4 xes(1)+.4], [thismean  thismean ], 'color', 'r', 'linewidth', 2', 'linestyle', ':')
    end
    
    ylim([-1 1])
    xlim([0 16])
    subplot(1, 3, 3)
    for k = 1:numel(stimSet)
        thisStim = stimSet(k);
        
        thisStimR = stim{thisStim};
        %thisSignalR = signal{thisStim};
        thisSpontR = spont{thisStim};
        
        xes = ones(1, numel(thisSpontR ))*k*2;
        
        
        jitterValuesX = 2*(rand(size(xes))-0.5)*jitterAmount;   % +/-jitterAmount max
        hold on
        plot(xes+jitterValuesX, thisSpontR , 'k.')
        hold on
        thismedian = nanmedian(thisSpontR);
        thismean = nanmean(thisSpontR);
        line([xes(1)-.4 xes(1)+.4], [thismedian  thismedian ], 'color', 'r', 'linewidth', 2')
        line([xes(1)-.4 xes(1)+.4], [thismean  thismean ], 'color', 'r', 'linewidth', 2', 'linestyle', ':')
    end
    ylim([-1 1])
    xlim([0 16])
    
    subplot(1, 3, 1)
    for k = 1:numel(stimSet)
        thisStim = stimSet(k);
        
        % thisStimR = stim{thisStim};
        thisSignalR = signal{thisStim};
        %thisSpontR = spont{thisStim};
        
        xes = ones(1, numel(thisSignalR))*k*2;
        
        jitterAmount = 0.35;
        jitterValuesX = 2*(rand(size(xes))-0.5)*jitterAmount;   % +/-jitterAmount max
        hold on
        plot(xes+jitterValuesX, thisSignalR, 'r.')
        thismedian = nanmedian(thisSignalR);
        thismean = nanmean(thisSignalR);
        line([xes(1)-.4 xes(1)+.4], [thismedian  thismedian ], 'color', 'k', 'linewidth', 2')
        line([xes(1)-.4 xes(1)+.4], [thismean  thismean ], 'color', 'k', 'linewidth', 2', 'linestyle', ':')
    end
    xlim([0 16])
    ylim([-1 1])
    
    
    
    figure(fiH)
    plot_filename = [plotDir 'RSC_SigNoiseSpont' txtend];
    plotpos = [0 0 30 8];
    print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
    print_in_A4(0, plot_filename, '-depsc', 0, plotpos);
    
end

%% Analysis for 100 ms bins

stim = R_Stim_100ms;
spont = R_Spont_100ms;
signal = R_StimSig_100ms;
col = [0.4 0.4 0.4];
txtend = '100ms';

%% Z transform all data
%% Fisher Z transform the R data https://en.wikipedia.org/wiki/Fisher_transformation
for k = 1:numel(stimSet)
    thisStim = stimSet(k);
    
    thisStimR = stim{thisStim};
    thisSignalR = signal{thisStim};
    thisSpontR = spont{thisStim};
    
    z_stimR = [];  z_signalR = []; z_spontR = [];
    for j = 1:numel(thisStimR)
        %z_stimR(j) = (1/2) * log ( (1 + thisStimR(j)) / (1 - thisStimR(j)));
        %z_signalR(j) = (1/2) * log ( (1 + thisSignalR(j)) / (1 - thisSignalR(j)));
        %z_spontR(j) = (1/2) * log ( (1 + thisSpontR(j)) / (1 - thisSpontR(j)));
        
        z_stimR(j) = atanh(thisStimR(j));
        z_signalR(j) = atanh(thisSignalR(j));
        z_spontR(j) = atanh(thisSpontR(j));
        
        
    end
    
    Z_stim{thisStim} = z_stimR;
    Z_signal{thisStim} = z_signalR;
    Z_spont{thisStim} = z_spontR;
    
end

%% Test for normality
bla = atanh(thisStimR);

h = lillietest(thisStimR);
h = jbtest(thisStimR);
h = ktest(thisStimR);


%% Signal R vs NOise R
FIGh = figure(352); hold on
for k = 1:numel(stimSet)
    thisStim = stimSet(k);
    
    
    subplot(4, 2, k); hold on
    
    thisStimR = stim{thisStim};
    thisSignalR = signal{thisStim};
    thisSpontR = spont{thisStim};
    
%     thisStimR = Z_stim{thisStim};
%     thisSignalR = Z_signal{thisStim};
%     thisSpontR = Z_spont{thisStim};
    
    
    xlim([-1.1 1.1])
    ylim([-1.1 1.1])
    plot(thisStimR, thisSignalR, 'bo')
    line([0 0], [-1.1 1.1], 'color', 'k')
    line([-1.1 1.1], [0 0], 'color', 'k')
    
    xlabel('Noise R')
    xlabel('Signal R')
    title(['Stim ' num2str(thisStim)])
    axis tight
end

FIGh = figure(322); hold on
for k = 1:numel(stimSet)
    thisStim = stimSet(k);
    
    
    subplot(4, 2, k) ; hold on
    thisStimR = stim{thisStim};
    thisSignalR = signal{thisStim};
    thisSpontR = spont{thisStim};
    
%  thisStimR = Z_stim{thisStim};
%     thisSignalR = Z_signal{thisStim};
%     thisSpontR = Z_spont{thisStim};
%     
xlim([-1.1 1.1])
    ylim([-1.1 1.1])
    plot(thisSpontR, thisSignalR, 'bo')
    line([0 0], [-1.1 1.1], 'color', 'k')
    line([-1.1 1.1], [0 0], 'color', 'k')
    
    xlabel('Silent R')
    xlabel('Signal R')
    title(['Stim ' num2str(thisStim)])
    axis tight
end

%% Signed Rank

for k = 1:numel(stimSet)
    thisStim = stimSet(k);
   
    thisStimR = Z_stim{thisStim};
    thisSpontR = Z_spont{thisStim};
    
    [p_w_spont(k), h_w_spont(k)] = signrank(thisSpontR); %h =1 rejects the null hyp of zero median
    [p_w(k), h_w(k)] = signrank(thisStimR); %h =1 rejects the null hyp of zero median
    
    [p_rank(k), h_rank(k)] = signrank(thisSpontR, thisStimR); % do not use this, samples are not independent
    [h_ttest(k), p_ttest(k)] = ttest(thisSpontR, thisStimR); % h = 1 rejects the null hyp of x-y mean equal to zero, REV, CON, BOS, qBOS, 
   
end



 
    %Z_stim{thisStim} = z_stimR;
    %Z_signal{thisStim} = z_signalR;
    %Z_spont{thisStim} = z_spontR;

            
        
    %%
    for k = 1:numel(stimSet)
        thisStim1 = stimSet(k);
        
        thisStimR1 = Z_stim{thisStim1};
        thisSignalR1 = Z_signal{thisStim1};
        thisSpontR1 = Z_spont{thisStim1};
        
        
        for kk = 1:numel(stimSet)
            thisStim2 = stimSet(kk);
            
            thisStimR2 = Z_stim{thisStim2};
            thisSignalR2 = Z_signal{thisStim2};
            thisSpontR2 = Z_spont{thisStim2};
            
            
            
            [p_Noise(k, kk), h_Noise(k, kk)] = ranksum(thisStimR1, thisStimR2);   % not really independent
            [p_Signal(k, kk), h_Signal(k, kk)] = ranksum(thisSignalR1, thisSignalR2);
            [p_Spont(k, kk), h_Spont(k, kk)] = ranksum(thisSpontR1, thisSpontR2);
            
            
            
        end
    end
    
    
    %% RM ANova come back to this..
    
    load fisheriris
    
    
    Stimulus = ['WN-S','Stacks','REV','CON','BOS', 'qBOS', 'WN-E'];
    
t = table(species,meas(:,1),meas(:,2),meas(:,3),meas(:,4),...
'VariableNames',{'species','meas1','meas2','meas3','meas4'})

Meas = table([1 2 3 4]','VariableNames',{'Measurements'});

rm = fitrm(t,'meas1-meas4~species','WithinDesign',Meas)

tt = table(Z_stim{:,1}, Z_stim{:,4}, Z_stim{:,6}, Z_stim{:,7}, Z_stim{:,8}, Z_stim{:,9}, Z_stim{:,12})
    %'VariableNames',{'WN-S','Stacks','REV','CON','BOS', 'qBOS', 'WN-E'});

rm = fitrm(tt,'Var1-Var7','WithinDesign')


%% 
j=1;
    
    nNegNoiseInds = []; nPosNoiseInds = [];
    nNegSigInds = [];nPosSigInds = [];
    mismatch_NegNoise_PosSig = []; mismatch_PosNoise_NegSig = [];
    match_PosNoise_PosSig = []; match_NegNoise_NegSig = [];
    cnt = 1;
    for k = [1 4 6 7 8 9 12]
        thisStim = k;
        
        cumstim = Z_stim{thisStim};
        cumsig = Z_signal{thisStim};
        
        
        negNoiseInds = find(cumstim < 0);
        posNoiseInds = find(cumstim > 0);
        
        negSigInds = find(cumsig < 0);
        posSigInds =  find(cumsig > 0);
        
        
%         negNoiseInds = find(cumstim < -.1);
%         posNoiseInds = find(cumstim > .1);
%         
%         negSigInds = find(cumsig < -.1);
%         posSigInds =  find(cumsig > .1);
        %
        %
        nNegNoiseInds(k) = numel(negNoiseInds);
        nPosNoiseInds(k) = numel(posNoiseInds);
        
        nNegSigInds(k) = numel(negSigInds);
        nPosSigInds(k) = numel(posSigInds);
        
        mismatch_NegNoise_PosSig(k) = sum(ismember(negNoiseInds, posSigInds));
        mismatch_PosNoise_NegSig(k) = sum(ismember(posNoiseInds, negSigInds));
        
        match_PosNoise_PosSig(k) = sum(ismember(posNoiseInds, posSigInds));
        match_NegNoise_NegSig(k) = sum(ismember(negNoiseInds, negSigInds));
        
    end
    
    all_mismatch_NegNoise_PosSig(j,:) = mismatch_NegNoise_PosSig;
    all_mismatch_PosNoise_NegSig(j,:) = mismatch_PosNoise_NegSig;
    all_match_PosNoise_PosSig(j,:) = match_PosNoise_PosSig;
    all_match_NegNoise_NegSig(j,:) = match_NegNoise_NegSig;
    
    all_totalNegSigInds(j,:) = nNegSigInds;
    all_totalPosSigInds(j,:) = nPosSigInds;
    
    all_totalNegNoiseInds(j,:) = nNegNoiseInds;
    all_totalPosNoiseInds(j,:) = nPosNoiseInds;
    
    
    
    
    %% Make a chi square
    
    stim1 = 8;
    stim2 = 7;
    
    n1 = all_mismatch_NegNoise_PosSig(stim1) + all_mismatch_PosNoise_NegSig(stim1);
    n2= all_mismatch_NegNoise_PosSig(stim2) + all_mismatch_PosNoise_NegSig(stim2);
    
    
    N1 = all_totalNegNoiseInds(stim1) + all_totalPosSigInds(stim1) + all_totalPosNoiseInds(stim1) + all_totalNegSigInds(stim1);
    N2 = all_totalNegNoiseInds(stim2) + all_totalPosSigInds(stim2)  + all_totalPosNoiseInds(stim2) + all_totalNegSigInds(stim2);
    

    x1 = [repmat('a',N1,1); repmat('b',N2,1)];
    x2 = [repmat(1,n1,1); repmat(2,N1-n1,1); repmat(1,n2,1); repmat(2,N2-n2,1)];
    
    [tbl,chi2stat,pval] = crosstab(x1,x2)
    
    
    %
    %x = table([3;1],[6;7],'VariableNames',{'Flu','NoFlu'},'RowNames',{'NoShot','Shot'})
    x = table([n1;n2],[N1;N2],'VariableNames',{'nmismatch','total'},'RowNames',{'Stim1','Stim2'})
    [h,p,stats] = fishertest(x)
    %%
    stim1 = 8;
    stim2 = 7;
    
    n1 = all_match_PosNoise_PosSig(stim1) + all_match_NegNoise_NegSig(stim1);
    n2= all_match_PosNoise_PosSig(stim2) + all_match_NegNoise_NegSig(stim2);
    
    
    N1 = all_totalNegNoiseInds(stim1) + all_totalPosSigInds(stim1) + all_totalPosNoiseInds(stim1) + all_totalNegSigInds(stim1);
    N2 = all_totalNegNoiseInds(stim2) + all_totalPosSigInds(stim2)  + all_totalPosNoiseInds(stim2) + all_totalNegSigInds(stim2);
    

    x1 = [repmat('a',N1,1); repmat('b',N2,1)];
    x2 = [repmat(1,n1,1); repmat(2,N1-n1,1); repmat(1,n2,1); repmat(2,N2-n2,1)];
    
    [tbl,chi2stat,pval] = crosstab(x1,x2)
    
     x = table([n1;n2],[N1;N2],'VariableNames',{'nmismatch','total'},'RowNames',{'Stim1','Stim2'})
    [h,p,stats] = fishertest(x)
    
    
    
    %%

for j = 1
    
    cnt = 1;
    NegNoise_PosSig_ratio = []; PosNoise_NegSig_ratio =[];
    PosNoise_PosSig_ratio = []; NegNoise_NegSig_ratio =[];
    nPosSig = []; nNegSig = []; nNegNoise = []; nPosNoise = [];
    for o = [1 4 6 7 8 9 12]
        
        NegNoise_PosSig_ratio(cnt) = (all_mismatch_NegNoise_PosSig(j,o) / (all_totalNegNoiseInds(j,o) + all_totalPosSigInds(j,o)))*100;
        PosNoise_NegSig_ratio(cnt) = (all_mismatch_PosNoise_NegSig(j,o) / (all_totalPosNoiseInds(j,o) + all_totalNegSigInds(j,o)))*100;
        
        PosNoise_PosSig_ratio(cnt) = (all_match_PosNoise_PosSig(j,o) / (all_totalPosNoiseInds(j,o) + all_totalPosSigInds(j,o)))*100;
        NegNoise_NegSig_ratio(cnt) = (all_match_NegNoise_NegSig(j,o) / (all_totalNegNoiseInds(j,o) + all_totalNegSigInds(j,o)))*100;
        
        nPosSig(cnt) = all_totalPosSigInds(j,o);
        nNegSig(cnt) = all_totalNegSigInds(j,o);
        
        nNegNoise(cnt) = all_totalNegNoiseInds(j,o);
        nPosNoise(cnt) = all_totalPosNoiseInds(j,o);
        
        cnt = cnt+1;
        
    end
    
    fIH = figure(100+j); clf
    subplot(2, 1, 1)
    toPlot = [NegNoise_PosSig_ratio; PosNoise_NegSig_ratio];
    bar(toPlot')
    title(['Unmatched Corr' allTxtEnds{j}])
    colormap('gray')
    ylim([0 50])
    
    subplot(2, 1, 2)
    
    toPlot = [NegNoise_NegSig_ratio; PosNoise_PosSig_ratio];
    bar(toPlot')
    title(['Matched Corr' allTxtEnds{j}])
    colormap('gray')
    ylim([0 50])
    
    figure(fIH)
    plot_filename = [plotDir 'RSC_SigProportions_0-' allTxtEnds{j}];
    plotpos = [0 0 15 15];
    print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
    print_in_A4(0, plot_filename, '-depsc', 0, plotpos);
    
    figDS = figure(352);clf
    
    toPlot = [nNegSig ; nNegNoise ;nPosSig; nPosNoise];
    bar(toPlot')
    title(['ns' allTxtEnds{j}])
    colormap('gray')
    axis tight
    ylim([0 150])
    
    legtxt = {'nNegSig', 'nNegNoise', 'nPosSig', 'nPosNoise'};
    legend(legtxt);
    legend('boxoff')
    
    figure(figDS)
    plot_filename = [plotDir 'RSC_nTypesOfProportions_0-' allTxtEnds{j}];
    plotpos = [0 0 25 15];
    print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
    print_in_A4(0, plot_filename, '-depsc', 0, plotpos);
    
    
end





end
