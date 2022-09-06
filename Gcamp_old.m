n_tone = length(Time_Tone);
n_wait = length(Wait_in);
if n_wait == n_tone + 1
    % clear the last trial
    Wait_in(end) = [];
    n_tone = n_wait;
end

raw = table2array(s2);
for i = 1:length(raw)
   if raw(i,3) == 1 % record first event of time lick 
      break
    end
end
Fs = 100 
raw(1:(i-floor(Fs*Time_Lick(:,1))),:) = []; % omit time gap between fiber recording and time lick

Wait_in_m=[];
for i = 1: length(Wait_in)
     if (Wait_time(i)>2 && Wait_time(i)<3)
         Wait_in_m(end+1)= Wait_in(i)
     end
end
et = Wait_in_m

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
wave_ntrial_df_f= (wave_ntrial - base_mean_ntrial) ./ (base_mean_ntrial -5);
ntrial = length(et);

wave_ntrial_df_f = wave_ntrial_df_f - wave_ntrial_df_f(:,100) %% normalize to time 0 aka. wait start

ntrial = length(event_interest);
wave_df_f_mean = mean(wave_ntrial_df_f, 1);
wave_df_f_std  = std(wave_ntrial_df_f, 0, 1);
wave_df_f_sem  = wave_df_f_std/sqrt(ntrial);
ttick          = samplerange/Fs;


 for i=1:ntrial
     hold on
     plot(samplerange/Fs, wave_ntrial_df_f(i,:), 'Color',[0.5 0.5 0.5]);
 end
 xlim(twin);
 xlabel('time (sec)');
 ylabel('\DeltaF/F');
 
 BF_plotwSEM(ttick,wave_df_f_mean,wave_df_f_sem);
xlim(twin);
xlabel('time (sec)');
ylabel('\DeltaF/F');
title('')

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
