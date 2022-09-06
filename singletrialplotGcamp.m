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
for i = 1:length(eee)
    wave_df_f(i,:) = (eee(i,:) - base_mean_ntrial(i)) ./ (base_mean_ntrial(i) - 5)
end
wave_df_f = wave_df_f - wave_df_f(:,1) %% normalize to 0 

for i = 1:size(wave_df_f,1)
    figure(2)
    hold on
    plot(wave_df_f(i,:)*100, 'Color', [0.1 0.1 0.1])
end

 xlabel('time (sec)');
 ylabel('\DeltaF/F %');
