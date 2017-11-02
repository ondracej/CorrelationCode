function [] = makeBarplotForACLags()



gausACs = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/AudACsGauss.mat');
gAC = gausACs.AC;

rawACs = load('/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/AudACs.mat');

plotDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/Plots/AC_AudData-notGaus/';


AC = rawACs.AC;
lags_ms = AC.lags_ms;
scanrate = AC.scanrate;

finalMean = nanmean(AC.allMeanACs_Aud);
finalstd = nanstd(AC.allMeanACs_Aud);

figH = figure(100); clf
plot(lags_ms, finalMean, 'k', 'linewidth', 1.5);
hold on
plot(lags_ms, finalMean+finalstd, 'r');
hold on
plot(lags_ms, finalMean-finalstd, 'r');

axis tight
xlim([-25 25]); ylim([-.003 .01])
xlabel(['Time lag [ms]'])
title(['Final Mean AC'])
set(gca, 'xminortick', 'on')
grid minor
%%
figure(figH)
plot_filename = [plotDir 'FinalMeanAClarge'];
plotpos = [0 0 10 12];
print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);

% Lowest point is around 1.5ms (1.59 ms)
%%

timeWin_ms_right = 100;
timeWin_ms_left = 1;

timeWin_samp_right = round(timeWin_ms_right/1000*scanrate );
timeWin_samp_left = round(timeWin_ms_left/1000*scanrate );

roi = (30031+timeWin_samp_left:30031+timeWin_samp_right);
Lags3to10msRL = lags_ms(roi);

%%

ACvalsROI = AC.allMeanACs_Aud(:, roi);
time_ms = [];
for j = 1:size(ACvalsROI);
    
    %thisAC = ACvalsROI(j,:) - mean(ACvalsROI(j,:));
    thisAC = ACvalsROI(j,:);
    
    %offsetmean = nanmean(ACvalsROI(1:10));
    %offset = 0-offsetmean;
    
    %thisAC =  thisAC + offset;
    
    %figure(100);clf
    %plot(Lags3to10msRL, thisAC); axis tight
    
    %thesh = 100*mean(thisAC(1:10));
    thesh = nanstd(thisAC);
    
    [pks,locs,w,p]= findpeaks(thisAC, 'MinPeakHeight',0, 'MinPeakWidth',.8);
    %[pks,locs,w,p]= findpeaks(thisAC, 'MinPeakHeight',thesh, 'MinPeakProminence',1);
    if isempty(locs)
        time_ms(j) = nan;
    else
        hold on
        %plot(Lags3to10msRL(locs(1)), thisAC(locs(1)), 'rv'); axis tight
        time_ms(j) = Lags3to10msRL(locs(1)) +1 ; % add 1 sice we are only looking after 1 ms
    end
    %pause
    
end

naninds = sum(isnan(time_ms));
t_msMean = nanmean(time_ms);
stdMean = nanstd(time_ms);
semMean = stdMean/ (sqrt(numel(time_ms) -   naninds));

%%
rng(8)
figH = figure(200); clf
line([-1 2],[ 1 1])
hold on
boxplot(time_ms, 'whisker', 0, 'symbol', 'ko', 'outliersize', 5,  'jitter', 0.3, 'colors', [0 0 0])
ylabel('Time lag (ms)')
title(['Mean lag = ' num2str(t_msMean) '\pm' num2str(semMean) ])
ylim([0 26])

figure(figH)
plot_filename = [plotDir 'FinalMeanBoxplot'];
plotpos = [0 0 10 20];
print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
print_in_A4(0, plot_filename, '-depsc', 0, plotpos);


%%


% inds to use 120, 57, 19, 113
inds = find(time_ms ==9.691);

allInds = [120, 57, 19, 113];
%%

col = [.5 .5 .5];
for p = 1:numel(allInds)
    
    
    inds = allInds(p);
    
    thisIndMean = gAC.allMeanACs_Aud(inds,:);
    thisIndSEM = gAC.allSemsACs_Aud (inds,:);
    thisLags = gAC.lags_ms;
    
    
    DataFiles_Aud_ind = gAC.allDataFiles_Aud(inds);
    DataChans_Aud_ind = gAC.allDataChans_Aud(inds);
    
    %%
    figH = figure(200); clf
    ttileTxt = [DataFiles_Aud_ind{:} ' Ch-' num2str(DataChans_Aud_ind{:})  ' mean = ' num2str(time_ms(inds))];
    savetxt = [DataFiles_Aud_ind{:} ' Ch-' num2str(DataChans_Aud_ind{:})];
    
    
    %plot(thisLags, smooth(thisIndMean, smoothWin_samps));
    
    plot(lags_ms, thisIndMean+thisIndSEM, 'color', col );
    hold on
    plot(lags_ms, thisIndMean-thisIndSEM, 'color', col );
    hold on
    plot(thisLags, thisIndMean, 'k', 'linewidth', 1);
    hold on
    line([-100 100], [0 0])
    xlim([-100 100]); ylim([-.005 .05])
    title(ttileTxt)
    xlabel('Time lag (ms)')
    %%
    plot_filename = [plotDir 'Example-' savetxt];
    plotpos = [0 0 10 5];
    print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
    print_in_A4(0, plot_filename, '-depsc', 0, plotpos);
    
end

disp('')
end
