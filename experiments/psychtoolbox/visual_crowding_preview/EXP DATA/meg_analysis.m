
confile = 'MEG data\Sub_001_01_vcp.con';

matFilePath = fullfile('MATLAB Data', 'Sub_001_vcp.mat');
load_data_MAT = load(matFilePath);
data_MAT = load_data_MAT.EXP.data;

%Load the data into fieldtrip

cfg =[];

cfg.dataset = confile;

cfg.coilaccuracy = 0;

data_MEG = ft_preprocessing(cfg);

% Plot the data

cfg = [];

cfg.viewmode = 'vertical';
cfg.blocksize = 300; %in seconds;
ft_databrowser(cfg, data_MEG);

% Band-pass filter the data 
cfg = [];
cfg.bpfilter = 'yes';
cfg.bpfreq = [4 40]; % Band-pass filter range
cfg.bpfiltord = 4;    % Filter order
data_bp = ft_preprocessing(cfg, data_MEG);

% Notch filter the data at 50 Hz
cfg = [];
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51]; % Notch filter range
data_filtered_EC = ft_preprocessing(cfg, data_bp);

time = data_filtered_EC.time{1}; % Extract time vector from struct

% plot raw and filtered data
%
first_chan_raw = data_MEG.trial{1}(1,:);
second_chan_filtered = data_filtered_EC.trial{1}(1,:);

figure
plot(time,first_chan_raw)
hold on 
plot(time,second_chan_filtered)




