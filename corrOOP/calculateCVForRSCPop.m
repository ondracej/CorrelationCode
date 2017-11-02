function [] = calculateCVForRSCPop()


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


ms10 = load([ baseDir 'SortedData/WNSpontOrStim-1s/AudSpkData/10msRSC_INFO.mat']);
ms50 = load([baseDir 'SortedData/WNSpontOrStim-1s/AudSpkData/50msRSC_INFO.mat']);
ms100 = load([ baseDir 'SortedData/WNSpontOrStim-1s/AudSpkData/100msRSC_INFO.mat']);
ms200 = load([baseDir 'SortedData/WNSpontOrStim-1s/AudSpkData/200msRSC_INFO.mat']);


disp('');

% CV_Stim_10ms = ms10.metaRSC.CV_Stim;
% CV_Spont_10ms = ms10.metaRSC.CV_Spont;
%
% CV_Stim_50ms = ms50.metaRSC.CV_Stim;
% CV_Spont_50ms = ms50.metaRSC.CV_Spont;
%
% CV_Stim_100ms = ms100.metaRSC.CV_Stim;
% CV_Spont_100ms = ms100.metaRSC.CV_Spont;
%
% CV_Stim_200ms = ms200.metaRSC.CV_Stim;
% CV_Spont_200ms = ms200.metaRSC.CV_Spont;


CV_Stim_10ms = ms10.metaRSC.std_Stim;
CV_Spont_10ms = ms10.metaRSC.std_Spont;
CV_StimSig_10ms = ms10.metaRSC.std_StimSignal;

CV_Stim_50ms = ms50.metaRSC.std_Stim;
CV_Spont_50ms = ms50.metaRSC.std_Spont;
CV_StimSig_50ms = ms50.metaRSC.std_StimSignal;

CV_Stim_100ms = ms100.metaRSC.std_Stim;
CV_Spont_100ms = ms100.metaRSC.std_Spont;
CV_StimSig_100ms = ms100.metaRSC.std_StimSignal;

CV_Stim_200ms = ms200.metaRSC.std_Stim;
CV_Spont_200ms = ms200.metaRSC.std_Spont;
CV_StimSig_200ms = ms200.metaRSC.std_StimSignal;



stimSet = [1 4 6 7 8 9 12];

figH = figure(100); clf

for j = 1:4
    
    switch j
        case 1
            
            stim = CV_Stim_10ms;
            spont = CV_Spont_10ms;
            col = [0 0 0];
        case 2
            
            stim = CV_Stim_50ms;
            spont = CV_Spont_50ms;
            col = [0.2 0.2 0.2];
            
        case 3
            
            stim = CV_Stim_100ms;
            spont = CV_Spont_100ms;
            col = [0.4 0.4 0.4];
        case 4
            
            stim = CV_Stim_200ms;
            spont = CV_Spont_200ms;
            col = [0.6 0.6 0.6];
    end
    
    
    toPLot_stim = []; toPLot_spont = [];
    for k = 1:numel(stimSet)
        thisStim = stimSet(k);
        
        toPLot_stim(k) = stim{thisStim};
        toPLot_spont(k) = spont{thisStim};
        
    end
    
    
    figure(figH)
    
    hold on
    plot(toPLot_stim, 'color', col, 'marker', 'o')
    plot(toPLot_stim, 'color', col, 'linewidth', 2)
    
    plot(toPLot_spont, 'color', col, 'marker', 'v')
    plot(toPLot_spont, 'color', col, 'linewidth', 2)
    
    
end
axis tight
ylim([1 3.5])
xlim([.5 7.5])
ylabel('Coefficient Variation')

legtxt = {'10 ms', '50 ms', '100 ms', '200 ms'};
legend(legtxt)
legend('boxoff')


figure(figH)
plot_filename = [plotDir 'RSC_CV'];
plotpos = [0 0 20 10];
print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
print_in_A4(0, plot_filename, '-depsc', 0, plotpos);


