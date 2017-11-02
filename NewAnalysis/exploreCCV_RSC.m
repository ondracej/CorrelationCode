function [] = exploreCCV_RSC()

dbstop if error
d = load('/home/janie/Documents/CorrPaper2016/Data/AuditoryForebrain-Population/AllPooledData/allPooledData_2016.mat');
INFO = d.INFO;
RSC = d.RSC;
CCV = d.CCV;
CCVBins = CCV.CCVBins;

%saveDir = '/home/janie/Data/INI/Quadruplet/CorPlots_Motifs/';
%saveDir = '/home/janie/Data/INI/Quadruplet/CorrPlots/';
saveDir = '/home/janie/Data/INI/Quadruplet/CorrPlots_WN/';
%saveDir = '/home/janie/Data/INI/Quadruplet/Motifs_BOS-CON/';

%{
StimCCV_allMeans_REV = CCV.CCV_Motif.CCV.allMeans{1,8};
StimSignalCOV_allMeans_REV = CCV.CCV_Motif.SignalCOV.allMeans{1,8};
StimNoiseCOV_allMeans_REV = CCV.CCV_Motif.NoiseCOV.allMeans{1,8};

StimCCV_allMeans_BOS = CCV.CCV_Motif.CCV.allMeans{1,7};
StimSignalCOV_allMeans_BOS = CCV.CCV_Motif.SignalCOV.allMeans{1,7};
StimNoiseCOV_allMeans_BOS = CCV.CCV_Motif.NoiseCOV.allMeans{1,7};

FRRSC_REV = d.FRStats.FR.Motif.SpkCntsRSC{1,8};
FRRSC_BOS = d.FRStats.FR.Motif.SpkCntsRSC{1,7};

RSC_REV = RSC.RSC_Motif.RSC.r{1,8};
RSC_BOS = RSC.RSC_Motif.RSC.r{1,7};

RSC_REV_p = RSC.RSC_Motif.RSC.p{1,8};
RSC_BOS_p = RSC.RSC_Motif.RSC.p{1,7};
%}

%
StimCCV_allMeans_REV = CCV.CCV_Stim.CCV.allMeans{1,1};
StimSignalCOV_allMeans_REV = CCV.CCV_Stim.SignalCOV.allMeans{1,1};
StimNoiseCOV_allMeans_REV = CCV.CCV_Stim.NoiseCOV.allMeans{1,1};

StimCCV_allMeans_BOS = CCV.CCV_Stim.CCV.allMeans{1,12};
StimSignalCOV_allMeans_BOS = CCV.CCV_Stim.SignalCOV.allMeans{1,12};
StimNoiseCOV_allMeans_BOS = CCV.CCV_Stim.NoiseCOV.allMeans{1,12};

FRRSC_REV = d.FRStats.FR.Stim.SpkCntsRSC{1,1};
FRRSC_BOS = d.FRStats.FR.Stim.SpkCntsRSC{1,12};

RSC_REV = RSC.RSC_Stim.RSC.r{1,1};
RSC_BOS = RSC.RSC_Stim.RSC.r{1,12};

RSC_REV_p = RSC.RSC_Stim.RSC.p{1,1};
RSC_BOS_p = RSC.RSC_Stim.RSC.p{1,12};
%}

%{
StimCCV_allMeans_REV = CCV.CCV_Motif.CCV.allMeans{1,6};
StimSignalCOV_allMeans_REV = CCV.CCV_Motif.SignalCOV.allMeans{1,6};
StimNoiseCOV_allMeans_REV = CCV.CCV_Motif.NoiseCOV.allMeans{1,6};

StimCCV_allMeans_BOS = CCV.CCV_Motif.CCV.allMeans{1,8};
StimSignalCOV_allMeans_BOS = CCV.CCV_Motif.SignalCOV.allMeans{1,8};
StimNoiseCOV_allMeans_BOS = CCV.CCV_Motif.NoiseCOV.allMeans{1,8};

FRRSC_REV = d.FRStats.FR.Motif.SpkCntsRSC{1,6};
FRRSC_BOS = d.FRStats.FR.Motif.SpkCntsRSC{1,8};

RSC_REV = RSC.RSC_Motif.RSC.r{1,6};
RSC_BOS = RSC.RSC_Motif.RSC.r{1,8};

RSC_REV_p = RSC.RSC_Motif.RSC.p{1,6};
RSC_BOS_p = RSC.RSC_Motif.RSC.p{1,8};

%}

