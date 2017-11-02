function [] = loadMetaFilesAndDoMetaAnalysis()
dbstop if error

metaDir = '/home/janie/Data/INI/Quadruplet/Analysis/5ms/03-Mar-2015-Stims-Coef/PairwiseOutput/MetaAnalysis/';

%% Find meta files in dir
meta_file_list = dir(fullfile(metaDir, '*.mat'));
num_meta_files = size(meta_file_list, 1);

for j = 1 : num_meta_files
    meta_filenames{j} = meta_file_list(j, :).name;
end


disp('')
%% calc spikewave for neurons
%{
spk_cnt = 1;

for j = 1: num_meta_files
    
    
    m = load([metaDir meta_filenames{j}]);

    scanrate = m.meta.scanrate;
    
    chanInds = m.meta.totalChanNumber;
    nChans = numel(chanInds);
    
    for k = 1:nChans
        
        spkShps_thisChan = m.meta.allSpikeShapes{1, chanInds(k)};
        
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
    
end
%%
binwidths = 0:0.05:1;

figure; histogram(peakWidth, binwidths)
figure; histogram(w_halfprom_all*1000/scanrate, binwidths)
figure; histogram(spkLoc_all, 150)
%%

figure; plot(meanShape_thisChan)
close all

%}
%% calculate d primes

for j = 1: num_meta_files
    
    
    m = load([metaDir meta_filenames{j}]);

    chanInds = m.meta.totalChanNumber;
    nChans = numel(chanInds);
    
    for k = 1:nChans

    end
    
end

        





%%