%% Cumulative Dists of R Values

R_Stim_10ms = ms10.metaRSC.allRsThisStim;
R_Spont_10ms = ms10.metaRSC.allRsThisSpont;
R_StimSig_10ms = ms10.metaRSC.allRsThisStim_Signal;

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
        case 3
            
            stim = R_Stim_10ms;
            spont = R_Spont_10ms;
            signal = R_StimSig_10ms;
            col = [0 0 0];
            txtend = '10ms';
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

for j = 1:2
    
    switch j
        case 3
            
            stim = R_Stim_10ms;
            spont = R_Spont_10ms;
            signal = R_StimSig_10ms;
            col = [0 0 0];
            txtend = '10ms';
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
    
    for k = 1:numel(stimSet)
        thisStim1 = stimSet(k);
        
        thisStimR1 = stim{thisStim1};
        thisSignalR1 = signal{thisStim1};
        thisSpontR1 = spont{thisStim1};
        
        
        for kk = 1:numel(stimSet)
            thisStim2 = stimSet(kk);
            
            thisStimR2 = stim{thisStim2};
            thisSignalR2 = signal{thisStim2};
            thisSpontR2 = spont{thisStim2};
            
            
            
            [p_Noise(k, kk), h_Noise(k, kk)] = ranksum(thisStimR1, thisStimR2);
            [p_Signal(k, kk), h_Signal(k, kk)] = ranksum(thisSignalR1, thisSignalR2);
            [p_Spont(k, kk), h_Spont(k, kk)] = ranksum(thisSpontR1, thisSpontR2);
            
            
            
        end
    end
    
    
    
    
    
    
end






%% Sigs




%
%                             %jitterValuesY = 2*(rand(size(ALL_sumSpks_N2))-0.5)*jitterAmount;   % +/-jitterAmount max
%
%
%
%                             figure(figHH); clf
%                             scatterhist(jitterValuesX+ALL_sumSpks_N1, jitterValuesY+ALL_sumSpks_N2, 'Kernel', 'on', 'Location','SouthWest','Direction','in', 'Marker','.')
%
%
%
%         %[cx, cy] = hist(cumsig, binCenters);
%
%         %thisCumSum{k, 1} = cumsum(cx) ./ sum(cx);
%
%         subplot (7, 1, cnt)
%         stairs(cy, cx, 'k')
%         title([txtend '-Stim: ' num2str(k)])
%         %thisCumSum{k, 2} = cumsum(cx) ./ sum(cx);
%         hold on
%         [cx, cy] = hist(cumstim, binCenters);
%         %thisCumSum{k, 3} = cumsum(cx) ./ sum(cx);
%         stairs(cy, cx, 'r')
%         [cx, cy] = hist(cumspont, binCenters);
%         stairs(cy, cx, 'b')
%        cnt = cnt+1;


figure(fiH)
plot_filename = [plotDir 'RSCSigSpontHists-' txtend];
plotpos = [0 0 10 18];
print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
print_in_A4(0, plot_filename, '-depsc', 0, plotpos);



%% Relative proportions of neurons

for j = 1
    all_mismatch_NegNoise_PosSig = [];
    all_mismatch_PosNoise_NegSig = [];
    all_match_PosNoise_PosSig = [];
    all_match_NegNoise_NegSig = [];
    
    all_totalNegSigInds = [];
    all_totalPosSigInds = [];
    
    all_totalNegNoiseInds = [];
    all_totalPosNoiseInds = [];
    
    switch j
        case 3
            
            stim = R_Stim_10ms;
            spont = R_Spont_10ms;
            signal = R_StimSig_10ms;
            col = [0 0 0];
            txtend = '10ms';
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
    allTxtEnds{j} = txtend;
    
    nNegNoiseInds = []; nPosNoiseInds = [];
    nNegSigInds = [];nPosSigInds = [];
    mismatch_NegNoise_PosSig = []; mismatch_PosNoise_NegSig = [];
    match_PosNoise_PosSig = []; match_NegNoise_NegSig = [];
    
    for k = [1 4 6 7 8 9 12]
        thisStim = k;
        
        cumstim = stim{thisStim};
        cumsig = signal{thisStim};
        
        
        negNoiseInds = find(cumstim < 0);
        posNoiseInds = find(cumstim > 0);
        
        negSigInds = find(cumsig < 0);
        posSigInds =  find(cumsig > 0);
        
        %
