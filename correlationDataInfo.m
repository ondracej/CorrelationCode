function [raw_data_file_db] = correlationDataInfo()

%[exp_db, raw_data_file_db] = default_db_structure();

dbstop if error

%% Anatomical Reconstruction code:
%% Left side of setup
% M#1 = 30 degrees
% M#3 = 45 degrees
%% Right side of setup
% M#2 = 55 degrees
% M#4 = 45 degrees

%% %%%%%%%%%%%%%% %%
%% Janie's Extracellular Quadruplet Experiments
%% %%%%%%%%%%%%%% %%


% Raw File Counter
rfc = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% b20r1
%% b20r1 01 = 1
raw_data_file_db(rfc).birdID  = 1;
raw_data_file_db(rfc).bird_name  = 'b20r1';
raw_data_file_db(rfc).bird_age  = 470;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'b20r1 01';
raw_data_file_db(rfc).spike_file = 'b20r1 01-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 2;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [1 3 5 7];
raw_data_file_db(rfc).spikeforms = 'b20r1 01-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'all recordings made in birds left hemisphere';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'b20r1 01-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'b20r1 01-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'b20r1 01-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'b20r1 01-NEW_MOTIF.mat';
raw_data_file_db(rfc).MOTIF_SYL_startstop = 'b20r1 01-MOTIF_SYL_SameLengths.mat';

%% Specific Neuron Info
%%  (1) b20r1 01 - Chan 1
raw_data_file_db(rfc).chan_info(1).channel = 1;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 1;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw = 19.1718;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 17.8806;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 1659;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = 'contains 2 neurons, small one is saved on spike chan 7';

%%  (1) b20r1 01 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 10.0479;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 11.5642;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 2500;
raw_data_file_db(rfc).chan_info(2).ml = 1500;
raw_data_file_db(rfc).chan_info(2).dv = 2020;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = '';

%% (1) b20r1 01 - Chan 4 - No recording

%%  (1) b20r1 01 - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = 3;
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 5.5085;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 6.9563;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 3500;
raw_data_file_db(rfc).chan_info(3).ml = 1000;
raw_data_file_db(rfc).chan_info(3).dv = 2511;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = 'contains crosstalk from ch 3';

%%  (1) b20r1 01 - Chan 7(1)
raw_data_file_db(rfc).chan_info(4).channel = 1;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 7;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 6.4568;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 7.7398;

raw_data_file_db(rfc).chan_info(4).manipulator = 1;
raw_data_file_db(rfc).chan_info(4).ap = 0;
raw_data_file_db(rfc).chan_info(4).ml = 1400;
raw_data_file_db(rfc).chan_info(4).dv = 1659;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(4).notes = 'small neuron from ch 1';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% (2) b20r1 02 = 2
raw_data_file_db(rfc).birdID  = 1;
raw_data_file_db(rfc).bird_name  = 'b20r1';
raw_data_file_db(rfc).bird_age  = 470;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'b20r1 02';
raw_data_file_db(rfc).spike_file = 'b20r1 02-0-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 2;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [1 3 4 5 7];
raw_data_file_db(rfc).spikeforms = 'b20r1 02-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'all recordings made in birds left hemisphere';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).BOUT_startstop = 'b20r1 02-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'b20r1 02-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'b20r1 02-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'b20r1 02-NEW_MOTIF.mat';

%% Specific Neuron Info
%%  (2) b20r1 02 - Chan 1
raw_data_file_db(rfc).chan_info(1).channel = 1;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 1;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc+1; rfc+2];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [1];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = 4;
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw = 6.3979;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 6.8510;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 931;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'crosstalk from ch 4; duplicate neuron; might be a little dorsal for L2b';

%%  (2) b20r1 02 - Chan 3 
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [5];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  8.0426;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 9.1042;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 2500;
raw_data_file_db(rfc).chan_info(2).ml = 1500;
raw_data_file_db(rfc).chan_info(2).dv = 2194;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = 'tiny crosstalk from ch 5, duplicate neuron';

%%  (2) b20r1 02 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc+1; rfc+2;];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  18.0097;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  22.9870;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 400;
raw_data_file_db(rfc).chan_info(3).ml = 1100;
raw_data_file_db(rfc).chan_info(3).dv = 1020;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(3).notes = 'ch contains 2 spikes, small one = spk ch 7; duplicate neuron';

%%  (2) b20r1 02 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = 3;
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =  16.0304;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =  21.6417;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 3500;
raw_data_file_db(rfc).chan_info(4).ml = 1000;
raw_data_file_db(rfc).chan_info(4).dv = 2633;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(4).notes = 'crosstalk from ch 3; duplicate neuron; major 50Hz noise';

%%  (2) b20r1 02 - Chan 7(4)
raw_data_file_db(rfc).chan_info(5).channel = 4;
raw_data_file_db(rfc).chan_info(5).spikefile_index = 7;
raw_data_file_db(rfc).chan_info(5).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(5).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(5).same_as_spike_chan = [7];
raw_data_file_db(rfc).chan_info(5).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(5).SN_ratio_raw =  5.2937;
raw_data_file_db(rfc).chan_info(5).SN_ratio_fil = 6.4525;

raw_data_file_db(rfc).chan_info(5).manipulator = 3;
raw_data_file_db(rfc).chan_info(5).ap = 400;
raw_data_file_db(rfc).chan_info(5).ml = 1100;
raw_data_file_db(rfc).chan_info(5).dv = 1020;
raw_data_file_db(rfc).chan_info(5).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(5).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(5).notes = 'small spike from ch 4; duplicate neuron';

rfc = rfc +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (3) b20r1 03 = 3
raw_data_file_db(rfc).birdID  = 1;
raw_data_file_db(rfc).bird_name  = 'b20r1';
raw_data_file_db(rfc).bird_age  = 470;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'b20r1 03';
raw_data_file_db(rfc).spike_file = 'b20r1 03-0-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 2;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [1 3 4 5 7];
raw_data_file_db(rfc).spikeforms = 'b20r1 03-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'all neurons here are the same as in b20r1 02';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).BOUT_startstop = 'b20r1 03-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'b20r1 03-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'b20r1 03-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'b20r1 03-NEW_MOTIF';

%% Specific Neuron Info
%%  (3) b20r1 03 - Chan 1
raw_data_file_db(rfc).chan_info(1).channel = 1;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 1;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc-1; rfc+1;];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [1];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = 4;
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =   4.8783;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  5.8896;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 931;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'crosstalk from ch 4; duplicate neuron; might be a little dorsal for L2b';

%%  (3) b20r1 03 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [5];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =   4.9658;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  5.4644;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 2500;
raw_data_file_db(rfc).chan_info(2).ml = 1500;
raw_data_file_db(rfc).chan_info(2).dv = 2194;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = 'very small s/n, sorted through REV (around 370); duplicate neuron, crosstalk from ch 5';

%%  (3) b20r1 03 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1; rfc+1];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =   14.5875;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  17.7323;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 400;
raw_data_file_db(rfc).chan_info(3).ml = 1100;
raw_data_file_db(rfc).chan_info(3).dv = 1020;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(3).notes = 'ch contains 2 spikes, small one = spk ch 7; duplicate neurons';

%%  (3) b20r1 03 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = 3;
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =   17.3802;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =  25.3842;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 3500;
raw_data_file_db(rfc).chan_info(4).ml = 1000;
raw_data_file_db(rfc).chan_info(4).dv = 2633;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(4).notes = 'crosstalk from ch 3; duplicate neuron, major 50 Hz noise';

%%  (3) b20r1 03 - Chan 7(4)
raw_data_file_db(rfc).chan_info(5).channel = 4;
raw_data_file_db(rfc).chan_info(5).spikefile_index = 7;
raw_data_file_db(rfc).chan_info(5).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(5).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(5).same_as_spike_chan = [7];
raw_data_file_db(rfc).chan_info(5).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(5).SN_ratio_raw =   3.6955;
raw_data_file_db(rfc).chan_info(5).SN_ratio_fil = 4.4045;

raw_data_file_db(rfc).chan_info(5).manipulator = 3;
raw_data_file_db(rfc).chan_info(5).ap = 400;
raw_data_file_db(rfc).chan_info(5).ml = 1100;
raw_data_file_db(rfc).chan_info(5).dv = 1020;
raw_data_file_db(rfc).chan_info(5).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(5).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(5).notes = 'small spike from ch 4; duplicate neuron';

rfc = rfc +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (4) b20r1 04 = 4
raw_data_file_db(rfc).birdID  = 1;
raw_data_file_db(rfc).bird_name  = 'b20r1';
raw_data_file_db(rfc).bird_age  = 470;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'b20r1 04';
raw_data_file_db(rfc).spike_file = 'b20r1 04-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 2;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [1 3 4];
raw_data_file_db(rfc).spikeforms = 'b20r1 04-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'some neurons here are the same as in b20r1 02/b20r1 03';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).BOUT_startstop = 'b20r1 04-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'b20r1 04-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'b20r1 04-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'b20r1 04-NEW_MOTIF';

% Specific Neuron Info
%%  (4) b20r1 04 - Chan 1
raw_data_file_db(rfc).chan_info(1).channel = 1;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 1;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc-1; rfc-2;];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [1];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = 4;
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw = 5.9027;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  6.9805;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 932;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'crosstalk from ch 4; duplicate neuron; might be a little dorsal for L2b';
%%  (4) b20r1 04 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  10.1199;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  13.5744;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 2500;
raw_data_file_db(rfc).chan_info(2).ml = 1500;
raw_data_file_db(rfc).chan_info(2).dv = 1528;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = 'something happened @ around 800 (during CON) last 8 reps of CON are deleted; This spike wavefore looks like 2 spikes';

%%  (4) b20r1 04 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;%
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1; rfc-2; ];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  17.4721;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 20.5528;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 400;
raw_data_file_db(rfc).chan_info(3).ml = 1100;
raw_data_file_db(rfc).chan_info(3).dv = 1020;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(3).notes = 'ch contains 2 spikes, small one not sorted; duplicate neurons';

%%  (4) b20r1 04 - Chan 5 - Not sorted, too messy

rfc = rfc +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (5) g4r4 01 = 5
%%  
raw_data_file_db(rfc).birdID  = 2;
raw_data_file_db(rfc).bird_name  = 'g4r4';
raw_data_file_db(rfc).bird_age  = 135;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'g4r4 01';
raw_data_file_db(rfc).spike_file = 'g4r4 01-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 4 5];
raw_data_file_db(rfc).spikeforms = 'g4r4 01-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'Tried to do some intracellular recordings with this data';

% playback info
raw_data_file_db(rfc).soundfile_vers = 4;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'g4r4 01-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'g4r4 01-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'g4r4 01-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'g4r4 01-NEW_MOTIF.mat';

%% Specific Neuron Info
%% (5) g4r4 01 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  10.0555;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  12.7185;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 852;
raw_data_file_db(rfc).chan_info(1).putative_area = 'HVC';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 5;
raw_data_file_db(rfc).chan_info(1).notes = 'might be an HVC neuron?';

%% (5) g4r4 01 - Chan 3 - 2+ neurons with bursts, cant sort

%% (5) g4r4 01 - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 18.5609;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 24.6704;

raw_data_file_db(rfc).chan_info(2).manipulator = 3;
raw_data_file_db(rfc).chan_info(2).ap = 700;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 754;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = '';

%% (5) g4r4 01 - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc+1; rfc+2;];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 39.9645;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  44.2555;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 4000;
raw_data_file_db(rfc).chan_info(3).ml = 1400;
raw_data_file_db(rfc).chan_info(3).dv = 1095;
raw_data_file_db(rfc).chan_info(3).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(3).notes = '';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (6) g4r4 02 = rfc = 6
%%  
raw_data_file_db(rfc).birdID  = 2;
raw_data_file_db(rfc).bird_name  = 'g4r4';
raw_data_file_db(rfc).bird_age  = 135;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'g4r4 02';

raw_data_file_db(rfc).spike_file = 'g4r4 02-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5];
raw_data_file_db(rfc).spikeforms = 'g4r4 02-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'Tried to do some intracellular recordings with this data';

% playback info
raw_data_file_db(rfc).soundfile_vers = 4;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'g4r4 02-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'g4r4 02-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'g4r4 02-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'g4r4 02-NEW_MOTIF.mat';

%% Specific Neuron Info
%% (6) g4r4 02 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  8.7811;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  10.3798;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 911;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'Could also be HVC?';

%% (6) g4r4 02 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  19.7765;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  27.3937;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3500;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 852;
raw_data_file_db(rfc).chan_info(2).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(2).notes = '';

%% (6) g4r4 02 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 9.9480;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 13.6237;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 700;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1220;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = '';

%% (6) g4r4 02 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc-1; rfc+1;];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 16.8324;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =  17.1720;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 4000;
raw_data_file_db(rfc).chan_info(4).ml = 1400;
raw_data_file_db(rfc).chan_info(4).dv = 1095;
raw_data_file_db(rfc).chan_info(4).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(4).notes = '';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (7) g4r4 03 = rfc = 7
%%  
raw_data_file_db(rfc).birdID  = 2;
raw_data_file_db(rfc).bird_name  = 'g4r4';
raw_data_file_db(rfc).bird_age  = 135;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'g4r4 03';
raw_data_file_db(rfc).spike_file = 'g4r4 03-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 3 5];
raw_data_file_db(rfc).spikeforms = 'g4r4 03-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'Tried to do some intracellular recordings with this data';

% playback info
raw_data_file_db(rfc).soundfile_vers = 4;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'g4r4 03-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'g4r4 03-MOTIF';
raw_data_file_db(rfc).SPONT_startstop = 'g4r4 03-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'g4r4 03-NEW_MOTIF.mat';

%% Specific Neuron Info
%% (7) g4r4 03 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  17.2589;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  20.0615;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 1355;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = '';

%% (7) g4r4 03 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [5];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =   18.9702;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =   19.8383;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3500;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 852;
raw_data_file_db(rfc).chan_info(2).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(2).notes = '';

%% (7) g4r4 03 - Chan 4 - lost neuron at 156s

%% (7) g4r4 03 - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1; rfc-2;];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  30.6781;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =   32.7690;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 4000;
raw_data_file_db(rfc).chan_info(3).ml = 1400;
raw_data_file_db(rfc).chan_info(3).dv = 1095;
raw_data_file_db(rfc).chan_info(3).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(3).notes = '';


rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (8) g4r4 04 = rfc = 8
%%  
raw_data_file_db(rfc).birdID  = 2;
raw_data_file_db(rfc).bird_name  = 'g4r4';
raw_data_file_db(rfc).bird_age  = 135;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'g4r4 04';
raw_data_file_db(rfc).spike_file = 'g4r4 04-0-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5 7];
raw_data_file_db(rfc).spikeforms = 'g4r4 04-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'Tried to do some intracellular recordings with this data';

% playback info
raw_data_file_db(rfc).soundfile_vers = 4;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'g4r4 04-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'g4r4 04-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'g4r4 04-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'g4r4 04-NEW_MOTIF.mat';

%% Specific Neuron Info
%% (8) g4r4 04 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  23.3839;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =   23.7075;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 486;
raw_data_file_db(rfc).chan_info(1).putative_area = 'HVC';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 5;
raw_data_file_db(rfc).chan_info(1).notes = '';

%% (8) g4r4 04 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [5];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =   20.9629;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  28.0619 ;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3500;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 1376;
raw_data_file_db(rfc).chan_info(2).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(2).notes = '';

%% (8) g4r4 04 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 15.2154;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 15.9361;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 700;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 841;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(3).notes = '2 neurons, did not sort small one (only ~ 630 spikes)';

%% (8) g4r4 04 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =  66.8599 ;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =   72.0943;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 4000;
raw_data_file_db(rfc).chan_info(4).ml = 1400;
raw_data_file_db(rfc).chan_info(4).dv = 1095;
raw_data_file_db(rfc).chan_info(4).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(4).notes = 'Lost neuron during WNEOF; cross talk from ch 3';

%% (8) g4r4 04 - Chan 7(5)
raw_data_file_db(rfc).chan_info(5).channel = 5;
raw_data_file_db(rfc).chan_info(5).spikefile_index = 7;
raw_data_file_db(rfc).chan_info(5).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(5).same_as_ind = [];
raw_data_file_db(rfc).chan_info(5).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(5).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(5).SN_ratio_raw =   18.9289;
raw_data_file_db(rfc).chan_info(5).SN_ratio_fil =    21.2025;

raw_data_file_db(rfc).chan_info(5).manipulator = 4;
raw_data_file_db(rfc).chan_info(5).ap = 4000;
raw_data_file_db(rfc).chan_info(5).ml = 1400;
raw_data_file_db(rfc).chan_info(5).dv = 1095;
raw_data_file_db(rfc).chan_info(5).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(5).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(5).notes = 'neuron from ch 5, lost neuron during WNEOF';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (9) g4r4 05 = rfc = 9
%%  
raw_data_file_db(rfc).birdID  = 2;
raw_data_file_db(rfc).bird_name  = 'g4r4';
raw_data_file_db(rfc).bird_age  = 135;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'g4r4 05';
raw_data_file_db(rfc).spike_file = 'g4r4 05-0-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 3 5 7 8];
raw_data_file_db(rfc).spikeforms = 'g4r4 05-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'Tried to do some intracellular recordings with this data';

% playback info
raw_data_file_db(rfc).soundfile_vers = 4;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'g4r4 05-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'g4r4 05-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'g4r4 05-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'g4r4 05-NEW_MOTIF.mat';

%% Specific Neuron Info
%% (9) g4r4 05 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  13.8231;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  16.4546;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 1448;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = '';

%% (9) g4r4 05 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [5];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =   17.1546;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =   21.0203;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3500;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 761;
raw_data_file_db(rfc).chan_info(2).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(2).notes = '';

%% (9) g4r4 05 - Chan 4 - No recording

%% (9) g4r4 05 - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  39.1360;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  39.7773;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 4000;
raw_data_file_db(rfc).chan_info(3).ml = 1400;
raw_data_file_db(rfc).chan_info(3).dv = 2567;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = '1 huge spike and 2 smaller neurons (ch7, ch8)';

%% (9) g4r4 05 - Chan 7(5)
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 7;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =  2.9513;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =  3.0235;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 4000;
raw_data_file_db(rfc).chan_info(4).ml = 1400;
raw_data_file_db(rfc).chan_info(4).dv = 2567;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(4).notes = 'this is a small spike found on ch5, mostly upgoing rounded spikes';

%% (9) g4r4 05 - Chan 8(5)
raw_data_file_db(rfc).chan_info(5).channel = 5;
raw_data_file_db(rfc).chan_info(5).spikefile_index = 8;
raw_data_file_db(rfc).chan_info(5).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(5).same_as_ind = [];
raw_data_file_db(rfc).chan_info(5).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(5).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(5).SN_ratio_raw = 2.6140;
raw_data_file_db(rfc).chan_info(5).SN_ratio_fil = 2.6375;

raw_data_file_db(rfc).chan_info(5).manipulator = 4;
raw_data_file_db(rfc).chan_info(5).ap = 4000;
raw_data_file_db(rfc).chan_info(5).ml = 1400;
raw_data_file_db(rfc).chan_info(5).dv = 2567;
raw_data_file_db(rfc).chan_info(5).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(5).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(5).notes = 'This is another small spike found on ch5, it is burst and has a sharp bipolar shape';

rfc = rfc+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% (10) g18r2 01 = 10
raw_data_file_db(rfc).birdID  = 3;
raw_data_file_db(rfc).bird_name  = 'g18r2';
raw_data_file_db(rfc).bird_age  = 263;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'g18r2 01';
raw_data_file_db(rfc).spike_file = 'g18r2 01-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5];
raw_data_file_db(rfc).spikeforms = 'g18r2 01-Spkforms.mat';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 1;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'g18r2 01-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'g18r2 01-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'g18r2 01-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'g18r2 01-NEW_MOTIF.mat';

%% (10) g18r2 01 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [2];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw = 12.5570;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 14.7746;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 600;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 1236;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = '';

%% (10) g18r2 01 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 11.6536;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  13.1729;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 2500;
raw_data_file_db(rfc).chan_info(2).ml = 1000;
raw_data_file_db(rfc).chan_info(2).dv = 1360;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = '';

%% (10) g18r2 01 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  17.2981;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  19.4294;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1000;
raw_data_file_db(rfc).chan_info(3).dv = 1148;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(3).notes = '';


%% (10) g18r2 01 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 27.8334;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 29.5416;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 2000;
raw_data_file_db(rfc).chan_info(4).ml = 1200;
raw_data_file_db(rfc).chan_info(4).dv = 1578;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(4).notes = '';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (11) g18r2 02 = 11
raw_data_file_db(rfc).birdID  = 3;
raw_data_file_db(rfc).bird_name  = 'g18r2';
raw_data_file_db(rfc).bird_age  = 263;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'g18r2 02';
raw_data_file_db(rfc).spike_file = 'g18r2 02-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5];
raw_data_file_db(rfc).spikeforms = 'g18r2 02-Spkforms.mat';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 1;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'g18r2 02-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'g18r2 02-MOTIF.matc';
raw_data_file_db(rfc).SPONT_startstop = 'g18r2 02-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'g18r2 02-NEW_MOTIF.mat';

%% (11) g18r2 02 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [2];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  12.7131;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =   14.9103;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 600;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 1236;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = '';

