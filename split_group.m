Mark_Light(length(Wait_time)+1:end) = []
Exction = [];
Nonex = [];
for i = 1:length(Mark_Light)
    if Mark_Light(i) == 1
        Exction(end+1) = Wait_time(i)
    else
        Nonex(end+1) = Wait_time(i)
    end
end

%%
time_duration = Nonex
label = 1
while label
    mean_wait = mean(time_duration);
    std_wait = std(time_duration);
    new_wait = [];
    %% delete outliers mean +- 3*sd
    for i = 1:length(time_duration)
        if (time_duration(i) < mean_wait + 2*std_wait) && (time_duration(i) > mean_wait - 2*std_wait)
            new_wait(end + 1) = time_duration(i);
        end
    end
    if length(new_wait) == length(time_duration)
        label = 0 
        Nonex = new_wait
    else
        time_duration = new_wait
    end
end
%%
time_duration = Exction
label = 1
while label
    mean_wait = mean(time_duration);
    std_wait = std(time_duration);
    new_wait = [];
    %% delete outliers mean +- 3*sd
    for i = 1:length(time_duration)
        if (time_duration(i) < mean_wait + 2*std_wait) && (time_duration(i) > mean_wait - 2*std_wait)
            new_wait(end + 1) = time_duration(i);
        end
    end
    if length(new_wait) == length(time_duration)
        label = 0 
        Exction = new_wait
    else
        time_duration = new_wait
    end
end