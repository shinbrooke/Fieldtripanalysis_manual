%% Initializations
%alpha
dataPath = 'C:\Users\user\Desktop\screen\clipped,interpolated\'; 
 
subjects = {'p02' 'p03' 'p05' 'p07' 'p09' 'p10' 'p11' 'p12' 'p13' 'p15' 'p16' 'p18' ...
    'p19' 'p20' 'p22' 'p23' 'p24' 'p25' 'p26' 'p27' 'p30' 'p31' 'p32' 'p33' 'p34' 'p35' 'p37' 'p38'}; % the variable subjects contains the list of 
                          % subject-specific directories
nSubjs = numel(subjects);

%% preprocessing
% a1
for i = 1:nSubjs
    fileName = strcat(subjects{i}, '_a1.set');
    dataSet = fullfile(dataPath,subjects{i},fileName);

    %select time
    cfg = [];
    cfg.dataset = dataSet;
    cfg.detrend = 'yes';
    dataSet = ft_preprocessing(cfg);
    cfg.outputfile = fullfile(dataPath,subjects{i},'cropped');
    cfg.toilim = [0 200];
    dataSet = ft_redefinetrial(cfg, dataSet);

    %add baseline
    filename2 = strcat(subjects{i}, '_baseline.set');
    dataSet2 = fullfile(dataPath,subjects{i},filename2);
    cfg.dataset = dataSet2;
    cfg.detrend = 'yes';
    dataSet2 = ft_preprocessing(cfg);
    cfg.toi = [0 20];
    cfg.outputfile = fullfile(dataPath,subjects{i},'baseline');

    cfg = [];
    dataSet3 = ft_appenddata(cfg, dataSet2, dataSet);

    % Computing time-frequency representation for each trial
    cfg = [];
    cfg.dataset = dataSet3;
    cfg.method = 'wavelet';
    cfg.output = 'pow';
    cfg.foi = logspace(log10(12),log10(40),23); % 1 = frequency resolution = 1/trial duration
    cfg.toi = 0:1:220;
    cfg.width = 5; % width of the wavelet ( = number of cycles). 
                   % Small values increase the temporal resolution at 
                   % the expense of frequency resolution
    cfg.keeptrials = 'no';
    cfg.channel = {'all'};
    cfg.baseline     = [0 20];
    cfg.baselinetype = 'zscore';
    cfg.outputfile = fullfile(dataPath,subjects{i},'a1base_beta_final');
    ft_freqanalysis(cfg,dataSet);
    clear dataSet
end

%% preprocessing2
% b1
for i = 1:nSubjs
    fileName = strcat(subjects{i}, '_b1.set');
    dataSet = fullfile(dataPath,subjects{i},fileName);

    %select time
    cfg = [];
    cfg.dataset = dataSet;
    cfg.detrend = 'yes';
    dataSet = ft_preprocessing(cfg);
    cfg.outputfile = fullfile(dataPath,subjects{i},'cropped');
    cfg.toilim = [0 200];
    dataSet = ft_redefinetrial(cfg, dataSet);

    %add baseline
    filename2 = strcat(subjects{i}, '_baseline.set');
    dataSet2 = fullfile(dataPath,subjects{i},filename2);
    cfg.dataset = dataSet2;
    cfg.detrend = 'yes';
    dataSet2 = ft_preprocessing(cfg);
    cfg.toi = [0 20];
    cfg.outputfile = fullfile(dataPath,subjects{i},'baseline');

    cfg = [];
    dataSet3 = ft_appenddata(cfg, dataSet2, dataSet);

    % Computing time-frequency representation for each trial
    cfg = [];
    cfg.dataset = dataSet3;
    cfg.method = 'wavelet';
    cfg.output = 'pow';
    cfg.foi = logspace(log10(12),log10(40),23); % 1 = frequency resolution = 1/trial duration
    cfg.toi = 0:1:220;
    cfg.width = 5; % width of the wavelet ( = number of cycles). 
                   % Small values increase the temporal resolution at 
                   % the expense of frequency resolution
    cfg.keeptrials = 'no';
    cfg.channel = {'all'};
    cfg.baseline     = [0 20];
    cfg.baselinetype = 'zscore';
    cfg.outputfile = fullfile(dataPath,subjects{i},'b1base_beta_final');
    ft_freqanalysis(cfg,dataSet);
    clear dataSet
