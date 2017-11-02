function [stim_selected_by_user, stim_names_selected] = mapStimsToCorrectInds(this_startstop_dir, soundfile_vers)

[stim_ids, stim_names] = create_stimuli_list(this_startstop_dir);

if isempty(stim_names)
    disp('You probably provided the wrong file for the "start-stop"-file. Please re-run the program.');
    stim_selected_by_user = [];
    stim_names_selected = [];
    return;
end

%% This part matches the stimulus selected to the actual index it is mapped to

if size(stim_names,2) < 5
    stim_selected_by_user = stim_ids;
    stim_names_selected = stim_names;
else
    
    switch soundfile_vers
        case {1, 7}
            stim_selected_by_user = [1 3 4 6 7 8 9 12];
            stim_names_selected  = {stim_names{[1 2 3 4 5 6 7 8]}};
            %stim_selected_by_user = stim_ids;
            %stim_names_selected  = stim_names;
            
        case 2
            
            stim_selected_by_user = [1 4 6 7 8 9 12];
            stim_names_selected  = {stim_names{[1 2 3 4 5 6 7]}};
            
        case 3
            
            stim_selected_by_user = [1 6 7 8 12];
            stim_names_selected  = {stim_names{[1 2 3 4 5]}};
            %stim_selected_by_user = stim_ids;
            %stim_names_selected = stim_names;
            
        case 4
            
            stim_selected_by_user = [1 4 6 7 8 9 12];
            stim_names_selected  = {stim_names{[1 2 3 4 5 6 7]}};
            
        case 5
            
            stim_selected_by_user = [1 4 6 8 9 12];
            stim_names_selected  = {stim_names{[1 2 3 4 5 6]}};
            
        case 6
            stim_selected_by_user = [1 4 6 7 8 9 12];
            stim_names_selected  = {stim_names{[1 2 3 4 5 6 7]}};
            
    end
end
%% EOF
