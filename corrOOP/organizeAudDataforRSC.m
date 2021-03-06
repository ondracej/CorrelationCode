function [] = organizeAudDataforRSC()

dbstop if error

doStim =1; % 1 stim, 2 = spont
imgclims = [-1 1];

binSize_ms = 200;
texttime = [num2str(binSize_ms) 'ms'];

figH = figure(100);
figHH = figure(200);
doPLot = 0;

switch gethostname
    case 'turtle'
        
        sortedStimDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/StimOrdered/';
        sortedSpontDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontOrdered/';
        saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/';
        
        AudFile = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/Fr-Zscore/FR-Zscore_OnlyAud.mat';
        plotDir = ['/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/Plots/' texttime '-SpikeCntsStims/'];
        
    case 'deadpool'
        
        sortedStimDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/StimOrdered/';
        sortedSpontDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontOrdered/';
        saveDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/';
        
        AudFile = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/FR-Zscore/FR-Zscore_OnlyAud.mat';
        plotDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/RSCPlots/';
        
end


if exist(saveDir, 'dir') == 0
    mkdir(saveDir);
end

if exist(plotDir, 'dir') == 0
    mkdir(plotDir);
end


if doStim == 1
    StimFiles = dir([sortedStimDir '*.mat']);
    nFiles  = numel(StimFiles);
    allSpikesCntsOrderd_Stim = []; allSpikesOrderd_Stim = [];
    textbeg = 'RSC-Stim-';
elseif doStim  == 2
    SpontFiles = dir([sortedSpontDir '*.mat']);
    nFiles  = numel(SpontFiles);
    allSpikesOrderd_Spont = []; allSpikesCntsOrderd_Spont = [];
    textbeg = 'RSC-Spont-';
end

nCnt = 1;
ntestcnt = 1;

allDataFiles = []; allDataChans = []; dataChanSpkInds = [];

a = load(AudFile);
neuronInds = a.AudSorted.allAudInds;
AudNeuronNames = a.AudSorted.allDataChans_Aud;
AudDatFiles = a.AudSorted.allDataFiles_Aud;

