function [] = organizeAudDataForRSC_Motifs()

dbstop if error

binSize_ms = 50;
texttime = [num2str(binSize_ms) 'ms'];

figH = figure(100);
figHH = figure(200);
doPLot = 1;

switch gethostname
    case 'turtle'
        
        sortedStimDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/StimOrdered/';
        sortedSpontDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontOrdered/';
        saveDir = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/';
        
        AudFile = '/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/Fr-Zscore/FR-Zscore_OnlyAud.mat';
        plotDir = ['/home/janie/Data/INI/Data/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/Plots/' texttime '-SpikeCntsStims/'];
        
    case 'deadpool'
        
        motifStims = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/FR-Zscore/OrderedSpkData-Motifs.mat';
        %sortedSpontDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/SpontOrdered/';
        saveDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/';
        
        AudFile = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/FR-Zscore/FR-Zscore_OnlyAud.mat';
        plotDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/SortedData/WNSpontOrStim-1s/AudSpkData/MotifsRSC/';
        
        
end

if exist(saveDir, 'dir') == 0
    mkdir(saveDir);
end

if exist(plotDir, 'dir') == 0
    mkdir(plotDir);
end

%
% if doStim == 1
%     StimFiles = dir([sortedStimDir '*.mat']);
%     nFiles  = numel(StimFiles);
%     allSpikesCntsOrderd_Stim = []; allSpikesOrderd_Stim = [];
%     textbeg = 'RSC-Stim-';
% elseif doStim  == 2
%     SpontFiles = dir([sortedSpontDir '*.mat']);
%     nFiles  = numel(SpontFiles);
%     allSpikesOrderd_Spont = []; allSpikesCntsOrderd_Spont = [];
%     textbeg = 'RSC-Spont-';
% end

nCnt = 1;
ntestcnt = 1;

allDataFiles = []; allDataChans = []; dataChanSpkInds = [];

a = load(AudFile);
neuronInds = a.AudSorted.allAudInds;
AudNeuronNames = a.AudSorted.allDataChans_Aud;
AudDatFiles = a.AudSorted.allDataFiles_Aud;

disp('loading data...');
tic
M = load(motifStims);
toc


Sorted = M.Sorted;
nComps = size(Sorted.allAreas_M, 2);

song_set = [6 8 9];
nStims = numel(song_set);

