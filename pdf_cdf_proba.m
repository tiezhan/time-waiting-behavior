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

A= time_wait;
A_sort=sort(A)
Ns=length(A_sort)
h=50
dx=(max(A_sort)-min(A_sort))/h
A_bin_limit= min(A_sort):dx:max(A_sort)
A_count=zeros(1,length(A_bin_limit))
A_pdf=zeros(1,length(A_bin_limit))
A_cdf=zeros(1,length(A_bin_limit))
A_probablity=zeros(1,length(A_bin_limit))

for i=1:length(A_bin_limit)
    if i>1
        A_count(i)=sum(A_sort<=A_bin_limit(i))-sum(A_count(1:(i-1)))
        A_pdf(i)=sum(A_sort<=A_bin_limit(i))/(Ns*dx)-sum(A_pdf(1:(i-1)))
        A_probablity(i)=sum(A_sort<=A_bin_limit(i))/(Ns)-sum(A_probablity(1:(i-1)))
        A_cdf(i)=A_probablity(i)+A_cdf(i-1)
    else
        A_count(i)=sum(A_sort<A_bin_limit(i))
        A_pdf(i)=sum(A_sort<A_bin_limit(i))/(Ns*dx)
        A_probablity(i)=sum(A_sort<A_bin_limit(i))/(Ns)
        A_cdf(i)=A_probablity(i)
    end
end

plot(A_bin_limit,A_cdf)
plot(A_bin_limit,A_pdf,'b')
plot(A_bin_limit,A_probablity,'b')
x= linspace(min(time_wait),max(time_wait))
hold on
plot(x, evcdf(x,2.3027,0.2776))
cdfplot(time_wait)