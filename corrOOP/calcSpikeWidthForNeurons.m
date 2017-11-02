function [] = calcSpikeWidthForNeurons()


dbstop if error


switch gethostname
    case 'turtle'
        
        spkDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpkShape/';
        saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/StimOrderedV2/';
        AudFile = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/Fr-Zscore/FR-Zscore_OnlyAud.mat';
        
    case 'deadpool'
        
        spkDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpkShape/';
        saveDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/StimOrdered/';
        AudFile = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/FR-Zscore/FR-Zscore_OnlyAud.mat';
end

if exist(saveDir, 'dir') == 0
    mkdir(saveDir);
end

SpkFiles = dir([spkDir '*.mat']);
nFiles = numel(SpkFiles);

nCnt = 1;

for j = 1:nFiles
    
    %% Check to make sure the files match
    
    d = load([spkDir SpkFiles(j).name]);
    
    disp(SpkFiles(j).name);
    
    allSpkShapes = d.SPKINFO.allShapes;
    nChans = numel(d.SPKINFO.rawChans);
    
    
    for k = 1:nChans
        
        spkShps{nCnt} = allSpkShapes{k};
        allChans(nCnt) = d.SPKINFO.rawChans(k);
        
        nCnt = nCnt+1;
        
    end
end


%% Only take the Aud spike inds

audInds = load(AudFile);

aInds = audInds.AudSorted.allAudInds;
allAudSpkShapes = spkShps(aInds);
allAudChans = allChans(aInds);

timepoints = 1:1:size(allAudSpkShapes{1}, 2);

timepoints_ms = (timepoints/d.SPKINFO.scanrate)*1000;
timepoints_us = timepoints_ms*1000;

midPoint = 61;

for j = 1:numel(allAudSpkShapes)
    
    theseShapes = allAudSpkShapes{j};
    
    %thisMean = median(theseShapes, 1);
    thisMean = mean(theseShapes, 1);
    
    spikeAlignment = thisMean(midPoint);
    %[minThisSnippet, indmin] = min(spikeAlignment, [], 1);
    
    if spikeAlignment < 0
        thisMean = thisMean * -1;
    end
    
    
    %[pks,locs,w,p] = findpeaks(thisMean(midPoint-10:midPoint+10), d.SPKINFO.scanrate, 'WidthReference', 'halfheight')
    [pks,locs,w,p] = findpeaks(thisMean(midPoint-20:midPoint+20),  'WidthReference', 'halfheight');
    
    if numel(p) >1
        [maxin, indTake] = max(p);
        w = w(indTake);
    end
    
    allWidths(j) = w;
    
    %bla = thisMean(midPoint-10:midPoint+10);
    
    %timepoints = 1:1:numel(bla);
    %timepoints_us = (timepoints/d.SPKINFO.scanrate)*1000;
    
    %figH = figure(100); clf;
    %plot(thisMean(midPoint-20:midPoint+20))
    %axis tight
    
    allMeans{j} = thisMean;
    
    
    %plot(timepoints_us, theseShapes)
    %hold on
    %plot(timepoints_us, thisMean, 'k', 'linewidth', 2)
    %axis tight
    %
    
    %     figure(100); clf;
    %     plot(theseShapes)
    %     hold on
    %     plot(thisMean, 'k', 'linewidth', 2)
    %     axis tight
    
    
    [minPoint, minInd] = min(thisMean, [], 2);
    
    allMinINds(j) = minInd;
    sampsAfterMin = thisMean(minInd:end);
    
    [maxPoint, maxInd] = max(sampsAfterMin, [], 2);
    
    maxIndCor = maxInd+minInd-1; % We do this since the sencodn is rel to the first
    
    width_ms(j) = (maxIndCor-minInd)/d.SPKINFO.scanrate*1000;
    allMinPoints(j) = minPoint;
    allMaxPoints(j) = maxPoint;
    
    
%     hold on
%     plot(timepoints_us(minInd), minPoint, 'rv', 'linewidth', 2)
%     plot(timepoints_us(maxIndCor), maxPoint, 'rv', 'linewidth', 2)
%     
%    pause
    
end