for j = 1:nFiles
    
    if doStim == 1
        dStim = load([sortedStimDir StimFiles(j).name]);
        thisData= dStim.Sorted;
        scanrate = dStim.INFO.scanrate;
    elseif doStim == 2
        dSpont = load([sortedSpontDir SpontFiles(j).name]);
        thisData = dSpont.Sorted;
        scanrate = dSpont.INFO.scanrate;
    end
    
    dataFiles = thisData.allrawDataFiles;
    dataChans = thisData.allNeurons;
    dataChanSpkInds = thisData.allSpkInd;
    
    
    disp([dataFiles{1} ' = ' num2str(j)]);
    nNeurons = numel(dataChans);
    if nNeurons  ==1
        disp('Single neuron, skipping...')
    end
    
    
    %% This only makes sense to calculate when there are more than 1 neurons
    %so if nNeurons == 1, we should skip
    
    match = [];
    for k = 1:nNeurons
        
        match(k)  = ismember(ntestcnt, neuronInds);
        ntestcnt= ntestcnt +1;
        
    end
    
    if sum(match) > 1 % some of the neurons match
        
        notMatch = ~match;
        dataChans(notMatch) = []; % should do this in case there is a 0 1 1 match
        dataChanSpkInds(notMatch) = [];
        nNeurons = numel(dataChans);
        
        %% First order all the data for the ensembl
        allSpikesCntsOrdered = []; allSpikesOrdered = [];
        
        for k = 1:nNeurons
            
            %% checkthis
            
            allDataFiles{nCnt} = dataFiles{k};
            allDataChans{nCnt} = dataChans(k);
            allDataSpkInds{nCnt} = dataChanSpkInds(k);
            
            Lengths_s_Ordered_Stim = thisData.allLengths_sOrdered(k,:);
            song_set = find(cellfun(@(x) ~isempty(x), Lengths_s_Ordered_Stim));
            nStims = numel(song_set);
            
            for o = 1:nStims
                thisStim = song_set(o);
                
                allSpikesCntsOrdered{k,thisStim} =  thisData.allSpikesCntsOrdered{k, thisStim};
                allSpikesOrdered{k,thisStim} = thisData.allSpikesOrdered{k, thisStim};
                %allSpikesOrderd{k,thisStim} = thisData.allGaussSmoothOrdered{k, thisStim};
                
            end
            nCnt = nCnt+1;
            
        end
        
        binSize_samp = round(binSize_ms/1000*scanrate);
        
        for o = 1:nStims
            
            chanComparisons_P = []; chanComparisons_R = [];
            chanComparisons_R_matrix = [];
            posCorrs = []; negCorrs = [];
            allRepsCorrs_R = []; allRepsCorrs_P = [];
            all_CompSumSpksN1_N2 = [];
            
            ID_chanComparisons_P = []; ID_chanComparisons_R = [];
            ID_chanComparisons_R_matrix = [];
            ID_posCorrs = []; ID_negCorrs = [];
            ID_allRepsCorrs_R = []; ID_allRepsCorrs_P = [];
            ID_all_CompSumSpksN1_N2 = [];
            
            allRepsCorrs_R_Signal = [];
            allRepsCorrs_P_Signal = [];
            
            allFRMeans_Signal_N1 = [];
            allFRMeans_Signal_N2 = [];
            
            allFRStds_Signal_N1 = [];
            allFRStds_Signal_N2 = [];
            
            ID_allRepsCorrs_R_Signal = [];
            ID_allRepsCorrs_P_Signal = [];
            
            ID_allFRMeans_Signal_N1 = [];
            ID_allFRMeans_Signal_N2 = [];
            
            ID_allFRStds_Signal_N1 = [];
            ID_allFRStds_Signal_N2 = [];
                            
            
            thisStim = song_set(o);
            
            for i = 1:nNeurons
                
                thisChan1 = dataChanSpkInds(i);
                n1Data = allSpikesOrdered{i,thisStim};
                
                for ii = 1:nNeurons
                    thisChan2 = dataChanSpkInds(ii);
                    n2Data = allSpikesOrdered{ii,thisStim};
                    
                    
                    if i > ii || isempty(n1Data)
                        continue
                    else
                        
                        %% Reorganize all the data:
                        
                        titletxt = [dataFiles{1} ' | ' textbeg num2str(thisStim) ' | N-' num2str(dataChanSpkInds(i)) ' & N-' num2str(dataChanSpkInds(ii)) ' | CC | binsize = ' num2str(binSize_ms) 'ms'];
                        savetxt = [dataFiles{1} '-' textbeg num2str(thisStim) '_N-' num2str(dataChanSpkInds(i)) '-N-' num2str(dataChanSpkInds(ii)) '_CC_bin-' num2str(binSize_ms) 'ms'];
                        
                        nReps = size(n1Data, 2);
                        nUnique = size(n1Data, 1);
                        
                        P_UniqueStims = []; R_UniqueStims = []; buffLength_bins = [];
                        allSumSpksN1 = []; allSumSpksN2 = [];
                        all_SumSpks_N1 = []; all_SumSpks_N2 = [];
                        
                           allMeans_Sig_N1 = []; allMeans_Sig_N2 = [];
                            allStd_Sig_N1 = []; allStd_Sig_N2 = [];
                            
                        for U = 1:nUnique
                            
                            thisData1 = n1Data(U, :);
                            thisData2 = n2Data(U, :);
                            
                            rehapedN1 = cell2mat(thisData1');
                            rehapedN2 = cell2mat(thisData2');
                            
                            
                            %%
                            
                            nCompleteBins = floor(size(rehapedN1, 2) /  binSize_samp);
                            dataLengthCompleteBins = binSize_samp*nCompleteBins;
                            
                            
                            diffDataLength_s = (size(rehapedN1, 2) - dataLengthCompleteBins) / scanrate;
                            
                            
                            %% Calc for Singal Corr
                            SizeComplete_s = (size(rehapedN1(1:dataLengthCompleteBins), 2)) / scanrate;
                            
                            sumForSigSpks_N1 = sum(rehapedN1(:,1:dataLengthCompleteBins), 2);
                            sumForSigSpks_N2 = sum(rehapedN2(:,1:dataLengthCompleteBins), 2);
                            
                            FR_ForSigSpls_N1_mean = nanmean(sumForSigSpks_N1/SizeComplete_s);
                            FR_ForSigSpls_N2_mean = nanmean(sumForSigSpks_N2/SizeComplete_s);
                            
                            FR_ForSigSpls_N1_std = nanstd(sumForSigSpks_N1/SizeComplete_s);
                            FR_ForSigSpls_N2_std = nanstd(sumForSigSpks_N2/SizeComplete_s);
                            
                            %% Should do this for the same lengths
                            allMeans_Sig_N1(U) = FR_ForSigSpls_N1_mean;
                            allMeans_Sig_N2(U) = FR_ForSigSpls_N2_mean;
                            
                            allStd_Sig_N1(U) = FR_ForSigSpls_N1_std;
                            allStd_Sig_N2(U) = FR_ForSigSpls_N2_std;
                            
                            
                            buffN1 = []; buffN2 = [];
                            for R = 1:nReps
                                
                                % No Overlap
                                buffN1{R} = buffer(rehapedN1(R,1:dataLengthCompleteBins), binSize_samp);
                                buffN2{R} = buffer(rehapedN2(R,1:dataLengthCompleteBins), binSize_samp);
                            end
                            
                            sumSpksN1 = []; sumSpksN2 = [];
                            % These are the sums of spikes in 5ms bins
                            for R = 1:nReps
                                sumSpksN1(R,:) = sum(buffN1{R}, 1);
                                sumSpksN2(R,:) = sum(buffN2{R}, 1);
                            end
                            
                            allSumSpksN1{U} = sumSpksN1(1:end-1);
                            allSumSpksN2{U} = sumSpksN2(1:end-1);
                            buffLength_bins(U) = size(sumSpksN1, 2);
                            
                            allPs = []; allRs = [];
                            if thisStim ~=7
                                for qq = 1: buffLength_bins(U)
                                    
                                    [r, p] = corrcoef(sumSpksN1(:,qq), sumSpksN2(:,qq));
                                    allPs(qq) = p(1, 2);
                                    allRs(qq) = r(1, 2);
                                end
                            end
                            
                            P_UniqueStims{U} = allPs;
                            R_UniqueStims{U} = allRs;
                            
                            %%
                            %Re_allSumSpksN1 = cell2mat(allSumSpksN1');
                            %Re_allSumSpksN2 = cell2mat(allSumSpksN2');
                            
                            Re_allSumSpksN1 = reshape(sumSpksN1, 1, numel(sumSpksN1));
                            Re_allSumSpksN2 = reshape(sumSpksN2, 1, numel(sumSpksN2));
                            
                            meanN1 = nanmean(Re_allSumSpksN1);
                            meanN2 = nanmean(Re_allSumSpksN2);
                            
                            stdN1 = nanstd(Re_allSumSpksN1);
                            stdN2 = nanstd(Re_allSumSpksN2);
                            
                            ZSpksN1 = (Re_allSumSpksN1 - meanN1) / stdN1;
                            ZSpksN2 = (Re_allSumSpksN2 - meanN2) / stdN2;
                            
                            all_SumSpks_N1{U} = Re_allSumSpksN1;
                            all_SumSpks_N2{U} = Re_allSumSpksN2;
                            
                        end
                        
                        %% Signal
                        
                        
                        allMeans_Sig_N1(U) = FR_ForSigSpls_N1_mean;
                        allMeans_Sig_N2(U) = FR_ForSigSpls_N2_mean;
                        
                        allStd_Sig_N1(U) = FR_ForSigSpls_N1_std;
                        allStd_Sig_N2(U) = FR_ForSigSpls_N2_std;
                        
                        
                        [RR_sig, PP_sig] = corrcoef(allMeans_Sig_N1, allMeans_Sig_N2);
                        Rround_sig = round(RR_sig(1, 2), 4);
                        Pround_sig = round(PP_sig(1, 2), 4);
                        
                        
                        if doPLot
                            
                            figT = figure(231); clf
                            
                            plot(allMeans_Sig_N1, allMeans_Sig_N2, 'ko');
                            
                            for b = 1:numel(allStd_Sig_N1)
                                % N1 is on the x axis
                                hold on
                                line([allMeans_Sig_N1(b)-allStd_Sig_N1(b) allMeans_Sig_N1(b)+allStd_Sig_N1(b)], [allMeans_Sig_N2(b) allMeans_Sig_N2(b)], 'color', 'k')
                                line([allMeans_Sig_N1(b) allMeans_Sig_N1(b)], [allMeans_Sig_N2(b)-allStd_Sig_N2(b) allMeans_Sig_N2(b)+allStd_Sig_N2(b)], 'color', 'k')
                            end
                            
                            axis tight
                            
                            yssy = ylim;
                            yssx = xlim;
                            
                          maxx = max(yssx);
                          maxy = max(yssy);
                            
                          theMax = max([maxx maxy]);
                          
                          ylim([0 ceil(theMax)+1])
                          xlim([0 ceil(theMax)+1])
                          
                            xlabel(['Neuron ' num2str(thisChan1) ' FR (Hz)'])
                            ylabel(['Neuron ' num2str(thisChan2) ' FR (Hz)'])
                            
                            title([titletxt ' | Signal R = ' num2str(Rround_sig) ',  p = ' num2str(Pround_sig)])
                            
                            figure(figT)
                            plot_filename = [plotDir savetxt '-Signal_scatter'];
                            plotpos = [0 0 20 15];
                            %print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
                            print_in_A4(0, plot_filename, '-depsc', 0, plotpos);
                            disp(plot_filename)
                            
                        end
                        
                        ALL_sumSpks_N1 = []; ALL_sumSpks_N2 = [];
                        for c = 1:numel(all_SumSpks_N1)
                            
                            ALL_sumSpks_N1 = [ALL_sumSpks_N1  all_SumSpks_N1{c}];
                            ALL_sumSpks_N2 = [ALL_sumSpks_N2  all_SumSpks_N2{c}];
                        end
                        
                        [RR, PP] = corrcoef(ALL_sumSpks_N1, ALL_sumSpks_N2);
                        
                        Rround = round(RR(1, 2), 4);
                        Pround = round(PP(1, 2), 4);
                        
                        CompSumSpksN1_N2 = [ALL_sumSpks_N1 ; ALL_sumSpks_N2];
                        
                        %% Z score
                        %jitterValuesX = 2*(rand(size(ZSpksN1))-0.5)*jitterAmount;   % +/-jitterAmount max
                        %jitterValuesY = 2*(rand(size(ZSpksN2))-0.5)*jitterAmount;   % +/-jitterAmount max
                        %scatterhist(jitterValuesX+ZSpksN1, jitterValuesY+ZSpksN2, 'Kernel', 'on', 'Location','SouthEast','Direction','out')
                        %xlim([-5 5])
                        %ylim([-5 5])
                        %% Spks
                        if doPLot
                            jitterAmount = 0.35;
                            jitterValuesX = 2*(rand(size(ALL_sumSpks_N1))-0.5)*jitterAmount;   % +/-jitterAmount max
                            jitterValuesY = 2*(rand(size(ALL_sumSpks_N2))-0.5)*jitterAmount;   % +/-jitterAmount max
                            
                            figure(figHH); clf
                            scatterhist(jitterValuesX+ALL_sumSpks_N1, jitterValuesY+ALL_sumSpks_N2, 'Kernel', 'on', 'Location','SouthWest','Direction','in', 'Marker','.')
                            xlabel(['Neuron ' num2str(thisChan1) ' spikes'])
                            ylabel(['Neuron ' num2str(thisChan2) ' spikes'])
                            xlim([-1 11])
                            ylim([-1 11])
                            
                            hold on
                            plot(meanN1, meanN2, 'ko', 'MarkerFaceColor', 'k')
                            title([titletxt ' | R = ' num2str(Rround) ',  p = ' num2str(Pround)])
                            
                            figure(figHH)
                            plot_filename = [plotDir savetxt '-scatter'];
                            plotpos = [0 0 15 15];
                            %print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
                            print_in_A4(0, plot_filename, '-depsc', 0, plotpos);
                            disp(plot_filename)
                            
                        end
                        
                        
                        %bla = fit_ellipse(jitterValuesX+Re_allSumSpksN1, jitterValuesY+Re_allSumSpksN2)
                        
                        maxLength = max(buffLength_bins);
                        
                        %% Make zero padded array
                        thisBinnedStimZ = [];
                        if thisStim ~=7
                            for q = 1:numel(R_UniqueStims)
                                thisBinnedStim = R_UniqueStims{q};
                                
                                diff = [];
                                if size(thisBinnedStim, 2) < maxLength
                                    diff = zeros(1, maxLength - size(thisBinnedStim, 2)) ;
                                    thisBinnedStimZ(q,:) = [thisBinnedStim diff];
                                else
                                    thisBinnedStimZ(q,:) = [thisBinnedStim];
                                end
                            end
                        end
                        
                        cellmat_zero = thisBinnedStimZ;
                        
                        nanind = isnan(cellmat_zero);
                        cellmat_zero(nanind) = 0;
                        
                        %{
                        if doPLot
                            if thisStim ~=7
                                figure(figH); clf
                                imagesc(cellmat_zero, imgclims)
                                colormap('gray')
                                axis tight
                                xlim
                                xlabel(['Bins [' texttime ']'])
                                ylabel('Unique Stims')
                                title(titletxt)
                                
                                figure(figH)
                                plot_filename = [plotDir savetxt];
                                plotpos = [0 0 15 12];
                                %print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
                                print_in_A4(0, plot_filename, '-depsc', 0, plotpos);
                                disp(plot_filename)
                            end
                            
                        end
                        %}
                        %%
                        %{
                        for JJ = 1:numel(R_UniqueStims);
                            allRsThisRep = R_UniqueStims{1, JJ};
                            
                            repLengths = size(allRsThisRep, 2);
                            hold on
                            plot(allRsThisRepJJ, 'ko', 'MarkerFaceColor', 'k');
                            %plot(smooth(allRsThisRep +JJ), 'k-');
                            hold on
                            %line([repLengths repLengths],  [JJ+.5 JJ+1.5], 'color', 'k')
                            line([repLengths repLengths],  [JJ-1+.5 JJ-1-.5], 'color', 'k');
                            %line([0 0],  [JJ+1 JJ+1.5], 'color', 'k')
                        end
                        %}
                        
                        if thisChan1 == thisChan2
                            
                            ID_chanComparisons_P{thisChan1, thisChan2} = P_UniqueStims;
                            ID_chanComparisons_R{thisChan1, thisChan2} = R_UniqueStims;
                            
                            ID_chanComparisons_R_matrix{thisChan1, thisChan2} = thisBinnedStimZ;
                            
                            ID_posCorrs{thisChan1, thisChan2} = numel(find(cellmat_zero >0));
                            ID_negCorrs{thisChan1, thisChan2} = numel(find(cellmat_zero <0));
                            
                            ID_allRepsCorrs_R{thisChan1, thisChan2} =  RR(1, 2);
                            ID_allRepsCorrs_P{thisChan1, thisChan2} =  PP(1, 2);
                            
                            ID_all_CompSumSpksN1_N2{thisChan1, thisChan2} = CompSumSpksN1_N2;
                            
                            %% Signal
                            
                            ID_allRepsCorrs_R_Signal{thisChan1, thisChan2} =  RR_sig(1, 2);
                            ID_allRepsCorrs_P_Signal{thisChan1, thisChan2} =  PP_sig(1, 2);
                            
                            ID_allFRMeans_Signal_N1{thisChan1, thisChan2} = allMeans_Sig_N1;
                            ID_allFRMeans_Signal_N2{thisChan1, thisChan2} = allMeans_Sig_N2;
                            
                            ID_allFRStds_Signal_N1{thisChan1, thisChan2} = allStd_Sig_N1;
                            ID_allFRStds_Signal_N2{thisChan1, thisChan2} = allStd_Sig_N2;
                            
                            
                        else
                            chanComparisons_P{thisChan1, thisChan2} = P_UniqueStims;
                            chanComparisons_R{thisChan1, thisChan2} = R_UniqueStims;
                            
                            chanComparisons_R_matrix{thisChan1, thisChan2} = thisBinnedStimZ;
                            
                            posCorrs{thisChan1, thisChan2} = numel(find(cellmat_zero >0));
                            negCorrs{thisChan1, thisChan2} = numel(find(cellmat_zero <0));
                            
                            allRepsCorrs_R{thisChan1, thisChan2} =  RR(1, 2);
                            allRepsCorrs_P{thisChan1, thisChan2} =  PP(1, 2);
                            
                            all_CompSumSpksN1_N2{thisChan1, thisChan2} = CompSumSpksN1_N2;
                            
                            
                            %% Signal
                            
                            allRepsCorrs_R_Signal{thisChan1, thisChan2} =  RR_sig(1, 2);
                            allRepsCorrs_P_Signal{thisChan1, thisChan2} =  PP_sig(1, 2);
                            
                            allFRMeans_Signal_N1{thisChan1, thisChan2} = allMeans_Sig_N1;
                            allFRMeans_Signal_N2{thisChan1, thisChan2} = allMeans_Sig_N2;
                            
                            allFRStds_Signal_N1{thisChan1, thisChan2} = allStd_Sig_N1;
                            allFRStds_Signal_N2{thisChan1, thisChan2} = allStd_Sig_N2;
                            
                            
                        end
                        
                    end
                end
            end
            
            CC_P_OverStims{j, thisStim} = chanComparisons_P;
            CC_R_OverStims{j, thisStim} = chanComparisons_R;
            
            All_CC_R_OverStims{j, thisStim} = allRepsCorrs_R;
            All_CC_P_OverStims{j, thisStim} = allRepsCorrs_P;
            
            allSpkCnts_N1_N2{j, thisStim} = all_CompSumSpksN1_N2;
            
            CC_R_Matrix_OverStims{j, thisStim} = chanComparisons_R_matrix;
            
            nPosCorrs{j, thisStim} = posCorrs;
            nNegCorrs{j, thisStim} = negCorrs;
            
            SignalR{j,thisStim} = allRepsCorrs_R_Signal;
            SignalP{j,thisStim}  = allRepsCorrs_P_Signal;
            
            SignalFRmean_N1{j,thisStim} = allFRMeans_Signal_N1;
            SignalFRmean_N2{j,thisStim} = allFRMeans_Signal_N2;
            
            SignalFRstd_N1{j,thisStim} = allFRStds_Signal_N1;
            SignalFRstd_N2{j,thisStim} = allFRStds_Signal_N2;
            
            
            %%
            ID_CC_P_OverStims{j, thisStim} = ID_chanComparisons_P;
            ID_CC_R_OverStims{j, thisStim} = ID_chanComparisons_R;
            
            ID_All_CC_P_OverStims{j, thisStim} = ID_allRepsCorrs_P;
            ID_All_CC_R_OverStims{j, thisStim} = ID_allRepsCorrs_R;
            
            ID_allSpkCnts_N1_N2{j, thisStim} = ID_all_CompSumSpksN1_N2;
            
            ID_CC_R_Matrix_OverStims{j, thisStim} = ID_chanComparisons_R_matrix;
            
            ID_nPosCorrs{j, thisStim} = ID_posCorrs;
            ID_nNegCorrs{j, thisStim} = ID_negCorrs;
            
            ID_SignalR{j,thisStim} = allRepsCorrs_R_Signal;
            ID_SignalP{j,thisStim}  = allRepsCorrs_P_Signal;
            
            ID_SignalFRmean_N1{j,thisStim} = allFRMeans_Signal_N1;
            ID_SignalFRmean_N2{j,thisStim} = allFRMeans_Signal_N2;
            
            ID_SignalFRstd_N1{j,thisStim} = allFRStds_Signal_N1;
            ID_SignalFRstd_N2{j,thisStim} = allFRStds_Signal_N2;
            
            
            allDatNames{j} = dataFiles{1};
            allChanNames{j} = dataChans;
            allSpkInds{j} = dataChanSpkInds;
            
        end
    end
    disp('')
end

disp('')

RSC.CC_P_OverStims = CC_P_OverStims;
RSC.CC_R_OverStims = CC_R_OverStims;
RSC.CC_R_Matrix_OverStims = CC_R_Matrix_OverStims;

RSC.nPosCorrs = nPosCorrs;
RSC.nNegCorrs = nNegCorrs;

RSC.All_CC_P_OverStims = All_CC_P_OverStims;
RSC.All_CC_R_OverStims = All_CC_R_OverStims;

RSC.allSpkCnts_N1_N2 = allSpkCnts_N1_N2;


RSC.SignalR = SignalR;
RSC.SignalP  =SignalP;

RSC.SignalFRmean_N1 = SignalFRmean_N1;
RSC.SignalFRmean_N2 = SignalFRmean_N2;

RSC.SignalFRstd_N1 = SignalFRstd_N1;
RSC.SignalFRstd_N2 = SignalFRstd_N2;

%%
RSC.ID_CC_P_OverStims = ID_CC_P_OverStims;
RSC.ID_CC_R_OverStims = ID_CC_R_OverStims;
RSC.ID_CC_R_Matrix_OverStims = ID_CC_R_Matrix_OverStims;

RSC.ID_nPosCorrs = ID_nPosCorrs;
RSC.ID_nNegCorrs = ID_nNegCorrs;

RSC.ID_All_CC_P_OverStims = ID_All_CC_P_OverStims;
RSC.ID_All_CC_R_OverStims = ID_All_CC_R_OverStims;

RSC.ID_allSpkCnts_N1_N2 = ID_allSpkCnts_N1_N2;


RSC.ID_SignalR = ID_SignalR;
RSC.ID_SignalP  =ID_SignalP;

RSC.ID_SignalFRmean_N1 = ID_SignalFRmean_N1;
RSC.ID_SignalFRmean_N2 = ID_SignalFRmean_N2;

RSC.ID_SignalFRstd_N1 = ID_SignalFRstd_N1;
RSC.ID_SignalFRstd_N2 = ID_SignalFRstd_N2;

%%
RSC.allDataFiles_Aud = allDataFiles;
RSC.allDataChans_Aud = allDataChans;
RSC.allDataChans_Aud = allDataSpkInds;

RSC.allDatNames = allDatNames;
RSC.allChanNames = allChanNames;
RSC.allDataSpkInds_Aud = allSpkInds;

RSC.AudNeuronNames = AudNeuronNames;
RSC.AudDatFiles = AudDatFiles;

RSC.binSize_ms = binSize_ms;
RSC.binSize_samp = binSize_samp;
RSC.scanrate = scanrate;

%%
saveName = [saveDir textbeg texttime];
save(saveName, 'RSC', '-v7.3')
disp(saveName)

%%



end


