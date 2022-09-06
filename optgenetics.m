time_wait = (Wait_time);
label = 1
while label
    mean_wait = mean(time_wait);
    std_wait = std(time_wait);
    new_wait = [];
    %% delete outliers mean +- 3*sd
    for i = 1:length(time_wait)
        if (time_wait(i) < mean_wait + 3*std_wait) && (time_wait(i) > mean_wait - 3*std_wait)
            new_wait(end + 1) = time_wait(i);
        end
    end
    if length(new_wait) == length(time_wait)
        label = 0 
    else
        time_wait = new_wait
    end
end
%% collect suscess rate
m = 0;
success_wait = []
for i = 1:length(new_wait)
    if new_wait(i)>2
        m = m + 1;
        success_wait(end +1) = new_wait(i)
    end
end
rate_wait = m/length(new_wait);
susrate_2s = [susrate_2s rate_wait];

new_wait = success_wait(10:60)
% data2 = horzcat(data2,new_wait')
% data3 = horzcat(data3,new_wait')
data4 = horzcat(data4,new_wait')
data5 = vertcat(data2,data3,data4)
data7(data7 == 0)=NaN
%%
group_inx = [ones(1,70), 2.*ones(1,70), 3.*ones(1,70),4.*ones(1,70),5.*ones(1,70),];
group_names = {'session 1', 'session 2' , 'session 3','session 4' ,'session 5' ,};
condition_names = {'ChR Off', 'ChR Off', 'ChR Off','ChR On','ChR Off', 'ChR Off', 'ChR Off'};
% an alternative color scheme for some plots
% c =  [0.45, 0.80, 0.69;...
%       0.98, 0.40, 0.35;...
%       0.55, 0.60, 0.79;...
%       0.90, 0.70, 0.30];  
c =  [0, 0, 0;...
      0, 0, 0;...
      0, 0, 0;...
      0, 0, 0;...
      0, 0, 0];  
      
figure('Name', 'daboxplot_demo','WindowStyle','docked');
% different color scheme, a color flip, different outlier symbol
h = daboxplot(data7,'groups',group_inx,'linkline',1,...
    'xtlabels', condition_names,...
    'colors',c,'fill',0,'whiskers',0,'scatter',2,'outsymbol','k*',...
    'outliers',1,'scattersize',16,'flipcolors',1,'boxspacing',1.2,...
    'legend',group_names); 
ylabel('Waiting Duration (s)');
xl = xlim; xlim([xl(1), xl(2)+1]); % make more space for the legend
set(gca,'FontSize',9);
%% examine p value via t-test
 [h,p,ci,stats] = ttest2(data3(:,4),data3(:,5))