data= table2array(data1)
figure(1)
for i= 1:6
    subplot(2,3,i)
    bar([mean(data(i,1:6));mean(data(i,7:12));mean(data(i,13:18))])
end
figure(2)
for i= 1:6
    subplot(2,3,i)
    bar([mean(data(i+6,1:6));mean(data(i+6,7:12));mean(data(i+6,13:18))])
end
%% hold on cdf
time_wait = time_wait'
for i = 1:size(time_wait,1)
    hold on
    a= time_wait(i,:)
    a(find(a==0))=[]
    cdfplot(a)
    h1=cdfplot(a)
    set(h1,'color',[0.5 0.7 1])
end
for i = 1:size(time_wait,1)
    hold on
    a= time_wait(i,:)
    a(find(a==0))=[]
    x= linspace(min(a),max(a))
    plot(x, evcdf(x,mean(a),std(a)))
end

for i = 1:size(time_wait,1)
    hold on
    a= time_wait(i,:)
    a(find(a==0))=[]
    histfit(a)
end

%% hold on pdf plot
    a= time_wait(1,:)
    a(find(a==0))=[]
    b= time_wait(end,:)
    b(find(b==0))=[]
    A_sort=sort(a)
    B_sort=sort(b)
    Ns1=length(A_sort)
    Ns2=length(B_sort)
    h=50
    dx1=(max(A_sort)-min(A_sort))/h
    dx2=(max(B_sort)-min(B_sort))/h
    A_bin_limit= min(A_sort):dx1:max(A_sort)
    B_bin_limit= min(B_sort):dx2:max(B_sort)
    A_pdf=zeros(1,length(A_bin_limit))
    B_pdf=zeros(1,length(B_bin_limit))
    for i=1:length(A_bin_limit)
        if i>1
        A_pdf(i)=sum(A_sort<=A_bin_limit(i))/(Ns1*dx1)-sum(A_pdf(1:(i-1)))
        else
        A_pdf(i)=sum(A_sort<A_bin_limit(i))/(Ns1*dx1)
        end
    end

    for i=1:length(B_bin_limit)
        if i>1
        B_pdf(i)=sum(B_sort<=B_bin_limit(i))/(Ns2*dx2)-sum(B_pdf(1:(i-1)))
        else
        B_pdf(i)=sum(B_sort<B_bin_limit(i))/(Ns2*dx2)
        end
    end
hold on 
plot(A_bin_limit,A_pdf)
plot(B_bin_limit,B_pdf)
%%
x= linspace(min(time_wait(2,:)),max(time_wait(2,:)))
x1= linspace(min(time_wait(1,:)),max(time_wait(1,:)))
hold on
plot(x, evcdf(x,2.0083,0.2559))
plot(x1, evcdf(x1,mean(time_wait(1,:)),std(time_wait(1,:))))
cdfplot(time_wait(2,:))
%% plot histdistribution
a1 = reshape(time_wait(1:4,:),[1 440])
a2 = time_wait(end,:)
a = [a1;a2]
hist(a,100)
xlim([1.5 3])
ylim([0 10])