%% (11) g18r2 02 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  8.0788;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =   9.3482;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 2500;
raw_data_file_db(rfc).chan_info(2).ml = 1000;
raw_data_file_db(rfc).chan_info(2).dv = 1360;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = '';

%% (11) g18r2 02 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 12.5829;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  13.4209;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1000;
raw_data_file_db(rfc).chan_info(3).dv = 1148;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(3).notes = '';


%% (11) g18r2 02 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 22.5665;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 24.4080;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 2000;
raw_data_file_db(rfc).chan_info(4).ml = 1200;
raw_data_file_db(rfc).chan_info(4).dv = 1578;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(4).notes = 'some movement artifacts here';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (12) g18r2 03 = 12
raw_data_file_db(rfc).birdID  = 3;
raw_data_file_db(rfc).bird_name  = 'g18r2';
raw_data_file_db(rfc).bird_age  = 263;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'g18r2 03';
raw_data_file_db(rfc).spike_file = 'g18r2 03-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [3 5];
raw_data_file_db(rfc).spikeforms = 'g18r2 03-Spkforms.mat';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 1;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'g18r2 03-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'g18r2 03-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'g18r2 03-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'g18r2 03-NEW_MOTIF.mat';

%% (12) g18r2 03 - Chan 2 - Lost cell

%% (12) g18r2 03 - Chan 3
raw_data_file_db(rfc).chan_info(1).channel = 3;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =   19.4469;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =   23.2417;

raw_data_file_db(rfc).chan_info(1).manipulator = 2;
raw_data_file_db(rfc).chan_info(1).ap = 2500;
raw_data_file_db(rfc).chan_info(1).ml = 1000;
raw_data_file_db(rfc).chan_info(1).dv = 1328;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = '';

%% (12) g18r2 03 - Chan 4 - No recording

%% (12) g18r2 03 - Chan 5
raw_data_file_db(rfc).chan_info(2).channel = 5;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  10.9268;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 11.6152;

raw_data_file_db(rfc).chan_info(2).manipulator = 4;
raw_data_file_db(rfc).chan_info(2).ap = 2000;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 999;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = '';

rfc = rfc +1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (13) g18r2 04 = 13
raw_data_file_db(rfc).birdID  = 3;
raw_data_file_db(rfc).bird_name  = 'g18r2';
raw_data_file_db(rfc).bird_age  = 263;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'g18r2 04';
raw_data_file_db(rfc).spike_file = 'g18r2 04-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 4 5];
raw_data_file_db(rfc).spikeforms = 'g18r2 04-Spkforms.mat';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 1;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'g18r2 04-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'g18r2 04-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'g18r2 04-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'g18r2 04-NEW_MOTIF.mat';

%% (13) g18r2 04 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =   30.8277;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  37.3056;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 600;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 1719;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = 'another small spike present, really tiny, didnt sort';

%% (13) g18r2 04 - Chan 3 - Lost cell

%% (13) g18r2 04 - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  23.3721;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =   24.4631;

raw_data_file_db(rfc).chan_info(2).manipulator = 3;
raw_data_file_db(rfc).chan_info(2).ap = 500;
raw_data_file_db(rfc).chan_info(2).ml = 1000;
raw_data_file_db(rfc).chan_info(2).dv = 1067;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = '';


%% (13) g18r2 04 - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 15.4773;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 16.5615;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 2000;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1915;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(3).notes = 'Lost neuron at end of WNBOF -';

rfc = rfc +1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% (14) k17r4 01 = 14
raw_data_file_db(rfc).birdID  = 4;
raw_data_file_db(rfc).bird_name  = 'k17r4';
raw_data_file_db(rfc).bird_age  = 149;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'k17r4 01';
raw_data_file_db(rfc).spike_file = 'k17r4 01-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 5];
raw_data_file_db(rfc).spikeforms = 'k17r4 01-Spkforms.mat';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 1;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'k17r4 01-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'k17r4 01-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'k17r4 01-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'k17r4 01-NEW_MOTIF.mat';

%%   (14) k17r4 01 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw = 18.2213;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  21.1005;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 500;
raw_data_file_db(rfc).chan_info(1).ml = 1000;
raw_data_file_db(rfc).chan_info(1).dv = 1365;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = '';

%%   (14) k17r4 01 - Chan 3 - No recording
%%   (14) k17r4 01 - Chan 4 - Lost cell

%%   (14) k17r4 01 - Chan 5
raw_data_file_db(rfc).chan_info(2).channel = 5;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  15.7654;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  17.1745;

raw_data_file_db(rfc).chan_info(2).manipulator = 4;
raw_data_file_db(rfc).chan_info(2).ap = 2500;
raw_data_file_db(rfc).chan_info(2).ml = 1400;
raw_data_file_db(rfc).chan_info(2).dv = 1120;
raw_data_file_db(rfc).chan_info(2).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(2).notes = 'seems to be 2 neurons present, small one not sorted <400 spikes';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (15) k17r4 02 = 15
raw_data_file_db(rfc).birdID  = 4;
raw_data_file_db(rfc).bird_name  = 'k17r4';
raw_data_file_db(rfc).bird_age  = 149;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'k17r4 02';
raw_data_file_db(rfc).spike_file = 'k17r4 02-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 3 5 7];
raw_data_file_db(rfc).spikeforms = 'k17r4 02-Spkforms.mat';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 1;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'k17r4 02-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'k17r4 02-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'k17r4 02-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'k17r4 02-NEW_MOTIF.mat';

%% (15) k17r4 02 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  13.8673;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  17.3839;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 500;
raw_data_file_db(rfc).chan_info(1).ml = 1000;
raw_data_file_db(rfc).chan_info(1).dv = 1248;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = '';

%% (15) k17r4 02 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  17.1874;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  18.6445;

raw_data_file_db(rfc).chan_info(2).manipulator = 3;
raw_data_file_db(rfc).chan_info(2).ap = 100;
raw_data_file_db(rfc).chan_info(2).ml = 1400;
raw_data_file_db(rfc).chan_info(2).dv = 1018;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = '';

%% (15) k17r4 02 - Chan 4 - Lost cell

%% (15) k17r4 02 - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  9.6672;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  10.3058;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 2500;
raw_data_file_db(rfc).chan_info(3).ml = 1400;
raw_data_file_db(rfc).chan_info(3).dv = 1120;
raw_data_file_db(rfc).chan_info(3).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(3).notes = '2 neurons on this channel, Huge one - Ch7';


%% (15) k17r4 02 - Chan 7(5)
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 7;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =  34.1412;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =  35.3810;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 2500;
raw_data_file_db(rfc).chan_info(4).ml = 1400;
raw_data_file_db(rfc).chan_info(4).dv = 1120;
raw_data_file_db(rfc).chan_info(4).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(4).notes = 'Huge spike from ch 5';


rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (16) k17r4 03 = 16
raw_data_file_db(rfc).birdID  = 4;
raw_data_file_db(rfc).bird_name  = 'k17r4';
raw_data_file_db(rfc).bird_age  = 149;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'k17r4 03';
raw_data_file_db(rfc).spike_file = 'k17r4 03-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [3 4 5];
raw_data_file_db(rfc).spikeforms = 'k17r4 03-Spkforms.mat';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 1;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'k17r4 03-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'k17r4 03-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'k17r4 03-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'k17r4 03-NEW_MOTIF.mat';

%% (16) k17r4 03 - Chan 2 - No cell

%% (16) k17r4 03 - Chan 3
raw_data_file_db(rfc).chan_info(1).channel = 3;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw = 10.6278;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =   13.1602;

raw_data_file_db(rfc).chan_info(1).manipulator = 3;
raw_data_file_db(rfc).chan_info(1).ap = 100;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 1180;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = '';

%% (16) k17r4 03 - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =   11.2884;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =   12.4076;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 2250;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 1880;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = '';


%% (16) k17r4 03 - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =   26.0713;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =   27.8106;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 2500;
raw_data_file_db(rfc).chan_info(3).ml = 1400;
raw_data_file_db(rfc).chan_info(3).dv = 1175;
raw_data_file_db(rfc).chan_info(3).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(3).notes = '';

rfc = rfc +1;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (17) k18r4 01  Many duplicate neurons - do not use

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%  (17) k18r4 02 = 18
raw_data_file_db(rfc).birdID  = 5;
raw_data_file_db(rfc).bird_name  = 'k18r4';
raw_data_file_db(rfc).bird_age  = 164;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'k18r4 02';
raw_data_file_db(rfc).spike_file = 'k18r4 02-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = [];% no mic recorded
raw_data_file_db(rfc).neuron_chans = [2 4 5 7];
raw_data_file_db(rfc).spikeforms = 'k18r4 02-Spkforms.mat';
raw_data_file_db(rfc).other_notes = '';

% playback infoqUA
raw_data_file_db(rfc).soundfile_vers = 6;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'k18r4 02-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'k18r4 02-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'k18r4 02-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'k18r4 02-NEW_MOTIF.mat';

%%  (17) k18r4 02 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [2];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw = 12.8711;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 14.4521;

raw_data_file_db(rfc).chan_info(1).manipulator = 2;
raw_data_file_db(rfc).chan_info(1).ap = 2000;
raw_data_file_db(rfc).chan_info(1).ml = 1000;
raw_data_file_db(rfc).chan_info(1).dv = 2188;
raw_data_file_db(rfc).chan_info(1).putative_area = 'NCM';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 7;
raw_data_file_db(rfc).chan_info(1).notes = '';

%%  (17) k18r4 02 - Chan 3 - No recording

%%   (17) k18r4 02 - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 21.7528;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 22.9283;

raw_data_file_db(rfc).chan_info(2).manipulator = 3;
raw_data_file_db(rfc).chan_info(2).ap = 500;
raw_data_file_db(rfc).chan_info(2).ml = 1400;
raw_data_file_db(rfc).chan_info(2).dv = 1492;
raw_data_file_db(rfc).chan_info(2).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(2).notes = '';


%% (17) k18r4 02  - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  14.1769;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 14.2721;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 2200;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1387;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(3).notes = 'Two v correlated neurons, smaller preemptive spike is on Ch 7';

%% (17) k18r4 02  - Chan 7 (5)
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 7;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [7];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 6.4678;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 6.6964;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 2200;
raw_data_file_db(rfc).chan_info(4).ml = 1200;
raw_data_file_db(rfc).chan_info(4).dv = 1387;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(4).notes = 'preemptive spike from ch 5';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (18) k18r4 03 = 18
raw_data_file_db(rfc).birdID  = 5;
raw_data_file_db(rfc).bird_name  = 'k18r4';
raw_data_file_db(rfc).bird_age  = 164;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'k18r4 03';
raw_data_file_db(rfc).spike_file = 'k18r4 03-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = [];% no mic recorded
raw_data_file_db(rfc).neuron_chans = [2 4 5 7];
raw_data_file_db(rfc).spikeforms = 'k18r4 03-Spkforms.mat';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 6;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'k18r4 03-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'k18r4 03-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'k18r4 03-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'k18r4 03-NEW_MOTIF.mat';

%%  (18) k18r4 03 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [2];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw = 9.4677;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  9.9756;

raw_data_file_db(rfc).chan_info(1).manipulator = 2;
raw_data_file_db(rfc).chan_info(1).ap = 2000;
raw_data_file_db(rfc).chan_info(1).ml = 1000;
raw_data_file_db(rfc).chan_info(1).dv = 2188;
raw_data_file_db(rfc).chan_info(1).putative_area = 'NCM';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 7;
raw_data_file_db(rfc).chan_info(1).notes = 'lost cell after WNBOF';

%%   (18) k18r4 03 - Chan 3 - No recording

%%   (18) k18r4 03 - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 17.8530;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 19.3668;

raw_data_file_db(rfc).chan_info(2).manipulator = 3;
raw_data_file_db(rfc).chan_info(2).ap = 500;
raw_data_file_db(rfc).chan_info(2).ml = 1400;
raw_data_file_db(rfc).chan_info(2).dv = 1564;
raw_data_file_db(rfc).chan_info(2).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(2).notes = '';


%% (18) k18r4 03  - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 16.6744;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 16.0948;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 2200;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1388;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(3).notes = '';

%% (18) k18r4 03  - Chan 7 (5)
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 7;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [7];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 8.2949;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =  8.7548;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 2200;
raw_data_file_db(rfc).chan_info(4).ml = 1200;
raw_data_file_db(rfc).chan_info(4).dv = 1388;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(4).notes = '';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%%  (19) o1r4 01 = 19
raw_data_file_db(rfc).birdID  = 6;
raw_data_file_db(rfc).bird_name  = 'o1r4';
raw_data_file_db(rfc).bird_age  = 167;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'o1r4 01';
raw_data_file_db(rfc).spike_file = 'o1r4 01-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 5;
raw_data_file_db(rfc).neuron_chans = [2 4 7];
raw_data_file_db(rfc).spikeforms = 'o1r4 01-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'All recordings on birds R hemisphere';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'o1r4 01-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'o1r4 01-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'o1r4 01-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'o1r4 01-NEW_MOTIF.mat';

%%  (19) o1r4 01 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw = 22.8701;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 24.5076;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1000;
raw_data_file_db(rfc).chan_info(1).dv = 1109;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = '';

%%  (19) o1r4 01 - Chan 3 - there are 2 small neurons, hard to sort

%%  (19) o1r4 01 - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 7.4219;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  9.9580;

raw_data_file_db(rfc).chan_info(2).manipulator = 3;
raw_data_file_db(rfc).chan_info(2).ap = 500;
raw_data_file_db(rfc).chan_info(2).ml = 1000;
raw_data_file_db(rfc).chan_info(2).dv = 819;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = '';

%%  (19) o1r4 01 - Chan 7 (2)
raw_data_file_db(rfc).chan_info(3).channel = 2;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 7;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 4.2291;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 4.6812;

raw_data_file_db(rfc).chan_info(3).manipulator = 1;
raw_data_file_db(rfc).chan_info(3).ap = 0;
raw_data_file_db(rfc).chan_info(3).ml = 1000;
raw_data_file_db(rfc).chan_info(3).dv = 1109;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(3).notes = '';


rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (20) o1r4 02 = 20
raw_data_file_db(rfc).birdID  = 6;
raw_data_file_db(rfc).bird_name  = 'o1r4';
raw_data_file_db(rfc).bird_age  = 167;
raw_data_file_db(rfc).data_number  = rfc;

%file info
raw_data_file_db(rfc).raw_file = 'o1r4 02';
raw_data_file_db(rfc).spike_file = 'o1r4 02-0-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 5;
raw_data_file_db(rfc).neuron_chans = [2 3 4 7 8];
raw_data_file_db(rfc).spikeforms = 'o1r4 02-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'All recordings on birds R hemisphere';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'o1r4 02-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'o1r4 02-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'o1r4 02-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'o1r4 02-NEW_MOTIF.mat';

%%  (20) o1r4 02 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  7.2206;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  7.9354;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1000;
raw_data_file_db(rfc).chan_info(1).dv = 1143;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = '2 neurons, small one ch 2, sorted from BOS to end, big one - ch7 ; crosstalk from ch 4, ';

%%  (20) o1r4 02 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  6.9630;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  6.1858;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 2773;
raw_data_file_db(rfc).chan_info(2).ml = 1500;
raw_data_file_db(rfc).chan_info(2).dv = 2217;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = '2 neurons, positive peak -ch3, bipolar spike on ch 8';


%%  (20) o1r4 02 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc+1;];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 18.5414;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  23.5440;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1000;
raw_data_file_db(rfc).chan_info(3).dv = 879;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicated neuron';

%%  (20) o1r4 02 - Chan 7 (2)
raw_data_file_db(rfc).chan_info(4).channel = 2;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 7;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 26.1978;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =  27.0478;

raw_data_file_db(rfc).chan_info(4).manipulator = 1;
raw_data_file_db(rfc).chan_info(4).ap = 0;
raw_data_file_db(rfc).chan_info(4).ml = 1000;
raw_data_file_db(rfc).chan_info(4).dv = 1143;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(4).notes = 'huge neuron from ch 2';


%%  (20) o1r4 02 - Chan 8 (3)
raw_data_file_db(rfc).chan_info(5).channel = 3;
raw_data_file_db(rfc).chan_info(5).spikefile_index = 8;
raw_data_file_db(rfc).chan_info(5).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(5).same_as_ind = [];
raw_data_file_db(rfc).chan_info(5).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(5).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(5).SN_ratio_raw =  7.3787;
raw_data_file_db(rfc).chan_info(5).SN_ratio_fil =  10.7799;

raw_data_file_db(rfc).chan_info(5).manipulator = 2;
raw_data_file_db(rfc).chan_info(5).ap = 2773;
raw_data_file_db(rfc).chan_info(5).ml = 1500;
raw_data_file_db(rfc).chan_info(5).dv = 2217;
raw_data_file_db(rfc).chan_info(5).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(5).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(5).notes = 'bipolar spike from ch 3';

rfc = rfc +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  (21) o1r4 03 = 21
raw_data_file_db(rfc).birdID  = 6;
raw_data_file_db(rfc).bird_name  = 'o1r4';
raw_data_file_db(rfc).bird_age  = 167;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'o1r4 03';
raw_data_file_db(rfc).spike_file = 'o1r4 03-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 5;
raw_data_file_db(rfc).neuron_chans = [2 3 4];
raw_data_file_db(rfc).spikeforms = 'o1r4 03-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'All recordings on birds R hemisphere';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'o1r4 03-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'o1r4 03-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'o1r4 03-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'o1r4 03-NEW_MOTIF.mat';

%%  (21) o1r4 03 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =   8.0543;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  9.4994;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1000;
raw_data_file_db(rfc).chan_info(1).dv = 1201;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'crosstalk from ch 4';

%%  (21) o1r4 03 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc+1;];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  9.6861;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =   11.6599;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 2773;
raw_data_file_db(rfc).chan_info(2).ml = 1500;
raw_data_file_db(rfc).chan_info(2).dv = 3260;
raw_data_file_db(rfc).chan_info(2).putative_area = 'NCM';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 7;
raw_data_file_db(rfc).chan_info(2).notes = 'duplicate neuron';


%%  (21) o1r4 03 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 14.4195;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =   18.4691;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1000;
raw_data_file_db(rfc).chan_info(3).dv = 879;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate neuron - maybe HVC shelf?';


rfc = rfc +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  (22) o1r4 04 = 22
raw_data_file_db(rfc).birdID  = 6;
raw_data_file_db(rfc).bird_name  = 'o1r4';
raw_data_file_db(rfc).bird_age  = 167;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'o1r4 04';
raw_data_file_db(rfc).spike_file = 'o1r4 04-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 5;
raw_data_file_db(rfc).neuron_chans = [2 3 4];
raw_data_file_db(rfc).spikeforms = 'o1r4 04-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'All recordings on birds R hemisphere';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'o1r4 04-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'o1r4 04-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'o1r4 04-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'o1r4 04-NEW_MOTIF.mat';

%%  (22) o1r4 04 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [2];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =    8.9720;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =   8.7552;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1000;
raw_data_file_db(rfc).chan_info(1).dv = 1256;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'duplicate; crosstalk from ch 4';

%%  (22) o1r4 04 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =   11.5082;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =    14.1607;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 2773;
raw_data_file_db(rfc).chan_info(2).ml = 1500;
raw_data_file_db(rfc).chan_info(2).dv = 3260;
raw_data_file_db(rfc).chan_info(2).putative_area = 'NCM';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 7;
raw_data_file_db(rfc).chan_info(2).notes = 'duplicate neuron';


%%  (22) o1r4 04 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [20];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 14.2625;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =   18.7966;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1000;
raw_data_file_db(rfc).chan_info(3).dv = 1000;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(3).notes = '';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (23) o1r4 05 = 23
raw_data_file_db(rfc).birdID  = 6;
raw_data_file_db(rfc).bird_name  = 'o1r4';
raw_data_file_db(rfc).bird_age  = 167;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'o1r4 05';
raw_data_file_db(rfc).spike_file = 'o1r4 05-0-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 5;
raw_data_file_db(rfc).neuron_chans = [2 3 4 6 7];
raw_data_file_db(rfc).spikeforms = 'o1r4 05-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'All recordings on birds R hemisphere';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'o1r4 05-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'o1r4 05-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'o1r4 05-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'o1r4 05-NEW_MOTIF.mat';

%%  (23) o1r4 05 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =      21.9289;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =    22.2607;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1000;
raw_data_file_db(rfc).chan_info(1).dv = 1253;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'crosstalk from ch 4; duplicate neuron';

%%  (23) o1r4 05 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =    10.4660;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =     14.3028;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 2773;
raw_data_file_db(rfc).chan_info(2).ml = 1500;
raw_data_file_db(rfc).chan_info(2).dv = 1440;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = '';


%%  (23) o1r4 05 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 18.5707;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =    23.4558;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1000;
raw_data_file_db(rfc).chan_info(3).dv = 1230;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = '';

%%  (23) o1r4 05 - Chan 6
raw_data_file_db(rfc).chan_info(4).channel = 6;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 17.5550;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =  18.6044;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 3500;
raw_data_file_db(rfc).chan_info(4).ml = 1500;
raw_data_file_db(rfc).chan_info(4).dv = 2496;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(4).notes = '2 neruons and crosstalk from ch 3, small neuron = ch 7';

