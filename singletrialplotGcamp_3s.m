%% figure;plotHz(Fs, sub1.D1);
Fs = 100;
[tRise, tDur] = detectTTL(data.D2);
tRise = tRise/Fs;
tDur  = tDur/Fs;
tLea = tRise + tDur 
tRew = tLea + 1
% figure(2)
% plot(data.Signal)
% hold on 
% barline(tRise*100, [5 7],'k')
% barline(tLea*100, [5 7],'r')
% barline(tRew*100, [5 7],'b')
%% extrat 3s
Fs = 100;
[tRise, tDur] = detectTTL(data.D2);
tRise = tRise/Fs;
tDur  = tDur/Fs;
%
Wait_in_m=[];
meddur=[];
medlea=[];
for i = 1: size(tRise,1)
     if (tDur(i)>3 && tDur(i)<4)
         Wait_in_m(end+1)= tRise(i)
          meddur(end + 1) = tDur(i)
          medlea(end +1) = tRise(i)+tDur(i)
     end
end
Wait_in_long=[];
longdur=[];
 for i = 1: size(tRise,1)
     if (tDur(i)>4 && tDur(i)<5)
         Wait_in_long(end+1)= tRise(i)
         longdur(end + 1) = tDur(i)
     end
 end
Wait_in_short=[];
shodur=[];
for i = 1: size(tRise,1)
    if (tDur(i)<3)
         Wait_in_short(end+1)= tRise(i)
         shodur(end + 1) = tDur(i)
    end
end    


%% 
raw = table2array(data);
Fs = 100;

% raw(1:29225,:) = []
et = Wait_in_m;

%% base line :[-2 0]
% 
% <<FILENAME.PNG>>                                    
% 
wave_raw = raw(:,4);
twin = [-2 0];
event_base = et;
wave_ntrial_base = funa(wave_raw, Fs, event_base, twin);
wave_ntrial_base(all(wave_ntrial_base == 0, 2),:) = []; %%delete NA value
%% align to wait %
% wave_raw: gcamp wave
% wave_ntrial: each trial of gcamp
% twin: gcamp wave relative to wave
eee = []
for i = 1:length(et)
    eee(i,:) = wave_raw(et(i)*100:((et(i)+5)*100))
end

% for i = 1:length(et)
%     figure(1)
%     hold on
%     plot(eee(i,:))
% end
%  xlabel('time (sec)');
%  ylabel('\DeltaF/F');
 
%% df / f %
base_mean_ntrial = mean(wave_ntrial_base,2); %mean in each trial
wave_df_f = []
for i = 1:size(eee,1)
    wave_df_f(i,:) = (eee(i,:) - base_mean_ntrial(i)) ./ (base_mean_ntrial(i) - 5)
end
wave_df_f = wave_df_f - wave_df_f(:,1) %% normalize to 0 

plot_areaerrorbar(wave_df_f)
for i = 1:size(wave_df_f,1)
%     figure(2)
    hold on
    plot(wave_df_f(i,:)*100, 'Color', [0.8 0.8 0.8])
end

xlabel('time (sec)');
ylabel('%\DeltaF/F');
title('')
