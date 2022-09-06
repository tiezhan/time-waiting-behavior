%% figure;plotHz(Fs, sub1.D1);
Fs = 100;
[tRise, tDur] = detectTTL(data.VarName2);
tRise = tRise/Fs;
tDur  = tDur/Fs;
tLea = tRise + tDur 
tRew = tLea + 1
%% extract 2s
Wait_in_m=[];
meddur=[];
medlea=[];
for i = 1: size(tRise,1)
     if (tDur(i)>2 && tDur(i)<3)
         Wait_in_m(end+1)= tRise(i)
          meddur(end + 1) = tDur(i)
          medlea(end +1) = tRise(i)+tDur(i)
     end
end
Wait_in_long=[];
longdur=[];
 for i = 1: size(tRise,1)
     if (tDur(i)>3 && tDur(i)<4)
         Wait_in_long(end+1)= tRise(i)
         longdur(end + 1) = tDur(i)
     end
 end
Wait_in_short=[];
shodur=[];
for i = 1: size(tRise,1)
    if (tDur(i)<2)
         Wait_in_short(end+1)= tRise(i)
         shodur(end + 1) = tDur(i)
    end
end    
%%    
raw = table2array(data)
et = Wait_in_short;

%% base line :[-2 0]
% 
% <<FILENAME.PNG>>                                    
% 
wave_raw = raw(:,4);
twin = [-1 0];
event_base = et;
wave_ntrial_base = funa(wave_raw, Fs, event_base, twin);
wave_ntrial_base(all(wave_ntrial_base == 0, 2),:) = []; %%delete NA value
%% align to wait %
% wave_raw: gcamp wave
% wave_ntrial: each trial of gcamp
% twin: gcamp wave relative to wave
twin = [-1 8];
samplerange = twin(1)*Fs:twin(2)*Fs;
event_interest = et; %% et2,et3.....etc
wave_ntrial = funa(wave_raw, Fs, event_interest, twin);
wave_ntrial(all(wave_ntrial == 0, 2),:) = []; %%delete NA value
%% df / f
base_mean_ntrial = mean(wave_ntrial_base,2); %mean in each trial
wave_ntrial_df_f= (wave_ntrial - base_mean_ntrial) ./ (base_mean_ntrial - 3);

wave_ntrial_df_f = wave_ntrial_df_f - wave_ntrial_df_f(:,100) %% normalize to time 0 aka. wait start
id = find(wave_ntrial_df_f(:) > 1); %% find outliers
wave_ntrial_df_f(id,:) = [];%% delete outliers
id = find(wave_ntrial_df_f(:) < -1); %% find outliers
wave_ntrial_df_f(id,:) = [];%% delete outliers
id = find(wave_ntrial_df_f(:,100) >= wave_ntrial_df_f(:,300)); %% select none-ramp trials
wave_all = wave_ntrial_df_f; %% save all trials
wave_none_ramp = wave_ntrial_df_f(id,:); %% save none-ramp trials
wave_ntrial_df_f(id,:) = [];  %% delete none-ramp trials
id = find(wave_ntrial_df_f(:,200) >= wave_ntrial_df_f(:,300));
wave_ntrial_df_f(id,:) = []; 
wave_ramp = wave_ntrial_df_f; %%save ramp trials

ntrial = size(wave_ntrial_df_f,1);  %%average ramp trial 
wave_df_f_mean = mean(wave_ntrial_df_f, 1);
wave_df_f_std  = std(wave_ntrial_df_f, 0, 1);
wave_df_f_sem  = wave_df_f_std/sqrt(ntrial);
ttick          = samplerange/Fs;

ntrial = size(wave_none_ramp,1);  %%average none-ramp trial 
wave_none_ramp_mean = mean(wave_none_ramp, 1);
wave_none_ramp_std  = std(wave_none_ramp, 0, 1);
wave_none_ramp_sem  = wave_none_ramp_std/sqrt(ntrial);
ttick          = samplerange/Fs;

ntrial = size(wave_all,1);  %%average all trial 
wave_all_mean = mean(wave_all, 1);
wave_all_std  = std(wave_all, 0, 1);
wave_all_sem  = wave_all_std/sqrt(ntrial);
ttick          = samplerange/Fs;

% time = [1:size(raw,1)]'/100;
% plot(time, raw(:,2))
% 
% for i = 1: size(Wait_time,2)
%     if (Wait_time(i)>2 && Wait_time(i)<4)
%         Wait_in_long(end+1)= Wait_in(i)
%     end
% end
%         
% for i = 1: size(Wait_time,2)
%     if (Wait_time(i)<2)
%         Wait_in_short(end+1)= Wait_in(i)
%     end
% end    
%     
%% sort value
ztest = zscore(wave_ntrial_df_f,1,2)%% z-score ramp trial & sort
zramp = sortrows(ztest, 300, 'ascend')
zramp =  zramp - zramp(:,100) %% normalize to time 0 aka. wait start
ntrial = size(zramp,1);
zramp_mean = mean(zramp, 1);
zramp_std  = std(zramp, 0, 1);
zramp_sem  = zramp_std/sqrt(ntrial);
ttick          = samplerange/Fs;