%%  (23) o1r4 05 - Chan 7 (6)
raw_data_file_db(rfc).chan_info(5).channel = 6;
raw_data_file_db(rfc).chan_info(5).spikefile_index = 7;
raw_data_file_db(rfc).chan_info(5).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(5).same_as_ind = [];
raw_data_file_db(rfc).chan_info(5).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(5).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(5).SN_ratio_raw =  6.2478;
raw_data_file_db(rfc).chan_info(5).SN_ratio_fil =    6.6546;

raw_data_file_db(rfc).chan_info(5).manipulator = 4;
raw_data_file_db(rfc).chan_info(5).ap = 3500;
raw_data_file_db(rfc).chan_info(5).ml = 1500;
raw_data_file_db(rfc).chan_info(5).dv = 2496;
raw_data_file_db(rfc).chan_info(5).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(5).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(5).notes = 'small neuron from ch 6, crosstalk from ch 3; mvmt artifact ~665';


rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (24) o1r4 06 = 24
raw_data_file_db(rfc).birdID  = 6;
raw_data_file_db(rfc).bird_name  = 'o1r4';
raw_data_file_db(rfc).bird_age  = 167;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'o1r4 06';
raw_data_file_db(rfc).spike_file = 'o1r4 06-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 5;
raw_data_file_db(rfc).neuron_chans = [2 3 4 6];
raw_data_file_db(rfc).spikeforms = 'o1r4 06-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'All recordings on birds R hemisphere';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'o1r4 06-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'o1r4 06-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'o1r4 06-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'o1r4 06-NEW_MOTIF.mat';

%%  (24) o1r4 06 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  21.7242;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  24.7773;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1000;
raw_data_file_db(rfc).chan_info(1).dv = 1361;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'crosstalk from ch 4';

%%  (24) o1r4 06 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc+1;];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 15.3004;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 19.6335;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 2773;
raw_data_file_db(rfc).chan_info(2).ml = 1500;
raw_data_file_db(rfc).chan_info(2).dv = 1995;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = 'some mvmt artifacts; duplicate neuron';


%%  (24) o1r4 06 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc+1;];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  19.0131;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 22.8640;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1000;
raw_data_file_db(rfc).chan_info(3).dv = 1466;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate neuron';

%%  (24) o1r4 06 - Chan 6
raw_data_file_db(rfc).chan_info(4).channel = 6;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc+1;];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [6];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 17.5550;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =  18.6044;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 3500;
raw_data_file_db(rfc).chan_info(4).ml = 1500;
raw_data_file_db(rfc).chan_info(4).dv = 2575;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(4).notes = 'crosstalk from ch 3; duplicate neuron';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (25) o1r4 07 = 25
raw_data_file_db(rfc).birdID  = 6;
raw_data_file_db(rfc).bird_name  = 'o1r4';
raw_data_file_db(rfc).bird_age  = 167;
raw_data_file_db(rfc).data_number  = rfc;
%file info
raw_data_file_db(rfc).raw_file = 'o1r4 07';
raw_data_file_db(rfc).spike_file = 'o1r4 07-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 5;
raw_data_file_db(rfc).neuron_chans = [2 3 4 6];
raw_data_file_db(rfc).spikeforms = 'o1r4 07-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'All recordings on birds R hemisphere';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'o1r4 07-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'o1r4 07-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'o1r4 07-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'o1r4 07-NEW_MOTIF.mat';

%%  (25) o1r4 07 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =   21.3734;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  26.3674;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1000;
raw_data_file_db(rfc).chan_info(1).dv = 1815;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = 'crosstalk from ch 4';

%%  (25) o1r4 07 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 13.1481;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  15.6156;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 2773;
raw_data_file_db(rfc).chan_info(2).ml = 1500;
raw_data_file_db(rfc).chan_info(2).dv = 1995;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = 'some mvmt artifacts, duplicate neuron';


%%  (25) o1r4 07 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =   21.4067;
raw_data_file_db(rfc).chan_info(3).SN_ratio3_fil = 26.0037;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1000;
raw_data_file_db(rfc).chan_info(3).dv = 1456;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate neuron';

%%  (25) o1r4 07 - Chan 6
raw_data_file_db(rfc).chan_info(4).channel = 6;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [6];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =  22.3932;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =   23.2384;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 3500;
raw_data_file_db(rfc).chan_info(4).ml = 1500;
raw_data_file_db(rfc).chan_info(4).dv = 2575;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(4).notes = 'crosstalk from ch 3; duplicate neuron';

rfc = rfc +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%  (26) o5r3 01 = 26
raw_data_file_db(rfc).birdID  = 7;
raw_data_file_db(rfc).bird_name  = 'o5r3';
raw_data_file_db(rfc).bird_age  = 171;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'o5r3 01';
raw_data_file_db(rfc).spike_file = 'o5r3 01-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 5;
raw_data_file_db(rfc).neuron_chans = [3 4 6 7];
raw_data_file_db(rfc).spikeforms = 'o5r3 01-Spkforms.mat';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 1;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'o5r3 01-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'o5r3 01-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'o5r3 01-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'o5r3 01-NEW_MOTIF.mat';

%%   (26) o5r3 01 - Chan 3
raw_data_file_db(rfc).chan_info(1).channel = 3;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw = 15.5575;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 16.6497;

raw_data_file_db(rfc).chan_info(1).manipulator = 2;
raw_data_file_db(rfc).chan_info(1).ap = 2961;
raw_data_file_db(rfc).chan_info(1).ml = 924;
raw_data_file_db(rfc).chan_info(1).dv = 1364;
raw_data_file_db(rfc).chan_info(1).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 7;
raw_data_file_db(rfc).chan_info(1).notes = '';

%%  (26) o5r3 01 - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 21.9798;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 24.4956;

raw_data_file_db(rfc).chan_info(2).manipulator = 4;
raw_data_file_db(rfc).chan_info(2).ap = 3026;
raw_data_file_db(rfc).chan_info(2).ml = 1282;
raw_data_file_db(rfc).chan_info(2).dv = 1917;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = '2 neurons, one starts in the mid of WNBOF (on ch 7)';


%%  (26) o5r3 01 - Chan 6
raw_data_file_db(rfc).chan_info(3).channel = 6;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  12.8023;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  13.3075;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 673;
raw_data_file_db(rfc).chan_info(3).ml = 1382;
raw_data_file_db(rfc).chan_info(3).dv = 1063;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = '';


%%  (26) o5r3 01 - Chan 7 (4)
raw_data_file_db(rfc).chan_info(4).channel = 4;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 7;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 6.2926;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 5.8248;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 3026;
raw_data_file_db(rfc).chan_info(4).ml = 1282;
raw_data_file_db(rfc).chan_info(4).dv = 1917;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(4).notes = 'small neuron from ch 4, only starts firing in mid of WNBOF..';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (27) o5r3 02 = 27
raw_data_file_db(rfc).birdID  = 7;
raw_data_file_db(rfc).bird_name  = 'o5r3';
raw_data_file_db(rfc).bird_age  = 171;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'o5r3 02';
raw_data_file_db(rfc).spike_file = 'o5r3 02-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 5;
raw_data_file_db(rfc).neuron_chans = [2 3 4 6];
raw_data_file_db(rfc).spikeforms = 'o5r3 02-Spkforms.mat';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 1;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'o5r3 02-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'o5r3 02-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'o5r3 02-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'o5r3 02-NEW_MOTIF.mat';

%%  (27) o5r3 02 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  7.7885;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  9.6772;

raw_data_file_db(rfc).chan_info(1).manipulator = 2;
raw_data_file_db(rfc).chan_info(1).ap = 2961;
raw_data_file_db(rfc).chan_info(1).ml = 924;
raw_data_file_db(rfc).chan_info(1).dv = 1272;
raw_data_file_db(rfc).chan_info(1).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 7;
raw_data_file_db(rfc).chan_info(1).notes = '';

%%  (27) o5r3 02 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  11.0471;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  12.1339;

raw_data_file_db(rfc).chan_info(2).manipulator = 1;
raw_data_file_db(rfc).chan_info(2).ap = [];%unknown
raw_data_file_db(rfc).chan_info(2).ml = [];%unknown
raw_data_file_db(rfc).chan_info(2).dv = 1179;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = '';

%%  (27) o5r3 02 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [2];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 8.4694;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  8.6004;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 3026;
raw_data_file_db(rfc).chan_info(3).ml = 1282;
raw_data_file_db(rfc).chan_info(3).dv = 2185;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate neuron; crosstalk from ch 2';


%%  (27) o5r3 02 - Chan 6
raw_data_file_db(rfc).chan_info(4).channel = 6;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =   7.4593;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =   8.2423;

raw_data_file_db(rfc).chan_info(4).manipulator = 3;
raw_data_file_db(rfc).chan_info(4).ap = 673;
raw_data_file_db(rfc).chan_info(4).ml = 1382;
raw_data_file_db(rfc).chan_info(4).dv = 1147;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(4).notes = '';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (28) o5r3 03 = 28
raw_data_file_db(rfc).birdID  = 7;
raw_data_file_db(rfc).bird_name  = 'o5r3';
raw_data_file_db(rfc).bird_age  = 171;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'o5r3 03';
raw_data_file_db(rfc).spike_file = 'o5r3 03-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 5;
raw_data_file_db(rfc).neuron_chans = [2 3 4];
raw_data_file_db(rfc).spikeforms = 'o5r3 03-Spkforms.mat';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 1;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'o5r3 03-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'o5r3 03-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'o5r3 03-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'o5r3 03-NEW_MOTIF.mat';

%%  (28) o5r3 03 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  18.2862;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =   19.9918;

raw_data_file_db(rfc).chan_info(1).manipulator = 2;
raw_data_file_db(rfc).chan_info(1).ap = 2961;
raw_data_file_db(rfc).chan_info(1).ml = 924;
raw_data_file_db(rfc).chan_info(1).dv = 1272;
raw_data_file_db(rfc).chan_info(1).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 7;
raw_data_file_db(rfc).chan_info(1).notes = '';

%%  (28) o5r3 03 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =   15.6845;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =   16.6380;

raw_data_file_db(rfc).chan_info(2).manipulator = 1;
raw_data_file_db(rfc).chan_info(2).ap = [];%unknown
raw_data_file_db(rfc).chan_info(2).ml = [];%unknown
raw_data_file_db(rfc).chan_info(2).dv = 1179;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = '';

%%  (28) o5r3 03 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [2];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  14.8173;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  15.9159;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 3026;
raw_data_file_db(rfc).chan_info(3).ml = 1282;
raw_data_file_db(rfc).chan_info(3).dv = 2227;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate neuron; crosstalk from ch 2';

%%  (28) o5r3 03 - Chan 6 - Lost Neuron

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (29) o5r3 04 = 29
raw_data_file_db(rfc).birdID  = 7;
raw_data_file_db(rfc).bird_name  = 'o5r3';
raw_data_file_db(rfc).bird_age  = 171;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'o5r3 04';
raw_data_file_db(rfc).spike_file = 'o5r3 04-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 5;
raw_data_file_db(rfc).neuron_chans = [2 4 6];
raw_data_file_db(rfc).spikeforms = 'o5r3 04-Spkforms.mat';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 1;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'o5r3 04-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'o5r3 04-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'o5r3 04-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'o5r3 04-NEW_MOTIF.mat';

%%  (29) o5r3 04 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  12.5123;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  20.8852;

raw_data_file_db(rfc).chan_info(1).manipulator = 2;
raw_data_file_db(rfc).chan_info(1).ap = 2961;
raw_data_file_db(rfc).chan_info(1).ml = 924;
raw_data_file_db(rfc).chan_info(1).dv = 1384;
raw_data_file_db(rfc).chan_info(1).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 7;
raw_data_file_db(rfc).chan_info(1).notes = '';

%%  (29) o5r3 04 - Chan 3 - dirty signal, cant sort

%%  (29) o5r3 04 - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [2];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  15.5696;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =   18.0017;

raw_data_file_db(rfc).chan_info(2).manipulator = 4;
raw_data_file_db(rfc).chan_info(2).ap = 3026;
raw_data_file_db(rfc).chan_info(2).ml = 1282;
raw_data_file_db(rfc).chan_info(2).dv = 1847;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = 'crosstalk from ch 2';

%%  (29) o5r3 04 - Chan 6
raw_data_file_db(rfc).chan_info(3).channel = 6;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =   20.8211;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =    23.3213;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 673;
raw_data_file_db(rfc).chan_info(3).ml = 1382;
raw_data_file_db(rfc).chan_info(3).dv = 1181;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = '';


rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (30) o5r3 05 = 30
raw_data_file_db(rfc).birdID  = 7;
raw_data_file_db(rfc).bird_name  = 'o5r3';
raw_data_file_db(rfc).bird_age  = 171;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'o5r3 05';
raw_data_file_db(rfc).spike_file = 'o5r3 05-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 5;
raw_data_file_db(rfc).neuron_chans = [2 3 4 6];
raw_data_file_db(rfc).spikeforms = 'o5r3 05-Spkforms.mat';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 1;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'o5r3 05-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'o5r3 05-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'o5r3 05-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'o5r3 05-NEW_MOTIF.mat';

%%  (30) o5r3 05 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =   12.2735;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =   17.4673;

raw_data_file_db(rfc).chan_info(1).manipulator = 2;
raw_data_file_db(rfc).chan_info(1).ap = 2961;
raw_data_file_db(rfc).chan_info(1).ml = 924;
raw_data_file_db(rfc).chan_info(1).dv = 1424;
raw_data_file_db(rfc).chan_info(1).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 7;
raw_data_file_db(rfc).chan_info(1).notes = '';

%%  (28) o5r3 05 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  32.5681;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  34.9584;

raw_data_file_db(rfc).chan_info(2).manipulator = 1;
raw_data_file_db(rfc).chan_info(2).ap = [];%unknown
raw_data_file_db(rfc).chan_info(2).ml = [];%unknown
raw_data_file_db(rfc).chan_info(2).dv = 1405;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = '';

%%  (30) o5r3 05 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [2];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =    15.8762;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  16.0370;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 3026;
raw_data_file_db(rfc).chan_info(3).ml = 1282;
raw_data_file_db(rfc).chan_info(3).dv = 2164;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = 'crosstalk from ch 2; duplicate neuron';

%%  (30) o5r3 05 - Chan 6
raw_data_file_db(rfc).chan_info(4).channel = 6;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =  14.8589;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =   16.9040;

raw_data_file_db(rfc).chan_info(4).manipulator = 3;
raw_data_file_db(rfc).chan_info(4).ap = 673;
raw_data_file_db(rfc).chan_info(4).ml = 1382;
raw_data_file_db(rfc).chan_info(4).dv = 1334;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(4).notes = '';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (31) o5r3 06 = 31
raw_data_file_db(rfc).birdID  = 7;
raw_data_file_db(rfc).bird_name  = 'o5r3';
raw_data_file_db(rfc).bird_age  = 171;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'o5r3 06';
raw_data_file_db(rfc).spike_file = 'o5r3 06-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 5;
raw_data_file_db(rfc).neuron_chans = [2 3 4 6];
raw_data_file_db(rfc).spikeforms = 'o5r3 06-Spkforms.mat';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 1;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'o5r3 06-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'o5r3 06-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'o5r3 06-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'o5r3 06-NEW_MOTIF.mat';

%%  (31) o5r3 06 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw = 7.6170;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 10.2113;

raw_data_file_db(rfc).chan_info(1).manipulator = 2;
raw_data_file_db(rfc).chan_info(1).ap = 2961;
raw_data_file_db(rfc).chan_info(1).ml = 924;
raw_data_file_db(rfc).chan_info(1).dv = 1387;
raw_data_file_db(rfc).chan_info(1).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 7;
raw_data_file_db(rfc).chan_info(1).notes = 'spiking is really modulated.., did not sort for tones...';

%%  (31) o5r3 06 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [6];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  33.6170;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  35.8917;

raw_data_file_db(rfc).chan_info(2).manipulator = 1;
raw_data_file_db(rfc).chan_info(2).ap = [0];%unknown
raw_data_file_db(rfc).chan_info(2).ml = [];%unknown
raw_data_file_db(rfc).chan_info(2).dv = 1205;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = 'crosstalk from ch 6';

%%  (31) o5r3 06 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [2];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =   18.4614;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =   18.8970;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 3026;
raw_data_file_db(rfc).chan_info(3).ml = 1282;
raw_data_file_db(rfc).chan_info(3).dv = 2183;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = 'crosstalk from ch 2; duplicate neuron';

%%  (31) o5r3 06 - Chan 6
raw_data_file_db(rfc).chan_info(4).channel = 6;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =   18.2678;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =    21.0711;

raw_data_file_db(rfc).chan_info(4).manipulator = 3;
raw_data_file_db(rfc).chan_info(4).ap = 673;
raw_data_file_db(rfc).chan_info(4).ml = 1382;
raw_data_file_db(rfc).chan_info(4).dv = 1615;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(4).notes = '';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (32) o5r3 07 = 32
raw_data_file_db(rfc).birdID  = 7;
raw_data_file_db(rfc).bird_name  = 'o5r3';
raw_data_file_db(rfc).bird_age  = 171;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'o5r3 07';
raw_data_file_db(rfc).spike_file = 'o5r3 07-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 3;
raw_data_file_db(rfc).mic = 5;
raw_data_file_db(rfc).neuron_chans = [2 4];
raw_data_file_db(rfc).spikeforms = 'o5r3 07-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'The channels are messed up here again';

% playback info
raw_data_file_db(rfc).soundfile_vers = 1;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'o5r3 07-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'o5r3 07-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'o5r3 07-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'o5r3 07-NEW_MOTIF.mat';

%%  (32) o5r3 07 - Chan 1 - dirty signal, cant sort

%%  (32) o5r3 07 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  6.3094;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  7.4341;

raw_data_file_db(rfc).chan_info(1).manipulator = 2;
raw_data_file_db(rfc).chan_info(1).ap = 2961;
raw_data_file_db(rfc).chan_info(1).ml = 924;
raw_data_file_db(rfc).chan_info(1).dv = 1387;
raw_data_file_db(rfc).chan_info(1).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 7;
raw_data_file_db(rfc).chan_info(1).notes = '';

%%  (32) o5r3 07 - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =    17.4485;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =   18.8127;

raw_data_file_db(rfc).chan_info(2).manipulator = 4;
raw_data_file_db(rfc).chan_info(2).ap = 3026;
raw_data_file_db(rfc).chan_info(2).ml = 1282;
raw_data_file_db(rfc).chan_info(2).dv = 2183;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = '';

%%  (32) o5r3 07 - Chan 6 - No data saved

rfc = rfc +1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%  (33) o19r1 01 = 33
raw_data_file_db(rfc).birdID  = 8;
raw_data_file_db(rfc).bird_name  = 'o19r1';
raw_data_file_db(rfc).bird_age  = 337;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'o19r1 01';
raw_data_file_db(rfc).spike_file = 'o19r1 01-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [4 5];
raw_data_file_db(rfc).spikeforms = 'o19r1 01-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'No manipulator coordinates were recorded here, I assumed that I used similar coordinates as I used the previous day..';

% playback info
raw_data_file_db(rfc).soundfile_vers = 1;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'o19r1 01-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'o19r1 01-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'o19r1 01-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'o19r1 01-FREE_SPONT.mat';

%%  (33) o19r1 01 - Chan 2 - Lost Neuron
%%  (33) o19r1 01 - Chan 3 - 2 neurons, cant sort

%%  (33) o19r1 01 - Chan 4
raw_data_file_db(rfc).chan_info(1).channel = 4;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw = 17.9178;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 19.8349;

raw_data_file_db(rfc).chan_info(1).manipulator = 3;
raw_data_file_db(rfc).chan_info(1).ap = [];%unknown
raw_data_file_db(rfc).chan_info(1).ml = [];%unknown
raw_data_file_db(rfc).chan_info(1).dv = 1401;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = '1 big neuron, maybe 2 smaller one - these are too difficult to sort';


%%  (33) o19r1 01 - Chan 5
raw_data_file_db(rfc).chan_info(2).channel = 5;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  8.8064;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 8.4259;

raw_data_file_db(rfc).chan_info(2).manipulator = 4;
raw_data_file_db(rfc).chan_info(2).ap = [];%unknown
raw_data_file_db(rfc).chan_info(2).ml = [];%unknown
raw_data_file_db(rfc).chan_info(2).dv = 1174;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = '';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  (34) o19r1 02 = 34
raw_data_file_db(rfc).birdID  = 8;
raw_data_file_db(rfc).bird_name  = 'o19r1';
raw_data_file_db(rfc).bird_age  = 337;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'o19r1 02';
raw_data_file_db(rfc).spike_file = 'o19r1 02-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5];
raw_data_file_db(rfc).spikeforms = 'o19r1 02-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'something happened at 1050, big artifact';

% playback info
raw_data_file_db(rfc).soundfile_vers = 1;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'o19r1 02-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'o19r1 02-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'o19r1 02-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'o19r1 02-FREE_SPONT.mat';

%%  (34) o19r1 02 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  9.1970;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  11.1852;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = [];%unknown
raw_data_file_db(rfc).chan_info(1).ml = [];%unknown
raw_data_file_db(rfc).chan_info(1).dv = 1430;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'supressed neuron! - lost in the middle of WNEOF, deleted all spikes after 1050s';

%%  (34) o19r1 02 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 19.2469;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  21.8084;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = [];%unknown
raw_data_file_db(rfc).chan_info(2).ml = [];%unknown
raw_data_file_db(rfc).chan_info(2).dv = 1302;
raw_data_file_db(rfc).chan_info(2).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 7;
raw_data_file_db(rfc).chan_info(2).notes = 'also poked neuron around WNEOF - another skinny spike starts around 740s';