%                 negNoiseInds = find(cumstim < -.1);
%                 posNoiseInds = find(cumstim > .1);
%                 
%                 negSigInds = find(cumsig < -.1);
%                 posSigInds =  find(cumsig > .1);
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
    
end

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



%% cum sums
figHH = figure(105); clf
cnt = 1;
pcnt = 1;
allCols = [];
alltexts = [];
allBlas = [];
for o = 1:7
    
    thisStim = stimSet(o);
    
    
    allBlas = [];
    for j = 1:2
        
        switch j
            case 5
                
                stim = R_Stim_10ms;
                spont = R_Spont_10ms;
                signal = R_StimSig_10ms;
                col = [0 0 0];
                txtend = '10ms';
            case 1
                
                stim = R_Stim_50ms;
                spont = R_Spont_50ms;
                signal = R_StimSig_50ms;
                %col = [0.2 0.2 0.2];
                col = [0.6 0.6 0.6];
                txtend = '50ms';
                
            case 2
                
                stim = R_Stim_100ms;
                spont = R_Spont_100ms;
                signal = R_StimSig_100ms;
                col = [0 0 0];
                
                %col = [0.4 0.4 0.4];
                txtend = '100ms';
            case 3
                
                stim = R_Stim_200ms;
                spont = R_Spont_200ms;
                signal = R_StimSig_200ms;
                col = [0.6 0.6 0.6];
                txtend = '200ms';
        end
        
        allCols{j} = col;
        alltexts{j} = txtend;
        
        for k = 1:3
            
            switch k
                
                case 1
                    thisdata = signal;
                    
                case 2
                    
                    thisdata = stim;
                    
                case 3
                    
                    thisdata = spont;
                    
            end
            
            %allBlas = [];
            
            thiscumdata = thisdata{thisStim};
            
            [cx, cy] = hist(thiscumdata, binCenters);
            
            bla = cumsum(cx) ./ sum(cx);
            
            allBlas{j, k} = bla;
        end
    end
    
    
    for pp = 1:size(allBlas, 2);
        figure(figHH)
        subplot(7, 3, pcnt)
        
        for p = 1:size(allBlas, 1)
            col = allCols{p};
            
            
            hold on
            
            plot(cy, allBlas{p, pp}, 'color', col)
            
            title(['-Stim: ' num2str(thisStim)])
            line([0 0], [0 1], 'color', 'k')
            
            if pp ==3
                if p == 1
                    Col = 'b';
                elseif p ==2
                    Col = 'r';
                end
                
                figure(200)
                hold on
                plot(cy, allBlas{p, pp}, 'color', Col )
            end
            
            
        end
        
        
        pcnt = pcnt+1;
    end
    
    
end

figure(figHH)
plot_filename = [plotDir 'RSCSigSpontcumsums-All'];
plotpos = [0 0 20 18];
print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
print_in_A4(0, plot_filename, '-depsc', 0, plotpos);



%%

a1 = toPLotStim{1,1}';
a2 = toPLotStim{2,1}';
a3 = toPLotStim{3,1}';
a4 = toPLotStim{4,1}';

b1 = toPLotStim{1,2}';
b2 = toPLotStim{2,2}';
b3 = toPLotStim{3,2}';
b4 = toPLotStim{4,2}';

