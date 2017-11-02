dbstop if error
%44, 47, 79, 80,81
for oo = 1:83
    if oo == 44 || oo == 47 || oo == 79 || oo == 80 || oo == 81
        continue
    else
        
        birdObj = birdDataAnalysis(oo);
        
        %%
        audData = loadSpectralData(birdObj);
        
        plotRastersForMotifs(birdObj, audData)
        plotRastersForSpont(birdObj, audData)
        
        plotRastersForStim(birdObj, audData, 12)
        %%
        %
        BinWidth = 15;
        
        %binnedData_stim = binSpikesForStimulus(birdObj, BinWidth);
        binnedData_motifs = binSpikesForMotifs(birdObj, BinWidth);
        binnedData_spont = binSpikesForSpont(birdObj, BinWidth);
        
        %% Dprimes
        %2 = spont, 3 = motifs,
        allDPrimes_spont = calcDPRimesOnBins(birdObj, binnedData_spont, 2);
        allDPrimes_motif = calcDPRimesOnBins(birdObj, binnedData_motifs, 3);
        
        %% CorrCoef on Binned Data
        CC_motif = calcCCOnBins(birdObj, binnedData_motifs, 3);
        CC_spont = calcCCOnBins(birdObj, binnedData_spont, 2); % right now, this will not calc corrs for chans that are incmplete
        %}
    end
    
end