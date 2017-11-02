function [stim_info] = uniqueReps_Motifs(this_stim, startstop_motifs)
%% Soundfile version

stim_info = [];

switch this_stim
    
    case 6 % REV
        
        if isfield(startstop_motifs.rstart, 'A')
            stim_info.bout_reps = size(startstop_motifs.rstart.A, 1);
            stim_info.unique_bouts = 1;
        else
            stim_info.bout_reps = size(startstop_motifs.rstart, 1);
            stim_info.unique_bouts = 1;
        end
        
    case 7 % CON
        %startstop_motifs.cstart;
        stim_info.unique_bouts = size(startstop_motifs.cstart, 2);
        
        for j = 1:size(startstop_motifs.cstart, 2)
            stim_info.bout_reps(j) = size(startstop_motifs.cstart{j}, 1);
        end
        
    case 8 % BOS
        
        if isfield(startstop_motifs.bstart, 'A')
            stim_info.bout_reps = size(startstop_motifs.bstart.A, 1);
            stim_info.unique_bouts = 1;
        else
            stim_info.bout_reps = size(startstop_motifs.bstart, 1);
            stim_info.unique_bouts = 1;
        end
    case 9 %BOS quiet
        
        if isfield(startstop_motifs.blstart, 'A')
            stim_info.bout_reps = size(startstop_motifs.blstart.A, 1);
            stim_info.unique_bouts = 1;
        else    
            stim_info.bout_reps = size(startstop_motifs.blstart, 1);
            stim_info.unique_bouts = 1;
        end
end