%%  (34) o19r1 02 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  13.2135;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 14.3927;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = [];%unknown
raw_data_file_db(rfc).chan_info(3).ml = [];%unknown
raw_data_file_db(rfc).chan_info(3).dv = 1401;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = 'also lost neuron during WNEOF, deleted all spikes after 1050';


%%  (34) o19r1 02 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =  24.1736;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 24.3099;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = [];%unknown
raw_data_file_db(rfc).chan_info(4).ml = [];%unknown
raw_data_file_db(rfc).chan_info(4).dv = 1240;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(4).notes = '2 diff sized spikes at beginning, look like same waveform, deleted small spike...lost neuron around 970, deleted all spikes afterwards';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  (35) o19r1 03 = 35
raw_data_file_db(rfc).birdID  = 8;
raw_data_file_db(rfc).bird_name  = 'o19r1';
raw_data_file_db(rfc).bird_age  = 337;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'o19r1 03';
raw_data_file_db(rfc).spike_file = 'o19r1 03-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5];
raw_data_file_db(rfc).spikeforms = 'o19r1 03-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'incomplete file, lost neuron during CON';

% playback info
raw_data_file_db(rfc).soundfile_vers = 1;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'o19r1 03-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'o19r1 03-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'o19r1 03-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'o19r1 03-FREE_SPONT.mat';

%%  (35) o19r1 03 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  8.1401;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  9.6945;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = [];%unknown
raw_data_file_db(rfc).chan_info(1).ml = [];%unknown
raw_data_file_db(rfc).chan_info(1).dv = [];%unknown
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'Lost neuron in middle of CON, use for WNBOF/Stacks/REV';

%%  (35) o19r1 03 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 17.3689;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  18.3547;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = [];%unknown
raw_data_file_db(rfc).chan_info(2).ml = [];%unknown
raw_data_file_db(rfc).chan_info(2).dv = [];%unknown
raw_data_file_db(rfc).chan_info(2).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 7;
raw_data_file_db(rfc).chan_info(2).notes = 'Lost neuron in middle of CON, use for WNBOF/Stacks/REV';


%%  (35) o19r1 03 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =   9.2969;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  9.6998;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = [];%unknown
raw_data_file_db(rfc).chan_info(3).ml = [];%unknown
raw_data_file_db(rfc).chan_info(3).dv = 1359;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = 'Lost neuron in middle of CON, use for WNBOF/Stacks/REV';


%%  (35) o19r1 03 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =  14.7104;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 14.3009;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = [];%unknown
raw_data_file_db(rfc).chan_info(4).ml = [];%unknown
raw_data_file_db(rfc).chan_info(4).dv = [];%unknown
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(4).notes = 'Lost neuron in middle of CON, use for WNBOF/Stacks/REV';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (36) p11r4 01 = 36
raw_data_file_db(rfc).birdID  = 9;
raw_data_file_db(rfc).bird_name  = 'p11r4';
raw_data_file_db(rfc).bird_age  = 131;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'p11r4 01';
raw_data_file_db(rfc).spike_file = 'p11r4 01-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5];
raw_data_file_db(rfc).spikeforms = 'p11r4 01-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'Recorded in Right Hemisphere';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'p11r4 01-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'p11r4 01-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'p11r4 01-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'p11r4 01-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'p11r4 01-NEW_MOTIF.mat';

%%  (36) p11r4 01 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc+1;];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [2];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  8.5500;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =   10.1199;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1100;
raw_data_file_db(rfc).chan_info(1).dv = 765;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'duplicate; cross talk from ch 3';

%%  (36) p11r4 01 - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc+1;];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 14.8768;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =   17.7676;

raw_data_file_db(rfc).chan_info(2).manipulator = 3;
raw_data_file_db(rfc).chan_info(2).ap = 477;
raw_data_file_db(rfc).chan_info(2).ml = 1400;
raw_data_file_db(rfc).chan_info(2).dv = 724;
raw_data_file_db(rfc).chan_info(2).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(2).notes = 'duplicate;';


%%  (36) p11r4 01 - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc+1;];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 12.3140;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 15.8980;

raw_data_file_db(rfc).chan_info(3).manipulator = 2;
raw_data_file_db(rfc).chan_info(3).ap = 3000;
raw_data_file_db(rfc).chan_info(3).ml = 1400;
raw_data_file_db(rfc).chan_info(3).dv = 2665;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L3';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 4;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate;';


%%  (36) p11r4 01 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc+1;];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 10.4163;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 10.6392;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 4000;
raw_data_file_db(rfc).chan_info(4).ml = 1020;
raw_data_file_db(rfc).chan_info(4).dv = 1040;
raw_data_file_db(rfc).chan_info(4).putative_area = 'Hippocampus';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 9;
raw_data_file_db(rfc).chan_info(4).notes = 'duplicate; major crosstalk from ch 4';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (37) p11r4 02 = 37
raw_data_file_db(rfc).birdID  = 9;
raw_data_file_db(rfc).bird_name  = 'p11r4';
raw_data_file_db(rfc).bird_age  = 131;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'p11r4 02';

raw_data_file_db(rfc).spike_file = 'p11r4 02-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5];
raw_data_file_db(rfc).spikeforms = 'p11r4 02-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'Recorded in Right Hemisphere';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'p11r4 02-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'p11r4 02-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'p11r4 02-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'p11r4 02-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'p11r4 02-NEW_MOTIF.mat';

%%  (37) p11r4 02  - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [2];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  10.5511;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 11.7423;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1100;
raw_data_file_db(rfc).chan_info(1).dv = 765;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'duplicate; cross talk from ch 3';

%%  (37) p11r4 02  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 18.5520;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 22.7993;

raw_data_file_db(rfc).chan_info(2).manipulator = 3;
raw_data_file_db(rfc).chan_info(2).ap = 477;
raw_data_file_db(rfc).chan_info(2).ml = 1400;
raw_data_file_db(rfc).chan_info(2).dv = 724;
raw_data_file_db(rfc).chan_info(2).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(2).notes = 'duplicate; ';


%%  (37) p11r4 02  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 12.8735;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 17.1471;

raw_data_file_db(rfc).chan_info(3).manipulator = 2;
raw_data_file_db(rfc).chan_info(3).ap = 3000;
raw_data_file_db(rfc).chan_info(3).ml = 1400;
raw_data_file_db(rfc).chan_info(3).dv = 2665;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L3';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 4;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate;';


%%  (37) p11r4 02 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 13.1663;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 13.6678;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 4000;
raw_data_file_db(rfc).chan_info(4).ml = 1020;
raw_data_file_db(rfc).chan_info(4).dv = 1040;
raw_data_file_db(rfc).chan_info(4).putative_area = 'Hippocampus';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 9;
raw_data_file_db(rfc).chan_info(4).notes = 'duplicate; major crosstalk from ch 4';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (38) p11r4 03 = 38
raw_data_file_db(rfc).birdID  = 9;
raw_data_file_db(rfc).bird_name  = 'p11r4';
raw_data_file_db(rfc).bird_age  = 131;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'p11r4 03';
raw_data_file_db(rfc).spike_file = 'p11r4 03-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 3 5];
raw_data_file_db(rfc).spikeforms = 'p11r4 03-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'Recorded in Right Hemisphere';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'p11r4 03-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'p11r4 03-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'p11r4 03-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'p11r4 03-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'p11r4 03-NEW_MOTIF.mat';

%%  (38) p11r4 03  - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  20.8882;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 21.9084;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1100;
raw_data_file_db(rfc).chan_info(1).dv = 928;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'cross talk from ch 3';

%%  (38) p11r4 03  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  17.1237;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 20.8564;

raw_data_file_db(rfc).chan_info(2).manipulator = 3;
raw_data_file_db(rfc).chan_info(2).ap = 477;
raw_data_file_db(rfc).chan_info(2).ml = 1400;
raw_data_file_db(rfc).chan_info(2).dv = 1346;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = '';

%%  (38) p11r4 03 - Chan 4 - No cell

%%  (38) p11r4 03 - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 33.1134;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 37.1778;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 4000;
raw_data_file_db(rfc).chan_info(3).ml = 1020;
raw_data_file_db(rfc).chan_info(3).dv = 2232;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L1';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 3;
raw_data_file_db(rfc).chan_info(3).notes = 'major crosstalk from ch 4';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (39) p11r4 04 = 39
raw_data_file_db(rfc).birdID  = 9;
raw_data_file_db(rfc).bird_name  = 'p11r4';
raw_data_file_db(rfc).bird_age  = 131;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'p11r4 04';
raw_data_file_db(rfc).spike_file = 'p11r4 04-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [3 4 5];
raw_data_file_db(rfc).spikeforms = 'p11r4 04-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'Recorded in Right Hemisphere';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'p11r4 04-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'p11r4 04-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'p11r4 04-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'p11r4 04-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'p11r4 04-NEW_MOTIF.mat';

%%  (39) p11r4 04  - Chan 2 - No cell

%%  (39) p11r4 04  - Chan 3
raw_data_file_db(rfc).chan_info(1).channel = 3;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw = 16.5358;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 18.1430;

raw_data_file_db(rfc).chan_info(1).manipulator = 3;
raw_data_file_db(rfc).chan_info(1).ap = 477;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 2220;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L3';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 4;
raw_data_file_db(rfc).chan_info(1).notes = '';


%%  (39) p11r4 04  - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 12.7445;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 15.7018;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3000;
raw_data_file_db(rfc).chan_info(2).ml = 1400;
raw_data_file_db(rfc).chan_info(2).dv = 1468;
raw_data_file_db(rfc).chan_info(2).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 7;
raw_data_file_db(rfc).chan_info(2).notes = '';


%%  (39) p11r4 04 - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 18.8224;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 19.3890;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 4000;
raw_data_file_db(rfc).chan_info(3).ml = 1020;
raw_data_file_db(rfc).chan_info(3).dv = 2321;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L1';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 3;
raw_data_file_db(rfc).chan_info(3).notes = 'major crosstalk from ch 4';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (40) p11r4 05 = 40
raw_data_file_db(rfc).birdID  = 9;
raw_data_file_db(rfc).bird_name  = 'p11r4';
raw_data_file_db(rfc).bird_age  = 131;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'p11r4 05';
raw_data_file_db(rfc).spike_file = 'p11r4 05-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5];
raw_data_file_db(rfc).spikeforms = 'p11r4 05-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'Recorded in Right Hemisphere';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'p11r4 05-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'p11r4 05-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'p11r4 05-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'p11r4 05-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'p11r4 05-NEW_MOTIF.mat';

%%  (40) p11r4 05  - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  14.5880;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 16.2003;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1100;
raw_data_file_db(rfc).chan_info(1).dv = 876;
raw_data_file_db(rfc).chan_info(1).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(1).notes = 'cross talk from ch 3';

%%  (40) p11r4 05  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 14.5024;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 17.0399;

raw_data_file_db(rfc).chan_info(2).manipulator = 3;
raw_data_file_db(rfc).chan_info(2).ap = 477;
raw_data_file_db(rfc).chan_info(2).ml = 1400;
raw_data_file_db(rfc).chan_info(2).dv = 860;
raw_data_file_db(rfc).chan_info(2).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(2).notes = '';


%%  (40) p11r4 05  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc+1;];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 12.0877;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 15.4887;

raw_data_file_db(rfc).chan_info(3).manipulator = 2;
raw_data_file_db(rfc).chan_info(3).ap = 3000;
raw_data_file_db(rfc).chan_info(3).ml = 1400;
raw_data_file_db(rfc).chan_info(3).dv = 1856;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L1';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 3;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate';


%%  (40) p11r4 05 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =  18.0603;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 19.3224;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 4000;
raw_data_file_db(rfc).chan_info(4).ml = 1020;
raw_data_file_db(rfc).chan_info(4).dv = 2375;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L1';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 3;
raw_data_file_db(rfc).chan_info(4).notes = 'duplicate; major crosstalk from ch 4';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (41) p11r4 06 = 41
raw_data_file_db(rfc).birdID  = 9;
raw_data_file_db(rfc).bird_name  = 'p11r4';
raw_data_file_db(rfc).bird_age  = 131;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'p11r4 06';
raw_data_file_db(rfc).spike_file = 'p11r4 06-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5];
raw_data_file_db(rfc).spikeforms = 'p11r4 06-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'Recorded in Right Hemisphere';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'p11r4 06-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'p11r4 06-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'p11r4 06-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'p11r4 06-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'p11r4 06-NEW_MOTIF.mat';

%%  (41) p11r4 06  - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  17.3804;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 18.1899;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1100;
raw_data_file_db(rfc).chan_info(1).dv = 960;
raw_data_file_db(rfc).chan_info(1).putative_area = 'HVC-SHelf';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(1).notes = 'cross talk from ch 3';

%%  (41) p11r4 06  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 15.4101;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 19.8522;

raw_data_file_db(rfc).chan_info(2).manipulator = 3;
raw_data_file_db(rfc).chan_info(2).ap = 477;
raw_data_file_db(rfc).chan_info(2).ml = 1400;
raw_data_file_db(rfc).chan_info(2).dv = 1586;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = '';


%%  (41) p11r4 06  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 15.2224;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 18.6436;

raw_data_file_db(rfc).chan_info(3).manipulator = 2;
raw_data_file_db(rfc).chan_info(3).ap = 3000;
raw_data_file_db(rfc).chan_info(3).ml = 1400;
raw_data_file_db(rfc).chan_info(3).dv = 1860;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L1';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 3;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate';


%%  (41) p11r4 06 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =  17.3736;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 18.5158;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 4000;
raw_data_file_db(rfc).chan_info(4).ml = 1020;
raw_data_file_db(rfc).chan_info(4).dv = 2375;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L1';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 3;
raw_data_file_db(rfc).chan_info(4).notes = 'duplicate; major crosstalk from ch 4';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   p11r4 07  = 41
%% This data is v difficult to sort, easy channels are duplicates, ignoring for now..
%{
raw_data_file_db(rfc).birdID  = 9;
raw_data_file_db(rfc).bird_name  = 'p11r4';
raw_data_file_db(rfc).bird_age  = 131;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'p11r4 07';
raw_data_file_db(rfc).spike_file = 'p11r4 07-0-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5 7];
raw_data_file_db(rfc).spikeforms = '';
raw_data_file_db(rfc).other_notes = 'Recorded in Right Hemisphere';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'p11r4 07-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'p11r4 07-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'p11r4 07-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'p11r4 07-NEW_MOTIF.mat';

%%  (42) p11r4 07   - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  ;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = ;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1100;
raw_data_file_db(rfc).chan_info(1).dv = 1555;
raw_data_file_db(rfc).chan_info(1).putative_area = '';
raw_data_file_db(rfc).chan_info(1).putative_area_num = [];
raw_data_file_db(rfc).chan_info(1).notes = 'cross talk from ch 3, another small neuron present';

%%  (42) p11r4 07   - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 15.4101;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 19.8522;

raw_data_file_db(rfc).chan_info(2).manipulator = 3;
raw_data_file_db(rfc).chan_info(2).ap = 477;
raw_data_file_db(rfc).chan_info(2).ml = 1400;
raw_data_file_db(rfc).chan_info(2).dv = 1586;
raw_data_file_db(rfc).chan_info(2).putative_area = '';
raw_data_file_db(rfc).chan_info(2).putative_area_num = [];
raw_data_file_db(rfc).chan_info(2).notes = '';


%%  (42) p11r4 07   - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [40];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 15.2224;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 18.6436;

raw_data_file_db(rfc).chan_info(3).manipulator = 2;
raw_data_file_db(rfc).chan_info(3).ap = 3000;
raw_data_file_db(rfc).chan_info(3).ml = 1400;
raw_data_file_db(rfc).chan_info(3).dv = 1860;
raw_data_file_db(rfc).chan_info(3).putative_area = '';
raw_data_file_db(rfc).chan_info(3).putative_area_num = [];
raw_data_file_db(rfc).chan_info(3).notes = '';


%%  (42) p11r4 07 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [40];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =  17.3736;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 18.5158;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 4000;
raw_data_file_db(rfc).chan_info(4).ml = 1020;
raw_data_file_db(rfc).chan_info(4).dv = 2375;
raw_data_file_db(rfc).chan_info(4).putative_area = '';
raw_data_file_db(rfc).chan_info(4).putative_area_num = [];
raw_data_file_db(rfc).chan_info(4).notes = 'major crosstalk from ch 4';

rfc = rfc +1;
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (42) p11r4 08 = 42
raw_data_file_db(rfc).birdID  = 9;
raw_data_file_db(rfc).bird_name  = 'p11r4';
raw_data_file_db(rfc).bird_age  = 131;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'p11r4 08';

raw_data_file_db(rfc).spike_file = 'p11r4 08-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 3 5 7];
raw_data_file_db(rfc).spikeforms = 'p11r4 08-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'Recorded in Right Hemisphere';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'p11r4 08-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'p11r4 08-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'p11r4 08-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'p11r4 08-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'p11r4 08-NEW_MOTIF.mat';

%%  (42) p11r4 08  - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  15.4616;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 17.3429;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1100;
raw_data_file_db(rfc).chan_info(1).dv = 1426;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'cross talk from ch 3; 2 neurons, lost both in middle of REV @ ~ 320 s';

%%  (41) p11r4 08  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 23.4817;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 26.8901;

raw_data_file_db(rfc).chan_info(2).manipulator = 3;
raw_data_file_db(rfc).chan_info(2).ap = 477;
raw_data_file_db(rfc).chan_info(2).ml = 1400;
raw_data_file_db(rfc).chan_info(2).dv = 1028;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = '';

%%  (42) p11r4 08 - Chan 4 - No cell

%%  (42) p11r4 08 - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  23.1690;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 26.8809;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 4000;
raw_data_file_db(rfc).chan_info(3).ml = 1020;
raw_data_file_db(rfc).chan_info(3).dv = 2821;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate neuron';

%%  (42) p11r4 08 - Chan 7 (5)
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 7;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [7];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =   8.0763;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 9.2754;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 4000;
raw_data_file_db(rfc).chan_info(4).ml = 1020;
raw_data_file_db(rfc).chan_info(4).dv = 2821;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(4).notes = 'small spike that is from channel 5; duplicate neuron';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (43) p11r4 09 = 43
raw_data_file_db(rfc).birdID  = 9;
raw_data_file_db(rfc).bird_name  = 'p11r4';
raw_data_file_db(rfc).bird_age  = 131;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'p11r4 09';
raw_data_file_db(rfc).spike_file = 'p11r4 09-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 3 5 7];
raw_data_file_db(rfc).spikeforms = 'p11r4 09-Spkforms.mat';
raw_data_file_db(rfc).other_notes = 'Recorded in Right Hemisphere';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'p11r4 09-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'p11r4 09-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'p11r4 09-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'p11r4 09-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'p11r4 09-NEW_MOTIF.mat';

%%  (43) p11r4 09  - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  24.0417;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 25.3950;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1100;
raw_data_file_db(rfc).chan_info(1).dv = 1415;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'cross talk from ch 3; 2 neurons, lost both in middle of REV @ ~ 320 s';

%%  (43) p11r4 09  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 17.9044;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 20.8733;

raw_data_file_db(rfc).chan_info(2).manipulator = 3;
raw_data_file_db(rfc).chan_info(2).ap = 477;
raw_data_file_db(rfc).chan_info(2).ml = 1400;
raw_data_file_db(rfc).chan_info(2).dv = 1368;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = '';

%%  (43) p11r4 09 - Chan 4 - No rec (UF?)

%%  (43) p11r4 09 - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  26.5230;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 28.4990;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 4000;
raw_data_file_db(rfc).chan_info(3).ml = 1020;
raw_data_file_db(rfc).chan_info(3).dv = 2821;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate neuron, 2 spikes, small spike sorted on ch 7';


%%  (43) p11r4 09 - Chan 7 (5)
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 7;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc-1]; % same as previous data set
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [7];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =   8.2235;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 9.5348;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 4000;
raw_data_file_db(rfc).chan_info(4).ml = 1020;
raw_data_file_db(rfc).chan_info(4).dv = 2821;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(4).notes = 'duplicate neuron, small spike that is from channel 5';


rfc = rfc +1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (44) p17r2 01 = 44
raw_data_file_db(rfc).birdID  = 10;
raw_data_file_db(rfc).bird_name  = 'p17r2';
raw_data_file_db(rfc).bird_age  = 564;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'p17r2 01';
raw_data_file_db(rfc).spike_file = 'p17r2 01-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = [];% no wav recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 5];
raw_data_file_db(rfc).spikeforms = 'p17r2 01-Spkforms';
raw_data_file_db(rfc).other_notes = 'Some of this data is recorded in int16 (cfg.file_format = 2)';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'p17r2 01-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'p17r2 01-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'p17r2 01-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'p17r2 01-NEW_MOTIF.mat';

%%  (44) p17r2 01  - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [2];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  22.3720;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 24.1095;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = []; %unknown, maybe ~ 2316
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = '';

%%  (44) p17r2 01 - Chan 3 - No cell
%%  (44) p17r2 01 - Chan 4 - No cell

%%  (44) p17r2 01 - Chan 5
raw_data_file_db(rfc).chan_info(2).channel = 5;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =   8.1812;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 9.6841;