ztest = zscore(wave_none_ramp,1,2)%% z-score none-ramp trial & sort
zNramp = sortrows(ztest, 300, 'ascend')
zNramp =  zNramp - zNramp(:,100) %% normalize to time 0 aka. wait start
ntrial = size(zNramp,1);
zNramp_mean = mean(zNramp, 1);
zNramp_std  = std(zNramp, 0, 1);
zNramp_sem  = zNramp_std/sqrt(ntrial);
ttick          = samplerange/Fs;

ztest = zscore(wave_all,1,2)%% z-score all trial & sort
zall = sortrows(ztest, 300, 'ascend')
zall =  zall - zall(:,100) %% normalize to time 0 aka. wait start
ntrial = size(zall,1);
zall_mean = mean(zall, 1);
zall_std  = std(zall, 0, 1);
zall_sem  = zall_std/sqrt(ntrial);
ttick          = samplerange/Fs;

%% plot df/f & heatmap & z-scored df/f
figure(1)
hold on;
 for i=1:size(wave_ntrial_df_f,1)
     plot(samplerange/Fs, 100*wave_ntrial_df_f(i,:), 'Color',[0.8 0.8 0.8]);
 end
 xlim(twin);
 xlabel('Time (sec)');
 ylabel('\DeltaF/F');
 
BF_plotwSEM(ttick,100*wave_df_f_mean,100*wave_df_f_sem);
xlim(twin);
xlabel('Time (sec)');
ylabel('%\DeltaF/F');
title('Ramp Trial')

figure(2)
imagesc(zramp)
xlabel('Time from waiting onset (s)')
xticklabels({'0','1','2','3','4','5','6','7','8'})
ylabel('# Trial')

figure(3)
hold on;
 for i=1:size(zramp,1)
     plot(samplerange/Fs, zramp(i,:), 'Color',[0.8 0.8 0.8]);
 end
 
 BF_plotwSEM(ttick,zramp_mean,zramp_sem);
xlim(twin);
xlabel('time (sec)');
ylabel('Z-score DeltaF/F');
title('Ramp Trial Z-scored')

figure(4)
hold on;
 for i=1:size(wave_none_ramp,1)
     plot(samplerange/Fs, 100*wave_none_ramp(i,:), 'Color',[0.8 0.8 0.8]);
 end
 xlim(twin);
 xlabel('Time (sec)');
 ylabel('\DeltaF/F');
 
 BF_plotwSEM(ttick,100*wave_none_ramp_mean,100*wave_none_ramp_sem);
xlim(twin);
xlabel('Time (sec)');
ylabel('%\DeltaF/F');
title('None Ramp')

figure(5);
imagesc(zNramp)
xlabel('Time from waiting onset (s)')
xticklabels({'0','1','2','3','4','5','6','7','8'})
ylabel('# Trial')

figure(6);
hold on;
 for i=1:size(zNramp,1)
     plot(samplerange/Fs, zNramp(i,:), 'Color',[0.8 0.8 0.8]);
 end
 
 BF_plotwSEM(ttick,zNramp_mean,zNramp_sem);
xlim(twin);
xlabel('time (sec)');
ylabel('Z-score DeltaF/F');
title('None Ramp Z-scored')

figure(7);
hold on;
 for i=1:1:size(wave_all,1)
     plot(samplerange/Fs, 100*wave_all(i,:), 'Color',[0.8 0.8 0.8]);
 end
 xlim(twin);
 xlabel('Time (sec)');
 ylabel('\DeltaF/F');
 
 BF_plotwSEM(ttick,100*wave_all_mean,100*wave_all_sem);
xlim(twin);
xlabel('Time (sec)');
ylabel('%\DeltaF/F');
title('Trial All')

figure(8);
imagesc(zall)
xlabel('Time from waiting onset (s)')
xticklabels({'0','1','2','3','4','5','6','7','8'})
ylabel('# Trial')

figure(9);
hold on;
 for i=1:1:size(zall,1)
     plot(samplerange/Fs, zall(i,:), 'Color',[0.8 0.8 0.8]);
 end
 
 BF_plotwSEM(ttick,zall_mean,zall_sem);
xlim(twin);
xlabel('time (sec)');
ylabel('Z-score DeltaF/F');
title('Trial Z-scored')
%% save data
pathname = 'D:\lutiezhan\dataALL\fiber_recording\DAT-cre-vta\2s\sub12\2s-DAT-GCaMP6recording-VTA-withHeatM-Duration\'; %% choose file location
filename = 'mice120218.mat'; 
save([pathname,filename],'wave_ramp','wave_none_ramp','wave_all','zramp','zNramp','zall')