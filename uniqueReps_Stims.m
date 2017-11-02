function [stim_info] = uniqueReps_Stims(this_stim, soundfile_vers)
%% Soundfile version
%% 1: 18 BOS
%% 2: 30 BOS
%% 3: 60 BOS
%% 5: 30 BOS (short version)

stim_info = [];

switch this_stim
    
    
    case 1
        %% WN SOF
        if soundfile_vers == 3
            stim_info.stim_reps = 3;
            stim_info.unique_stims = 10;
            
        elseif soundfile_vers == 5
            stim_info.stim_reps = 2;
            stim_info.unique_stims = 10;
            
        else
            stim_info.stim_reps = 2;
            stim_info.unique_stims = 20;
        end
        
        stim_info.spont_reps = (stim_info.stim_reps * stim_info.unique_stims) - 1;
        stim_info.spont_versions = 1;
        
        stim_info.motif_reps = [];
        stim_info.unique_motifs = [];
        
        
    case 2
        %% Pips, not used
        
    case 3
        %% Tones
        if soundfile_vers == 1 || 7
            stim_info.stim_reps = 4;
            stim_info.unique_stims = 5;
            
            stim_info.spont_reps = (stim_info.stim_reps * stim_info.unique_stims) - 1;
            stim_info.spont_versions = 1;
            
        else
            stim_info.stim_reps = [];
            stim_info.unique_stims = [];
            
            stim_info.spont_reps = [];
            stim_info.spont_versions = [];
            
        end
        
        stim_info.motif_reps = [];
        stim_info.unique_motifs = [];
        
        stim_info.spont_reps = (stim_info.stim_reps * stim_info.unique_stims) - 1;
        stim_info.spont_versions = 1;
        
        
    case 4
        %% Stacks
        if soundfile_vers == 3
            stim_info.stim_reps = [];
            stim_info.unique_stims = [];
            
            stim_info.spont_reps = [];
            stim_info.spont_versions = [];
            
        else
            stim_info.stim_reps = 4;
            stim_info.unique_stims = 5;
            
            stim_info.spont_reps = (stim_info.stim_reps * stim_info.unique_stims) - 1;
            stim_info.spont_versions = 1;
            
        end
        
        stim_info.spont_reps = (stim_info.stim_reps * stim_info.unique_stims) - 1;
        stim_info.spont_versions = 1;
        
        
    case 5
        %% Subsong, not used
        
    case 6
        %% REV
        if soundfile_vers == 3
            
            stim_info.stim_reps = 10;
            stim_info.unique_stims = 6;
            
        elseif soundfile_vers == 5
            stim_info.stim_reps = 3;
            stim_info.unique_stims = 10;
            
        else
            
            stim_info.stim_reps = 3;
            stim_info.unique_stims = 6;
            
        end
        
        
        stim_info.spont_reps = (stim_info.stim_reps * stim_info.unique_stims) - 1;
        stim_info.spont_versions = 1;
        
        
    case 7
        %% CON
        switch soundfile_vers
            case 1
                stim_info.stim_reps = 1;
                stim_info.unique_stims = 40;
                
            case {2, 4, 6}
                stim_info.stim_reps = 1;
                stim_info.unique_stims = 75;
                
            case 3
                stim_info.stim_reps = 1;
                stim_info.unique_stims = 100;
                
            case 5
                
                stim_info.stim_reps = [];
                stim_info.unique_stims = [];
                
            case 7
                stim_info.stim_reps = 1;
                stim_info.unique_stims = 38;
                
        end
        
        stim_info.spont_reps = (stim_info.stim_reps * stim_info.unique_stims) - 1;
        stim_info.spont_versions = 1;
        
        stim_info.motif_reps = [];
        stim_info.unique_motifs = [];
        
        
    case 8
        %% BOS
        switch soundfile_vers
            case {1, 7}
                stim_info.stim_reps = 3;
                stim_info.unique_stims = 6;
                
            case 2
                stim_info.stim_reps = 5;
                stim_info.unique_stims = 6;
                
            case 3
                stim_info.stim_reps = 10;
                stim_info.unique_stims = 6;
                
                
            case 4
                stim_info.stim_reps = 3;
                stim_info.unique_stims = 6;
                
            case 5
                stim_info.stim_reps = 3;
                stim_info.unique_stims = 10;
                
            case 6
                stim_info.stim_reps = 3;
                stim_info.unique_stims = 6;
                
        end
        
        stim_info.spont_reps = (stim_info.stim_reps * stim_info.unique_stims) - 1;
        stim_info.spont_versions = 1;
        
        
    case 9
        %% qBOS
        if soundfile_vers == 3
            
            stim_info.stim_reps = [];
            stim_info.unique_stims = [];
            
            stim_info.motif_reps = [];
            stim_info.unique_motifs = [];
            
            stim_info.spont_reps = [];
            stim_info.spont_versions = [];
            
            
        elseif soundfile_vers == 5
            
            stim_info.stim_reps = 3;
            stim_info.unique_stims = 10;
            stim_info.spont_reps = (stim_info.stim_reps * stim_info.unique_stims) - 1;
            stim_info.spont_versions = 1;
            
        else
            
            stim_info.stim_reps = 3;
            stim_info.unique_stims = 6;
            stim_info.spont_reps = (stim_info.stim_reps * stim_info.unique_stims) - 1;
            stim_info.spont_versions = 1;
            
        end
        
        
        
    case 10
        %% Call, not used
        
    case 11
        %% pBOS (perturbed BOS)
        if soundfile_vers == 3
            
            stim_info.stim_reps = [];
            stim_info.unique_stims = [];
            
            stim_info.motif_reps = [];
            stim_info.unique_motifs = [];
            
            stim_info.spont_reps = [];
            stim_info.spont_versions = [];
            
        else
            
            stim_info.stim_reps = 3;
            stim_info.unique_stims = 1;
            
            stim_info.motif_reps = 51;
            stim_info.unique_motifs = 1;
            
            stim_info.spont_reps = (stim_info.stim_reps * stim_info.unique_stims) - 1;
            stim_info.spont_versions = 1;
        end
        
        
    case 12
        %% WN-EOF
        if soundfile_vers == 3
            stim_info.stim_reps = 3;
            stim_info.unique_stims = 10;
            
            
            stim_info.spont_reps = (stim_info.stim_reps * stim_info.unique_stims) - 1;
            stim_info.spont_versions = 1;
            
        elseif soundfile_vers == 5
            stim_info.stim_reps = 2;
            stim_info.unique_stims = 10;
            
            stim_info.spont_reps = (stim_info.stim_reps * stim_info.unique_stims) - 1;
            stim_info.spont_versions = 1;
            
        else
            stim_info.stim_reps = 2;
            stim_info.unique_stims = 20;
            
            stim_info.spont_reps = (stim_info.stim_reps * stim_info.unique_stims) - 1;
            stim_info.spont_versions = 1;
            
        end
        
        stim_info.motif_reps = [];
        stim_info.unique_motifs = [];
        
end