raw_data_file_db(rfc).chan_info(2).manipulator = 4;
raw_data_file_db(rfc).chan_info(2).ap = 4000;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = []; %unknown, ~ 2102
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = '';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (45) p17r2 02 = 45
raw_data_file_db(rfc).birdID  = 10;
raw_data_file_db(rfc).bird_name  = 'p17r2';
raw_data_file_db(rfc).bird_age  = 564;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'p17r2 02';
raw_data_file_db(rfc).spike_file = 'p17r2 02-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = [];% no wav recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 4];
raw_data_file_db(rfc).spikeforms = 'p17r2 02-Spkforms';
raw_data_file_db(rfc).other_notes = 'This data is recorded in int16 (cfg.file_format = 2)';
%raw_data_file_db(rfc).other_notes = 'Some of this data is recorded in int16 (cfg.file_format = 2; p17r2 01, 02, 03; some of the data is recorded in new recorder format (cfg.file_format = 8; all the rest)';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'p17r2 02-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'p17r2 02-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'p17r2 02-SPONT.mat';
%raw_data_file_db(rfc).NEW_MOTIF_startstop = 'p17r2 02-NEW_MOTIF.mat';

%%  (45) p17r2 02  - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [2];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  11.5009;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 11.7652;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 1556;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = 'unstable recording, spikes changing size a lot..';

%%  (45) p17r2 02  - Chan 3 - NO cell

%%  (45) p17r2 02  - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  17.0957;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 24.7464;

raw_data_file_db(rfc).chan_info(2).manipulator = 3;
raw_data_file_db(rfc).chan_info(2).ap = 500;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 1124;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = '';

%%  (45) p17r2 02  - Chan 5 - No cell

rfc = rfc +1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   p17r2 03 = 
%% This data is extrememly messy - v unstable signal, spikes hard to sort, com back later
%{
raw_data_file_db(rfc).birdID  = 10;
raw_data_file_db(rfc).bird_name  = 'p17r2';
raw_data_file_db(rfc).bird_age  = 564;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'p17r2 03';
raw_data_file_db(rfc).spike_file = '';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = [];% no wav recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 4 5];
raw_data_file_db(rfc).spikeforms = '';
raw_data_file_db(rfc).other_notes = 'This data is recorded in int16 (cfg.file_format = 2)';
%raw_data_file_db(rfc).other_notes = 'Some of this data is recorded in int16 (cfg.file_format = 2; p17r2 01, 02, 03; some of the data is recorded in new recorder format (cfg.file_format = 8; all the rest)';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'p17r2 03-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'p17r2 03-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'p17r2 03-SPONT.mat';

%%  (46) p17r2 03  - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  ;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = ;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 1334;
raw_data_file_db(rfc).chan_info(1).putative_area = '';
raw_data_file_db(rfc).chan_info(1).putative_area_num = [];
raw_data_file_db(rfc).chan_info(1).notes = '2 neurons, v unstable, v diff to sort';

%%  (46) p17r2 03  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = ;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = ;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1299;
raw_data_file_db(rfc).chan_info(3).putative_area = '';
raw_data_file_db(rfc).chan_info(3).putative_area_num = [];
raw_data_file_db(rfc).chan_info(3).notes = 'really unstable recording, maybe multiunit';


%%  (46) p17r2 03 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =  ;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = ;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 4000;
raw_data_file_db(rfc).chan_info(4).ml = 1200;
raw_data_file_db(rfc).chan_info(4).dv = 2085;
raw_data_file_db(rfc).chan_info(4).putative_area = '';
raw_data_file_db(rfc).chan_info(4).putative_area_num = [];
raw_data_file_db(rfc).chan_info(4).notes = 'interesting rhythmic neurons, hard to sort';

rfc = rfc +1;
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (46) p17r2A-f0007 = 46
raw_data_file_db(rfc).birdID  = 10;
raw_data_file_db(rfc).bird_name  = 'p17r2';
raw_data_file_db(rfc).bird_age  = 564;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'p17r2A-f0007.lvd';
raw_data_file_db(rfc).spike_file = 'p17r2A-f0007-0-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 8;

% General Channel Info
raw_data_file_db(rfc).wav = [];% no wav recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5 6];
raw_data_file_db(rfc).spikeforms = 'p17r2A-f0007-Spkforms';
raw_data_file_db(rfc).other_notes = 'This data is recorded in new recorder format (cfg.file_format = 8';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'p17r2A-f0007-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'p17r2A-f0007-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'p17r2A-f0007-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'p17r2A-f0007-NEW_MOTIF.mat';

%%  (46) p17r2A-f0007 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  14.7545;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  14.6666;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 2316;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = 'neuron gets tiny/big at wneof';

%%  (46) p17r2A-f0007  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  6.9244;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  9.6116;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3500;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 1995;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L1';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 3;
raw_data_file_db(rfc).chan_info(2).notes = '';


%%  (46) p17r2A-f0007  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 10.5858;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 14.7727;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1862;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = '';


%%  (46) p17r2A-f0007 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =   37.2348;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 39.8749;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 4000;
raw_data_file_db(rfc).chan_info(4).ml = 1200;
raw_data_file_db(rfc).chan_info(4).dv = 2102;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L1';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 3;
raw_data_file_db(rfc).chan_info(4).notes = '2 neurons, small one sorted on ch 6';


%%  (46) p17r2A-f0007 - Chan 6 (5)
raw_data_file_db(rfc).chan_info(5).channel = 5;
raw_data_file_db(rfc).chan_info(5).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(5).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(5).same_as_ind = [];
raw_data_file_db(rfc).chan_info(5).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(5).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(5).SN_ratio_raw =   11.1649;
raw_data_file_db(rfc).chan_info(5).SN_ratio_fil =  10.9080;

raw_data_file_db(rfc).chan_info(5).manipulator = 4;
raw_data_file_db(rfc).chan_info(5).ap = 4000;
raw_data_file_db(rfc).chan_info(5).ml = 1200;
raw_data_file_db(rfc).chan_info(5).dv = 2102;
raw_data_file_db(rfc).chan_info(5).putative_area = 'L1';
raw_data_file_db(rfc).chan_info(5).putative_area_num = 3;
raw_data_file_db(rfc).chan_info(5).notes = 'small spike from ch 5';


rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (47) p17r2A-f0024 = 48
raw_data_file_db(rfc).birdID  = 10;
raw_data_file_db(rfc).bird_name  = 'p17r2';
raw_data_file_db(rfc).bird_age  = 564;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'p17r2A-f0024.lvd';
raw_data_file_db(rfc).spike_file = 'p17r2A-f0024-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 8;

% General Channel Info
raw_data_file_db(rfc).wav = [];% no wav recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 5];
raw_data_file_db(rfc).spikeforms = 'p17r2A-f0024-Spkforms';
raw_data_file_db(rfc).other_notes = 'recorder crashed during CON, This data is recorded in new recorder format (cfg.file_format = 8';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'p17r2A-f0024-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'p17r2A-f0024-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'p17r2A-f0024-SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'p17r2A-f0024-NEW_MOTIF.mat';

%%  (47) p17r2A-f0024 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  20.7772;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  21.6340;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = []; % unknown, maybe 2316
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = 'Recorder crashed in middle of CON, Use for only WNBOF and REV';

%%  (47) p17r2A-f0024 - Chan 3 - No neueon
%%  (47) p17r2A-f0024 - Chan 4 - No Neuron

%%  (47) p17r2A-f0024 - Chan 5
raw_data_file_db(rfc).chan_info(2).channel = 5;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =    9.7576;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 9.9781;

raw_data_file_db(rfc).chan_info(2).manipulator = 4;
raw_data_file_db(rfc).chan_info(2).ap = 4000;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = [];% unknown, maybe 2102
raw_data_file_db(rfc).chan_info(2).putative_area = 'L1';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 3;
raw_data_file_db(rfc).chan_info(2).notes = 'Recorder crashed in middle of CON, Use for only WNBOF and REV';


rfc = rfc +1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (48) r2y20 01 = 49
raw_data_file_db(rfc).birdID  = 11;
raw_data_file_db(rfc).bird_name  = 'r2y20';
raw_data_file_db(rfc).bird_age  = 257;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r2y20 01';
raw_data_file_db(rfc).spike_file = 'r2y20 01-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = [];% wav not recorded
raw_data_file_db(rfc).mic = [1 5]; % mic recorded on 2 channels
raw_data_file_db(rfc).neuron_chans = [3 4];
raw_data_file_db(rfc).spikeforms = 'r2y20 01-Spkforms';
raw_data_file_db(rfc).other_notes = 'no coordinates recorded for any data, uncertain about neuron location and manipulator';

% playback info
raw_data_file_db(rfc).soundfile_vers = 7;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r2y20 01-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'r2y20 01-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'r2y20 01-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r2y20 01-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r2y20 01-NEW_MOTIF.mat';

%%  (48) r2y20 01  - Chan 2 - Lost neuron at 540, messy

%%  (48) r2y20 01  - Chan 3
raw_data_file_db(rfc).chan_info(1).channel = 3;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  78.8671;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  84.0924;

raw_data_file_db(rfc).chan_info(1).manipulator = 2;
raw_data_file_db(rfc).chan_info(1).ap = 2500;
raw_data_file_db(rfc).chan_info(1).ml = 1000;
raw_data_file_db(rfc).chan_info(1).dv = []; % unknown
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = '';


%%  (48) r2y20 01  - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 16.0461;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 20.9347;

raw_data_file_db(rfc).chan_info(2).manipulator = 4;
raw_data_file_db(rfc).chan_info(2).ap = 2500;
raw_data_file_db(rfc).chan_info(2).ml = 1400;
raw_data_file_db(rfc).chan_info(2).dv = []; % unknown
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = '';


rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (49) r2y20 02 = 50
raw_data_file_db(rfc).birdID  = 11;
raw_data_file_db(rfc).bird_name  = 'r2y20';
raw_data_file_db(rfc).bird_age  = 257;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r2y20 02';
raw_data_file_db(rfc).spike_file = 'r2y20 02-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = [];% wav not recorded
raw_data_file_db(rfc).mic = [1 5]; % mic recorded on 2 channels
raw_data_file_db(rfc).neuron_chans = [2 3 4];
raw_data_file_db(rfc).spikeforms = 'r2y20 02-Spkforms';
raw_data_file_db(rfc).other_notes = 'no coordinates recorded for any data, uncertain about neuron location and manipulator';

% playback info
raw_data_file_db(rfc).soundfile_vers = 7;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r2y20 02-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'r2y20 02-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'r2y20 02-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r2y20 02-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r2y20 02-NEW_MOTIF.mat';

%%  (49) r2y20 02 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  7.9047;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =   8.9083;

raw_data_file_db(rfc).chan_info(1).manipulator = 3; % uncertain
raw_data_file_db(rfc).chan_info(1).ap = 500;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = []; % unknown
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = '';

%%  (49) r2y20 02  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  34.5791;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  34.4271;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 2500;
raw_data_file_db(rfc).chan_info(2).ml = 1000;
raw_data_file_db(rfc).chan_info(2).dv = []; % unknown
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = '';


%%  (49) r2y20 02  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 7.4969;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 9.6830;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 2500;
raw_data_file_db(rfc).chan_info(3).ml = 1400;
raw_data_file_db(rfc).chan_info(3).dv = []; % unknown
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = '';


rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  (50) r2y20 03 = 51
raw_data_file_db(rfc).birdID  = 11;
raw_data_file_db(rfc).bird_name  = 'r2y20';
raw_data_file_db(rfc).bird_age  = 257;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r2y20 03';
raw_data_file_db(rfc).spike_file = 'r2y20 03-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = [4];
raw_data_file_db(rfc).mic = [5];
raw_data_file_db(rfc).neuron_chans = [1 2];
raw_data_file_db(rfc).spikeforms = 'r2y20 03-Spkforms';
raw_data_file_db(rfc).other_notes = 'Rerarranged channels, no coordinates recorded for any data, uncertain about neuron location and manipulator';

% playback info
raw_data_file_db(rfc).soundfile_vers = 7;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r2y20 03-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'r2y20 03-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'r2y20 03-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r2y20 03-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r2y20 03-NEW_MOTIF.mat';

%%  (50) r2y20 03  - Chan 1
raw_data_file_db(rfc).chan_info(1).channel = 1;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 1;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw = 10.6770;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 12.2212;

raw_data_file_db(rfc).chan_info(1).manipulator = [];% unknown
raw_data_file_db(rfc).chan_info(1).ap = []; % unknown
raw_data_file_db(rfc).chan_info(1).ml = []; % unknown
raw_data_file_db(rfc).chan_info(1).dv = []; % unknown
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = '';


%%  (50) r2y20 03 - Chan 2
raw_data_file_db(rfc).chan_info(2).channel = 2;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  10.7820;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =   10.8849;

raw_data_file_db(rfc).chan_info(2).manipulator = 3; % uncertain
raw_data_file_db(rfc).chan_info(2).ap = 500;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = []; % unknown
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = '';

%%  (50) r2y20 03 - Chan 3 - Signal is bad


rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (51) r3p 01 = 52
raw_data_file_db(rfc).birdID  = 12;
raw_data_file_db(rfc).bird_name  = 'r3p';
raw_data_file_db(rfc).bird_age  = 662;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r3p 01';
raw_data_file_db(rfc).spike_file = 'r3p 01-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 2;
raw_data_file_db(rfc).neuron_chans = [3 5 6 ];
raw_data_file_db(rfc).spikeforms = 'r3p 01-Spkforms';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r3p 01-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'r3p 01-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'r3p 01-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r3p 01-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r3p 01-NEW_MOTIF.mat';

%%  (51) r3p 01 - Chan 3
raw_data_file_db(rfc).chan_info(1).channel = 3;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [5];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  12.7615;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  15.3734;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1100;
raw_data_file_db(rfc).chan_info(1).dv = 623;
raw_data_file_db(rfc).chan_info(1).putative_area = 'HVC';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 5;
raw_data_file_db(rfc).chan_info(1).notes = 'crosstalk from ch 5';

%%  (51) r3p 01  - Chan 4 - No neuron

%%  (51) r3p 01  - Chan 5
raw_data_file_db(rfc).chan_info(2).channel = 5;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 15.3473;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 20.9026;

raw_data_file_db(rfc).chan_info(2).manipulator = 3;
raw_data_file_db(rfc).chan_info(2).ap = 500;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 823;
raw_data_file_db(rfc).chan_info(2).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(2).notes = '';


%%  (51) r3p 01 - Chan 6
raw_data_file_db(rfc).chan_info(3).channel = 6;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =   27.0040;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 30.8099;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 4000;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1687;
raw_data_file_db(rfc).chan_info(3).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(3).notes = '2 neurons, small one sorted on ch 6';

rfc = rfc +1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (52) r3p 02 = 53
raw_data_file_db(rfc).birdID  = 12;
raw_data_file_db(rfc).bird_name  = 'r3p';
raw_data_file_db(rfc).bird_age  = 662;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r3p 02';
raw_data_file_db(rfc).spike_file = 'r3p 02-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 2;
raw_data_file_db(rfc).neuron_chans = [3 4 5 6];
raw_data_file_db(rfc).spikeforms = 'r3p 02-Spkforms';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r3p 02-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'r3p 02-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'r3p 02-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r3p 02-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r3p 02-NEW_MOTIF.mat';

%%  (52) r3p 02 - Chan 3
raw_data_file_db(rfc).chan_info(1).channel = 3;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [5];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  23.5171;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  26.1623;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1100;
raw_data_file_db(rfc).chan_info(1).dv = 711;
raw_data_file_db(rfc).chan_info(1).putative_area = 'HVC';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 5;
raw_data_file_db(rfc).chan_info(1).notes = 'crosstalk from ch 5';

%%  (52) r3p 02  - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [6];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  15.1036;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  18.9906;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3400;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 302;
raw_data_file_db(rfc).chan_info(2).putative_area = 'Hippocampus';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 9;
raw_data_file_db(rfc).chan_info(2).notes = 'tiny crosstalk from ch 6';


%%  (52) r3p 02  - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  13.1683;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 17.1798;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 823;
raw_data_file_db(rfc).chan_info(3).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(3).notes = '';


%%  (52) r3p 02 - Chan 6
raw_data_file_db(rfc).chan_info(4).channel = 6;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [6];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =   9.9293;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 10.7797;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 4000;
raw_data_file_db(rfc).chan_info(4).ml = 1200;
raw_data_file_db(rfc).chan_info(4).dv = 805;
raw_data_file_db(rfc).chan_info(4).putative_area = 'Hippocampus';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 9;
raw_data_file_db(rfc).chan_info(4).notes = 'crosstalk from ch 4';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (53) r3p 03 = 54
raw_data_file_db(rfc).birdID  = 12;
raw_data_file_db(rfc).bird_name  = 'r3p';
raw_data_file_db(rfc).bird_age  = 662;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r3p 03';
raw_data_file_db(rfc).spike_file = 'r3p 03-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 2;
raw_data_file_db(rfc).neuron_chans = [3 4 5 6];
raw_data_file_db(rfc).spikeforms = 'r3p 03-Spkforms';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r3p 03-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'r3p 03-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'r3p 03-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r3p 03-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r3p 03-NEW_MOTIF.mat';

%%  (53) r3p 03 - Chan 3
raw_data_file_db(rfc).chan_info(1).channel = 3;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [5];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  21.9761;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  24.7745;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1100;
raw_data_file_db(rfc).chan_info(1).dv = 820;
raw_data_file_db(rfc).chan_info(1).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(1).notes = 'crosstalk from ch 5';

%%  (53) r3p 03  - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [6];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  13.0100;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  15.6827;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3400;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 302;
raw_data_file_db(rfc).chan_info(2).putative_area = 'Hippocampus';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 9;
raw_data_file_db(rfc).chan_info(2).notes = 'tiny crosstalk from ch 6';


%%  (53) r3p 03  - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  14.0995;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 20.4225;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1124;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(3).notes = '';


%%  (53) r3p 03 - Chan 6
raw_data_file_db(rfc).chan_info(4).channel = 6;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [6];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =   13.9924;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 14.5793;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 4000;
raw_data_file_db(rfc).chan_info(4).ml = 1200;
raw_data_file_db(rfc).chan_info(4).dv = 833;
raw_data_file_db(rfc).chan_info(4).putative_area = 'Hippocampus';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 9;
raw_data_file_db(rfc).chan_info(4).notes = 'crosstalk from ch 4';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (54) r3p 04 = 55
raw_data_file_db(rfc).birdID  = 12;
raw_data_file_db(rfc).bird_name  = 'r3p';
raw_data_file_db(rfc).bird_age  = 662;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r3p 04';
raw_data_file_db(rfc).spike_file = 'r3p 04-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 2;
raw_data_file_db(rfc).neuron_chans = [3 4 5 6];
raw_data_file_db(rfc).spikeforms = 'r3p 04-Spkforms';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r3p 04-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'r3p 04-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'r3p 04-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r3p 04-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r3p 04-NEW_MOTIF.mat';

%%  (54) r3p 04 - Chan 3
raw_data_file_db(rfc).chan_info(1).channel = 3;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [5];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  9.2204;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  10.0459;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1100;
raw_data_file_db(rfc).chan_info(1).dv = 897;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'unstable recording, spike switches polarity;  crosstalk from ch 5';

%%  (54) r3p 04  - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [6];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  16.5033;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  21.2916;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3400;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 1797;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L1';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 3;
raw_data_file_db(rfc).chan_info(2).notes = 'tiny crosstalk from ch 6';


%%  (54) r3p 04  - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  7.5866;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 9.3854;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1398;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = 'lost neuron around 760, deleted spikes after CON';


%%  (54) r3p 04 - Chan 6
raw_data_file_db(rfc).chan_info(4).channel = 6;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc+1; rfc+2];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [6];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =    26.5626;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 28.8953;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 4000;
raw_data_file_db(rfc).chan_info(4).ml = 1200;
raw_data_file_db(rfc).chan_info(4).dv = 1962;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L1';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 3;
raw_data_file_db(rfc).chan_info(4).notes = 'crosstalk from ch 4';

rfc = rfc +1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (55) r3p 05 = 56
raw_data_file_db(rfc).birdID  = 12;
raw_data_file_db(rfc).bird_name  = 'r3p';
raw_data_file_db(rfc).bird_age  = 662;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r3p 05';
raw_data_file_db(rfc).spike_file = 'r3p 05-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 2;
raw_data_file_db(rfc).neuron_chans = [3 4 5 6];
raw_data_file_db(rfc).spikeforms = 'r3p 05-Spkforms';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r3p 05-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'r3p 05-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'r3p 05-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r3p 05-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r3p 05-NEW_MOTIF.mat';

%%  (55) r3p 05 - Chan 3
raw_data_file_db(rfc).chan_info(1).channel = 3;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [5];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  29.5314;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  32.4778;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1100;
raw_data_file_db(rfc).chan_info(1).dv = 976;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'crosstalk from ch 5';

%%  (55) r3p 05  - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [6];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  12.2540;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =   16.1368;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3400;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 1846;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L1';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 3;
raw_data_file_db(rfc).chan_info(2).notes = 'tiny crosstalk from ch 6';


%%  (55) r3p 05  - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  15.5935;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 21.0123;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 770;
raw_data_file_db(rfc).chan_info(3).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(3).notes = '';


