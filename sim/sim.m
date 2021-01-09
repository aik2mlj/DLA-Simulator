clc
clear
%% n
n=(1000:1000:10000)';
df_n=zeros(size(n,1));
for i=1:length(n)
    df_n(i)=modify(n(i),2,1);
end
figure
hold on
plot(n,df_n);
grid on
xlabel('n');
ylabel('df');
title('df-数密度关系图');
hold off
%% step
step=(1:0.1:3)';
df_st=zeros(size(step,1));
for i=1:length(step)
    df_st(i)=modify(5000,step(i),1);
end
figure
hold on
plot(step,df_st);
grid on
xlabel('step');
ylabel('df');
title('df-步长关系图');
hold off
%% pr
prob=(0.2:0.1:1)';
df_pr=zeros(size(prob,1));
for i=1:length(prob)
    df_pr(i)=modify(5000,2,prob(i));
end
figure
hold on
plot(step,df_st);
grid on
xlabel('prob(%)');
ylabel('df');
title('df-粘合概率关系图');
hold off