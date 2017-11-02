function [] = plotAutoCovariances()

dbstop if error
d = load('/home/janie/Documents/CorrPaper2016/Data/AuditoryForebrain-Population/AllPooledData/allPooledData_2016.mat');
INFO = d.INFO;

saveDir = '/home/janie/Data/INI/Quadruplet/AutoCovPlots/';
stimSelection1 = 6;
stimSelection2 = 7;
stimSelection3 = 8;

SpontAutoCOV1 = d.FRStats.AutoCov.Spont.mean{1, stimSelection1 };
StimAutoCOV1 = d.FRStats.AutoCov.Stim.mean{1, stimSelection1 };

SpontAutoCOV2 = d.FRStats.AutoCov.Spont.mean{1, stimSelection2 };
StimAutoCOV2 = d.FRStats.AutoCov.Stim.mean{1, stimSelection2 };

SpontAutoCOV3 = d.FRStats.AutoCov.Spont.mean{1, stimSelection3 };
StimAutoCOV3 = d.FRStats.AutoCov.Stim.mean{1, stimSelection3 };

timelags = -1000:5:1000;
gray = [0.3 0.3 0.3];
Yss = [-0.12 0.12];
Xss = [-200 200];

for j = 1: size(SpontAutoCOV1, 2)
    
    annotationTitle = [INFO.IndividualNeurons_FileNames{j} ' | CH-' num2str(INFO.IndividualNeurons_Channels(j,1))];
    
    %%
    figH = figure(105);clf
    subplot(2, 3, 1)
    
    if ~isempty(SpontAutoCOV2{1,j}{1,1})
        
        plot(timelags, SpontAutoCOV2{1,j}{1,1}, 'color', gray)
        xlim(Xss)
        ylim(Yss)
        line([0 0], [Yss(1) Yss(2)], 'color', 'k')
        line([Xss(1) Xss(2)], [0 0], 'color', 'k')
        grid on
        grid minor
    end
    
    title('CON-Spont')
    
    subplot(2, 3, 4)
    plot(timelags, StimAutoCOV2{1,j}{1,1}, 'b')
    
    xlim(Xss)
    ylim(Yss)
    line([0 0], [Yss(1) Yss(2)], 'color', 'k')
    line([Xss(1) Xss(2)], [0 0], 'color', 'k')
    grid on
    grid minor
    
    title('CON-Stim')
    xlabel('Time [ms]')
    
    %%
    
    subplot(2, 3, 2)
    
    if ~isempty(SpontAutoCOV1{1,j}{1,1})
        
        plot(timelags, SpontAutoCOV1{1,j}{1,1}, 'color', gray)
        xlim(Xss)
        ylim(Yss)
        line([0 0], [Yss(1) Yss(2)], 'color', 'k')
        line([Xss(1) Xss(2)], [0 0], 'color', 'k')
        grid on
        grid minor
    end
    
    title('REV-Spont')
    
    subplot(2, 3, 5)
    plot(timelags, StimAutoCOV1{1,j}{1,1}, 'b')
    xlim(Xss)
    ylim(Yss)
    line([0 0], [Yss(1) Yss(2)], 'color', 'k')
    line([Xss(1) Xss(2)], [0 0], 'color', 'k')
    grid on
    grid minor
    
    title('REV-Stim')
    xlabel('Time [ms]')
    
    %%
    
    subplot(2, 3, 3)
    
    if ~isempty(SpontAutoCOV3{1,j}{1,1})
        
        plot(timelags, SpontAutoCOV3{1,j}{1,1}, 'color', gray)
        xlim(Xss)
        ylim(Yss)
        line([0 0], [Yss(1) Yss(2)], 'color', 'k')
        line([Xss(1) Xss(2)], [0 0], 'color', 'k')
        grid on
        grid minor
    end
    
    title('BOS-Spont')
    
    subplot(2, 3, 6)
    plot(timelags, StimAutoCOV3{1,j}{1,1}, 'b')
    
    xlim(Xss)
    ylim(Yss)
    line([0 0], [Yss(1) Yss(2)], 'color', 'k')
    line([Xss(1) Xss(2)], [0 0], 'color', 'k')
    grid on
    grid minor
    
    title('BOS-Stim')
    xlabel('Time [ms]')
    
    %%
    
    annotation(figH,'textbox',...
        [0.03 0.93 0.5 0.05],...
        'String', annotationTitle,...
        'LineStyle','none',...
        'FitBoxToText','off');
    
    %%
    FigSaveName = [saveDir INFO.IndividualNeurons_FileNames{j} '_CH-' num2str(INFO.IndividualNeurons_Channels(j,1))];
    figure(figH)
    
    disp('Printing Plot')
    set(0, 'CurrentFigure', figH)
    
    print_format = 4;
    
    export_to = set_export_file_format(print_format);
    plotpos = [0 0 40 20];
    print_in_A4(0, FigSaveName, export_to, 0, plotpos);
    
    
    
end

end

