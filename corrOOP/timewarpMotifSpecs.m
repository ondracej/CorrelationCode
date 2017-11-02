function [] = timewarpMotifSpecs(obj, audData)

startstops = load('/home/janie/Datab20r1 01-byhandMotifs_DiffLengths.mat');


nfft = 512;
win = 400;
noverlap = 360; % nonoverlap - 40 samples

binSize_samp = 40;

starts = startstops.stim1_start;
stops = startstops.stim1_stop;
nstims = numel(starts);

allLengths1 = stops - starts;
chans = obj.SPKS.chans;

for j = 1: numel(chans)
    
    thisChan = chans(j);
    
    %spkStimInfo_chan = obj.SPKS.spkStimInfo{thisChan};
    spks = obj.SPKS.spks{thisChan};
    
    allspksCnts_Bins = [];
    all_binDur_samp = [];
    allNBins = [];
    for b = 1:nstims
        
        start_stim =  starts(b);
        stop_stim =  stops(b);
        lengthStim = stop_stim - start_stim;
       
        %ncol = fix((nx-noverlap)/(nwind-noverlap));
        %colindex = 1 + (0:(ncol-1))*(nwind-noverlap);
        ncol = fix((lengthStim-noverlap)/(win-noverlap));
        %colindex = 1 + (0:(ncol-1))*(win-noverlap);
        colindex = start_stim + (0:(ncol-1))*(win-noverlap);
        t = (colindex-1)'/obj.scanrate;
        
        %{
        nbins = ceil(lengthStim/(win-noverlap));
        binStarts = []; binStops = [];
        
        for q = 1:ncol
            if q  ==1
                binStarts(q) = start_stim;
                binStops(q) = binStarts(q)+colindex(q+1)-1;
                
            elseif q == ncol
                binStarts(q) = binStops(q-1) - noverlap;
                binStops(q) = stop_stim;
                
            else
                binStarts(q) = binStops(q-1) - noverlap;
                binStops(q) =  binStarts(q) + win;
            end
        end
        
        
        binStarts_T_rel = (binStarts-binStarts(1))/obj.scanrate;
        %}
        %% Define Bin Start Stops
       
        %binStarts = start_stim:binSize_samp:stop_stim-binSize_samp;
        %binStarts_relT = (binStarts-binStarts(1))/obj.scanrate;
        %nBinsStarts = numel(binStarts);
        
        %diff(binStarts)
        %stimDur_samp = stop_stim -start_stim; % needs to be defined for each new unique stim
        %nBins = ceil(stimDur_samp/binSize_samp);
        %[~, indices_in_same_bin] = histc(1:stimDur_samp, [1:binSize_samp:stimDur_samp+binSize_samp]);
        
        cum_spikes = 0;
        spksCnts_Bins = []; binDur_samp = [];
        
        for o = 1: ncol
            
            %% Define stimulus onset offset
            
            % Map indices in stimulus to time points in stimulus
            %this_data_range = start_stim:stop_stim-1;
            
            %samples_this_bin = this_data_range(indices_in_same_bin == o);
            
            %bin_start_samp = samples_this_bin(1);
            %bin_stop_samp = samples_this_bin(end);
            
            if o == ncol
            spkTimesInBin_rel = spks(spks >= colindex(o) & spks < colindex(o)+win-noverlap)- colindex(o);
            spkTimesInBin_abs = spks(spks >=  colindex(o) & spks < colindex(o)+win-noverlap);
            
            length_this_bin = colindex(o)+win-noverlap - colindex(o); % check to make sure bin length is correct
            
            else
            
            spkTimesInBin_rel = spks(spks >= colindex(o) & spks < colindex(o+1))- colindex(o);
            spkTimesInBin_abs = spks(spks >=  colindex(o) & spks <= colindex(o+1));
            
            length_this_bin = colindex(o+1) - colindex(o); % check to make sure bin length is correct
            %length_this_bin = bin_stop_samp - bin_start_samp +1; % check to make sure bin length is correct
            end
            
            %spkTimesInBin_rel = spks(spks >= bin_start_samp & spks <= bin_stop_samp)-bin_start_samp;
            %spkTimesInBin_abs = spks(spks >= bin_start_samp & spks <= bin_stop_samp);
            
            %% Binned Spike count used in COV calculations
            if ~isempty(spkTimesInBin_abs)
                spkCnt_Bin = numel(spkTimesInBin_abs);
            else
                spkCnt_Bin = 0;
            end
            
            % Test to make sure the binned spike counts match the unbinned spike counts
            cum_spikes = cum_spikes + spkCnt_Bin;
            
            % Binned Firing rate statistics
            spksCnts_Bins(o) = spkCnt_Bin;
            %spksTimes_InBin_rel_samp{b,o} = spkTimesInBin_rel;
            %spksTimes_InBin_abs_samp{b,o} = spkTimesInBin_abs;
            binDur_samp(o) = length_this_bin;
            
            
        end
        allspksCnts_Bins{b} = spksCnts_Bins;
        all_binDur_samp{b} = binDur_samp;
        allNBins(b) = ncol;
    end
    %uniqueBins = unique(allNBins);
    allChansSpks{thisChan}.allspksCnts_Bins = allspksCnts_Bins;
    allChansSpks{thisChan}.all_binDur_samp = all_binDur_samp;
    allChansSpks{thisChan}.allNBins = allNBins;