%%  (55) r3p 05 - Chan 6
raw_data_file_db(rfc).chan_info(4).channel = 6;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc-1; rfc+1];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [6];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =    27.1324;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =  29.4499;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 4000;
raw_data_file_db(rfc).chan_info(4).ml = 1200;
raw_data_file_db(rfc).chan_info(4).dv = 1962;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L1';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 3;
raw_data_file_db(rfc).chan_info(4).notes = 'crosstalk from ch 4';

rfc = rfc +1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (56) r3p 06 = 57
raw_data_file_db(rfc).birdID  = 12;
raw_data_file_db(rfc).bird_name  = 'r3p';
raw_data_file_db(rfc).bird_age  = 662;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r3p 06';
raw_data_file_db(rfc).spike_file = 'r3p 06-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 2;
raw_data_file_db(rfc).neuron_chans = [3 4 5 6];
raw_data_file_db(rfc).spikeforms = 'r3p 06-Spkforms';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r3p 06-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'r3p 06-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'r3p 06-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r3p 06-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r3p 06-NEW_MOTIF.mat';

%%  (56) r3p 06 - Chan 3
raw_data_file_db(rfc).chan_info(1).channel = 3;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [5];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  18.2175;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =   20.7890;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1100;
raw_data_file_db(rfc).chan_info(1).dv = 1667;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = 'crosstalk from ch 5';

%%  (56) r3p 06  - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [6];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  12.8375;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  17.3063;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3400;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 1992;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L1';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 3;
raw_data_file_db(rfc).chan_info(2).notes = 'tiny crosstalk from ch 6';


%%  (56) r3p 06  - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  9.4119;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 12.4055;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1760;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = '';


%%  (56) r3p 06 - Chan 6
raw_data_file_db(rfc).chan_info(4).channel = 6;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc-1; rfc-2];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [6];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =    27.6117;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =  29.8795;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 4000;
raw_data_file_db(rfc).chan_info(4).ml = 1200;
raw_data_file_db(rfc).chan_info(4).dv = 1962;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L1';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 3;
raw_data_file_db(rfc).chan_info(4).notes = 'crosstalk from ch 4';

rfc = rfc +1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (57) r6y11A-f0001 = 58
raw_data_file_db(rfc).birdID  = 13;
raw_data_file_db(rfc).bird_name  = 'r6y11';
raw_data_file_db(rfc).bird_age  = 238;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r6y11A-f0001.lvd';
raw_data_file_db(rfc).spike_file = 'r6y11A-f0001-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 8;

% General Channel Info
raw_data_file_db(rfc).wav = []; % wav channel not recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 4 5];
raw_data_file_db(rfc).spikeforms = 'r6y11A-f0001-Spkforms';
raw_data_file_db(rfc).other_notes = 'This data is recorded in new recorder format (cfg.file_format = 8';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r6y11A-f0001-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'r6y11A-f0001-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'r6y11A-f0001-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r6y11A-f0001-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r6y11A-f0001-NEW_MOTIF.mat';


%%  (57) r6y11A-f0001 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  18.3464;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 19.3282;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 1383;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'crosstalk from ch 4';

%%  (57) r6y11A-f0001  - Chan 3 - unstable recording

%%  (57) r6y11A-f0001  - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 20.2196;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 28.5886;

raw_data_file_db(rfc).chan_info(2).manipulator = 3;
raw_data_file_db(rfc).chan_info(2).ap = 0;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 1059;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = '';


%%  (57) r6y11A-f0001 - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 7.3902;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  8.3310;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 3700;
raw_data_file_db(rfc).chan_info(3).ml = 1300;
raw_data_file_db(rfc).chan_info(3).dv = 2124;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = 'cross tralk from ch 3';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% r6y11A-f0002.lvd -- no data
%% r6y11A-f0003.lvd -- no data
%% r6y11A-f0004.lvd -- no data
%% r6y11A-f0005.lvd -- no data
%% r6y11A-f0006.lvd -- no data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%

%%  (58) r6y11A-f0007 = 59
raw_data_file_db(rfc).birdID  = 13;
raw_data_file_db(rfc).bird_name  = 'r6y11';
raw_data_file_db(rfc).bird_age  = 238;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r6y11A-f0007.lvd';
raw_data_file_db(rfc).spike_file = 'r6y11A-f0007-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 8;

% General Channel Info
raw_data_file_db(rfc).wav = []; % wav channel not recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 3 4];
raw_data_file_db(rfc).spikeforms = 'r6y11A-f0007-Spkforms';
raw_data_file_db(rfc).other_notes = 'This data is recorded in new recorder format (cfg.file_format = 8';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r6y11A-f0007-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'r6y11A-f0007-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'r6y11A-f0007-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r6y11A-f0007-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r6y11A-f0007-NEW_MOTIF.mat';

%%  (58) r6y11A-f0007 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  30.9090;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 31.5092;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 1657;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = 'crosstalk from ch 4';

%%  (58) r6y11A-f0007  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 14.4902;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 19.6167;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3200;
raw_data_file_db(rfc).chan_info(2).ml = 1300;
raw_data_file_db(rfc).chan_info(2).dv = 2528;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = '';

%%  (58) r6y11A-f0007  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 9.5287;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  13.7121;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 0;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1411;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate neuron';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (59) r6y11A-f0008 = 58
% raw_data_file_db(rfc).birdID  = 13;
% raw_data_file_db(rfc).bird_name  = 'r6y11';
% raw_data_file_db(rfc).bird_age  = 238;
% raw_data_file_db(rfc).data_number  = rfc; 
% %file info
% raw_data_file_db(rfc).raw_file = 'r6y11A-f0008.lvd';
% raw_data_file_db(rfc).spike_file = 'r6y11A-f0008-0-0-0-0';
% raw_data_file_db(rfc).scanrate = 30031;
% raw_data_file_db(rfc).data_file_format = 8;
% 
% % General Channel Info
% raw_data_file_db(rfc).wav = []; % wav channel not recorded
% raw_data_file_db(rfc).mic = 1;
% raw_data_file_db(rfc).neuron_chans = [2 3 4 5];
% raw_data_file_db(rfc).spikeforms = 'r6y11A-f0008-Spkforms';
% raw_data_file_db(rfc).other_notes = 'This data is recorded in new recorder format (cfg.file_format = 8';
% 
% % playback info
% raw_data_file_db(rfc).soundfile_vers = 3;
% raw_data_file_db(rfc).startstop_path = 'Startstop';
% raw_data_file_db(rfc).BOUT_startstop = 'r6y11A-f0008-BOUT.mat';
% raw_data_file_db(rfc).MOTIF_startstop = 'r6y11A-f0008-MOTIF.mat';
% raw_data_file_db(rfc).SPONT_startstop = 'r6y11A-f0008-SPONT.mat';
% raw_data_file_db(rfc).FREE_SPONT_startstop = 'r6y11A-f0008-FREE_SPONT.mat';
% 
% %%  (59) r6y11A-f0008 - Chan 2
% raw_data_file_db(rfc).chan_info(1).channel = 2;
% raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
% raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
% raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc+1; rfc+2; rfc+3];
% raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [2];
% raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
% raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =   16.5031;
% raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 17.2944;
% 
% raw_data_file_db(rfc).chan_info(1).manipulator = 1;
% raw_data_file_db(rfc).chan_info(1).ap = 0;
% raw_data_file_db(rfc).chan_info(1).ml = 1200;
% raw_data_file_db(rfc).chan_info(1).dv = 1588;
% raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
% raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
% raw_data_file_db(rfc).chan_info(1).notes = 'duplicate neuron; crosstalk from ch 4';
% 
% %%  (59) r6y11A-f0008  - Chan 3
% raw_data_file_db(rfc).chan_info(2).channel = 3;
% raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
% raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
% raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc+1];
% raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
% raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
% raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  8.8686;
% raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 11.7269;
% 
% raw_data_file_db(rfc).chan_info(2).manipulator = 2;
% raw_data_file_db(rfc).chan_info(2).ap = 3200;
% raw_data_file_db(rfc).chan_info(2).ml = 1300;
% raw_data_file_db(rfc).chan_info(2).dv = 2638;
% raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
% raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
% raw_data_file_db(rfc).chan_info(2).notes = 'duplicate neuron;';
% 
% %%  (59) r6y11A-f0008  - Chan 4
% raw_data_file_db(rfc).chan_info(3).channel = 4;
% raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
% raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
% raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1];
% raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
% raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
% raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 13.7330;
% raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  17.5836;
% 
% raw_data_file_db(rfc).chan_info(3).manipulator = 3;
% raw_data_file_db(rfc).chan_info(3).ap = 0;
% raw_data_file_db(rfc).chan_info(3).ml = 1200;
% raw_data_file_db(rfc).chan_info(3).dv = 1411;
% raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
% raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
% raw_data_file_db(rfc).chan_info(3).notes = 'duplicate neuron';
% 
% 
% %%  (59) r6y11A-f0008 - Chan 5
% raw_data_file_db(rfc).chan_info(4).channel = 5;
% raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
% raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
% raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
% raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
% raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [3];
% raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =  28.1568;
% raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 32.1660;
% 
% raw_data_file_db(rfc).chan_info(4).manipulator = 4;
% raw_data_file_db(rfc).chan_info(4).ap = 3700;
% raw_data_file_db(rfc).chan_info(4).ml = 1300;
% raw_data_file_db(rfc).chan_info(4).dv = 2204;s
% raw_data_file_db(rfc).chan_info(4).putative_area = 'L1';
% raw_data_file_db(rfc).chan_info(4).putative_area_num = 3;
% raw_data_file_db(rfc).chan_info(4).notes = 'cross tralk from ch 3';
% 
% rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (59) r6y11A-f0009 = 59
raw_data_file_db(rfc).birdID  = 13;
raw_data_file_db(rfc).bird_name  = 'r6y11';
raw_data_file_db(rfc).bird_age  = 238;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r6y11A-f0009.lvd';
raw_data_file_db(rfc).spike_file = 'r6y11A-f0009-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 8;

% General Channel Info
raw_data_file_db(rfc).wav = []; % wav channel not recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5];
raw_data_file_db(rfc).spikeforms = 'r6y11A-f0009-Spkforms';
raw_data_file_db(rfc).other_notes = 'This data is recorded in new recorder format (cfg.file_format = 8';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r6y11A-f0009-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = [];% Not created
raw_data_file_db(rfc).SPONT_startstop = 'r6y11A-f0009-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r6y11A-f0009-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r6y11A-f0009-NEW_MOTIF.mat';

%%  (60) r6y11A-f0009 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc-1; rfc+1; rfc+2;];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [2];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =   15.6112;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 16.5733;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 1588;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = 'duplicate neuron';

%%  (60) r6y11A-f0009  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  6.6054;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  8.6103;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3200;
raw_data_file_db(rfc).chan_info(2).ml = 1300;
raw_data_file_db(rfc).chan_info(2).dv = 2638;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = 'duplicate neuron; something happened to neuron in mid of CON, sorted spikes though REV';

%%  (60) r6y11A-f0009  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  7.9054;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =   9.6297;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 0;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1490;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = '';


%%  (60) r6y11A-f0009 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =   28.6512;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 31.4813;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 3700;
raw_data_file_db(rfc).chan_info(4).ml = 1300;
raw_data_file_db(rfc).chan_info(4).dv = 2398;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(4).notes = 'another small neuron present, didnt sort';

rfc = rfc +1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% r6y11A-f0010.lvd = no data


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (61) r6y11A-f0011 = 60
raw_data_file_db(rfc).birdID  = 13;
raw_data_file_db(rfc).bird_name  = 'r6y11';
raw_data_file_db(rfc).bird_age  = 238;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r6y11A-f0011.lvd';
raw_data_file_db(rfc).spike_file = 'r6y11A-f0011-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 8;

% General Channel Info
raw_data_file_db(rfc).wav = []; % wav channel not recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5];
raw_data_file_db(rfc).spikeforms = 'r6y11A-f0011-Spkforms';
raw_data_file_db(rfc).other_notes = 'This data is recorded in new recorder format (cfg.file_format = 8';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r6y11A-f0011-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = [];% Not created
raw_data_file_db(rfc).SPONT_startstop = 'r6y11A-f0011-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r6y11A-f0011-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r6y11A-f0011-NEW_MOTIF.mat';

%%  (61) r6y11A-f0011 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc-1; rfc-2; rfc+1];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [2];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =   17.4497;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 18.6026;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 1588;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = 'duplicate neuron; another small spike present (didnt sort)';

%%  (61) r6y11A-f0011  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =   8.5155;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  11.7006;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3200;
raw_data_file_db(rfc).chan_info(2).ml = 1300;
raw_data_file_db(rfc).chan_info(2).dv = 2892;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L3';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 4;
raw_data_file_db(rfc).chan_info(2).notes = 'lost neuron at 800s';

%%  (61) r6y11A-f0011  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc+1;];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  9.7671;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =   15.1889;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 0;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1583;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate';


%%  (61) r6y11A-f0011 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =    16.6648;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =  18.6521;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 3700;
raw_data_file_db(rfc).chan_info(4).ml = 1300;
raw_data_file_db(rfc).chan_info(4).dv = 2675;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(4).notes = 'v unstable recording, sorted until 480, lost neuron at 1360';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (62) r6y11A-f0012 = 61
raw_data_file_db(rfc).birdID  = 13;
raw_data_file_db(rfc).bird_name  = 'r6y11';
raw_data_file_db(rfc).bird_age  = 238;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r6y11A-f0012.lvd';
raw_data_file_db(rfc).spike_file = 'r6y11A-f0012-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 8;

% General Channel Info
raw_data_file_db(rfc).wav = []; % wav channel not recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 3 4];
raw_data_file_db(rfc).spikeforms = 'r6y11A-f0012-Spkforms';
raw_data_file_db(rfc).other_notes = 'This data is recorded in new recorder format (cfg.file_format = 8';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r6y11A-f0012-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = []; % Not created
raw_data_file_db(rfc).SPONT_startstop = 'r6y11A-f0012-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r6y11A-f0012-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r6y11A-f0012-NEW_MOTIF.mat';

%%  (62) r6y11A-f0012 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc-1; rfc-2; rfc-3];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [2];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =    14.7662;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 15.3617;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 1588;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = 'duplicate neuron; lost aroun 1160';

%%  (62) r6y11A-f0012  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =   16.0377;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  21.8232;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3500;
raw_data_file_db(rfc).chan_info(2).ml = 1300;
raw_data_file_db(rfc).chan_info(2).dv = 2590;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = 'lost neuron at 770s';

%%  (62) r6y11A-f0012  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 13.6803;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 19.6843;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 0;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1583;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate neuron';

%%  (62) r6y11A-f0012  - Chan 5 - Lost neuron at 400s

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (63) r6y11A-f0013 = 62
raw_data_file_db(rfc).birdID  = 13;
raw_data_file_db(rfc).bird_name  = 'r6y11';
raw_data_file_db(rfc).bird_age  = 238;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r6y11A-f0013.lvd';
raw_data_file_db(rfc).spike_file = 'r6y11A-f0013-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 8;

% General Channel Info
raw_data_file_db(rfc).wav = []; % wav channel not recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5];
raw_data_file_db(rfc).spikeforms = 'r6y11A-f0013-Spkforms';
raw_data_file_db(rfc).other_notes = 'This data is recorded in new recorder format (cfg.file_format = 8';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r6y11A-f0013-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = []; % Not created
raw_data_file_db(rfc).SPONT_startstop = 'r6y11A-f0013-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r6y11A-f0013-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r6y11A-f0013-NEW_MOTIF.mat';

%%  (63) r6y11A-f0013 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =   15.5412;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 15.2665;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 1610;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = 'another small neuron present';

%%  (63) r6y11A-f0013  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =    10.5903;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  15.9931;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3500;
raw_data_file_db(rfc).chan_info(2).ml = 1300;
raw_data_file_db(rfc).chan_info(2).dv = 2625;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L3';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 4;
raw_data_file_db(rfc).chan_info(2).notes = '';

%%  (63) r6y11A-f0013  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 15.7050;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  23.6657;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 0;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1624;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(3).notes = '';


%%  (63) r6y11A-f0013 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =  26.6532;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 29.0037;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 3700;
raw_data_file_db(rfc).chan_info(4).ml = 1300;
raw_data_file_db(rfc).chan_info(4).dv = 2875;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L3';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 4;
raw_data_file_db(rfc).chan_info(4).notes = 'another small neuron present could, sort it, but it is small, maybe later';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (64) r6y11A-f0014 = 63
raw_data_file_db(rfc).birdID  = 13;
raw_data_file_db(rfc).bird_name  = 'r6y11';
raw_data_file_db(rfc).bird_age  = 238;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r6y11A-f0014.lvd';
raw_data_file_db(rfc).spike_file = 'r6y11A-f0014-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 8;

% General Channel Info
raw_data_file_db(rfc).wav = []; % wav channel not recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5];
raw_data_file_db(rfc).spikeforms = 'r6y11A-f0014-Spkforms';
raw_data_file_db(rfc).other_notes = 'This data is recorded in new recorder format (cfg.file_format = 8';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r6y11A-f0014-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = []; % Not created
raw_data_file_db(rfc).SPONT_startstop = 'r6y11A-f0014-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r6y11A-f0014-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r6y11A-f0014-NEW_MOTIF.mat';

%%  (64) r6y11A-f0014 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc+1;];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =   22.0726;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =21.8508;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 1698;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = 'another small neuron present';

%%  (64) r6y11A-f0014  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 11.8223;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 15.6410;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3500;
raw_data_file_db(rfc).chan_info(2).ml = 1300;
raw_data_file_db(rfc).chan_info(2).dv = 2672;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = 'lost arund 1405s';

%%  (64) r6y11A-f0014  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 9.9084;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 14.8211;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 0;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 2101;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L3';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 4;
raw_data_file_db(rfc).chan_info(3).notes = '';


%%  (64) r6y11A-f0014 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 17.0782;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 19.7229;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 3700;
raw_data_file_db(rfc).chan_info(4).ml = 1300;
raw_data_file_db(rfc).chan_info(4).dv = 2917;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L3';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 4;
raw_data_file_db(rfc).chan_info(4).notes = 'crosstalk from ch 3';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (65) r6y11A-f0015 = 64
raw_data_file_db(rfc).birdID  = 13;
raw_data_file_db(rfc).bird_name  = 'r6y11';
raw_data_file_db(rfc).bird_age  = 238;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r6y11A-f0015.lvd';
raw_data_file_db(rfc).spike_file = 'r6y11A-f0015-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 8;

% General Channel Info
raw_data_file_db(rfc).wav = []; % wav channel not recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 4];
raw_data_file_db(rfc).spikeforms = 'r6y11A-f0015-Spkforms';
raw_data_file_db(rfc).other_notes = 'This data is recorded in new recorder format (cfg.file_format = 8';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r6y11A-f0015-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = []; % Not created
raw_data_file_db(rfc).SPONT_startstop = 'r6y11A-f0015-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r6y11A-f0015-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r6y11A-f0015-NEW_MOTIF.mat';

%%  (65) r6y11A-f0015 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [2];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =   22.7925;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 22.5745;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 1698;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = 'duplicate; another small neuron present';

%%  (65) r6y11A-f0015  - Chan 3 - No neruon

%%  (65) r6y11A-f0015  - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 9.1337;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 14.1646;

raw_data_file_db(rfc).chan_info(2).manipulator = 3;
raw_data_file_db(rfc).chan_info(2).ap = 0;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 1497;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(2).notes = '';

%%  (65) r6y11A-f0015  - Chan 5 - Lost neuron at 24s
rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (66) r6y12A-f0001 = 65
raw_data_file_db(rfc).birdID  = 14;
raw_data_file_db(rfc).bird_name  = 'r6y12';
raw_data_file_db(rfc).bird_age  = 233;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r6y12A-f0001.lvd';
raw_data_file_db(rfc).spike_file = 'r6y12A-f0001-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 8;

% General Channel Info
raw_data_file_db(rfc).wav = []; % wav channel not recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5];
raw_data_file_db(rfc).spikeforms = 'r6y12A-f0001-Spkforms';
raw_data_file_db(rfc).other_notes = 'This data is recorded in new recorder format (cfg.file_format = 8';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r6y12A-f0001-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'r6y12A-f0001-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'r6y12A-f0001-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r6y12A-f0001-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r6y12A-f0001-NEW_MOTIF.mat';


%%  (66) r6y12A-f0001 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [2];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  16.1096;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 17.0739;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 700;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 1479;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = '';

%%  (66) r6y12A-f0001  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 11.5644;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 15.0520;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3000;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 2125;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = '';

%%  (66) r6y12A-f0001  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 8.7944;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 13.8202;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 0;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1870;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L3';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 4;
raw_data_file_db(rfc).chan_info(3).notes = '';


%%  (66) r6y12A-f0001 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 13.3425;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 15.4484;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 3500;
raw_data_file_db(rfc).chan_info(4).ml = 1200;
raw_data_file_db(rfc).chan_info(4).dv = 2370;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(4).notes = '';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (67) r6y12A-f0002 = 66
raw_data_file_db(rfc).birdID  = 14;
raw_data_file_db(rfc).bird_name  = 'r6y12';
raw_data_file_db(rfc).bird_age  = 233;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r6y12A-f0002.lvd';
raw_data_file_db(rfc).spike_file = 'r6y12A-f0002-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 8;