textbeg = 'RSC-Stim-Motif_';
for j = 1:nComps
    
    allSpikesOrdered = Sorted.allSpikesOrdered_M{1, j};
    
    if isempty(allSpikesOrdered)
        continue
    else
        
        theseChans = Sorted.allNeurons_M{j};
        
        nNeurons = numel(theseChans);
        
        dataFiles = Sorted.allrawDataFiles_M{1, j};
        
        disp(dataFiles{1});
        
        scanrate = M.INFO.scanrate{j};
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
            
            thisStim = song_set(o);
            
            if size(allSpikesOrdered, 2) >= thisStim
                
                for i = 1:nNeurons
                    
                    thisChan1 = theseChans(i);
                    n1Data = allSpikesOrdered{i,thisStim};
                    
                    for ii = 1:nNeurons
                        thisChan2 = theseChans(ii);
                        n2Data = allSpikesOrdered{ii,thisStim};
                        
                        
                        if i > ii || isempty(n1Data)
                            continue
                        else
                            
                            %% Reorganize all the data:
                            
                            titletxt = [dataFiles{1} ' | ' textbeg num2str(thisStim) ' | N-' num2str(theseChans(i)) ' & N-' num2str(theseChans(ii)) ' | CC | binsize = ' num2str(binSize_ms) 'ms'];
                            savetxt = [dataFiles{1} '-' textbeg num2str(thisStim) '_N-' num2str(theseChans(i)) '-N-' num2str(theseChans(ii)) '_CC_bin-' num2str(binSize_ms) 'ms'];
                            
                            nReps = size(n1Data, 1);
                            nUnique = size(n1Data, 2);
                            
                            P_UniqueStims = []; R_UniqueStims = []; buffLength_bins = [];
                            allSumSpksN1 = []; allSumSpksN2 = [];
                            all_SumSpks_N1 = []; all_SumSpks_N2 = [];
                            
                            %for U = 1:nUnique
                            
                            thisData1 = n1Data;
                            thisData2 = n2Data;
                            
                            rehapedN1 = cell2mat(thisData1);
                            rehapedN2 = cell2mat(thisData2);
                            
                            
                            nCompleteBins = floor(size(rehapedN1, 2) /  binSize_samp);
                            dataLengthCompleteBins = binSize_samp*nCompleteBins;
                            diffDataLength_s = (size(rehapedN1, 2) - dataLengthCompleteBins) / scanrate;
                            
                            testN1 = rehapedN1(:,1:dataLengthCompleteBins);
                            testN2 = rehapedN2(:,1:dataLengthCompleteBins);
                            
                            
                            buffN1 = []; buffN2 = [];
                            
                            for R = 1:nReps
                                % No Overlap
                                %buffN1{R} = buffer(rehapedN1(R,1:dataLengthCompleteBins), binSize_samp);
                                %buffN2{R} = buffer(rehapedN2(R,1:dataLengthCompleteBins), binSize_samp);
                                
                                buffN1{R, 1} = buffer(testN1(R,1:dataLengthCompleteBins), binSize_samp);
                                buffN2{R, 1} = buffer(testN2(R,1:dataLengthCompleteBins), binSize_samp);
                            end
                            
                            %% Reorganize into like bins
                            
                            allBinsN1 = []; allBinsN2 = [];
                            for b = 1:nCompleteBins
                                
                                for R = 1:nReps
                                    
                                    thisN1Data = buffN1{R, 1};
                                    thisN2Data = buffN2{R, 1};
                                    
                                    allBinsN1{b}(R,:) = thisN1Data(:,b)';
                                    allBinsN2{b}(R,:) = thisN2Data(:,b)';
                                end
                                
                            end
                            
                            
                            sumSpksN1 = []; sumSpksN2 = [];
                            % These are the sums of spikes in 5ms bins
                            for R = 1:nCompleteBins
                                sumSpksN1(:,R) = sum(allBinsN1{1, R}, 2)';
                                sumSpksN2(:,R) = sum(allBinsN2{1, R}, 2)';
                            end
                            
                            %allSumSpksN1{U} = sumSpksN1(1:end-1);
                            %allSumSpksN2{U} = sumSpksN2(1:end-1);
                            buffLength_bins = size(sumSpksN1, 2);
                            
                            allPs = []; allRs = [];
                            
                            for qq = 1: buffLength_bins
                                
                                [r, p] = corrcoef(sumSpksN1(:,qq), sumSpksN2(:,qq));
                                allPs(qq) = p(1, 2);
                                allRs(qq) = r(1, 2);
                            end
                            
                            
                            P_UniqueStims = allPs;
                            R_UniqueStims = allRs;
                            
                            %%
                            
                            Re_allSumSpksN1 = reshape(sumSpksN1, 1, numel(sumSpksN1));
                            Re_allSumSpksN2 = reshape(sumSpksN2, 1, numel(sumSpksN2));
                            
                            meanN1 = nanmean(Re_allSumSpksN1);
                            meanN2 = nanmean(Re_allSumSpksN2);
                            
                            stdN1 = nanstd(Re_allSumSpksN1);
                            stdN2 = nanstd(Re_allSumSpksN2);
                            
                            %ZSpksN1 = (Re_allSumSpksN1 - meanN1) / stdN1;
                            %ZSpksN2 = (Re_allSumSpksN2 - meanN2) / stdN2;
                            
                            all_SumSpks_N1 = Re_allSumSpksN1;
                            all_SumSpks_N2 = Re_allSumSpksN2;
                            
                        end
                        
                        
                        [RR, PP] = corrcoef(all_SumSpks_N1, all_SumSpks_N2);
                        
                        Rround = round(RR(1, 2), 4);
                        Pround = round(PP(1, 2), 4);
                        
                        CompSumSpksN1_N2 = [all_SumSpks_N1 ; all_SumSpks_N2];
                        
                        %% Z score
                        %jitterValuesX = 2*(rand(size(ZSpksN1))-0.5)*jitterAmount;   % +/-jitterAmount max
                        %jitterValuesY = 2*(rand(size(ZSpksN2))-0.5)*jitterAmount;   % +/-jitterAmount max
                        %scatterhist(jitterValuesX+ZSpksN1, jitterValuesY+ZSpksN2, 'Kernel', 'on', 'Location','SouthEast','Direction','out')
                        %xlim([-5 5])
                        %ylim([-5 5])
                        %% Spks
                        if doPLot
                            jitterAmount = 0.35;
                            jitterValuesX = 2*(rand(size(all_SumSpks_N1))-0.5)*jitterAmount;   % +/-jitterAmount max
                            jitterValuesY = 2*(rand(size(all_SumSpks_N2))-0.5)*jitterAmount;   % +/-jitterAmount max
                            
                            figure(figHH); clf
                            scatterhist(jitterValuesX+all_SumSpks_N1, jitterValuesY+all_SumSpks_N2, 'Kernel', 'on', 'Location','SouthWest','Direction','in', 'Marker','.')
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
                        
                        for q = 1:numel(R_UniqueStims)
                            thisBinnedStim = R_UniqueStims(1, q);
                            thisBinnedStimZ(q) = [thisBinnedStim];
                            
                        end
                        
                        cellmat_zero = thisBinnedStimZ;
                        
                        nanind = isnan(cellmat_zero);
                        cellmat_zero(nanind) = 0;
                        
                        %
                        if doPLot
                            
                            
                            
                            
                            
                            
                            
                            figure(figH); clf
                            %imagesc(cellmat_zero, imgclims)
                            %colormap('gray')
                            
                            plot(cellmat_zero, 'ko')
                            hold on
                            plot(cellmat_zero, 'linewidth', 2, 'color', 'k')
                            
                            axis tight
                            ylim([-1 1])
                            xlim([0.5 [numel(cellmat_zero)+.5]])
                            xlabel(['Bins [' texttime ']'])
                            ylabel('Corr Coef')
                            title(titletxt)
                            
                            figure(figH)
                            plot_filename = [plotDir savetxt];
                            plotpos = [0 0 10 10];
                            %print_in_A4(0, plot_filename, '-djpeg', 0, plotpos);
                            print_in_A4(0, plot_filename, '-depsc', 0, plotpos);
                            disp(plot_filename)
                            
                            
                        end
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
                            
                            %ID_chanComparisons_R_matrix{thisChan1, thisChan2} = thisBinnedStimZ;
                            
                            ID_posCorrs{thisChan1, thisChan2} = numel(find(cellmat_zero >0));
                            ID_negCorrs{thisChan1, thisChan2} = numel(find(cellmat_zero <0));
                            
                            ID_allRepsCorrs_R{thisChan1, thisChan2} =  RR(1, 2);
                            ID_allRepsCorrs_P{thisChan1, thisChan2} =  PP(1, 2);
                            
                            ID_all_CompSumSpksN1_N2{thisChan1, thisChan2} = CompSumSpksN1_N2;
                            
                            
                        else
                            chanComparisons_P{thisChan1, thisChan2} = P_UniqueStims;
                            chanComparisons_R{thisChan1, thisChan2} = R_UniqueStims;
                            
                            chanComparisons_R_matrix{thisChan1, thisChan2} = thisBinnedStimZ;
                            
                            posCorrs{thisChan1, thisChan2} = numel(find(cellmat_zero >0));
                            negCorrs{thisChan1, thisChan2} = numel(find(cellmat_zero <0));
                            
                            allRepsCorrs_R{thisChan1, thisChan2} =  RR(1, 2);
                            allRepsCorrs_P{thisChan1, thisChan2} =  PP(1, 2);
                            
                            all_CompSumSpksN1_N2{thisChan1, thisChan2} = CompSumSpksN1_N2;
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
            
            %%
            ID_CC_P_OverStims{j, thisStim} = ID_chanComparisons_P;
            ID_CC_R_OverStims{j, thisStim} = ID_chanComparisons_R;
            
            ID_All_CC_P_OverStims{j, thisStim} = ID_allRepsCorrs_P;
            ID_All_CC_R_OverStims{j, thisStim} = ID_allRepsCorrs_R;
            
            ID_allSpkCnts_N1_N2{j, thisStim} = ID_all_CompSumSpksN1_N2;
            
            ID_CC_R_Matrix_OverStims{j, thisStim} = ID_chanComparisons_R_matrix;
            
            ID_nPosCorrs{j, thisStim} = ID_posCorrs;
            ID_nNegCorrs{j, thisStim} = ID_negCorrs;
            
            allDatNames{j} = dataFiles{1};
            allChanNames{j} = theseChans;
            allSpkInds{j} = theseChans;
            
            
            disp('')
        end
    end
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

