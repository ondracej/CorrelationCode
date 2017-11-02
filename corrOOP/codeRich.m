% specs{i} is the raw spectrogram
% spec0 is the longest spetrogramS

dataFile = 



startstops = load('/home/janie/Datab20r1 01-byhandMotifs_DiffLengths.mat')

for i=1:number different motifs

    % similarity: 1- correlation
M=1-double(spec0')*double(specs{i})/norm(double(spec0))/norm(double(specs{i}));
    [p,q,D] = dp_rich(M);   % The warping is done by using dynamic programming to find a min-cost path through matrix M. state sequence in p,q returned

    time_p{i}=q; time_q{i}=p;

end

