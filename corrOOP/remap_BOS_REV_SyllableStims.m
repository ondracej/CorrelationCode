
function [] = remap_BOS_REV_SyllableStims()

equalLengths = 1;

fileToRemap = '/home/janie/Dropbox/INI/b20r10_REVBOSqBOSb20r1 01-byhandMotifSylls_DiffLengths.mat';
saveDir = '/home/janie/Data/INI/Data/Quadruplet/b20r1/Startstop/';
%saveDir = '/home/janie/Data/INI/Quadruplet/b20r1/Startstop/';

load(fileToRemap);

%% REV
rstart.s1 = stim3_start; % corresponding syl in BOS
rstart.s2 = stim2_start;
rstart.s3 = stim1_start;

rstop.s1 = stim3_stop; 
rstop.s2 = stim2_stop;
rstop.s3 = stim1_stop;


%% BOS
bstart.s1 = stim7_start; 
bstart.s2 = stim6_start;
bstart.s3 = stim5_start;

bstop.s1 = stim7_stop;
bstop.s2 = stim6_stop;
bstop.s3 = stim5_stop;


%% quiet BOS
blstart.s1 = stim11_start; 
blstart.s2 = stim10_start;
blstart.s3 = stim9_start;

blstop.s1 = stim11_stop;
blstop.s2 = stim10_stop;
blstop.s3 = stim9_stop;

fileName = 'b20r1 01-MOTIF_SYL_UniqueLengths';

%% if we want to make all the lenghts the same

if equalLengths

    %REV
    rs1Lengths = rstop.s1 - rstart.s1; 
    rs1meansLength = mean(rs1Lengths);
    rstop.s1 = rstart.s1 + rs1meansLength;
    
    rs2Lengths = rstop.s2 - rstart.s2; 
    rs2meansLength = mean(rs2Lengths);
    rstop.s2 = rstart.s2 + rs2meansLength;
    
    rs3Lengths = rstop.s3 - rstart.s3; 
    rs3meansLength = mean(rs3Lengths);
    rstop.s3 = rstart.s3 + rs3meansLength;
    
    %BOS
    bs1Lengths = bstop.s1 - bstart.s1; 
    bs1meansLength = mean(bs1Lengths);
    bstop.s1 = bstart.s1 + bs1meansLength;
    
    bs2Lengths = bstop.s2 - bstart.s2; 
    bs2meansLength = mean(bs2Lengths);
    bstop.s2 = bstart.s2 + bs2meansLength;
    
    bs3Lengths = bstop.s3 - bstart.s3; 
    bs3meansLength = mean(bs3Lengths);
    bstop.s3 = bstart.s3 + bs3meansLength;
    
    % qBOS
    bls1Lengths = blstop.s1 - blstart.s1; 
    bls1meansLength = mean(bls1Lengths);
    blstop.s1 = blstart.s1 + bls1meansLength;
    
    bls2Lengths = blstop.s2 - blstart.s2; 
    bls2meansLength = mean(bls2Lengths);
    blstop.s2 = blstart.s2 + bls2meansLength;
    
    bls3Lengths = blstop.s3 - blstart.s3; % corresponding syl in s2OS
    bls3meansLength = mean(bls3Lengths);
    blstop.s3 = blstart.s3 + bls3meansLength;
    
    
    fileName = 'b20r1 01-MOTIF_SYL_SameLengths';
end
    
saveName = [saveDir fileName];

save(saveName, 'rstart', 'rstop', 'bstart', 'bstop', 'blstart', 'blstop')
disp(saveName)


end
