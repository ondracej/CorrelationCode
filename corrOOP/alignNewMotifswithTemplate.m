function [] = alignNewMotifswithTemplate

%% First Run stimAlin to figure out where the alignment points are



newMotifTemplateFile = '/home/janie/Data/INI/Quadruplet/y5y10/Startstop/y5y10 01-NEW_MOTIF.mat';
alignmentTimepointInNewDataFile_samps = 2751030;
saveDir = '/home/janie/Data/INI/Quadruplet/y5y10/Startstop/';
Filename = ['y5y10 12-NEW_MOTIF.mat'];

%%
saveName = [saveDir Filename];
tStartStops = load(newMotifTemplateFile);

%% First start stop is the first rev
t_rstart = tStartStops.rstart;
tFirstRStart = t_rstart(1);

diffBetweenTAndAlignmentPoint = alignmentTimepointInNewDataFile_samps - tFirstRStart; % This is always relative to the template, + means the align comes later in the template

%% ADJUST ALL THE STIMS

% REV
rstart = tStartStops.rstart + diffBetweenTAndAlignmentPoint;
rstop = tStartStops.rstop+ diffBetweenTAndAlignmentPoint;

%BOS
bstart = tStartStops.bstart + diffBetweenTAndAlignmentPoint;
bstop = tStartStops.bstop+ diffBetweenTAndAlignmentPoint;

%qBOS
blstart = tStartStops.blstart + diffBetweenTAndAlignmentPoint;
blstop = tStartStops.blstop + diffBetweenTAndAlignmentPoint;

%% CONS

nUniqueCONs = size(tStartStops.cstart, 2);

for j = 1:nUniqueCONs
    
    cstart{j} = tStartStops.cstart{j} + diffBetweenTAndAlignmentPoint;
    cstop{j} = tStartStops.cstop{j} + diffBetweenTAndAlignmentPoint;
end

save(saveName, 'cstart', 'cstop', 'rstart', 'rstop', 'bstart', 'bstop', 'blstart', 'blstop')
%save(saveName, 'cstart', 'cstop', 'rstart', 'rstop', 'bstart', 'bstop')
disp(['Saved: ' saveName])

%% Make sure to edit the data Base to include this new file!!!!
end
