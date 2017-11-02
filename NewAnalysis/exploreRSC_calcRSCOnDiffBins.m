function [] = exploreRSC_calcRSCOnDiffBins()
dbstop if error
d = load('/home/janie/Documents/CorrPaper2016/Data/AuditoryForebrain-Population/AllPooledData/allPooledData_2016.mat');
INFO = d.INFO;
RSC = d.RSC;

stimRSC_rs = RSC.RSC_Motif.RSC.r{1, 8};

saveDir = '/home/janie/Data/INI/Quadruplet/BinnedRSC/';

%%
cols = {'r', 'b', 'k', [.6 .6 .6], [.3 .6 .4], [.2 .5 .1]};

for j = 45: size(stimRSC_rs, 2)
    
    annotationTitle = [INFO.PairwiseComparisons_FileNames{j} ' | CH-' num2str(INFO.PairwiseComparisons_Channels(j,1)) ',' num2str(INFO.PairwiseComparisons_Channels(j,2))];
    
    [AllIndividualInds] = lookupIndNeurons(j, INFO);
    
    thisData = d.FRStats.FR.Motif.SpkCntBinned{1,8};
    [thisDATA] = getDataFromInds(thisData, AllIndividualInds);
    
    thisPair = thisDATA;
    spks1 = thisPair{1, 1};
    spks2 = thisPair{1, 2};
    
    
    figH = figure(107);clf
    allRSC = []; allNumels = [];
    
    rs = [];
    spkcnt1 = spks1;
    spkcnt2 = spks2;
    
    
    %bla = spks1(:, k);
    for k = 1:size(spkcnt1, 2)
        [r h] = corrcoef(spks1(:,k), spks2(:,k));
        rs(k) = r(2, 1);
        
    end
    
    Xss = size(spkcnt2,2);
    
    subplot(3, 1, 2)
    imagesc(spkcnt1)
    title(['Binned Motifs | Ch-' num2str(INFO.PairwiseComparisons_Channels(j,1))])
    axis tight
    subplot(3, 1, 3)
    imagesc(spkcnt2)
    title(['Binned Motifs | Ch-' num2str(INFO.PairwiseComparisons_Channels(j,2))])
    colormap('bone')
    
    
    
    nonNanRs = rs;
    nonNanRs(isnan(rs)) = 0;
    
    subplot(3, 1, 1)
    plot(smooth(nonNanRs, 3), 'color', 'k')
    hold on
    plot(rs,'o', 'color', 'k')
    axis tight
    xlim([0 Xss])
    ylim([-.25 .25])
    
    ylabel(['R'])
    
    xlabel(['Time [5ms bins]'])
    title(['RSC in 5 ms bins '])
    
    annotation(figH,'textbox',...
        [0.03 0.93 0.5 0.05],...
        'String', annotationTitle,...
        'LineStyle','none',...
        'FitBoxToText','off');
    
    %%
    
    FigSaveName = [saveDir INFO.PairwiseComparisons_FileNames{j} '_CH-' num2str(INFO.PairwiseComparisons_Channels(j,1)) '_' num2str(INFO.PairwiseComparisons_Channels(j,2))];
    figure(figH)
    
    disp('Printing Plot')
    set(0, 'CurrentFigure', figH)
    
    print_format = 4;
    
    export_to = set_export_file_format(print_format);
    plotpos = [0 0 30 20];
    print_in_A4(0, FigSaveName, export_to, 0, plotpos);
    
    
end



end

