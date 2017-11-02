function [] = correctCONMotifFiles

%% Con motif Template

ConPt1 = load('/home/janie/Data/INI/Quadruplet/r6y11/Stimulus/r6y11r6y11A-f0011.lvd-byhandCON-motifsPart1.mat');
ConPt2 = load('/home/janie/Data/INI/Quadruplet/r6y11/Stimulus/r6y11r6y11A-f0011.lvd-byhandCON-motifsPart2.mat');
ConPt3 = load('/home/janie/Data/INI/Quadruplet/r6y11/Stimulus/r6y11r6y11A-f0011.lvd-byhandCON-motifsPart3.mat');
ConPt4 = load('/home/janie/Data/INI/Quadruplet/r6y11/Stimulus/r6y11r6y11A-f0011.lvd-byhandCON-motifsPart4.mat');

BOS_Rev_motifs = load('/home/janie/Data/INI/Quadruplet/r6y11/Stimulus/r6y11_extracell_r6y11A-f0011-byhandMotifs.mat');

%%

checkRev = load('/home/janie/Data/INI/Quadruplet/r6y11/Stimulus/Stimulusr6y11A-f0012.lvd-byhandMotifs.mat');

ConStart = 14875699;
REVStart = 4156993;

DiffCONs = ConPt1.stim1_start(1) - ConStart;
DiffREVs = checkRev.stim2_start(1) - REVStart;



otehrRev = BOS_Rev_motifs.rstart(1);
diffOtherRev = otehrRev - checkRev.stim2_start(1);











end