% General Channel Info
raw_data_file_db(rfc).wav = []; % wav channel not recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5];
raw_data_file_db(rfc).spikeforms = 'r6y12A-f0002-Spkforms';
raw_data_file_db(rfc).other_notes = 'This data is recorded in new recorder format (cfg.file_format = 8';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r6y12A-f0002-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'r6y12A-f0002-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'r6y12A-f0002-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r6y12A-f0002-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r6y12A-f0002-NEW_MOTIF.mat';

%%  (67) r6y12A-f0002 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [2];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  48.7584;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 51.9602;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 700;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 1487;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = '';

%%  (67) r6y12A-f0002  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  5.6928;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 6.6181;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3000;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 2125;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = '';

%%  (67) r6y12A-f0002  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 13.1670;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 18.8964;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 0;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1870;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L3';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 4;
raw_data_file_db(rfc).chan_info(3).notes = '';


%%  (67) r6y12A-f0002 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 13.5044;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 15.0765;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 3500;
raw_data_file_db(rfc).chan_info(4).ml = 1200;
raw_data_file_db(rfc).chan_info(4).dv = 2436;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(4).notes = '';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (68) r6y12A-f0003 = 67
raw_data_file_db(rfc).birdID  = 14;
raw_data_file_db(rfc).bird_name  = 'r6y12';
raw_data_file_db(rfc).bird_age  = 233;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r6y12A-f0003.lvd';
raw_data_file_db(rfc).spike_file = 'r6y12A-f0003-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 8;

% General Channel Info
raw_data_file_db(rfc).wav = []; % wav channel not recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5];
raw_data_file_db(rfc).spikeforms = 'r6y12A-f0003-Spkforms';
raw_data_file_db(rfc).other_notes = 'The first white noise here is really short, should not count..This data is recorded in new recorder format (cfg.file_format = 8';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r6y12A-f0003-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'r6y12A-f0003-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'r6y12A-f0003-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r6y12A-f0003-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r6y12A-f0003-NEW_MOTIF.mat';

%%  (68) r6y12A-f0003 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [2];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  16.0644;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 16.7072;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 700;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 1571;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'lost around 1050; small crosstalk with ch 4';

%%  (68) r6y12A-f0003  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc+1; rfc+2];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 11.5037;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 14.5821;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3000;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 2150;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = 'duplicate';

%%  (68) r6y12A-f0003  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc+1; rfc+2];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 10.5540;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  13.4488;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 0;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 2141;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L3';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 4;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate; poking this neuron during wneof, might be 2 neurons?';


%%  (68) r6y12A-f0003 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 16.0669;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 17.5875;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 3500;
raw_data_file_db(rfc).chan_info(4).ml = 1200;
raw_data_file_db(rfc).chan_info(4).dv = 2622;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L3';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 4;
raw_data_file_db(rfc).chan_info(4).notes = '';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (69) r6y12A-f0004 = 68
raw_data_file_db(rfc).birdID  = 14;
raw_data_file_db(rfc).bird_name  = 'r6y12';
raw_data_file_db(rfc).bird_age  = 233;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r6y12A-f0004.lvd';
raw_data_file_db(rfc).spike_file = 'r6y12A-f0004-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 8;

% General Channel Info
raw_data_file_db(rfc).wav = []; % wav channel not recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 3 4];
raw_data_file_db(rfc).spikeforms = 'r6y12A-f0004-Spkforms';
raw_data_file_db(rfc).other_notes = 'This data is recorded in new recorder format (cfg.file_format = 8';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r6y12A-f0004-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'r6y12A-f0004-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'r6y12A-f0004-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r6y12A-f0004-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r6y12A-f0004-NEW_MOTIF.mat';

%%  (69) r6y12A-f0004 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc-1;];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [2];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw = 37.2057;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 38.7244;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 700;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 1583;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'small crosstalk with ch 4, another neuron present at end';

%%  (69) r6y12A-f0004  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc-1; rfc+1];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 10.2200;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 13.6496;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3000;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 2150;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = 'duplicate neuron';

%%  (69) r6y12A-f0004  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1; rfc+1; ];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 19.4730;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  27.7259;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 0;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 2140;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L3';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 4;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate neuron';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (70) r6y12A-f0005 = 70
raw_data_file_db(rfc).birdID  = 14;
raw_data_file_db(rfc).bird_name  = 'r6y12';
raw_data_file_db(rfc).bird_age  = 233;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r6y12A-f0005.lvd';
raw_data_file_db(rfc).spike_file = 'r6y12A-f0005-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 8;

% General Channel Info
raw_data_file_db(rfc).wav = []; % wav channel not recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5];
raw_data_file_db(rfc).spikeforms = 'r6y12A-f0005-Spkforms';
raw_data_file_db(rfc).other_notes = 'some Mvmt artifacts, This data is recorded in new recorder format (cfg.file_format = 8';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r6y12A-f0005-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'r6y12A-f0005-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'r6y12A-f0005-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r6y12A-f0005-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r6y12A-f0005-NEW_MOTIF.mat';

%%  (70) r6y12A-f0005 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  44.6808;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 46.5301;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 700;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 1571;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = '';

%%  (70) r6y12A-f0005  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc-1; rfc-2;];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 10.2071;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 12.8404;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3000;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 2150;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = 'duplicate';

%%  (70) r6y12A-f0005  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1; rfc-2];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 10.5540;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =   25.2422;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 0;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 2143;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L3';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 4;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate, lost at 1120';


%%  (70) r6y12A-f0005 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 30.2018;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 30.7735;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 3500;
raw_data_file_db(rfc).chan_info(4).ml = 1200;
raw_data_file_db(rfc).chan_info(4).dv = 2528;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(4).notes = '';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% r6y12A-f0006.lvd = no data
%% r6y12A-f0007.lvd = too many movement artifacts - dont use
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (71) r6y12A-f0008 = 70
raw_data_file_db(rfc).birdID  = 14;
raw_data_file_db(rfc).bird_name  = 'r6y12';
raw_data_file_db(rfc).bird_age  = 233;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'r6y12A-f0008.lvd';
raw_data_file_db(rfc).spike_file = 'r6y12A-f0008-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 8;

% General Channel Info
raw_data_file_db(rfc).wav = []; % wav channel not recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 4 5];
raw_data_file_db(rfc).spikeforms = 'r6y12A-f0008-Spkforms';
raw_data_file_db(rfc).other_notes = 'MAny Mvmt artifacts, This data is recorded in new recorder format (cfg.file_format = 8';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'r6y12A-f0008-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'r6y12A-f0008-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'r6y12A-f0008-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'r6y12A-f0008-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'r6y12A-f0008-NEW_MOTIF.mat';

%%  (71) r6y12A-f0008 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  22.1061;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 22.7495;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 700;
raw_data_file_db(rfc).chan_info(1).ml = 1200;
raw_data_file_db(rfc).chan_info(1).dv = 2094;
raw_data_file_db(rfc).chan_info(1).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(1).notes = '';

%%  (71) r6y12A-f0008  - Chan 3
% Lost neuron at 120 s

%%  (71) r6y12A-f0008  - Chan 4
raw_data_file_db(rfc).chan_info(2).channel = 4;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 15.5526;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 21.4073;

raw_data_file_db(rfc).chan_info(2).manipulator = 3;
raw_data_file_db(rfc).chan_info(2).ap = 0;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 2540;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L3';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 4;
raw_data_file_db(rfc).chan_info(2).notes = '';


%%  (71) r6y12A-f0008 - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 16.6243;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 17.8871;

raw_data_file_db(rfc).chan_info(3).manipulator = 4;
raw_data_file_db(rfc).chan_info(3).ap = 3500;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 2112;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = '';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% r6y12A-f0009.lvd = Incomplete filed - too many mvmt artifacts
%% r6y12A-f0010.lvd = Incomplete file  - too many mvmt artifacts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (72) y5y10 01 = 71
raw_data_file_db(rfc).birdID  = 15;
raw_data_file_db(rfc).bird_name  = 'y5y10';
raw_data_file_db(rfc).bird_age  = 520;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'y5y10 01';
raw_data_file_db(rfc).spike_file = 'y5y10 01-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5];
raw_data_file_db(rfc).spikeforms = 'y5y10 01-Spkforms';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'y5y10 01-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'y5y10 01-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'y5y10 01-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'y5y10 01-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'y5y10 01-NEW_MOTIF.mat';

%%  (72) y5y10 01 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  7.3420;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 8.4453;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 708;
raw_data_file_db(rfc).chan_info(1).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(1).notes = '';

%%  (72) y5y10 01  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  9.1608;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  12.6383;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3000;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 1917;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = 'duplicate';

%%  (72) y5y10 01  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  14.2740;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 17.0972;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1503;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate';


%%  (72) y5y10 01 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 13.4918;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil = 13.5744;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 4000;
raw_data_file_db(rfc).chan_info(4).ml = 1400;
raw_data_file_db(rfc).chan_info(4).dv = 1611;
raw_data_file_db(rfc).chan_info(4).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(4).notes = 'duplicate';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (73) y5y10 02 = 72

raw_data_file_db(rfc).birdID  = 15;
raw_data_file_db(rfc).bird_name  = 'y5y10';
raw_data_file_db(rfc).bird_age  = 520;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'y5y10 02';
raw_data_file_db(rfc).spike_file = 'y5y10 02-0-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 6;
raw_data_file_db(rfc).neuron_chans = [2 3 4 5 7];
raw_data_file_db(rfc).spikeforms = 'y5y10 02-Spkforms';
raw_data_file_db(rfc).other_notes = '';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'y5y10 02-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'y5y10 02-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'y5y10 02-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'y5y10 02-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'y5y10 02-NEW_MOTIF.mat';

%%  (73) y5y10 02 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw = 18.1204;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 19.2277;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 920;
raw_data_file_db(rfc).chan_info(1).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(1).notes = '';

%%  (73) y5y10 02  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  8.7900;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  12.0372;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3000;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 1918;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = 'duplicate';

%%  (73) y5y10 02  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [4];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  15.3089;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  17.5489;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1503;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate; another small neuron present, sorted on ch 7';


%%  (73) y5y10 02 - Chan 5
raw_data_file_db(rfc).chan_info(4).channel = 5;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 14.8431;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =  15.0704;

raw_data_file_db(rfc).chan_info(4).manipulator = 4;
raw_data_file_db(rfc).chan_info(4).ap = 4000;
raw_data_file_db(rfc).chan_info(4).ml = 1400;
raw_data_file_db(rfc).chan_info(4).dv = 1613;
raw_data_file_db(rfc).chan_info(4).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(4).notes = 'duplicate';


%%  (73) y5y10 02  - Chan 7 (4)
raw_data_file_db(rfc).chan_info(5).channel = 4;
raw_data_file_db(rfc).chan_info(5).spikefile_index = 7;
raw_data_file_db(rfc).chan_info(5).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(5).same_as_ind = [];
raw_data_file_db(rfc).chan_info(5).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(5).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(5).SN_ratio_raw =  4.1942;
raw_data_file_db(rfc).chan_info(5).SN_ratio_fil = 5.0500;

raw_data_file_db(rfc).chan_info(5).manipulator = 3;
raw_data_file_db(rfc).chan_info(5).ap = 500;
raw_data_file_db(rfc).chan_info(5).ml = 1200;
raw_data_file_db(rfc).chan_info(5).dv = 1503;
raw_data_file_db(rfc).chan_info(5).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(5).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(5).notes = 'small neuron from ch 4';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  y5y10 03 = Only data on ch 2, do not use

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (74) y5y10 04 = 73

raw_data_file_db(rfc).birdID  = 15;
raw_data_file_db(rfc).bird_name  = 'y5y10';
raw_data_file_db(rfc).bird_age  = 520;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'y5y10 04';
raw_data_file_db(rfc).spike_file = 'y5y10 04-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 4;
raw_data_file_db(rfc).neuron_chans = [2 5 6];
raw_data_file_db(rfc).spikeforms = 'y5y10 04-Spkforms';
raw_data_file_db(rfc).other_notes = 'Manipulator channels for this recording, MIC now ch 4';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'y5y10 04-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'y5y10 04-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'y5y10 04-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'y5y10 04-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'y5y10 04-NEW_MOTIF.mat';

%%  (74) y5y10 04 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [6];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw = 22.6529;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 25.3145;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 1209;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'small crosstralk from ch 6';

%%  (74) y5y10 04  - Chan 3 - big crosstalk from ch 5; 2/3 neurons, hard to sort, come back

%%  (74) y5y10 04  - Chan 5
raw_data_file_db(rfc).chan_info(2).channel = 5;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =   11.7085;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  15.1789;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3000;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 1592;
raw_data_file_db(rfc).chan_info(2).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(2).notes = 'duplicate';


%%  (74) y5y10 04 - Chan 6
raw_data_file_db(rfc).chan_info(3).channel = 6;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  8.9416;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  10.4257;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1609;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = '';

rfc = rfc +1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (75) y5y10 05 = 73
raw_data_file_db(rfc).birdID  = 15;
raw_data_file_db(rfc).bird_name  = 'y5y10';
raw_data_file_db(rfc).bird_age  = 520;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'y5y10 05';
raw_data_file_db(rfc).spike_file = 'y5y10 05-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 4;
raw_data_file_db(rfc).neuron_chans = [2 5 6];
raw_data_file_db(rfc).spikeforms = 'y5y10 05-Spkforms';
raw_data_file_db(rfc).other_notes = 'Manipulator channels for this recording, MIC now ch 4';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'y5y10 05-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'y5y10 05-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'y5y10 05-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'y5y10 05-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'y5y10 05-NEW_MOTIF.mat';


%%  (75) y5y10 05 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [6];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  21.3026;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 24.0291;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 1444;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'big crosstralk from ch 6';

%%  (75) y5y10 05  - Chan 3 - big crosstalk from ch 5; 2/3 neurons, hard to sort, come back;

%%  (75) y5y10 05  - Chan 5
raw_data_file_db(rfc).chan_info(2).channel = 5;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  12.0256;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  14.3370;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3000;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 1592;
raw_data_file_db(rfc).chan_info(2).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(2).notes = 'duplicate';


%%  (75) y5y10 05 - Chan 6
raw_data_file_db(rfc).chan_info(3).channel = 6;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc+1; rfc+2; rfc+3];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [6];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  15.4675;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  17.2565;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 612;
raw_data_file_db(rfc).chan_info(3).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (76) y5y10 06 = 75

raw_data_file_db(rfc).birdID  = 15;
raw_data_file_db(rfc).bird_name  = 'y5y10';
raw_data_file_db(rfc).bird_age  = 520;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'y5y10 06';
raw_data_file_db(rfc).spike_file = 'y5y10 06-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 4;
raw_data_file_db(rfc).neuron_chans = [2 5 6];
raw_data_file_db(rfc).spikeforms = 'y5y10 06-Spkforms';
raw_data_file_db(rfc).other_notes = 'Manipulator channels for this recording, MIC now ch 4';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'y5y10 06-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'y5y10 06-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'y5y10 06-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'y5y10 06-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'y5y10 06-NEW_MOTIF.mat';

%%  (76) y5y10 06 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [6];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  13.0730;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 15.6341;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 1509;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2b';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 2;
raw_data_file_db(rfc).chan_info(1).notes = 'big crosstralk from ch 6';

%%  (76) y5y10 06 - Chan 3 - No Neuron, all crosstalk from ch 5

%%  (76) y5y10 06  - Chan 5
raw_data_file_db(rfc).chan_info(2).channel = 5;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc+1; rfc+2; rfc+3; rfc+4; rfc+5; rfc+6;];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =   20.1998;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  25.5673;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3000;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 1730;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = 'duplicate';


%%  (76) y5y10 06 - Chan 6
raw_data_file_db(rfc).chan_info(3).channel = 6;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1; rfc+1; rfc+2];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [6];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  13.5428;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 13.5426;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 612;
raw_data_file_db(rfc).chan_info(3).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (77) y5y10 07 = 76

raw_data_file_db(rfc).birdID  = 15;
raw_data_file_db(rfc).bird_name  = 'y5y10';
raw_data_file_db(rfc).bird_age  = 520;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'y5y10 07';
raw_data_file_db(rfc).spike_file = 'y5y10 07-0-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 4;
raw_data_file_db(rfc).neuron_chans = [2 3 5 6 7];
raw_data_file_db(rfc).spikeforms = 'y5y10 07-Spkforms';
raw_data_file_db(rfc).other_notes = 'Manipulator channels for this recording, MIC now ch 4';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'y5y10 07-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'y5y10 07-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'y5y10 07-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'y5y10 07-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'y5y10 07-NEW_MOTIF.mat';

%%  (77) y5y10 07 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [6];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =   14.7637;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 16.0026;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 1743;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = 'big crosstralk from ch 6';

%%  (77) y5y10 07  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc+1; rfc+2; rfc+3; rfc+4; rfc+5; ];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [5];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  29.4037;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 30.4432;

raw_data_file_db(rfc).chan_info(2).manipulator = 4;
raw_data_file_db(rfc).chan_info(2).ap = 4000;
raw_data_file_db(rfc).chan_info(2).ml = 1400;
raw_data_file_db(rfc).chan_info(2).dv = 1720;
raw_data_file_db(rfc).chan_info(2).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(2).notes = 'duplicate; another neuron, sorted on ch 7 - big crosstalk from ch 5;';

%%  (77) y5y10 07  - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1; rfc+1; rfc+2; rfc+3; rfc+4; rfc+5;] ;
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =   22.1084;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 26.6503 ;

raw_data_file_db(rfc).chan_info(3).manipulator = 2;
raw_data_file_db(rfc).chan_info(3).ap = 3000;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1730;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate';


%%  (77) y5y10 07 - Chan 6
raw_data_file_db(rfc).chan_info(4).channel = 6;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc+1; rfc-1; rfc-2; ];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [6];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =   13.5204;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =  14.3786;

raw_data_file_db(rfc).chan_info(4).manipulator = 3;
raw_data_file_db(rfc).chan_info(4).ap = 500;
raw_data_file_db(rfc).chan_info(4).ml = 1200;
raw_data_file_db(rfc).chan_info(4).dv = 612;
raw_data_file_db(rfc).chan_info(4).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(4).notes = 'duplicate';

%%  (77) y5y10 07  - Chan 7(3)
raw_data_file_db(rfc).chan_info(5).channel = 3;
raw_data_file_db(rfc).chan_info(5).spikefile_index = 7;
raw_data_file_db(rfc).chan_info(5).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(5).same_as_ind = [rfc+1];
raw_data_file_db(rfc).chan_info(5).same_as_spike_chan = [7];
raw_data_file_db(rfc).chan_info(5).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(5).SN_ratio_raw =   5.8420;
raw_data_file_db(rfc).chan_info(5).SN_ratio_fil =  5.8259;

raw_data_file_db(rfc).chan_info(5).manipulator = 2;
raw_data_file_db(rfc).chan_info(5).ap = 3000;
raw_data_file_db(rfc).chan_info(5).ml = 1200;
raw_data_file_db(rfc).chan_info(5).dv = 1730;
raw_data_file_db(rfc).chan_info(5).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(5).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(5).notes = 'duplicate; small neruon from ch 3';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (78) y5y10 08 = 77

raw_data_file_db(rfc).birdID  = 15;
raw_data_file_db(rfc).bird_name  = 'y5y10';
raw_data_file_db(rfc).bird_age  = 520;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'y5y10 08';
raw_data_file_db(rfc).spike_file = 'y5y10 08-0-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 4;
raw_data_file_db(rfc).neuron_chans = [2 3 5 6 7];
raw_data_file_db(rfc).spikeforms = 'y5y10 08-Spkforms';
raw_data_file_db(rfc).other_notes = 'Manipulator channels for this recording, MIC now ch 4';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'y5y10 08-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'y5y10 08-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'y5y10 08-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'y5y10 08-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'y5y10 08-NEW_MOTIF.mat';

%%  (78) y5y10 08 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [6];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  11.8999;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 11.9590;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 670;
raw_data_file_db(rfc).chan_info(1).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(1).notes = 'crosstralk from ch 6';

%%  (78) y5y10 08  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc-1; rfc+1; rfc+2; rfc+3; rfc+4;];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [5];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =  21.8323;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 22.3019;

raw_data_file_db(rfc).chan_info(2).manipulator = 4;
raw_data_file_db(rfc).chan_info(2).ap = 4000;
raw_data_file_db(rfc).chan_info(2).ml = 1400;
raw_data_file_db(rfc).chan_info(2).dv = 1720;
raw_data_file_db(rfc).chan_info(2).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(2).notes = 'duplicate; another neuron, sorted on ch 7 - big crosstalk from ch 5;';

%%  (78) y5y10 08  - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1; rfc-2; rfc+1; rfc+2; rfc+3; rfc+4];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  18.4852;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 20.6308;

raw_data_file_db(rfc).chan_info(3).manipulator = 2;
raw_data_file_db(rfc).chan_info(3).ap = 3000;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1730;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate';


%%  (78) y5y10 08 - Chan 6
raw_data_file_db(rfc).chan_info(4).channel = 6;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc-1; rfc-2; rfc-3];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [6];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =   9.7869;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =  11.0488;