end
%% preprocessing3
% c1
for i = 1:nSubjs
    fileName = strcat(subjects{i}, '_c1.set');
    dataSet = fullfile(dataPath,subjects{i},fileName);

    %select time
    cfg = [];
    cfg.dataset = dataSet;
    cfg.detrend = 'yes';
    dataSet = ft_preprocessing(cfg);
    cfg.outputfile = fullfile(dataPath,subjects{i},'cropped');
    cfg.toilim = [0 200];
    dataSet = ft_redefinetrial(cfg, dataSet);

    %add baseline
    filename2 = strcat(subjects{i}, '_baseline.set');
    dataSet2 = fullfile(dataPath,subjects{i},filename2);
    cfg.dataset = dataSet2;
    cfg.detrend = 'yes';
    dataSet2 = ft_preprocessing(cfg);
    cfg.toi = [0 20];
    cfg.outputfile = fullfile(dataPath,subjects{i},'baseline');

    cfg = [];
    dataSet3 = ft_appenddata(cfg, dataSet2, dataSet);

    % Computing time-frequency representation for each trial
    cfg = [];
    cfg.dataset = dataSet3;
    cfg.method = 'wavelet';
    cfg.output = 'pow';
    cfg.foi = logspace(log10(12),log10(40),23); % 1 = frequency resolution = 1/trial duration
    cfg.toi = 0:1:220;
    cfg.width = 5; % width of the wavelet ( = number of cycles). 
                   % Small values increase the temporal resolution at 
                   % the expense of frequency resolution
    cfg.keeptrials = 'no';
    cfg.channel = {'all'};
    cfg.baseline     = [0 20];
    cfg.baselinetype = 'zscore';
    cfg.outputfile = fullfile(dataPath,subjects{i},'c1base_beta_final');
    ft_freqanalysis(cfg,dataSet);
    clear dataSet
end

%% Load data
% load data
a1_beta = cell(1,nSubjs);
for i = 1:nSubjs
    fileName = 'a1base_beta_final.mat';
    dataSet = fullfile(dataPath,subjects{i},fileName);
    load(dataSet); % loading the variable 'freq'
    
    % Computing the average over trials
    cfg = [];
    a1_beta{i} = ft_struct2double(ft_freqdescriptives(cfg,freq));
    clear freq
end

b1_beta = cell(1,nSubjs);
for i = 1:nSubjs
    fileName = 'b1base_beta_final.mat';
    dataSet = fullfile(dataPath,subjects{i},fileName);
    load(dataSet); % loading the variable 'freq'
    
    % Computing the average over trials
    cfg = [];
    b1_beta{i} = ft_struct2double(ft_freqdescriptives(cfg,freq));
    clear freq
end

c1_beta = cell(1,nSubjs);
for i = 1:nSubjs
    fileName = 'c1base_beta_final.mat';
    dataSet = fullfile(dataPath,subjects{i},fileName);
    load(dataSet); % loading the variable 'freq'
    
    % Computing the average over trials
    cfg = [];
    c1_beta{i} = ft_struct2double(ft_freqdescriptives(cfg,freq));
    clear freq
end

%% grand average
cfg = [];
cfg.outputfile = fullfile(dataPath,'grandavg_a1_beta');
gAvga1_beta = ft_freqgrandaverage(cfg, a1_beta{:});

cfg = [];
cfg.outputfile = fullfile(dataPath,'grandavg_b1_beta');
gAvgb1_beta = ft_freqgrandaverage(cfg,b1_beta{:});

cfg = [];
cfg.outputfile = fullfile(dataPath,'grandavg_c1_beta');
gAvgc1_beta = ft_freqgrandaverage(cfg, c1_beta{:});

%% wavelet images
%a1
cfg = [];
%cfg.ylim = [8 40];
cfg.zlim = 'maxmin';
cfg.channel = {'Fp2', 'F7', 'F3', 'Fz', 'F4', 'F8', 'FC5', 'FC1', 'FC2', 'FC6', 'T7', 'C3', 'Cz', 'C4', 'T8', 'CP5', 'CP1', 'CP2', 'CP6', 'P7', 'P3', 'Pz', 'P4', 'P8', 'O1', 'Oz', 'O2'};
cfg.colormap = jet;
cfg.layout = 'acticap-64ch-standard2.mat';
figure;
ft_multiplotTFR(cfg,gAvga1_beta);
set(gca,'Fontsize',20);
title('Screen Off');
set(gca,'box','on');
xlabel('time (s)');
ylabel('frequency (Hz)');
c = colorbar;
c.LineWidth = 1;
c.FontSize  = 18;
title(c,'Rel. change');

%b1
cfg = [];
%cfg.ylim = [8 40];
cfg.zlim = 'maxmin';
cfg.channel = {'Fp2', 'F7', 'F3', 'Fz', 'F4', 'F8', 'FC5', 'FC1', 'FC2', 'FC6', 'T7', 'C3', 'Cz', 'C4', 'T8', 'CP5', 'CP1', 'CP2', 'CP6', 'P7', 'P3', 'Pz', 'P4', 'P8', 'O1', 'Oz', 'O2'};
cfg.colormap = jet;
cfg.layout = 'acticap-64ch-standard2.mat';
figure;
ft_multiplotTFR(cfg,gAvgb1_beta);
set(gca,'Fontsize',20);
title('Ceiling');
set(gca,'box','on');
xlabel('time (s)');
ylabel('frequency (Hz)');
c = colorbar;
c.LineWidth = 1;
c.FontSize  = 18;
title(c,'Rel. change');