width_us = width_ms*1000;
%[idx, C] = kmeans(width_us', 2);
[idx, C] = kmeans(allWidths', 2);

if C(1) < C(2)
    short = 1;
    long = 2;
else
    short = 2;
    long = 1;
end

longSpkInds = find(idx ==long);
shortSpkInds = find(idx ==short);

LongWidths_us = width_us(longSpkInds);
ShortWidths_us = width_us(shortSpkInds);

LongWidths_us = allWidths(longSpkInds);
ShortWidths_us = allWidths(shortSpkInds);

LongPeakTrough = allMinPoints(longSpkInds);
ShortPeakTrough = allMinPoints(shortSpkInds);

longMedians = allMeans(longSpkInds)';
shortMedians = allMeans(shortSpkInds)';



%%
figure(200); clf

plot(LongWidths_us, LongPeakTrough, 'k*')
hold on

plot(ShortWidths_us, ShortPeakTrough, 'r*')
xlim([0 1000])
ylim([-3000 0])


%%
figure(200); clf

subplot(2, 1,1)
for j = 1:numel(longMedians)
    hold on
    plot(longMedians{j})
    axis tight
    ylim([-2500 2000])
end

subplot(2, 1,2)
for j = 1:numel(shortMedians)
    hold on
    plot(shortMedians{j})
    axis tight
    ylim([-2500 2000])
end




%%
binC = 0:.25:30;

%figure(100); clf; hist(width_us', binC);

figure(100); clf; hist(allWidths', binC);

%%
subplot(1, 2, 1)
boxplot(LongMeans, 'whisker', 0, 'symbol', 'k*', 'outliersize', 4,  'jitter', 0.3, 'colors', [0 0 0])
ylim([0 1000])
%ylabel('Euclidian Distance')
%legtxt = ['mean = ' num2str(roundn(nonmvmtnMeans, -2))];
%text(0.90, 18, legtxt)
%xticklables = {'NoMvmt'};
%set(gca, 'xticklabels', xticklables)

subplot(1, 2, 2)
boxplot(ShortMeans, 'whisker', 0, 'symbol', 'r*', 'outliersize', 4,  'jitter', 0.3, 'colors', [0 0 0])
ylim([0 1000])
%ylabel('Euclidian Distance')


disp('')


spkpercent = 1;

% take 30 % of spikes to make an average
nSpikes = size(spkShps_thisChan, 2);
nspksPercent = ceil(nSpikes*spkpercent );

%for o = 1:1

randSel = randperm(nSpikes);

radnThisSel = randSel(1:nspksPercent);
spkShapeSel = spkShps_thisChan(:, radnThisSel);

% Analysis
meanShape_thisChan = mean(spkShapeSel, 2);

maxpeak = max(meanShape_thisChan);
minpeak = min(meanShape_thisChan);

if abs(minpeak) > abs(maxpeak)
    meanShape_thisChan = meanShape_thisChan*-1;
end

diffShape = diff(meanShape_thisChan);

spkthesh_all = find(diffShape > 9);
spkthesh = meanShape_thisChan(spkthesh_all(1));

figure; plot(meanShape_thisChan)

%
overthresh = find(meanShape_thisChan > spkthesh);


peakWidth(spk_cnt) = numel(overthresh)/scanrate*1000;

%meandiff = diff(meanShape_thisChan);

%figure; plot(meanShape_thisChan, 'k')
%hold on; plot(meandiff, 'g')

%meanSubShape_thisChan  = meanShape_thisChan  - mean(meanShape_thisChan );

%[spkPeak, spkLocs, w_halfHeight, p] = findpeaks(meanShape_thisChan, 'widthreference', 'halfheight');
%[~, ~, w_halfprom] = findpeaks(meanShape_thisChan, 'widthreference', 'halfprom');

%[maxP Minds] = max(p);

%meanShape_all{spk_cnt} = meanShape_thisChan;
%spkLoc_all(spk_cnt) = spkLocs(Minds);
%spkPeak_all(spk_cnt) = spkPeak(Minds);
%w_halfHeight_all(spk_cnt) = w_halfHeight(Minds);
%w_halfprom_all(spk_cnt) = w_halfprom(Minds);

spk_cnt = spk_cnt+1;
%  end

end