%%
RSC.ID_CC_P_OverStims = ID_CC_P_OverStims;
RSC.ID_CC_R_OverStims = ID_CC_R_OverStims;
RSC.ID_CC_R_Matrix_OverStims = ID_CC_R_Matrix_OverStims;

RSC.ID_nPosCorrs = ID_nPosCorrs;
RSC.ID_nNegCorrs = ID_nNegCorrs;

RSC.ID_All_CC_P_OverStims = ID_All_CC_P_OverStims;
RSC.ID_All_CC_R_OverStims = ID_All_CC_R_OverStims;

RSC.ID_allSpkCnts_N1_N2 = ID_allSpkCnts_N1_N2;
%%
RSC.allDataFiles_Aud = allDatNames;
RSC.allDataChans_Aud = allChanNames;
%RSC.allDataChans_Aud = allDataSpkInds;

%RSC.allDatNames = allDatNames;
%RSC.allChanNames = allChanNames;
%RSC.allDataSpkInds_Aud = allSpkInds;

RSC.AudNeuronNames = AudNeuronNames;
RSC.AudDatFiles = AudDatFiles;

RSC.binSize_ms = binSize_ms;
RSC.binSize_samp = binSize_samp;
RSC.scanrate = scanrate;

%%
saveName = [saveDir textbeg texttime];
save(saveName, 'RSC', '-v7.3')
disp(saveName)
end

