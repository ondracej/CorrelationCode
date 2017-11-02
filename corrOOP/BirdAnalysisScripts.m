

%% Remapping of REV & BOS Syllables



remap_BOS_REV_SyllableStims()




 %% Create object
 %11 = g18r2
 % 25 = o1r4 07
 clear all
birdObj = birdDataAnalysis(25);
audData = loadSpectralData(birdObj);

%%
plotMotifSpectrogramsAndRawData(birdObj, audData, 8)

%% Constructor does this

%birdObj = getTriggerInfo(birdObj);
%birdObj = getSpikesTimes(birdObj);
%birdObj = getSpikesTimes(birdObj);

%% Extras for spectrogram


timewarpMotifSpecs(birdObj, audData)

%plotMotifSylSpectrograms(birdObj, audData)
plotRastersForMotifSyllables(birdObj, audData)


plotRastersForMotifs(birdObj, audData)
plotRastersForSpont(birdObj, audData, 5)

plotRastersForStim(birdObj, audData, 8)

plotRastersForSpontSingleStim(birdObj, audData, 1)

plotMotifSpectrograms(birdObj, audData)



plotMotifSpectrogramsTimeWarping(birdObj, audData)

%% Plot motifs to correct alignemnt points
%plotMotifSpectrograms(birdObj, audData)

%% Plot motifs to check CON alignemnt points
plotCONMotifSpectrograms(birdObj, audData)

% 1 Stims, 2 = spont, 3 = motifs, 4 = con

%% Bin Stims
BinWidth = 15;

binnedData_stim = binSpikesForStimulus(birdObj, BinWidth);
binnedData_motifs = binSpikesForMotifs(birdObj, BinWidth);
binnedData_spont = binSpikesForSpont(birdObj, BinWidth);

%% Dprimes
%2 = spont, 3 = motifs,
allDPrimes_spont = calcDPRimesOnBins(birdObj, binnedData_spont, 2);
allDPrimes_motif = calcDPRimesOnBins(birdObj, binnedData_motifs, 3);

%% FR

FR = calcFROnBins(birdObj, binnedData_motifs, 3)
%% CorrCoef on Binned Data

% need to fix remapping of stim names. 
CC_motif = calcCCOnBins(birdObj, binnedData_motifs, 3);
CC_spont = calcCCOnBins(birdObj, binnedData_spont, 2); % right now, this will not calc corrs for chans that are incmplete
CC_stims = calcCCOnBins(birdObj, binnedData_stim, 1);


%%