%c1
cfg = [];
%cfg.ylim = [8 40];
cfg.zlim = 'maxmin';
cfg.channel = {'Fp2', 'F7', 'F3', 'Fz', 'F4', 'F8', 'FC5', 'FC1', 'FC2', 'FC6', 'T7', 'C3', 'Cz', 'C4', 'T8', 'CP5', 'CP1', 'CP2', 'CP6', 'P7', 'P3', 'Pz', 'P4', 'P8', 'O1', 'Oz', 'O2'};
cfg.colormap = jet;
cfg.layout = 'acticap-64ch-standard2.mat';
figure;
ft_multiplotTFR(cfg,gAvgc1_beta);
set(gca,'Fontsize',20);
title('Screen On');
set(gca,'box','on');
xlabel('time (s)');
ylabel('frequency (Hz)');
c = colorbar;
c.LineWidth = 1;
c.FontSize  = 18;
title(c,'Rel. change');

%% wavelet images (전극 하나만 확인)
%a1
cfg = [];
%cfg.ylim = [8 40];
cfg.zlim = 'maxmin';
cfg.channel = {'Oz'};
cfg.colormap = jet;
cfg.layout = 'acticap-64ch-standard2.mat';
figure;
ft_singleplotTFR(cfg,gAvga1_beta);
set(gca,'Fontsize',20);
title('Screen Off');
set(gca,'box','on');
xlabel('time (s)');
ylabel('frequency (Hz)');
c = colorbar;
c.LineWidth = 1;
c.FontSize  = 18;
title(c,'Rel. change');

%b1
cfg = [];
%cfg.ylim = [8 40];
cfg.zlim = 'maxmin';
cfg.channel = {'Oz'};
cfg.colormap = jet;
cfg.layout = 'acticap-64ch-standard2.mat';
figure;
ft_singleplotTFR(cfg,gAvgb1_beta);
set(gca,'Fontsize',20);
title('Ceiling');
set(gca,'box','on');
xlabel('time (s)');
ylabel('frequency (Hz)');
c = colorbar;
c.LineWidth = 1;
c.FontSize  = 18;
title(c,'Rel. change');

%c1
cfg = [];
%cfg.ylim = [8 40];
cfg.zlim = 'maxmin';
cfg.channel = {'Oz'};
cfg.colormap = jet;
cfg.layout = 'acticap-64ch-standard2.mat';
figure;
ft_singleplotTFR(cfg,gAvgc1_beta);
set(gca,'Fontsize',20);
title('Screen On');
set(gca,'box','on');
xlabel('time (s)');
ylabel('frequency (Hz)');
c = colorbar;
c.LineWidth = 1;
c.FontSize  = 18;
title(c,'Rel. change');

%% Statistics ANOVA (without clusters)

%prepare neighbors
cfg = [];
cfg.layout = 'acticap-64ch-standard2.mat';
cfg.method = 'distance';
cfg.neighbourdist = 0.13;
neighbours = ft_prepare_neighbours(cfg);
% Preparing the design matrix for the statistical evaluation
% For within-subjects analysis, the design matrix contains two rows
design = [1:nSubjs 1:nSubjs 1:nSubjs; ones(1,nSubjs) ones(1,nSubjs)*2 ones(1,nSubjs)*3]; 
 
% Test the null-hypothesis of exchangeability between conditions
cfg = [];
cfg.channel = {'Fp2', 'F7', 'F3', 'Fz', 'F4', 'F8', 'FC5', 'FC1', 'FC2', 'FC6', 'T7', 'C3', 'Cz', 'C4', 'T8', 'CP5', 'CP1', 'CP2', 'CP6', 'P7', 'P3', 'Pz', 'P4', 'P8', 'O1', 'Oz', 'O2'};
%{'Fp2', 'F7', 'F3', 'Fz', 'F4', 'F8', 'FC5', 'FC1', 'FC2', 'FC6', 'T7', 'C3', 'Cz', 'C4', 'T8', 'CP5', 'CP1', 'CP2', 'CP6', 'P7', 'P3', 'Pz', 'P4', 'P8', 'O1', 'Oz', 'O2'};
cfg.latency = [0 200];
%cfg.avgovertime = 'yes';
cfg.avgoverfreq = 'no';
%cfg.parameter   = 'avg';
cfg.method      = 'ft_statistics_montecarlo';
%cfg.clusterthreshold = 'nonparametric_common';
cfg.correctm    = 'no';
cfg.clusteralpha = 0.05;
cfg.tail = 1;
cfg.correcttail = 'prob';
cfg.numrandomization = 1000;
cfg.statistic   = 'ft_statfun_depsamplesFunivariate';
cfg.alpha       = 0.05;
cfg.computestat    = 'yes';
cfg.computeprob = 'yes';
cfg.design = design;
cfg.uvar = 1; % row in design indicating subjects, repeated measure
cfg.ivar = 2; % row in design indicating condition for contrast
cfg.outputfile = fullfile(dataPath,'stat_plain');
stat_plain = ft_freqstatistics(cfg, a1_beta{:}, b1_beta{:}, c1_beta{:});