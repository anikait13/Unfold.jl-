EEG = pop_loadset('filename','raw_EM_RtrFixCnd_clean_opticat_ICA_FiltAvRefIntp.set');
EEG = eeg_checkset(EEG);

cfgDesign = [];
cfgDesign.eventtypes = {'fixation','TestOnset'};
cfgDesign.formula={'y ~ 1 +cat(CTD_Correctness) +rank +iTest +spl(duration,5) +spl(sac_amplitude,5) +circspl(sac_angle,5,-180,180)', 'y~1'};
cfgDesign.categorical = {'CTD_Correctness',{'Cue_Cor','Trg_Cor','Dst_Cor','Cue_Wro','Trg_Wro','Dst_Wro','Other',}};

% design matrix
EEG = uf_designmat(EEG,cfgDesign);

% Timexpand everything:
cfgTimeexpand = [];
cfgTimeexpand.timelimits = [-0.2 0.4]; 
EEG = uf_timeexpandDesignmat(EEG,cfgTimeexpand);

% exclude bad and irrelevant data basing on markers made in R
winrej = readmatrix('5_winrej_Rtr.txt');
EEG = uf_continuousArtifactExclude(EEG,struct('winrej',winrej));

% Fit the model with DC
EEG = uf_glmfit(EEG);

%% Model output of each condition

EEG_epoch = uf_epoch(EEG,'timelimits',[-0.2 0.4]); 
EEG_epoch = uf_glmfit_nodc(EEG_epoch);

ufresult = uf_condense(EEG_epoch);
ufresult = uf_predictContinuous(ufresult); 
ufresult = uf_addmarginal(ufresult);

% text export
suffix = '(02-04)_CTD_Cor_SS_angle';
chNames = ["FP1","FP2","F7","F3","FZ","F4","F8","FC5","FC1","FCZ","FC2","FC6","T7","C3","CZ","C4","T8","CP5","CP1","CP2","CP6","P7","P3","PZ","P4","P8","PO9","O1","O2","PO10","IZ"];
cnd =["Cue_Cor","Trg_Cor","Dst_Cor","Cue_Wro","Trg_Wro","Dst_Wro"];

    for j = 1:length(cnd)
    beta=ufresult.beta(:,:,j ).'; 
    betaT = array2table(beta,'VariableNames',chNames);
    writetable(betaT,strcat(cnd{j},'_',suffix,'_FRP.txt'),'Delimiter',' ');
    end
