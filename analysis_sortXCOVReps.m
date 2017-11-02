function[COV_sorted_C_matrix, COH_sorted_C_matrix] = analysis_sortXCOVReps(C_Matrix, OnOff_params, FR_meta, stim_selected_by_user)

%% This code sorts the calculations into unshuffled and shuffled comparisons

dbstop if error

%% Unpack Variables
channel_numbers = FR_meta.channel_numbers;
num_channels = FR_meta.num_channels;

unique_stims = OnOff_params.unique_stims;
reps = OnOff_params.reps;

COVs = C_Matrix.COVs;
COHs = C_Matrix.COHs;

%% Define the channel comparison
for n = 1 : num_channels
    this_chan1 = channel_numbers(n);
    
    for m = 1: num_channels
        
        if n >= m % We looked at mirrored comparisons
            continue,
        end
        
        this_chan2 = channel_numbers(m);
        
        COVchans = COVs{this_chan1, this_chan2};
        COHchans = COHs{this_chan1, this_chan2};
        
        test = [];
        test_numel = [];
        
        %% We do this to test whether there is actually corr analysis
        
        for a = 1:numel(COVchans)
            this_run = COVchans{a,:};
            test_empty(a) = sum(sum(cellfun(@(x) isempty(x), this_run)));
            test_numel(a) = numel(this_run);
        end
        if sum(test_empty) == sum(test_numel)
            continue
        end
        
        %% Define the specific reptition comparison
        %% Non shuffled (time-locked, TL) Shuffled (time-shuffled n+1), TS)
        
        for j = 1 : unique_stims
            
            TL_reps_this_stim = cell(1, reps);
            TS_reps_this_stim = cell(1, reps);
            
            runs = 1;
            
            for h = 1 : reps
                
                for g = 1 : reps
                    
                    d = h+1; % d is the n+1 shuffle
                    
                    if h == reps % if it the last rep, we take the first rep for d
                        d = 1;
                    end
                    
                    this_rep_comp_COV = COVchans{j,1}{h,g};
                    this_rep_comp_COH = COHchans{j,1}{h,g};
                    
                    this_rep_com_COV_TSnp1 = COVchans{j,1}{h,d};
                    this_rep_com_COH_TSnp1 = COHchans{j,1}{h,d};
                    
                    %figure; plot(this_rep_comp_COV, 'k'); hold on; plot(this_rep_com_COV_TSnp1, 'b'); plot(COVchans{j,1}{h,2}, 'r')
                    
                    %% If it is not empty, use different matrices for storing
                    % time locked and time shuffeled data
                    
                    if g == h % TL, identical rep, identical times
                        COV_TL_reps_this_stim{:,h} = this_rep_comp_COV;
                        COH_TL_reps_this_stim{:,h} = this_rep_comp_COH;
                        
                    else % TS, identical rep, non-identical times
                        
                        % all possible shuffled pairings in time
                        COV_TS_reps_this_stim{:,runs}  = this_rep_comp_COV;
                        COH_TS_reps_this_stim{:,runs}  = this_rep_comp_COH;
                        
                        % n+1 shuffled pairings in time
                        COV_TS_np1_reps_this_stim{:,h}  = this_rep_com_COV_TSnp1;
                        COH_TS_np1_reps_this_stim{:,h}  = this_rep_com_COH_TSnp1;
                        
                        runs = runs+1;
                    end
                    
                end
            end
            
            COV_all_stims_TL(j,:) = COV_TL_reps_this_stim;
            COH_all_stims_TL(j,:) = COH_TL_reps_this_stim;
            
            %% Con issue
            if stim_selected_by_user ~= 7 || OnOff_params.stim_analysis_type == 4 %% Not CON, or motifs
                
                COV_all_stims_TS(j,:) = COV_TS_reps_this_stim;
                COH_all_stims_TS(j,:) = COH_TS_reps_this_stim;
                
                COV_all_stims_TS_np1(j,:) = COV_TS_np1_reps_this_stim;
                COH_all_stims_TS_np1(j,:) = COH_TS_np1_reps_this_stim;
                
            else % CON (no identical repetitions present, set to NaN)
                COV_all_stims_TS(j,:) = NaN;
                COH_all_stims_TS(j,:) = NaN;
                
                COV_all_stims_TS_np1(j,:) = NaN;
                COH_all_stims_TS_np1(j,:) = NaN;
                
            end
            
        end
        
        % check to see if empty cells  = total number of cells
        if sum(sum(cellfun(@(x) isempty(x), COV_all_stims_TL))) == numel(COV_all_stims_TL)
            
            disp(['<<< No TL reps present for this channel comparison: Ch- ' num2str(this_chan1) ' | Ch-' num2str(this_chan2)])
            
            % Set matrix for channel comparison to empty;
            COV_matrix_TL{this_chan1, this_chan2} = [];
            COH_matrix_TL{this_chan1, this_chan2} = [];
            
            COV_matrix_TS{this_chan1, this_chan2} = [];
            COH_matrix_TS{this_chan1, this_chan2} = [];
            
            COV_matrix_TS_np1{this_chan1, this_chan2} = [];
            COH_matrix_TS_np1{this_chan1, this_chan2} = [];
            
        else
            COV_matrix_TL{this_chan1, this_chan2} = COV_all_stims_TL;
            COH_matrix_TL{this_chan1, this_chan2} = COH_all_stims_TL;
            
            COV_matrix_TS{this_chan1, this_chan2} = COV_all_stims_TS;
            COH_matrix_TS{this_chan1, this_chan2} = COH_all_stims_TS;
            
            COV_matrix_TS_np1{this_chan1, this_chan2} = COV_all_stims_TS_np1;
            COH_matrix_TS_np1{this_chan1, this_chan2} = COH_all_stims_TS_np1;
        end
        
    end
    
end

COV_sorted_C_matrix.TL = COV_matrix_TL;
COV_sorted_C_matrix.TS_all = COV_matrix_TS;
COV_sorted_C_matrix.TS_np1 = COV_matrix_TS_np1;


COH_sorted_C_matrix.TL = COH_matrix_TL;
COH_sorted_C_matrix.TS_all = COH_matrix_TS;
COH_sorted_C_matrix.TS_np1 = COH_matrix_TS_np1;

disp('<<< Finished sorting xCOV reps.');
end