raw_data_file_db(rfc).chan_info(4).manipulator = 3;
raw_data_file_db(rfc).chan_info(4).ap = 500;
raw_data_file_db(rfc).chan_info(4).ml = 1200;
raw_data_file_db(rfc).chan_info(4).dv = 654;
raw_data_file_db(rfc).chan_info(4).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(4).notes = 'duplicate, lost neuron at 617';

%%  (78) y5y10 08  - Chan 7(5)
raw_data_file_db(rfc).chan_info(5).channel = 3;
raw_data_file_db(rfc).chan_info(5).spikefile_index = 7;
raw_data_file_db(rfc).chan_info(5).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(5).same_as_ind = [rfc-1];
raw_data_file_db(rfc).chan_info(5).same_as_spike_chan = [7];
raw_data_file_db(rfc).chan_info(5).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(5).SN_ratio_raw =   2.2534;
raw_data_file_db(rfc).chan_info(5).SN_ratio_fil =  2.1342;

raw_data_file_db(rfc).chan_info(5).manipulator = 2;
raw_data_file_db(rfc).chan_info(5).ap = 3000;
raw_data_file_db(rfc).chan_info(5).ml = 1200;
raw_data_file_db(rfc).chan_info(5).dv = 1730;
raw_data_file_db(rfc).chan_info(5).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(5).putative_area_num = 7;
raw_data_file_db(rfc).chan_info(5).notes = 'small neruon from ch 3; duplicate';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (79) y5y10 09 = 78

raw_data_file_db(rfc).birdID  = 15;
raw_data_file_db(rfc).bird_name  = 'y5y10';
raw_data_file_db(rfc).bird_age  = 520;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'y5y10 09';
raw_data_file_db(rfc).spike_file = 'y5y10 09-0-0-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 4;
raw_data_file_db(rfc).neuron_chans = [2 3 5 6 7 8];
raw_data_file_db(rfc).spikeforms = 'y5y10 09-Spkforms';
raw_data_file_db(rfc).other_notes = 'Manipulator channels for this recording, MIC now ch 4';

% playback info
raw_data_file_db(rfc).soundfile_vers = 2;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'y5y10 09-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'y5y10 09-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'y5y10 09-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'y5y10 09-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'y5y10 09-NEW_MOTIF.mat';

%%  (79) y5y10 09 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [6];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  9.0438;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 9.7337;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 760;
raw_data_file_db(rfc).chan_info(1).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(1).notes = 'crosstralk from ch 6';

%%  (79) y5y10 09  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc-1; rfc-2; rfc+1; rfc+2; rfc+3;];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [5];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 28.4191;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 29.7202;

raw_data_file_db(rfc).chan_info(2).manipulator = 4;
raw_data_file_db(rfc).chan_info(2).ap = 4000;
raw_data_file_db(rfc).chan_info(2).ml = 1400;
raw_data_file_db(rfc).chan_info(2).dv = 1737;
raw_data_file_db(rfc).chan_info(2).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(2).notes = 'duplicate; another neuron v sparse neuron sorted on ch 8 - big crosstalk from ch 5;';

%%  (79) y5y10 09  - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1; rfc-2; rfc-3; rfc+1; rfc+2; rfc+3; ];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [3];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  17.2587;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 18.4492;

raw_data_file_db(rfc).chan_info(3).manipulator = 2;
raw_data_file_db(rfc).chan_info(3).ap = 3000;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1732;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate; small crosstalk from ch 3';


%%  (79) y5y10 09 - Chan 6
raw_data_file_db(rfc).chan_info(4).channel = 6;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc+1; rfc+2; rfc+3; ];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [6];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [2];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw =  25.3103;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =   26.2616;

raw_data_file_db(rfc).chan_info(4).manipulator = 3;
raw_data_file_db(rfc).chan_info(4).ap = 500;
raw_data_file_db(rfc).chan_info(4).ml = 1200;
raw_data_file_db(rfc).chan_info(4).dv = 722;
raw_data_file_db(rfc).chan_info(4).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(4).notes = 'duplicate; some small crosstalk from ch 2';

%%  (79) y5y10 09  - Chan 7(2)
raw_data_file_db(rfc).chan_info(5).channel = 2;
raw_data_file_db(rfc).chan_info(5).spikefile_index = 7;
raw_data_file_db(rfc).chan_info(5).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(5).same_as_ind = [];
raw_data_file_db(rfc).chan_info(5).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(5).crosstalk_from_channel = [6];
raw_data_file_db(rfc).chan_info(5).SN_ratio_raw = 56.9188;
raw_data_file_db(rfc).chan_info(5).SN_ratio_fil =  63.1124;

raw_data_file_db(rfc).chan_info(5).manipulator = 1;
raw_data_file_db(rfc).chan_info(5).ap = 0;
raw_data_file_db(rfc).chan_info(5).ml = 1400;
raw_data_file_db(rfc).chan_info(5).dv = 760;
raw_data_file_db(rfc).chan_info(5).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(5).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(5).notes = 'Big neuron from ch 2, crosstalk from ch 6';


%%  (79) y5y10 09  - Chan 8(3)
raw_data_file_db(rfc).chan_info(6).channel = 3;
raw_data_file_db(rfc).chan_info(6).spikefile_index = 8;
raw_data_file_db(rfc).chan_info(6).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(6).same_as_ind = [];
raw_data_file_db(rfc).chan_info(6).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(6).crosstalk_from_channel = [5];
raw_data_file_db(rfc).chan_info(6).SN_ratio_raw =   8.4444;
raw_data_file_db(rfc).chan_info(6).SN_ratio_fil =  9.1702;

raw_data_file_db(rfc).chan_info(6).manipulator = 4;
raw_data_file_db(rfc).chan_info(6).ap = 4000;
raw_data_file_db(rfc).chan_info(6).ml = 1400;
raw_data_file_db(rfc).chan_info(6).dv = 1737;
raw_data_file_db(rfc).chan_info(6).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(6).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(6).notes = 'v sparse neuron from ch 3;';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (80) y5y10 10 = 79

raw_data_file_db(rfc).birdID  = 15;
raw_data_file_db(rfc).bird_name  = 'y5y10';
raw_data_file_db(rfc).bird_age  = 520;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'y5y10 10';
raw_data_file_db(rfc).spike_file = 'y5y10 10-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 4;
raw_data_file_db(rfc).neuron_chans = [3 5 6];
raw_data_file_db(rfc).spikeforms = 'y5y10 10-Spkforms';
raw_data_file_db(rfc).other_notes = 'Manipulator channels for this recording, MIC now ch 4';

% playback info
raw_data_file_db(rfc).soundfile_vers = 5;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'y5y10 10-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'y5y10 10-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'y5y10 10-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'y5y10 10-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'y5y10 10-NEW_MOTIF.mat';

%%  (80) y5y10 10 - Chan 2 - No Recording (UF?)

%%  (80) y5y10 10  - Chan 3
raw_data_file_db(rfc).chan_info(1).channel = 3;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc-1; rfc-2; rfc-3; rfc+1; rfc+2;];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [5];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  30.1208;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  30.9837;

raw_data_file_db(rfc).chan_info(1).manipulator = 4;
raw_data_file_db(rfc).chan_info(1).ap = 4000;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 1737;
raw_data_file_db(rfc).chan_info(1).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(1).notes = 'duplicate; another neuron v sparse neuron sorted on ch 8 - big crosstalk from ch 5;';

%%  (80) y5y10 10  - Chan 5
raw_data_file_db(rfc).chan_info(2).channel = 5;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc-1; rfc-2; rfc-3; rfc-4; rfc+1; rfc+2];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 14.3836;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 14.4789;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3000;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 1732;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = 'duplicate;';


%%  (80) y5y10 10 - Chan 6
raw_data_file_db(rfc).chan_info(3).channel = 6;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1; rfc+1; rfc+2];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [6];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 19.9459;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 22.0206;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 722;
raw_data_file_db(rfc).chan_info(3).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate';

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (81) y5y10 11 = 80

raw_data_file_db(rfc).birdID  = 15;
raw_data_file_db(rfc).bird_name  = 'y5y10';
raw_data_file_db(rfc).bird_age  = 520;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'y5y10 11';
raw_data_file_db(rfc).spike_file = 'y5y10 11-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 4;
raw_data_file_db(rfc).neuron_chans = [3 5 6];
raw_data_file_db(rfc).spikeforms = 'y5y10 11-Spkforms';
raw_data_file_db(rfc).other_notes = 'Manipulator channels for this recording, MIC now ch 4';

% playback info
raw_data_file_db(rfc).soundfile_vers = 5;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'y5y10 11-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'y5y10 11-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'y5y10 11-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'y5y10 11-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'y5y10 11-NEW_MOTIF.mat';

%%  (81) y5y10 11 - Chan 2 - No Recording (UF?)

%%  (81) y5y10 11  - Chan 3
raw_data_file_db(rfc).chan_info(1).channel = 3;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [rfc+1; rfc-1; rfc-2; rfc-3; rfc-4; ];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [5];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =   21.5124;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil =  21.6491;

raw_data_file_db(rfc).chan_info(1).manipulator = 4;
raw_data_file_db(rfc).chan_info(1).ap = 4000;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 1737;
raw_data_file_db(rfc).chan_info(1).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(1).notes = 'duplicate; another neuron v sparse neuron sorted on ch 8 - big crosstalk from ch 5;';

%%  (81) y5y10 11  - Chan 5
raw_data_file_db(rfc).chan_info(2).channel = 5;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc+1; rfc-1; rfc-2; rfc-3; rfc-4; rfc-5];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 13.0757;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 13.0054;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3000;
raw_data_file_db(rfc).chan_info(2).ml = 1200;
raw_data_file_db(rfc).chan_info(2).dv = 1732;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(2).notes = 'duplicate;';


%%  (81) y5y10 11 - Chan 6
raw_data_file_db(rfc).chan_info(3).channel = 6;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc+1; rfc-1; rfc-2; ];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [6];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 10.7481;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil =  14.6648;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 722;
raw_data_file_db(rfc).chan_info(3).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate';

rfc = rfc +1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (82) y5y10 12 = 81

raw_data_file_db(rfc).birdID  = 15;
raw_data_file_db(rfc).bird_name  = 'y5y10';
raw_data_file_db(rfc).bird_age  = 520;
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'y5y10 12';
raw_data_file_db(rfc).spike_file = 'y5y10 12-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 2;

% General Channel Info
raw_data_file_db(rfc).wav = 1;
raw_data_file_db(rfc).mic = 4;
raw_data_file_db(rfc).neuron_chans = [2 3 5 6];
raw_data_file_db(rfc).spikeforms = 'y5y10 12-Spkforms';
raw_data_file_db(rfc).other_notes = 'Manipulator channels for this recording, MIC now ch 4';

% playback info
raw_data_file_db(rfc).soundfile_vers = 5;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'y5y10 12-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'y5y10 12-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'y5y10 12-SPONT.mat';
raw_data_file_db(rfc).FREE_SPONT_startstop = 'y5y10 12-FREE_SPONT.mat';
raw_data_file_db(rfc).NEW_MOTIF_startstop = 'y5y10 12-NEW_MOTIF.mat';

%%  (82) y5y10 12 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = []; % a lot has been done to this neuron by now...
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [6];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw =  29.6428;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 30.8024;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0;
raw_data_file_db(rfc).chan_info(1).ml = 1400;
raw_data_file_db(rfc).chan_info(1).dv = 760;
raw_data_file_db(rfc).chan_info(1).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(1).notes = 'crosstralk from ch 6';

%%  (82) y5y10 12  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [rfc-1; rfc-2; rfc-3; rfc-4; rfc-5; ];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [3];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [5];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw =   24.2971;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  24.2095;

raw_data_file_db(rfc).chan_info(2).manipulator = 4;
raw_data_file_db(rfc).chan_info(2).ap = 4000;
raw_data_file_db(rfc).chan_info(2).ml = 1400;
raw_data_file_db(rfc).chan_info(2).dv = 1737;
raw_data_file_db(rfc).chan_info(2).putative_area = 'CM';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 6;
raw_data_file_db(rfc).chan_info(2).notes = 'duplicate; another neuron v sparse neuron sorted on ch 8 - big crosstalk from ch 5;';

%%  (82) y5y10 12  - Chan 5
raw_data_file_db(rfc).chan_info(3).channel = 5;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 5;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [rfc-1; rfc-2; rfc-3; rfc-4; rfc-5; rfc-6];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [5];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw =  13.5353;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 13.4704;

raw_data_file_db(rfc).chan_info(3).manipulator = 2;
raw_data_file_db(rfc).chan_info(3).ap = 3000;
raw_data_file_db(rfc).chan_info(3).ml = 1200;
raw_data_file_db(rfc).chan_info(3).dv = 1732;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = 'duplicate;';


%%  (82) y5y10 12 - Chan 6
raw_data_file_db(rfc).chan_info(4).channel = 6;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 6;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 1;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [rfc-1; rfc-2; rfc-3;];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [6];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 17.8260;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =  23.8514;

raw_data_file_db(rfc).chan_info(4).manipulator = 3;
raw_data_file_db(rfc).chan_info(4).ap = 500;
raw_data_file_db(rfc).chan_info(4).ml = 1200;
raw_data_file_db(rfc).chan_info(4).dv = 722;
raw_data_file_db(rfc).chan_info(4).putative_area = 'HVC-Shelf';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 8;
raw_data_file_db(rfc).chan_info(4).notes = 'duplicate';

rfc = rfc +1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%% yellow20A-f0009 = Incomplete data


%%  (83) yellow20A-f0012 = 82
raw_data_file_db(rfc).birdID  = 16;
raw_data_file_db(rfc).bird_name  = 'yellow20';
raw_data_file_db(rfc).bird_age  = [];
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'yellow20A-f0012.lvd';
raw_data_file_db(rfc).spike_file = 'yellow20A-f0012-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 8;

% General Channel Info
raw_data_file_db(rfc).wav = []; % wav channel not recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 3 4];
raw_data_file_db(rfc).spikeforms = 'yellow20A-f0012-Spkforms';
raw_data_file_db(rfc).other_notes = 'This data is recorded in new recorder format (cfg.file_format = 8';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'yellow20A-f0012-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'yellow20A-f0012-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'yellow20A-f0012-SPONT.mat';

%%  (83) yellow20A-f0012 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw = 16.2833;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 17.3446;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0; % using coordinates from p17r2
raw_data_file_db(rfc).chan_info(1).ml = 1200; % using coordinates from p17r2 
raw_data_file_db(rfc).chan_info(1).dv = []; % unknown
raw_data_file_db(rfc).chan_info(1).putative_area = 'L1';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 3;
raw_data_file_db(rfc).chan_info(1).notes = '';

%%  (83) yellow20A-f0012  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 20.0441;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil = 25.8301;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3000; % using coordinates from p17r2
raw_data_file_db(rfc).chan_info(2).ml = 1200; % using coordinates from p17r2
raw_data_file_db(rfc).chan_info(2).dv = 2656;
raw_data_file_db(rfc).chan_info(2).putative_area = 'L3';
raw_data_file_db(rfc).chan_info(2).putative_area_num = 4;
raw_data_file_db(rfc).chan_info(2).notes = '';

%%  (83) yellow20A-f0012  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 24.1555;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 33.5486;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500; % using coordinates from p17r2
raw_data_file_db(rfc).chan_info(3).ml = 1200; % using coordinates from p17r2
raw_data_file_db(rfc).chan_info(3).dv = 1902;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = '';

%%  (83) yellow20A-f0012 - Chan 5 - lost neuron at 260, crosstalk from ch 3

rfc = rfc +1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% yellow20A-f0013 = Lost all neurons excpet for that on ch 3, dont use

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%#%%%%%%%%%%
%%  (84) yellow20A-f0014 = 82
raw_data_file_db(rfc).birdID  = 16;
raw_data_file_db(rfc).bird_name  = 'yellow20';
raw_data_file_db(rfc).bird_age  = [];
raw_data_file_db(rfc).data_number  = rfc; 
%file info
raw_data_file_db(rfc).raw_file = 'yellow20A-f0014.lvd';
raw_data_file_db(rfc).spike_file = 'yellow20A-f0014-0-0-0-0';
raw_data_file_db(rfc).scanrate = 30031;
raw_data_file_db(rfc).data_file_format = 8;

% General Channel Info
raw_data_file_db(rfc).wav = []; % wav channel not recorded
raw_data_file_db(rfc).mic = 1;
raw_data_file_db(rfc).neuron_chans = [2 3 4];
raw_data_file_db(rfc).spikeforms = 'yellow20A-f0014-Spkforms';
raw_data_file_db(rfc).other_notes = 'This data is recorded in new recorder format (cfg.file_format = 8';

% playback info
raw_data_file_db(rfc).soundfile_vers = 3;
raw_data_file_db(rfc).startstop_path = 'Startstop';
raw_data_file_db(rfc).BOUT_startstop = 'yellow20A-f0014-BOUT.mat';
raw_data_file_db(rfc).MOTIF_startstop = 'yellow20A-f0014-MOTIF.mat';
raw_data_file_db(rfc).SPONT_startstop = 'yellow20A-f0014-SPONT.mat';

%%  (84) yellow20A-f0014 - Chan 2
raw_data_file_db(rfc).chan_info(1).channel = 2;
raw_data_file_db(rfc).chan_info(1).spikefile_index = 2;
raw_data_file_db(rfc).chan_info(1).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(1).same_as_ind = [];
raw_data_file_db(rfc).chan_info(1).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(1).crosstalk_from_channel = [4];
raw_data_file_db(rfc).chan_info(1).SN_ratio_raw = 12.6842;
raw_data_file_db(rfc).chan_info(1).SN_ratio_fil = 11.9904;

raw_data_file_db(rfc).chan_info(1).manipulator = 1;
raw_data_file_db(rfc).chan_info(1).ap = 0; % using coordinates from p17r2
raw_data_file_db(rfc).chan_info(1).ml = 1200; % using coordinates from p17r2 
raw_data_file_db(rfc).chan_info(1).dv = 2837;
raw_data_file_db(rfc).chan_info(1).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(1).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(1).notes = 'crosstalk from ch 4';

%%  (84) yellow20A-f0014  - Chan 3
raw_data_file_db(rfc).chan_info(2).channel = 3;
raw_data_file_db(rfc).chan_info(2).spikefile_index = 3;
raw_data_file_db(rfc).chan_info(2).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(2).same_as_ind = [];
raw_data_file_db(rfc).chan_info(2).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(2).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(2).SN_ratio_raw = 20.4277;
raw_data_file_db(rfc).chan_info(2).SN_ratio_fil =  26.0622;

raw_data_file_db(rfc).chan_info(2).manipulator = 2;
raw_data_file_db(rfc).chan_info(2).ap = 3000; % using coordinates from p17r2
raw_data_file_db(rfc).chan_info(2).ml = 1200; % using coordinates from p17r2
raw_data_file_db(rfc).chan_info(2).dv = 2676;
raw_data_file_db(rfc).chan_info(2).putative_area = '';
raw_data_file_db(rfc).chan_info(2).putative_area_num = [];
raw_data_file_db(rfc).chan_info(2).notes = 'another small neurons presetn, sorted on ch 6';

%%  (84) yellow20A-f0014  - Chan 4
raw_data_file_db(rfc).chan_info(3).channel = 4;
raw_data_file_db(rfc).chan_info(3).spikefile_index = 4;
raw_data_file_db(rfc).chan_info(3).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(3).same_as_ind = [];
raw_data_file_db(rfc).chan_info(3).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(3).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(3).SN_ratio_raw = 31.0359;
raw_data_file_db(rfc).chan_info(3).SN_ratio_fil = 41.5106;

raw_data_file_db(rfc).chan_info(3).manipulator = 3;
raw_data_file_db(rfc).chan_info(3).ap = 500; % using coordinates from p17r2
raw_data_file_db(rfc).chan_info(3).ml = 1200; % using coordinates from p17r2
raw_data_file_db(rfc).chan_info(3).dv = 2348;
raw_data_file_db(rfc).chan_info(3).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(3).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(3).notes = '';


%%  (84) yellow20A-f0014 - Chan 5 - lost neuron at 390, crosstalk from ch 3
%{
%%  (84) yellow20A-f0014  - Chan 7(3)
raw_data_file_db(rfc).chan_info(4).channel = 3;
raw_data_file_db(rfc).chan_info(4).spikefile_index = 7;
raw_data_file_db(rfc).chan_info(4).is_duplicate = 0;
raw_data_file_db(rfc).chan_info(4).same_as_ind = [];
raw_data_file_db(rfc).chan_info(4).same_as_spike_chan = [];
raw_data_file_db(rfc).chan_info(4).crosstalk_from_channel = [];
raw_data_file_db(rfc).chan_info(4).SN_ratio_raw = 4.6451;
raw_data_file_db(rfc).chan_info(4).SN_ratio_fil =   5.5567;

raw_data_file_db(rfc).chan_info(4).manipulator = 2;
raw_data_file_db(rfc).chan_info(4).ap = 3000; % using coordinates from p17r2
raw_data_file_db(rfc).chan_info(4).ml = 1200; % using coordinates from p17r2
raw_data_file_db(rfc).chan_info(4).dv = 2676;
raw_data_file_db(rfc).chan_info(4).putative_area = 'L2a';
raw_data_file_db(rfc).chan_info(4).putative_area_num = 1;
raw_data_file_db(rfc).chan_info(4).notes = 'small neuron from ch 3';

%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% yellow20A-f0015 = No Data
%% yellow20A-f0016 = Incomplete file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




end

%% EOF