%{
StimCCV_allMeans_REV = CCV.CCV_Stim.CCV.allMeans{1,6};
StimSignalCOV_allMeans_REV = CCV.CCV_Stim.SignalCOV.allMeans{1,6};
StimNoiseCOV_allMeans_REV = CCV.CCV_Stim.NoiseCOV.allMeans{1,6};

StimCCV_allMeans_BOS = CCV.CCV_Stim.CCV.allMeans{1,8};
StimSignalCOV_allMeans_BOS = CCV.CCV_Stim.SignalCOV.allMeans{1,8};
StimNoiseCOV_allMeans_BOS = CCV.CCV_Stim.NoiseCOV.allMeans{1,8};

FRRSC_REV = d.FRStats.FR.Stim.SpkCntsRSC{1,6};
FRRSC_BOS = d.FRStats.FR.Stim.SpkCntsRSC{1,8};

RSC_REV = RSC.RSC_Stim.RSC.r{1,6};
RSC_BOS = RSC.RSC_Stim.RSC.r{1,8};

RSC_REV_p = RSC.RSC_Stim.RSC.p{1,6};
RSC_BOS_p = RSC.RSC_Stim.RSC.p{1,8};
%}


timelags = -1000:5:1000;
gray = [0.3 0.3 0.3];
Yss = [-0.05 0.05];
Xss = [-500 500];
for j = 1: size(StimCCV_allMeans_REV, 1)
    
    annotationTitle = [INFO.PairwiseComparisons_FileNames{j} ' | CH-' num2str(INFO.PairwiseComparisons_Channels(j,1)) ',' num2str(INFO.PairwiseComparisons_Channels(j,2))];
    
    
    figH = figure(105);clf
    subplot(2, 2, 1)
    
    plot(timelags, smooth(StimCCV_allMeans_REV(j,:)), 'k')
    hold on
    plot(timelags, smooth(StimSignalCOV_allMeans_REV(j,:)), 'color', 'b')
    %plot(timelags, smooth(StimNoiseCOV_allMeans_REV(j,:)), 'b')
    xlim(Xss)
    ylim(Yss)
    line([0 0], [Yss(1) Yss(2)], 'color', 'k')
    line([Xss(1) Xss(2)], [0 0], 'color', 'k')
    %title('REV')
    title('WN-Start')
    %title('BOS')
    %leg = {'CCV', 'SignalCOV', 'NoiseCov'};
    leg = {'CCV', 'SignalCOV'};
    legend(leg)
    xlabel('Time [ms]')
    grid on
    
    subplot(2, 2, 3)
    
    plot(timelags, smooth(StimCCV_allMeans_BOS(j,:)), 'k')
    hold on
    plot(timelags, smooth(StimSignalCOV_allMeans_BOS(j,:)), 'color', 'b')
    %plot(timelags, smooth(StimNoiseCOV_allMeans_BOS(j,:)), 'b')
    xlim(Xss)
    ylim(Yss)
    line([0 0], [Yss(1) Yss(2)], 'color', 'k')
    line([Xss(1) Xss(2)], [0 0], 'color', 'k')
    %title('BOS')
    title('WN-End')%
    %title('CON')
   % leg = {'CCV', 'SignalCOV', 'NoiseCov'};
    leg = {'CCV', 'SignalCOV'};
    legend(leg)
    xlabel('Time [ms]')
    grid on
    
    [AllIndividualInds] = lookupIndNeurons(j, INFO);
    
    [thisDATA_RSC_REV] = getDataFromInds(FRRSC_REV, AllIndividualInds);
    N1 = thisDATA_RSC_REV{1, 1};
    N2 = thisDATA_RSC_REV{1, 2};
    
    N1_Z = (N1 - mean(N1))/std(N1);
    N2_Z = (N2 - mean(N2))/std(N2);
    
    nPoints = numel(N1_Z);
    halfPoints = floor(nPoints/2);
    jitterN = (rand(1, nPoints))*.7;
    jitterNN = (rand(1, nPoints))*.7;
    
    jitterN(1:halfPoints) = jitterN(1:halfPoints)*-1;
    jitterNN(1:halfPoints) = jitterNN(1:halfPoints)*-1;
    
    subplot(2, 2, 2)
    %plot(N1_Z, N2_Z, 'MarkerFaceColor',[0 0 0],'Marker','o','LineStyle','none','Color',[0 0 0]);
    plot(N1_Z+jitterN, N2_Z+jitterNN, 'MarkerFaceColor',[0 0 0],'Marker','o','LineStyle','none','Color',[0 0 0]);
    
    xlim([-4, 4])
    ylim([-4, 4])
    
    hline = refline(RSC_REV(j), 0);
    hline.Color = 'r';
    
    leg = {['Rsc = ' num2str(roundn(RSC_REV(j), -2)) ', p = ' num2str(roundn(RSC_REV_p(j), -3))]};
    legend(leg)
    
    xlabel(['CH-' num2str(INFO.PairwiseComparisons_Channels(j,1))])
    ylabel(['CH-' num2str(INFO.PairwiseComparisons_Channels(j,2))])
    %title('REV')
    title('WN-Start')
    %title('BOS')
    %%
    
    [thisDATA_RSC_BOS] = getDataFromInds(FRRSC_BOS, AllIndividualInds);
    N1 = thisDATA_RSC_BOS{1, 1};
    N2 = thisDATA_RSC_BOS{1, 2};
    
    if iscell(N1)
        N1 = cell2mat(N1);
        N2 = cell2mat(N2);
    end
    
    N1_Z = (N1 - mean(N1))/std(N1);
    N2_Z = (N2 - mean(N2))/std(N2);
    
    nPoints = numel(N1_Z);
    halfPoints = floor(nPoints/2);
    jitterN = (rand(1, nPoints))*.7;
    jitterNN = (rand(1, nPoints))*.7;
    
    jitterN(1:halfPoints) = jitterN(1:halfPoints)*-1;
    jitterNN(1:halfPoints) = jitterNN(1:halfPoints)*-1;
    
    subplot(2, 2, 4)
    plot(N1_Z +jitterN, N2_Z+jitterNN , 'MarkerFaceColor',[0 0 0],'Marker','o','LineStyle','none','Color',[0 0 0]);
    %plot(N1_Z, N2_Z, 'MarkerFaceColor',[0 0 0],'Marker','o','LineStyle','none','Color',[0 0 0]);
    
    xlim([-4, 4])
    ylim([-4, 4])
    
    hline = refline(RSC_BOS(j), 0);
    hline.Color = 'r';
    
    leg = {['Rsc = ' num2str(roundn(RSC_BOS(j), -2)) ', p = ' num2str(roundn(RSC_BOS_p(j), -3))]};
    legend(leg)
    
    xlabel(['CH-' num2str(INFO.PairwiseComparisons_Channels(j,1))])
    ylabel(['CH-' num2str(INFO.PairwiseComparisons_Channels(j,2))])
    %title('BOS')
    title('WN-End')
    %title('CON')
    
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
    plotpos = [0 0 40 20];
    print_in_A4(0, FigSaveName, export_to, 0, plotpos);
    
    
end
end