c1 = toPLotStim{1,3}';
c2 = toPLotStim{2,3}';
c3 = toPLotStim{3,3}';
c4 = toPLotStim{4,3}';

group = [repmat({'REV-10'}, numel(a1), 1);   repmat({'REV-50'}, numel(a2), 1);      repmat({'REV-100'}, numel(a3), 1);  repmat({'REV-200'}, numel(a4), 1);
    repmat({'CON-10'}, numel(b1), 1);     repmat({'CON-50'}, numel(b2), 1);   repmat({'CON-100'}, numel(b3), 1);    repmat({'CON-200'}, numel(b4), 1);
    repmat({'BOS-10'}, numel(c1), 1);        repmat({'BOS-50'}, numel(c2), 1);      repmat({'BOS-100'}, numel(c3), 1);    repmat({'BOS-200'}, numel(c4), 1)];

%
figHH = figure(200); clf
%poss = [1 1.5 2.5 3 4 4.5 5.5 6 7 7.5 8.5 9 10 10.5 11.5 12];
poss = [1 2 3 4 6 7 8 9 11 12 13 14];
rng(4);
subplot(1, 2,1)
boxplot([a1;a2;a3; a4; b1; b2; b3; b4; c1; c2; c3; c4], group, 'whisker', 0, 'symbol', 'ko', 'outliersize', 4, 'jitter', 0.7, 'colors', [0 0 0], 'positions', poss)
ylabel(['Corr Coef R'])
ylim([-.5 1])

%

a1 = toPLotSpont{1,1}';
a2 = toPLotSpont{2,1}';
a3 = toPLotSpont{3,1}';
a4 = toPLotSpont{4,1}';

b1 = toPLotSpont{1,2}';
b2 = toPLotSpont{2,2}';
b3 = toPLotSpont{3,2}';
b4 = toPLotSpont{4,2}';

c1 = toPLotSpont{1,3}';
c2 = toPLotSpont{2,3}';
c3 = toPLotSpont{3,3}';
c4 = toPLotSpont{4,3}';

group = [repmat({'REV-10'}, numel(a1), 1);   repmat({'REV-50'}, numel(a2), 1);      repmat({'REV-100'}, numel(a3), 1);  repmat({'REV-200'}, numel(a4), 1);
    repmat({'CON-10'}, numel(b1), 1);     repmat({'CON-50'}, numel(b2), 1);   repmat({'CON-100'}, numel(b3), 1);    repmat({'CON-200'}, numel(b4), 1);
    repmat({'BOS-10'}, numel(c1), 1);        repmat({'BOS-50'}, numel(c2), 1);      repmat({'BOS-100'}, numel(c3), 1);    repmat({'BOS-200'}, numel(c4), 1)];

poss = [1 2 3 4 6 7 8 9 11 12 13 14];
rng(4);
subplot(1, 2,2)
boxplot([a1;a2;a3; a4; b1; b2; b3; b4; c1; c2; c3; c4], group, 'whisker', 0, 'symbol', 'ko', 'outliersize', 4, 'jitter', 0.7, 'colors', [0 0 0], 'positions', poss)
ylabel(['Corr Coef R'])
ylim([-.5 1])

%%
figure(figHH)
plot_filename = [plotDir 'RSC_BoxplotREV-BOSCON'];
plotpos = [0 0 30 15];
print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
print_in_A4(0, plot_filename, '-depsc', 0, plotpos);

%%


a1 = toPLotStim{1,1}';
a2 = toPLotStim{1,2}';
a3 = toPLotStim{1,3}';

b1 = toPLotStim{2,1}';
b2 = toPLotStim{2,2}';
b3 = toPLotStim{2,3}';

c1 = toPLotStim{3,1}';
c2 = toPLotStim{3,2}';
c3 = toPLotStim{3,3}';

d1 = toPLotStim{4,1}';
d2 = toPLotStim{4,2}';
d3 = toPLotStim{4,3}';


