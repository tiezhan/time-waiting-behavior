%%
figure(1);
hold on;
plot((1:length(d17wait))*100/length(d17wait),d17wait)
plot((1:length(d18wait))*100/length(d18wait),d18wait)
plot((1:length(d19wait))*100/length(d19wait),d19wait);
plot((1:length(new_wait))*100/length(new_wait),new_wait)
plot((1:length(meddur))*100/length(meddur),meddur)
xlabel('# Trial')
ylabel('Wait Duration(s)')
line([0,100],[2,2],'linestyle',':')
line([0,100],[2,2],'linestyle',':')
line([0,100],[3,3],'linestyle',':')
%%
figure(2);
hold on 
plot((1:length(d1wait))*100/length(d1wait),d1wait)
plot((1:length(d9wait))*100/length(d9wait),d9wait)
plot((1:length(d19wait))*100/length(d19wait),d19wait);
xlabel('# Trial')
ylabel('Wait Duration(s)')
title('The trainging trajectory of time correction in a single session')
line([0,100],[2,2],'linestyle',':')
%%
figure(3);
subplot(2,2,1);plot((1:length(d1wait))*100/length(d1wait),d1wait)
line([0,100],[2,2],'linestyle',':')
xlabel('# Trial')
ylabel('Wait Duration(s)')
subplot(2,2,2);plot((1:length(d9wait))*100/length(d9wait),d9wait);
line([0,100],[2,2],'linestyle',':')
xlabel('# Trial')
ylabel('Wait Duration(s)')
subplot(2,2,3);plot((1:length(d18wait))*100/length(d18wait),d18wait);
line([0,100],[2,2],'linestyle',':')
xlabel('# Trial')
ylabel('Wait Duration(s)')
subplot(2,2,4);plot((1:length(d19wait))*100/length(d19wait),d19wait)
line([0,100],[2,2],'linestyle',':')
xlabel('# Trial')
ylabel('Wait Duration(s)')