end

%% Get all Data snippets

for j = 1:nstims
    thisData{j} = audData(starts(j):stops(j)-1);
    %allLengths(j) = stops(j) - starts(j);
end

allLengths = stops - starts;

uniqueLengths = unique(allLengths);
longestLength = max(uniqueLengths);
longestInds = find(allLengths == longestLength);

spec_scale = 1000;

% specs{i} is the raw spectrogram
% spec0 is the longest spetrogramS


[spec0, F, T] = specgram1(double(thisData{longestInds(1)})/spec_scale,nfft,obj.scanrate,win ,noverlap);

y = spec0;
t = T;
f = F;

T_samps = T*obj.scanrate;
figure
specgram1(double(thisData{longestInds(1)})/spec_scale,nfft,obj.scanrate,win ,noverlap);
% Spectrogram
%image(t,f,40*log10(abs(y)+10e-1));axis xy; colormap(jet)
%%

for j = 1:nstims
[specs{j}] = specgram1(double(thisData{j})/spec_scale,512,obj.scanrate,400,360); 
end

for i=1:1:nstims
    
    % similarity: 1- correlation
    %M=1-double(spec0')*double(specs{i})/norm(double(spec0))/norm(double(specs{i}));
    M=1-double(spec0')*double(specs{i})/norm(double(spec0))/norm(double(specs{i}));
    
    [p,q,D] = dp_rich(M);   % The warping is done by using dynamic programming to find a min-cost path through matrix M. state sequence in p,q returned
    
    time_p{i}=q; time_q{i}=p; 
    
end

disp('')
%% Reassigning spikes


figure
image(D)


bla = diff(time_p{1});
bla = diff(time_q{10});

%NFFT = 512;
%WINDOW = 400;
%NOVERLAP = 360;
% B = SPECGRAM(A,NFFT,Fs,WINDOW,NOVERLAP)
%  NOVERLAP is the number of samples the sections of A overlap. 

%no, those are the numbering of the bins. one of p or q is 1:T, the other is the 
%corresponding index in the other song. say p=1:T, then, if q(j)=p(i), this mean that 
%the i'th bin in one song corresponds to the j'th bin in the other song.

%just take the spikes from the ith bin for one song and in the jth bin for the other song.
% Of course this works if the bins for specgrams and spikes are the same size and aligned.
%When they are different, you would have to generate a new spike train from the old spike 
%train and the new times. In any case you have to bin the spike train into the same bins 
%used for spectrograms. If the specgram window size is nfft and the nonoverlap is nov, then 
%the first bin is from index 1 to nfft, the second bin is from nfft+nov to nfft+2*nov, the 
%third bin is from nfft+2*nov to nfft+3*nov, etc.

end