group = [repmat({'REV-10'}, numel(a1), 1);   repmat({'CON-10'}, numel(a2), 1);      repmat({'BOS-10'}, numel(a3), 1);  repmat({'REV-50'}, numel(b1), 1);
    repmat({'CON-50'}, numel(b2), 1);     repmat({'BOS-50'}, numel(b3), 1);   repmat({'REV-100'}, numel(c1), 1);    repmat({'CON-100'}, numel(c2), 1);
    repmat({'BOS-100'}, numel(c3), 1);        repmat({'REV-200'}, numel(d1), 1);      repmat({'CON-200'}, numel(d2), 1);    repmat({'BOS-200'}, numel(d3), 1)];

%
figH2 = figure(300); clf
%poss = [1 1.5 2.5 3 4 4.5 5.5 6 7 7.5 8.5 9 10 10.5 11.5 12];
poss = [1 2 3 5 6 7 9 10 11 13 14 15];
rng(1);
subplot(1, 2,1)
hA = boxplot([a1;a2;a3; b1; b2; b3; c1; c2; c3; d1; d2; d3], group, 'whisker', 0, 'symbol', 'ko', 'outliersize', 4, 'jitter', 0.0, 'colors', [0 0 0], 'positions', poss);
ylabel(['Corr Coef R'])
ylim([-.5 1])
yticks = [-.5:.25:1];
set(gca,'YTick',yticks)

grid on
%


a1 = toPLotSpont{1,1}';
a2 = toPLotSpont{1,2}';
a3 = toPLotSpont{1,3}';

b1 = toPLotSpont{2,1}';
b2 = toPLotSpont{2,2}';
b3 = toPLotSpont{2,3}';

c1 = toPLotSpont{3,1}';
c2 = toPLotSpont{3,2}';
c3 = toPLotSpont{3,3}';

d1 = toPLotSpont{4,1}';
d2 = toPLotSpont{4,2}';
d3 = toPLotSpont{4,3}';


group = [repmat({'REV-10'}, numel(a1), 1);   repmat({'CON-10'}, numel(a2), 1);      repmat({'BOS-10'}, numel(a3), 1);  repmat({'REV-50'}, numel(b1), 1);
    repmat({'CON-50'}, numel(b2), 1);     repmat({'BOS-50'}, numel(b3), 1);   repmat({'REV-100'}, numel(c1), 1);    repmat({'CON-100'}, numel(c2), 1);
    repmat({'BOS-100'}, numel(c3), 1);        repmat({'REV-200'}, numel(d1), 1);      repmat({'CON-200'}, numel(d2), 1);    repmat({'BOS-200'}, numel(d3), 1)];

%
figure(figH2);
%poss = [1 1.5 2.5 3 4 4.5 5.5 6 7 7.5 8.5 9 10 10.5 11.5 12];
poss = [1 2 3 5 6 7 9 10 11 13 14 15];
rng(1);
subplot(1, 2,2)
boxplot([a1;a2;a3; b1; b2; b3; c1; c2; c3; d1; d2; d3], group, 'whisker', 0, 'symbol', 'ko', 'outliersize', 4, 'jitter', 0.0, 'colors', [0 0 0], 'positions', poss)
ylabel(['Corr Coef R'])
ylim([-.5 1])
set(gca,'YTick',yticks)

grid on

%%
figure(figH2)
plot_filename = [plotDir 'RSC_Boxplot_REVBOSCON-ordered'];
plotpos = [0 0 30 15];
print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
print_in_A4(0, plot_filename, '-depsc', 0, plotpos);

%% CV test

bla1 = [2 2 3 2 3 3 2 3 2 3];
bla2 = [2 1 8 0 4 1 4 6 2 1];


mean_bla1 = mean(bla1);
mean_bla2 = mean(bla2);

std1 = std(bla1);
std2 = std(bla2);

cv1 = std1 / mean_bla1;
cv2 = std2 / mean_bla2;


end
